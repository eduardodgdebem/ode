#pragma once

#include "Parser/AST.hpp"
#include <iostream>
#include <ostream>

class ASTPrinter : public AST::Visitor {
public:
  explicit ASTPrinter(std::ostream &out = std::cout)
      : out_(out), indentLevel_(0) {}

  void visit(const AST::ProgramNode &node) override;
  void visit(const AST::BlockNode &node) override;
  void visit(const AST::VarDeclNode &node) override;
  void visit(const AST::AssignNode &node) override;
  void visit(const AST::IfStmtNode &node) override;
  void visit(const AST::WhileStmtNode &node) override;
  void visit(const AST::FuncDeclNode &node) override;
  void visit(const AST::FuncCallNode &node) override;
  void visit(const AST::ReturnStmtNode &node) override;
  void visit(const AST::PrintStmtNode &node) override;
  void visit(const AST::ExprStmtNode &node) override;
  void visit(const AST::BinaryOpNode &node) override;
  void visit(const AST::UnaryOpNode &node) override;
  void visit(const AST::NumberNode &node) override;
  void visit(const AST::BooleanNode &node) override;
  void visit(const AST::IdentifierNode &node) override;
  void visit(const AST::TypeNode &node) override;
  void visit(const AST::ParamListNode &node) override;
  void visit(const AST::ArgListNode &node) override;

private:
  std::ostream &out_;
  int indentLevel_;

  void indent() { ++indentLevel_; }
  void unindent() { --indentLevel_; }

  void printIndent(const std::string &text) {
    for (int i = 0; i < indentLevel_; ++i)
      out_ << "  ";
    out_ << text << '\n';
  }
};
