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

std::string ASTPrinter::annotation(const AST::Node &node) const {
  if (!types_) {
    return "";
  }

  auto found = types_->find(&node);
  if (found == types_->end()) {
    return "";
  }

  return std::format(" : {}", found->second.toString());
}

void ASTPrinter::emit(const std::string &kind, const AST::Node &node) {
  emitLine(std::format("{} {}:{}{}", kind, node.line(), node.column(),
                       annotation(node)));
}

void ASTPrinter::emitNamed(const std::string &kind, const std::string &text,
                           const AST::Node &node) {
  emitLine(std::format("{} '{}' {}:{}{}", kind, escape(text), node.line(),
                       node.column(), annotation(node)));
}

// A field, parameter or initialiser has no node of its own, so it never
// carries a resolved type.
void ASTPrinter::emitAt(const std::string &kind, const std::string &text,
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
  emit("program", node);
  for (const auto &stmt : node.statements()) {
    child(stmt.get());
  }
}

void ASTPrinter::visit(const AST::BlockNode &node) {
  emit("block", node);
  for (const auto &stmt : node.statements()) {
    child(stmt.get());
  }
}

void ASTPrinter::visit(const AST::VarDeclNode &node) {
  emitNamed("vardecl", node.name().value, node);
  child(node.type());
  child(node.expr());
}

void ASTPrinter::visit(const AST::AssignNode &node) {
  emit("assign", node);
  child(node.target());
  child(node.expr());
}

void ASTPrinter::visit(const AST::IfStmtNode &node) {
  emit("if", node);
  child(node.condition());
  child(node.thenBlock());
  child(node.elseBlock());
}

void ASTPrinter::visit(const AST::WhileStmtNode &node) {
  emit("while", node);
  child(node.condition());
  child(node.body());
}

void ASTPrinter::visit(const AST::BreakStmtNode &node) {
  emit("break", node);
}

void ASTPrinter::visit(const AST::ContinueStmtNode &node) {
  emit("continue", node);
}

void ASTPrinter::visit(const AST::FuncDeclNode &node) {
  emitNamed("fn", node.name().value, node);
  child(node.returnType());
  child(node.params());
  child(node.body());
}

void ASTPrinter::visit(const AST::ExternFuncDeclNode &node) {
  emitNamed("extern", node.name().value, node);
  child(node.returnType());
  child(node.params());
}

// A field has no node of its own, so it prints at its name's position with
// its type nested underneath.
void ASTPrinter::visit(const AST::StructDeclNode &node) {
  emitNamed("struct", node.name().value, node);
  ++indentLevel_;
  for (const auto &field : node.fields()) {
    emitAt("field", field.name.value, field.name.line, field.name.column);
    child(field.type.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::FuncCallNode &node) {
  emitNamed("call", node.name().value, node);
  child(node.args());
}

void ASTPrinter::visit(const AST::ReturnStmtNode &node) {
  emit("return", node);
  child(node.expr());
}

void ASTPrinter::visit(const AST::PrintStmtNode &node) {
  emit("print", node);
  child(node.expr());
}

void ASTPrinter::visit(const AST::ExprStmtNode &node) {
  emit("exprstmt", node);
  child(node.expr());
}

void ASTPrinter::visit(const AST::BinaryOpNode &node) {
  emitNamed("binary", node.op().value, node);
  child(node.left());
  child(node.right());
}

void ASTPrinter::visit(const AST::UnaryOpNode &node) {
  emitNamed("unary", node.op().value, node);
  child(node.operand());
}

void ASTPrinter::visit(const AST::CastNode &node) {
  emit("cast", node);
  child(node.expr());
  child(node.type());
}

void ASTPrinter::visit(const AST::FieldAccessNode &node) {
  emitNamed("fieldaccess", node.field().value, node);
  child(node.object());
}

void ASTPrinter::visit(const AST::IndexNode &node) {
  emit("index", node);
  child(node.base());
  child(node.index());
}

void ASTPrinter::visit(const AST::StructLiteralNode &node) {
  emitNamed("structlit", node.typeName().value, node);
  ++indentLevel_;
  for (const auto &field : node.fields()) {
    emitAt("finit", field.name.value, field.name.line, field.name.column);
    child(field.value.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::SizeOfNode &node) {
  emit("sizeof", node);
  child(node.type());
}

void ASTPrinter::visit(const AST::NumberNode &node) {
  emitNamed("number", node.value().value, node);
}

void ASTPrinter::visit(const AST::StringLiteralNode &node) {
  emitNamed("string", node.value().value, node);
}

void ASTPrinter::visit(const AST::CharLiteralNode &node) {
  emitNamed("char", node.value().value, node);
}

void ASTPrinter::visit(const AST::BooleanNode &node) {
  emitNamed("bool", node.value().value, node);
}

void ASTPrinter::visit(const AST::IdentifierNode &node) {
  emitNamed("ident", node.name().value, node);
}

void ASTPrinter::visit(const AST::TypeNode &node) {
  emitLine(std::format("type '{}' depth={} {}:{}", escape(node.type().value),
                       node.pointerDepth(), node.line(), node.column()));
}

void ASTPrinter::visit(const AST::ParamListNode &node) {
  emit("params", node);
  ++indentLevel_;
  for (const auto &param : node.params()) {
    emitAt("param", param.name.value, param.name.line, param.name.column);
    child(param.type.get());
  }
  --indentLevel_;
}

void ASTPrinter::visit(const AST::ArgListNode &node) {
  emit("args", node);
  for (const auto &arg : node.args()) {
    child(arg.get());
  }
}
