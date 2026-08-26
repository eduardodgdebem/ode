#pragma once
#include "Parser/AST.hpp"
#include "Type.hpp"
#include <format>
#include <print>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <vector>

// The type the semantic analyzer resolved for each expression node. Codegen
// reads this rather than inferring types a second time.
using ResolvedTypes = std::unordered_map<const AST::Node *, Type>;

class Symbol {
public:
  enum class Kind { Variable, Function };

  Symbol(std::string name, Kind kind, Type type,
         std::vector<Type> params = {});

  const std::string &name() const { return name_; }
  Kind kind() const { return kind_; }
  // For functions this is the return type.
  Type type() const { return type_; }
  const std::vector<Type> &params() const { return params_; }

private:
  std::string name_;
  Kind kind_;
  Type type_;
  std::vector<Type> params_;
};

class SymbolTable {
public:
  SymbolTable();

  void enterScope();
  void exitScope();
  void declare(const std::string &name, Symbol::Kind kind, Type type,
               std::vector<Type> params = {});
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

  // Valid once analyze() has returned. Keyed by node address, so it stays
  // valid only for as long as the analyzed AST is alive.
  const ResolvedTypes &resolvedTypes() const { return types_; }

  void visit(const AST::ProgramNode &node) override;
  void visit(const AST::BlockNode &node) override;
  void visit(const AST::VarDeclNode &node) override;
  void visit(const AST::AssignNode &node) override;
  void visit(const AST::IfStmtNode &node) override;
  void visit(const AST::WhileStmtNode &node) override;
  void visit(const AST::FuncDeclNode &node) override;
  void visit(const AST::ExternFuncDeclNode &node) override;
  void visit(const AST::FuncCallNode &node) override;
  void visit(const AST::ReturnStmtNode &node) override;
  void visit(const AST::PrintStmtNode &node) override;
  void visit(const AST::ExprStmtNode &node) override;
  void visit(const AST::BinaryOpNode &node) override;
  void visit(const AST::UnaryOpNode &node) override;
  void visit(const AST::CastNode &node) override;
  void visit(const AST::NumberNode &node) override;
  void visit(const AST::BooleanNode &node) override;
  void visit(const AST::IdentifierNode &node) override;
  void visit(const AST::TypeNode &node) override;
  void visit(const AST::ParamListNode &node) override;
  void visit(const AST::ArgListNode &node) override;

  static Type parseType(const AST::Node *node);
  static std::vector<Type> parseParamTypes(const AST::Node *params);

private:
  SymbolTable symbols_;
  ResolvedTypes types_;

  // Declares a function signature without walking its body, so that any
  // function can call any other regardless of declaration order.
  void hoistSignature(const AST::Node *stmt);

  // Resolves the type of an expression and records it in types_.
  Type checkExpr(const AST::Node *node);
  // The inference itself. Every caller should go through checkExpr so that
  // the result is recorded.
  Type inferExprType(const AST::Node *node);
  Type checkBinaryOp(const AST::BinaryOpNode &node);
  Type checkUnaryOp(const AST::UnaryOpNode &node);
  Type checkCast(const AST::CastNode &node);
  Type checkCall(const AST::FuncCallNode &node);
  Type checkNumberLiteral(const AST::NumberNode &node);
  // Verifies `target` is assignable and returns the type stored through it.
  Type checkAssignTarget(const AST::Node *target);

  static std::string typeToString(Type t) { return t.toString(); }
};
