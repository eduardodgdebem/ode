#include "SemanticAnalyzer.hpp"

void SemanticAnalyzer::analyze(AST::Node &root) { root.accept(*this); }

void SemanticAnalyzer::visit(const AST::ProgramNode &node) {
  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }

  if (!symbols_.lookup("main")) {
    throw Error("No main function found");
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
  const Symbol *sym = symbols_.lookup(node.name().value);
  if (!sym) {
    throw Error(std::format("undefined variable '{}'", node.name().value));
  }

  Type exprType = checkExpr(node.expr());
  if (sym->type() != exprType) {
    throw Error(
        std::format("type mismatch in assignment to '{}'", node.name().value),
        std::format("expected '{}' but got '{}'", typeToString(sym->type()),
                    typeToString(exprType)));
  }
}

void SemanticAnalyzer::visit(const AST::IfStmtNode &node) {
  Type condType = checkExpr(node.condition());
  if (condType != Type::Bool) {
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
  if (condType != Type::Bool) {
    throw Error("while condition must be boolean",
                std::format("got '{}'", typeToString(condType)));
  }

  node.body()->accept(*this);
}

void SemanticAnalyzer::visit(const AST::FuncDeclNode &node) {
  Type returnType = parseType(node.returnType());

  symbols_.declare(node.name().value, Symbol::Kind::Function, returnType);

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

void SemanticAnalyzer::visit(const AST::FuncCallNode &node) {
  const Symbol *sym = symbols_.lookup(node.name().value);
  if (!sym) {
    throw Error(std::format("undefined function '{}'", node.name().value));
  }

  if (sym->kind() != Symbol::Kind::Function) {
    throw Error(std::format("'{}' is not a function", node.name().value));
  }

  Todo("function argument type checking");
}

void SemanticAnalyzer::visit(const AST::ReturnStmtNode &node) {
  checkExpr(node.expr());
  Todo("return type validation against function signature");
}

void SemanticAnalyzer::visit(const AST::PrintStmtNode &node) {
  checkExpr(node.expr());
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
