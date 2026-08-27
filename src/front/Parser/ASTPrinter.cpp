#include "Parser/ASTPrinter.hpp"

#include <format>

std::string ASTPrinter::escape(const std::string &text) {
  std::string escaped;

  for (char character : text) {
    switch (character) {
    case '\\': escaped += "\\\\"; break;
    case '\n': escaped += "\\n"; break;
    case '\t': escaped += "\\t"; break;
    case '\r': escaped += "\\r"; break;
    case '\'': escaped += "\\'"; break;
    case '\0': escaped += "\\0"; break;
    default: escaped += character;
    }
  }

  return escaped;
}

void ASTPrinter::emitLine(const std::string &text) {
  for (int i = 0; i < indentLevel_; ++i) {
    out_ << "  ";
  }
  out_ << text << '\n';
}

void ASTPrinter::emit(const std::string &kind, int line, int column) {
  emitLine(std::format("{} {}:{}", kind, line, column));
}

void ASTPrinter::emitNamed(const std::string &kind, const std::string &text,
                           int line, int column) {
  emitLine(std::format("{} '{}' {}:{}", kind, escape(text), line, column));
}

void ASTPrinter::child(const AST::Node *node) {
  if (!node) {
    return;
  }
  ++indentLevel_;
  node->accept(*this);
  --indentLevel_;
}

void ASTPrinter::visit(const AST::ProgramNode &node) {
  emit("program", node.line(), node.column());
  for (const auto &stmt : node.statements()) {
    child(stmt.get());
  }
}

void ASTPrinter::visit(const AST::BlockNode &node) {
  emit("block", node.line(), node.column());
  for (const auto &stmt : node.statements()) {
    child(stmt.get());
  }
}

void ASTPrinter::visit(const AST::VarDeclNode &node) {
  emitNamed("vardecl", node.name().value, node.line(), node.column());
  child(node.type());
  child(node.expr());
}

void ASTPrinter::visit(const AST::AssignNode &node) {
  emit("assign", node.line(), node.column());
  child(node.target());
  child(node.expr());
}

void ASTPrinter::visit(const AST::IfStmtNode &node) {
  emit("if", node.line(), node.column());
  child(node.condition());
  child(node.thenBlock());
  child(node.elseBlock());
}

void ASTPrinter::visit(const AST::WhileStmtNode &node) {
  emit("while", node.line(), node.column());
  child(node.condition());
  child(node.body());
}

void ASTPrinter::visit(const AST::BreakStmtNode &node) {
  emit("break", node.line(), node.column());
}

void ASTPrinter::visit(const AST::ContinueStmtNode &node) {
  emit("continue", node.line(), node.column());
}

void ASTPrinter::visit(const AST::FuncDeclNode &node) {
  emitNamed("fn", node.name().value, node.line(), node.column());
  child(node.returnType());
  child(node.params());
  child(node.body());
}

void ASTPrinter::visit(const AST::ExternFuncDeclNode &node) {
  emitNamed("extern", node.name().value, node.line(), node.column());
  child(node.returnType());
  child(node.params());
}

// A field has no node of its own, so it prints at its name's position with
// its type nested underneath.
void ASTPrinter::visit(const AST::StructDeclNode &node) {
  emitNamed("struct", node.name().value, node.line(), node.column());
  ++indentLevel_;
  for (const auto &field : node.fields()) {
    emitNamed("field", field.name.value, field.name.line, field.name.column);
    child(field.type.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::FuncCallNode &node) {
  emitNamed("call", node.name().value, node.line(), node.column());
  child(node.args());
}

void ASTPrinter::visit(const AST::ReturnStmtNode &node) {
  emit("return", node.line(), node.column());
  child(node.expr());
}

void ASTPrinter::visit(const AST::PrintStmtNode &node) {
  emit("print", node.line(), node.column());
  child(node.expr());
}

void ASTPrinter::visit(const AST::ExprStmtNode &node) {
  emit("exprstmt", node.line(), node.column());
  child(node.expr());
}

void ASTPrinter::visit(const AST::BinaryOpNode &node) {
  emitNamed("binary", node.op().value, node.line(), node.column());
  child(node.left());
  child(node.right());
}

void ASTPrinter::visit(const AST::UnaryOpNode &node) {
  emitNamed("unary", node.op().value, node.line(), node.column());
  child(node.operand());
}

void ASTPrinter::visit(const AST::CastNode &node) {
  emit("cast", node.line(), node.column());
  child(node.expr());
  child(node.type());
}

void ASTPrinter::visit(const AST::FieldAccessNode &node) {
  emitNamed("fieldaccess", node.field().value, node.line(), node.column());
  child(node.object());
}

void ASTPrinter::visit(const AST::IndexNode &node) {
  emit("index", node.line(), node.column());
  child(node.base());
  child(node.index());
}

void ASTPrinter::visit(const AST::StructLiteralNode &node) {
  emitNamed("structlit", node.typeName().value, node.line(), node.column());
  ++indentLevel_;
  for (const auto &field : node.fields()) {
    emitNamed("finit", field.name.value, field.name.line, field.name.column);
    child(field.value.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::SizeOfNode &node) {
  emit("sizeof", node.line(), node.column());
  child(node.type());
}

void ASTPrinter::visit(const AST::NumberNode &node) {
  emitNamed("number", node.value().value, node.line(), node.column());
}

void ASTPrinter::visit(const AST::StringLiteralNode &node) {
  emitNamed("string", node.value().value, node.line(), node.column());
}

void ASTPrinter::visit(const AST::CharLiteralNode &node) {
  emitNamed("char", node.value().value, node.line(), node.column());
}

void ASTPrinter::visit(const AST::BooleanNode &node) {
  emitNamed("bool", node.value().value, node.line(), node.column());
}

void ASTPrinter::visit(const AST::IdentifierNode &node) {
  emitNamed("ident", node.name().value, node.line(), node.column());
}

void ASTPrinter::visit(const AST::TypeNode &node) {
  emitLine(std::format("type '{}' depth={} {}:{}", escape(node.type().value),
                       node.pointerDepth(), node.line(), node.column()));
}

void ASTPrinter::visit(const AST::ParamListNode &node) {
  emit("params", node.line(), node.column());
  ++indentLevel_;
  for (const auto &param : node.params()) {
    emitNamed("param", param.name.value, param.name.line, param.name.column);
    child(param.type.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::ArgListNode &node) {
  emit("args", node.line(), node.column());
  for (const auto &arg : node.args()) {
    child(arg.get());
  }
}
