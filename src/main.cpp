#include <iostream>
#include <memory>
#include <ostream>
#include <string>

#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Parser/Parser.hpp"
#include "Reader.hpp"
#include "SemanticAnalyzer.hpp"

class ASTPrinter : public AST::Visitor {
public:
  explicit ASTPrinter(std::ostream &out = std::cout)
      : out_(out), indentLevel_(0) {}

  void visit(const AST::ProgramNode &node) override {
    printIndent("Program");
    indent();
    for (const auto &stmt : node.statements()) {
      stmt->accept(*this);
    }
    unindent();
  }

  void visit(const AST::BlockNode &node) override {
    printIndent("Block");
    indent();
    for (const auto &stmt : node.statements()) {
      stmt->accept(*this);
    }
    unindent();
  }

  void visit(const AST::VarDeclNode &node) override {
    printIndent("VarDecl: " + node.name().value);
    indent();
    if (node.type())
      node.type()->accept(*this);
    if (node.expr())
      node.expr()->accept(*this);
    unindent();
  }

  void visit(const AST::AssignNode &node) override {
    printIndent("Assign: " + node.name().value);
    indent();
    node.expr()->accept(*this);
    unindent();
  }

  void visit(const AST::IfStmtNode &node) override {
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

  void visit(const AST::WhileStmtNode &node) override {
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

  void visit(const AST::FuncDeclNode &node) override {
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

  void visit(const AST::FuncCallNode &node) override {
    printIndent("FuncCall: " + node.name().value);
    indent();
    if (node.args())
      node.args()->accept(*this);
    unindent();
  }

  void visit(const AST::ReturnStmtNode &node) override {
    printIndent("ReturnStmt");
    if (node.expr()) {
      indent();
      node.expr()->accept(*this);
      unindent();
    }
  }

  void visit(const AST::PrintStmtNode &node) override {
    printIndent("PrintStmt");
    indent();
    node.expr()->accept(*this);
    unindent();
  }

  void visit(const AST::ExprStmtNode &node) override {
    printIndent("ExprStmt");
    indent();
    node.expr()->accept(*this);
    unindent();
  }

  void visit(const AST::BinaryOpNode &node) override {
    printIndent("BinaryOp: " + node.op().value);
    indent();
    node.left()->accept(*this);
    node.right()->accept(*this);
    unindent();
  }

  void visit(const AST::UnaryOpNode &node) override {
    printIndent("UnaryOp: " + node.op().value);
    indent();
    node.operand()->accept(*this);
    unindent();
  }

  void visit(const AST::NumberNode &node) override {
    printIndent("Number: " + node.value().value);
  }

  void visit(const AST::BooleanNode &node) override {
    printIndent("Boolean: " + node.value().value);
  }

  void visit(const AST::IdentifierNode &node) override {
    printIndent("Identifier: " + node.name().value);
  }

  void visit(const AST::TypeNode &node) override {
    printIndent("Type: " + node.type().value);
  }

  void visit(const AST::ParamListNode &node) override {
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

  void visit(const AST::ArgListNode &node) override {
    printIndent("ArgList");
    indent();
    for (const auto &arg : node.args()) {
      arg->accept(*this);
    }
    unindent();
  }

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

int main(int argc, char *argv[]) {
  const char *filePath = argc >= 1 ? argv[1] : nullptr;
  if (filePath == nullptr) {
    throw std::runtime_error("No input file found");
  }

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  std::string fileText = reader->readAll();

  std::unique_ptr<Lexer> lexer = std::make_unique<Lexer>(fileText);
  std::vector<Token> tokens = lexer->tokenize();

  std::unique_ptr<Parser> parser = std::make_unique<Parser>(tokens);
  AST::NodePtr root = parser->parse();

  auto printer = std::make_unique<ASTPrinter>();
  root->accept(*printer);

  auto analyzer = std::make_unique<SemanticAnalyzer>();
  analyzer->analyze(*root);

  std::unique_ptr<IRGenerator> irgen =
      std::make_unique<IRGenerator>("myProgram");

  irgen->generate(*root);
  irgen->emitToFile(std::format("{}.ll", filePath));
  irgen->emitObjectFile(std::format("{}.o", filePath));
}
