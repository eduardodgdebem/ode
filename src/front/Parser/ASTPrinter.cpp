#include "Parser/ASTPrinter.hpp"

void ASTPrinter::visit(const AST::ProgramNode &node) {
  printIndent("Program");
  indent();
  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }
  unindent();
}

void ASTPrinter::visit(const AST::BlockNode &node) {
  printIndent("Block");
  indent();
  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }
  unindent();
}

void ASTPrinter::visit(const AST::VarDeclNode &node) {
  printIndent("VarDecl: " + node.name().value);
  indent();
  if (node.type())
    node.type()->accept(*this);
  if (node.expr())
    node.expr()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::AssignNode &node) {
  printIndent("Assign");
  indent();
  printIndent("Target:");
  indent();
  node.target()->accept(*this);
  unindent();
  printIndent("Value:");
  indent();
  node.expr()->accept(*this);
  unindent();
  unindent();
}

void ASTPrinter::visit(const AST::IfStmtNode &node) {
  printIndent("IfStmt");
  indent();
  printIndent("Condition:");
  indent();
  node.condition()->accept(*this);
  unindent();

  printIndent("Then:");
  indent();
  node.thenBlock()->accept(*this);
  unindent();

  if (node.hasElse()) {
    printIndent("Else:");
    indent();
    node.elseBlock()->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::WhileStmtNode &node) {
  printIndent("WhileStmt");
  indent();
  printIndent("Condition:");
  indent();
  node.condition()->accept(*this);
  unindent();

  printIndent("Body:");
  indent();
  node.body()->accept(*this);
  unindent();
  unindent();
}

void ASTPrinter::visit(const AST::BreakStmtNode &node) {
  printIndent("Break");
}

void ASTPrinter::visit(const AST::ContinueStmtNode &node) {
  printIndent("Continue");
}

void ASTPrinter::visit(const AST::FuncDeclNode &node) {
  printIndent("FuncDecl: " + node.name().value);
  indent();
  if (node.returnType()) {
    printIndent("ReturnType:");
    indent();
    node.returnType()->accept(*this);
    unindent();
  }
  if (node.params()) {
    printIndent("Params:");
    indent();
    node.params()->accept(*this);
    unindent();
  }
  if (node.body()) {
    printIndent("Body:");
    indent();
    node.body()->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::ExternFuncDeclNode &node) {
  printIndent("ExternFuncDecl: " + node.name().value);
  indent();
  if (node.returnType()) {
    printIndent("ReturnType:");
    indent();
    node.returnType()->accept(*this);
    unindent();
  }
  if (node.params()) {
    printIndent("Params:");
    indent();
    node.params()->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::StructDeclNode &node) {
  printIndent("StructDecl: " + node.name().value);
  indent();
  for (const auto &field : node.fields()) {
    printIndent("Field: " + field.name.value);
    indent();
    field.type->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::FuncCallNode &node) {
  printIndent("FuncCall: " + node.name().value);
  indent();
  if (node.args())
    node.args()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::ReturnStmtNode &node) {
  printIndent(node.expr() ? "ReturnStmt" : "ReturnStmt (void)");
  if (node.expr()) {
    indent();
    node.expr()->accept(*this);
    unindent();
  }
}

void ASTPrinter::visit(const AST::PrintStmtNode &node) {
  printIndent("PrintStmt");
  indent();
  node.expr()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::ExprStmtNode &node) {
  printIndent("ExprStmt");
  indent();
  node.expr()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::BinaryOpNode &node) {
  printIndent("BinaryOp: " + node.op().value);
  indent();
  node.left()->accept(*this);
  node.right()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::UnaryOpNode &node) {
  printIndent("UnaryOp: " + node.op().value);
  indent();
  node.operand()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::CastNode &node) {
  printIndent("Cast");
  indent();
  node.expr()->accept(*this);
  node.type()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::FieldAccessNode &node) {
  printIndent("FieldAccess: ." + node.field().value);
  indent();
  node.object()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::IndexNode &node) {
  printIndent("Index");
  indent();
  node.base()->accept(*this);
  node.index()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::StructLiteralNode &node) {
  printIndent("StructLiteral: " + node.typeName().value);
  indent();
  for (const auto &field : node.fields()) {
    printIndent("Field: " + field.name.value);
    indent();
    field.value->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::SizeOfNode &node) {
  printIndent("SizeOf");
  indent();
  node.type()->accept(*this);
  unindent();
}

void ASTPrinter::visit(const AST::NumberNode &node) {
  printIndent("Number: " + node.value().value);
}

void ASTPrinter::visit(const AST::StringLiteralNode &node) {
  printIndent("String: \"" + node.value().value + "\"");
}

void ASTPrinter::visit(const AST::CharLiteralNode &node) {
  printIndent("Char: '" + node.value().value + "'");
}

void ASTPrinter::visit(const AST::BooleanNode &node) {
  printIndent("Boolean: " + node.value().value);
}

void ASTPrinter::visit(const AST::IdentifierNode &node) {
  printIndent("Identifier: " + node.name().value);
}

void ASTPrinter::visit(const AST::TypeNode &node) {
  printIndent("Type: " + std::string(node.pointerDepth(), '*') +
              node.type().value);
}

void ASTPrinter::visit(const AST::ParamListNode &node) {
  printIndent("ParamList");
  indent();
  for (const auto &param : node.params()) {
    printIndent("Param: " + param.name.value);
    indent();
    if (param.type)
      param.type->accept(*this);
    unindent();
  }
  unindent();
}

void ASTPrinter::visit(const AST::ArgListNode &node) {
  printIndent("ArgList");
  indent();
  for (const auto &arg : node.args()) {
    arg->accept(*this);
  }
  unindent();
}
