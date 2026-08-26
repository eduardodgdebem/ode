#pragma once
#include "Parser/AST.hpp"
#include "SourceError.hpp"
#include "StructTable.hpp"
#include "Type.hpp"
#include <format>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <unordered_set>
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
  // `line` and `column` locate the declaration for the duplicate-symbol
  // diagnostic; zero means unknown.
  void declare(const std::string &name, Symbol::Kind kind, Type type,
               std::vector<Type> params = {}, int line = 0, int column = 0);
  const Symbol *lookup(const std::string &name) const;

private:
  std::vector<std::unordered_map<std::string, Symbol>> scopes_;
};

class SemanticAnalyzer : public AST::Visitor {
public:
  class Error : public SourceError {
  public:
    explicit Error(const std::string &msg, int line = 0, int column = 0)
        : SourceError(msg, line, column) {}
    Error(const std::string &context, const std::string &detail, int line = 0,
          int column = 0)
        : SourceError(std::format("{}: {}", context, detail), line, column) {}
  };

  void analyze(AST::Node &root);

  // Valid once analyze() has returned. Keyed by node address, so it stays
  // valid only for as long as the analyzed AST is alive.
  const ResolvedTypes &resolvedTypes() const { return types_; }

  // The layout of every declared struct, in declaration order per struct.
  const StructTable &structs() const { return structs_; }

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

  static Type parseType(const AST::Node *node);
  static std::vector<Type> parseParamTypes(const AST::Node *params);

private:
  // The construct currently being checked. Diagnostics read their position
  // from it, so that an error found long after parsing still points at the
  // right line.
  class ErrorContext {
  public:
    ErrorContext(SemanticAnalyzer &analyzer, const AST::Node *node)
        : analyzer_(analyzer), previous_(analyzer.errorNode_) {
      if (node) {
        analyzer_.errorNode_ = node;
      }
    }
    ~ErrorContext() { analyzer_.errorNode_ = previous_; }

    ErrorContext(const ErrorContext &) = delete;
    ErrorContext &operator=(const ErrorContext &) = delete;

  private:
    SemanticAnalyzer &analyzer_;
    const AST::Node *previous_;
  };

  const AST::Node *errorNode_ = nullptr;

  // Throws an Error positioned at whatever is currently being checked.
  [[noreturn]] void fail(const std::string &msg) const;
  [[noreturn]] void fail(const std::string &context,
                         const std::string &detail) const;

  SymbolTable symbols_;
  ResolvedTypes types_;
  StructTable structs_;
  // The `let` declarations that are direct children of the program, which are
  // globals rather than locals.
  std::unordered_set<const AST::Node *> globals_;
  // Enclosing `while` loops in the function being checked, so `break` and
  // `continue` can be rejected outside one.
  int loopDepth_ = 0;
  bool inFunction_ = false;
  Type currentReturnType_;

  // Declares a function signature without walking its body, so that any
  // function can call any other regardless of declaration order.
  void hoistSignature(const AST::Node *stmt);
  // Records struct names first and their fields second, so that two structs
  // may point at each other.
  void registerStructName(const AST::Node *stmt);
  void registerStructFields(const AST::Node *stmt);
  void rejectStructCycles();
  void hoistGlobal(const AST::Node *stmt);

  // Rejects a type that names a struct which was never declared.
  void validateType(Type type, const std::string &context) const;
  const StructLayout &layoutOf(const Type &type,
                               const std::string &context) const;

  // Resolves the type of an expression and records it in types_.
  Type checkExpr(const AST::Node *node);
  // The inference itself. Every caller should go through checkExpr so that
  // the result is recorded.
  Type inferExprType(const AST::Node *node);
  Type checkBinaryOp(const AST::BinaryOpNode &node);
  Type checkUnaryOp(const AST::UnaryOpNode &node);
  Type checkCast(const AST::CastNode &node);
  Type checkFieldAccess(const AST::FieldAccessNode &node);
  Type checkIndex(const AST::IndexNode &node);
  Type checkStructLiteral(const AST::StructLiteralNode &node);
  // Global initialisers are emitted as LLVM constants, so they may only be
  // literals and casts or negations of literals.
  static bool isConstantExpr(const AST::Node *node);
  Type checkCall(const AST::FuncCallNode &node);
  // `target` is the type the literal is about to be converted to, and is the
  // default `i32` everywhere except directly under a cast. See
  // checkCastOperand.
  Type checkNumberLiteral(const AST::NumberNode &node,
                          Type target = Type(Type::Kind::I32));
  // checkExpr for the operand of a cast. A literal operand is offered the
  // cast's target type, so that a value too wide for `i32` can be written at
  // all: `3000000000 as i64`.
  Type checkCastOperand(const AST::Node *node, Type target);
  // Verifies `target` is assignable and returns the type stored through it.
  Type checkAssignTarget(const AST::Node *target);

  static std::string typeToString(Type t) { return t.toString(); }
};
