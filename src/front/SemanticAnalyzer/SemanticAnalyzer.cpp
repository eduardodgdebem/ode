#include "SemanticAnalyzer.hpp"

void SemanticAnalyzer::analyze(AST::Node &root) { root.accept(*this); }

// Two passes over the top level: the first records every function signature,
// the second walks the bodies. Without this a function could only call
// functions declared above it, which rules out mutual recursion.
void SemanticAnalyzer::visit(const AST::ProgramNode &node) {
  // Struct names come first so that two structs may point at each other,
  // then fields, then globals and function signatures, which may both refer
  // to any struct.
  for (const auto &stmt : node.statements()) {
    registerStructName(stmt.get());
  }
  for (const auto &stmt : node.statements()) {
    registerStructFields(stmt.get());
  }
  rejectStructCycles();

  for (const auto &stmt : node.statements()) {
    hoistGlobal(stmt.get());
  }
  for (const auto &stmt : node.statements()) {
    hoistSignature(stmt.get());
  }

  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }

  if (!symbols_.lookup("main")) {
    throw Error("No main function found");
  }
}

void SemanticAnalyzer::registerStructName(const AST::Node *stmt) {
  auto *decl = dynamic_cast<const AST::StructDeclNode *>(stmt);
  if (!decl) {
    return;
  }

  if (structs_.contains(decl->name().value)) {
    throw Error(std::format("struct '{}' is declared more than once",
                            decl->name().value));
  }
  structs_[decl->name().value] = StructLayout();
}

void SemanticAnalyzer::registerStructFields(const AST::Node *stmt) {
  auto *decl = dynamic_cast<const AST::StructDeclNode *>(stmt);
  if (!decl) {
    return;
  }

  StructLayout layout;
  for (const auto &field : decl->fields()) {
    if (layout.indexOf(field.name.value) >= 0) {
      throw Error(std::format("struct '{}' declares field '{}' twice",
                              decl->name().value, field.name.value));
    }

    Type type = parseType(field.type.get());
    validateType(type, std::format("field '{}' of struct '{}'",
                                   field.name.value, decl->name().value));
    if (type.isVoid()) {
      throw Error(std::format("field '{}' of struct '{}' cannot be void",
                              field.name.value, decl->name().value));
    }

    layout.addField(field.name.value, type);
  }

  structs_[decl->name().value] = std::move(layout);
}

// A struct that contains itself by value has no finite size. Going through a
// pointer is fine, and is how linked structures are built.
void SemanticAnalyzer::rejectStructCycles() {
  for (const auto &[name, _] : structs_) {
    std::vector<std::string> stack{name};
    std::unordered_set<std::string> seen{name};

    while (!stack.empty()) {
      std::string current = stack.back();
      stack.pop_back();

      for (const auto &field : structs_.at(current).fields()) {
        if (!field.type.isStruct()) {
          continue;
        }
        if (field.type.structName() == name) {
          throw Error(std::format("struct '{}' contains itself", name),
                      "use a pointer to break the cycle");
        }
        if (seen.insert(field.type.structName()).second) {
          stack.push_back(field.type.structName());
        }
      }
    }
  }
}

void SemanticAnalyzer::hoistGlobal(const AST::Node *stmt) {
  auto *decl = dynamic_cast<const AST::VarDeclNode *>(stmt);
  if (!decl) {
    return;
  }

  Type type = parseType(decl->type());
  validateType(type, std::format("in declaration of '{}'", decl->name().value));
  if (type.isVoid()) {
    throw Error(std::format("variable '{}' cannot be void", decl->name().value));
  }

  globals_.insert(decl);
  symbols_.declare(decl->name().value, Symbol::Kind::Variable, type);
}

void SemanticAnalyzer::hoistSignature(const AST::Node *stmt) {
  if (auto *func = dynamic_cast<const AST::FuncDeclNode *>(stmt)) {
    Type returnType = parseType(func->returnType());
    validateType(returnType,
                 std::format("return type of '{}'", func->name().value));

    std::vector<Type> params = parseParamTypes(func->params());
    for (Type param : params) {
      validateType(param, std::format("parameter of '{}'", func->name().value));
    }

    symbols_.declare(func->name().value, Symbol::Kind::Function, returnType,
                     std::move(params));
    return;
  }

  if (auto *ext = dynamic_cast<const AST::ExternFuncDeclNode *>(stmt)) {
    Type returnType = parseType(ext->returnType());
    validateType(returnType,
                 std::format("return type of extern '{}'", ext->name().value));

    std::vector<Type> params = parseParamTypes(ext->params());
    for (Type param : params) {
      validateType(param,
                   std::format("parameter of extern '{}'", ext->name().value));
    }

    // Passing a struct by value across the C ABI needs target-specific
    // lowering that this compiler does not do, so require a pointer.
    if (returnType.isStruct()) {
      throw Error(std::format("extern '{}' returns a struct by value",
                              ext->name().value),
                  "return a pointer instead");
    }
    for (Type param : params) {
      if (param.isStruct()) {
        throw Error(std::format("extern '{}' takes a struct by value",
                                ext->name().value),
                    "take a pointer instead");
      }
    }

    symbols_.declare(ext->name().value, Symbol::Kind::Function, returnType,
                     std::move(params));
  }
}

void SemanticAnalyzer::visit(const AST::BlockNode &node) {
  symbols_.enterScope();
  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }
  symbols_.exitScope();
}

void SemanticAnalyzer::visit(const AST::VarDeclNode &node) {
  Type declaredType = parseType(node.type());
  validateType(declaredType,
               std::format("in declaration of '{}'", node.name().value));
  if (declaredType.isVoid()) {
    throw Error(std::format("variable '{}' cannot be void", node.name().value));
  }

  Type exprType = checkExpr(node.expr());

  if (declaredType != exprType) {
    throw Error(
        std::format("type mismatch in declaration of '{}'", node.name().value),
        std::format("declared as '{}' but assigned '{}'",
                    typeToString(declaredType), typeToString(exprType)));
  }

  // Globals were declared during hoisting; all that is left is to confirm the
  // initialiser can be emitted as an LLVM constant.
  if (globals_.contains(&node)) {
    if (!isConstantExpr(node.expr())) {
      throw Error(std::format("initialiser of global '{}' is not constant",
                              node.name().value),
                  "globals may only be initialised from literals");
    }
    return;
  }

  symbols_.declare(node.name().value, Symbol::Kind::Variable, declaredType);
}

void SemanticAnalyzer::visit(const AST::AssignNode &node) {
  Type targetType = checkAssignTarget(node.target());
  Type exprType = checkExpr(node.expr());

  if (targetType != exprType) {
    throw Error("type mismatch in assignment",
                std::format("expected '{}' but got '{}'",
                            typeToString(targetType), typeToString(exprType)));
  }
}

void SemanticAnalyzer::visit(const AST::IfStmtNode &node) {
  Type condType = checkExpr(node.condition());
  if (!condType.isBool()) {
    throw Error("if condition must be boolean",
                std::format("got '{}'", typeToString(condType)));
  }

  node.thenBlock()->accept(*this);
  if (node.hasElse()) {
    node.elseBlock()->accept(*this);
  }
}

void SemanticAnalyzer::visit(const AST::WhileStmtNode &node) {
  Type condType = checkExpr(node.condition());
  if (!condType.isBool()) {
    throw Error("while condition must be boolean",
                std::format("got '{}'", typeToString(condType)));
  }

  ++loopDepth_;
  node.body()->accept(*this);
  --loopDepth_;
}

void SemanticAnalyzer::visit(const AST::BreakStmtNode &node) {
  if (loopDepth_ == 0) {
    throw Error("break used outside of a loop");
  }
}

void SemanticAnalyzer::visit(const AST::ContinueStmtNode &node) {
  if (loopDepth_ == 0) {
    throw Error("continue used outside of a loop");
  }
}

void SemanticAnalyzer::visit(const AST::FuncDeclNode &node) {
  // Top-level functions were already recorded by the hoisting pass.
  if (!symbols_.lookup(node.name().value)) {
    symbols_.declare(node.name().value, Symbol::Kind::Function,
                     parseType(node.returnType()),
                     parseParamTypes(node.params()));
  }

  symbols_.enterScope();

  const auto *params = dynamic_cast<const AST::ParamListNode *>(node.params());
  if (params) {
    for (const auto &param : params->params()) {
      Type paramType = parseType(param.type.get());
      symbols_.declare(param.name.value, Symbol::Kind::Variable, paramType);
    }
  }

  // A nested function gets its own return type and loop nesting; neither
  // leaks in from the function it is written inside.
  bool wasInFunction = inFunction_;
  Type previousReturnType = currentReturnType_;
  int previousLoopDepth = loopDepth_;

  inFunction_ = true;
  currentReturnType_ = parseType(node.returnType());
  loopDepth_ = 0;

  node.body()->accept(*this);

  inFunction_ = wasInFunction;
  currentReturnType_ = previousReturnType;
  loopDepth_ = previousLoopDepth;

  symbols_.exitScope();
}

void SemanticAnalyzer::visit(const AST::ExternFuncDeclNode &node) {
  if (!symbols_.lookup(node.name().value)) {
    symbols_.declare(node.name().value, Symbol::Kind::Function,
                     parseType(node.returnType()),
                     parseParamTypes(node.params()));
  }

  for (Type param : parseParamTypes(node.params())) {
    if (param.isVoid()) {
      throw Error(std::format("extern '{}' has a void parameter",
                              node.name().value));
    }
  }
}

void SemanticAnalyzer::visit(const AST::FuncCallNode &node) {
  checkCall(node);
}

void SemanticAnalyzer::visit(const AST::ReturnStmtNode &node) {
  if (!inFunction_) {
    throw Error("return used outside of a function");
  }

  if (!node.expr()) {
    if (!currentReturnType_.isVoid()) {
      throw Error("return without a value",
                  std::format("this function returns '{}'",
                              typeToString(currentReturnType_)));
    }
    return;
  }

  Type returned = checkExpr(node.expr());

  if (currentReturnType_.isVoid()) {
    throw Error("returning a value from a void function",
                std::format("got '{}'", typeToString(returned)));
  }

  if (returned != currentReturnType_) {
    throw Error("wrong return type",
                std::format("expected '{}' but got '{}'",
                            typeToString(currentReturnType_),
                            typeToString(returned)));
  }
}

void SemanticAnalyzer::visit(const AST::PrintStmtNode &node) {
  Type type = checkExpr(node.expr());
  if (type.isVoid()) {
    throw Error("cannot print a void value");
  }
}

void SemanticAnalyzer::visit(const AST::ExprStmtNode &node) {
  checkExpr(node.expr());
}

void SemanticAnalyzer::visit(const AST::BinaryOpNode &node) {
  throw Error("BinaryOpNode should not be visited directly - use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::UnaryOpNode &node) {
  throw Error("UnaryOpNode should not be visited directly - use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::CastNode &node) {
  throw Error("CastNode should not be visited directly - use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::FieldAccessNode &node) {
  throw Error("FieldAccessNode should not be visited directly - "
              "use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::IndexNode &node) {
  throw Error("IndexNode should not be visited directly - use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::StructLiteralNode &node) {
  throw Error("StructLiteralNode should not be visited directly - "
              "use checkExpr()");
}

void SemanticAnalyzer::visit(const AST::SizeOfNode &node) {
  throw Error("SizeOfNode should not be visited directly - use checkExpr()");
}

// Registered before any body is walked; nothing is left to check here.
void SemanticAnalyzer::visit(const AST::StructDeclNode &node) {}

void SemanticAnalyzer::visit(const AST::NumberNode &node) {
  // Leaf node - no action needed
}

void SemanticAnalyzer::visit(const AST::StringLiteralNode &node) {
  // Leaf node - no action needed
}

void SemanticAnalyzer::visit(const AST::CharLiteralNode &node) {
  // Leaf node - no action needed
}

void SemanticAnalyzer::visit(const AST::BooleanNode &node) {
  // Leaf node - no action needed
}

void SemanticAnalyzer::visit(const AST::IdentifierNode &node) {
  // Leaf node - lookup happens in checkExpr
}

void SemanticAnalyzer::visit(const AST::TypeNode &node) {
  // Leaf node - no action needed
}

void SemanticAnalyzer::visit(const AST::ParamListNode &node) {
  // Handled by FuncDeclNode
}

void SemanticAnalyzer::visit(const AST::ArgListNode &node) {
  // Handled by FuncCallNode
}
