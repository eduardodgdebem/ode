#pragma once

#include "Parser/AST.hpp"
#include "SemanticAnalyzer.hpp"
#include <iostream>
#include <ostream>
#include <string>

// Prints the tree one node per line, indented by depth:
//
//   fn 'main' 1:1
//     type 'i32' depth=0 1:12
//
// The format is a contract with the self-hosted compiler in selfhost/, whose
// `--dump-ast` produces the same bytes; selfhost/difftest.sh compares them. A
// change here needs the same change there.
class ASTPrinter : public AST::Visitor {
public:
  // With `types`, every expression the analyzer resolved gets its type
  // appended as `: i32`. Without it, only the tree is printed.
  explicit ASTPrinter(std::ostream &out = std::cout,
                      const ResolvedTypes *types = nullptr)
      : out_(out), types_(types), indentLevel_(0) {}

  void visit(const AST::ProgramNode &node) override;
  void visit(const AST::BlockNode &node) override;
  void visit(const AST::VarDeclNode &node) override;
  void visit(const AST::AssignNode &node) override;
  void visit(const AST::IfStmtNode &node) override;
  void visit(const AST::WhileStmtNode &node) override;
  void visit(const AST::BreakStmtNode &node) override;
  void visit(const AST::ContinueStmtNode &node) override;
  void visit(const AST::FuncDeclNode &node) override;
  void visit(const AST::ExternFuncDeclNode &node) override;
  void visit(const AST::StructDeclNode &node) override;
  void visit(const AST::FuncCallNode &node) override;
  void visit(const AST::ReturnStmtNode &node) override;
  void visit(const AST::PrintStmtNode &node) override;
  void visit(const AST::ExprStmtNode &node) override;
  void visit(const AST::BinaryOpNode &node) override;
  void visit(const AST::UnaryOpNode &node) override;
  void visit(const AST::CastNode &node) override;
  void visit(const AST::FieldAccessNode &node) override;
  void visit(const AST::IndexNode &node) override;
  void visit(const AST::StructLiteralNode &node) override;
  void visit(const AST::SizeOfNode &node) override;
  void visit(const AST::NumberNode &node) override;
  void visit(const AST::StringLiteralNode &node) override;
  void visit(const AST::CharLiteralNode &node) override;
  void visit(const AST::BooleanNode &node) override;
  void visit(const AST::IdentifierNode &node) override;
  void visit(const AST::TypeNode &node) override;
  void visit(const AST::ParamListNode &node) override;
  void visit(const AST::ArgListNode &node) override;

private:
  std::ostream &out_;
  const ResolvedTypes *types_;
  int indentLevel_;

  // The type annotation for a node, or empty when there is none to print.
  std::string annotation(const AST::Node &node) const;

  // A literal newline or NUL inside a string would otherwise break the
  // line-per-node format.
  static std::string escape(const std::string &text);

  void emit(const std::string &kind, const AST::Node &node);
  void emitNamed(const std::string &kind, const std::string &text,
                 const AST::Node &node);
  // For a construct printed at a token's position rather than a node's.
  void emitAt(const std::string &kind, const std::string &text, int line,
              int column);
  void emitLine(const std::string &text);

  // Prints a child one level deeper, skipping a null one.
  void child(const AST::Node *node);
};
