#pragma once
#include "Parser/AST.hpp"
#include <format>
#include <print>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

enum class Type { I32, Bool, Void };

class Symbol {
public:
  enum class Kind { Variable, Function };

  Symbol(std::string name, Kind kind, Type type);

  const std::string &name() const { return name_; }
  Kind kind() const { return kind_; }
  Type type() const { return type_; }

private:
  std::string name_;
  Kind kind_;
  Type type_;
};

class SymbolTable {
public:
  SymbolTable();

  void enterScope();
  void exitScope();
  void declare(const std::string &name, Symbol::Kind kind, Type type);
  const Symbol *lookup(const std::string &name) const;

private:
  std::vector<std::unordered_map<std::string, Symbol>> scopes_;
};

class SemanticAnalyzer : public AST::Visitor {
public:
  class Error : public std::runtime_error {
  public:
    explicit Error(const std::string &msg) : std::runtime_error(msg) {}
    Error(const std::string &context, const std::string &detail)
        : std::runtime_error(std::format("{}: {}", context, detail)) {}
  };

  class Todo {
  public:
    explicit Todo(const std::string &feature) {
      std::println(stderr, "[Warning] TODO: {} not yet implemented\n", feature);
    }
  };

  void analyze(AST::Node &root);

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
  void visit(const AST::NumberNode &node) override;
  void visit(const AST::BooleanNode &node) override;
  void visit(const AST::IdentifierNode &node) override;
  void visit(const AST::TypeNode &node) override;
  void visit(const AST::ParamListNode &node) override;
  void visit(const AST::ArgListNode &node) override;
  static Type parseType(const AST::Node *node);

private:
  SymbolTable symbols_;

  Type checkExpr(const AST::Node *node);
  Type checkBinaryOp(const AST::BinaryOpNode &node);
  Type checkNumber(const AST::NumberNode &node);

  static std::string typeToString(Type t);
};
