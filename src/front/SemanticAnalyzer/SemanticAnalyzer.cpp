#include "SemanticAnalyzer.hpp"

void SemanticAnalyzer::analyze(AST::Node &root) { root.accept(*this); }

// Two passes over the top level: the first records every function signature,
// the second walks the bodies. Without this a function could only call
// functions declared above it, which rules out mutual recursion.
void SemanticAnalyzer::visit(const AST::ProgramNode &node) {
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

void SemanticAnalyzer::hoistSignature(const AST::Node *stmt) {
  if (auto *func = dynamic_cast<const AST::FuncDeclNode *>(stmt)) {
    symbols_.declare(func->name().value, Symbol::Kind::Function,
                     parseType(func->returnType()),
                     parseParamTypes(func->params()));
    return;
  }

  if (auto *ext = dynamic_cast<const AST::ExternFuncDeclNode *>(stmt)) {
    symbols_.declare(ext->name().value, Symbol::Kind::Function,
                     parseType(ext->returnType()),
                     parseParamTypes(ext->params()));
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
  Type exprType = checkExpr(node.expr());

  if (declaredType != exprType) {
    throw Error(
        std::format("type mismatch in declaration of '{}'", node.name().value),
        std::format("declared as '{}' but assigned '{}'",
                    typeToString(declaredType), typeToString(exprType)));
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

  node.body()->accept(*this);
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

  node.body()->accept(*this);
  symbols_.exitScope();

  Todo("function return type checking");
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
  checkExpr(node.expr());
  Todo("return type validation against function signature");
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

void SemanticAnalyzer::visit(const AST::NumberNode &node) {
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
