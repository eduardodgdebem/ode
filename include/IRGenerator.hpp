#pragma once
#include "Parser/AST.hpp"
#include "SemanticAnalyzer.hpp"
#include "Type.hpp"

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>

#include <format>
#include <memory>
#include <stdexcept>
#include <string>
#include <unordered_map>

class IRGenerator : public AST::Visitor {
public:
  class Error : public std::runtime_error {
  public:
    explicit Error(const std::string &msg) : std::runtime_error(msg) {}
    Error(const std::string &context, const std::string &detail)
        : std::runtime_error(std::format("{}: {}", context, detail)) {}
  };

  class Todo : public std::runtime_error {
  public:
    explicit Todo(const std::string &feature)
        : std::runtime_error(
              std::format("TODO: {} not yet implemented", feature)) {}
  };

  explicit IRGenerator(const std::string &moduleName);

  void generate(const AST::Node &root);
  void emitToFile(const std::string &filename);
  void emitObjectFile(const std::string &filename);
  void printIR();

  llvm::Module *getModule() { return module_.get(); }

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

private:
  llvm::LLVMContext context_;
  std::unique_ptr<llvm::Module> module_;
  llvm::IRBuilder<> builder_;
  std::unordered_map<std::string, llvm::AllocaInst *> allocaMap_;
  // Ode-level types for the locals and functions in scope. The semantic
  // analyzer has already validated the program, so `typeOf` below only needs
  // to infer -- never to diagnose.
  std::unordered_map<std::string, Type> varTypes_;
  std::unordered_map<std::string, Type> funcReturnTypes_;
  llvm::Function *currentFunc_ = nullptr;
  llvm::Value *exprValue_ = nullptr;

  llvm::Type *getLLVMType(Type type);
  llvm::AllocaInst *createEntryBlockAlloca(llvm::Function *func,
                                           const std::string &name,
                                           llvm::Type *type);
  llvm::Value *loadVariable(const std::string &name);

  // Creates (or returns) the prototype for a function so that callers can
  // reference it before its body has been emitted.
  llvm::Function *declarePrototype(const std::string &name,
                                   const AST::Node *returnType,
                                   const AST::Node *params);

  Type typeOf(const AST::Node *node);

  llvm::Value *generateExpr(const AST::Node *node);
  // Yields the address of an lvalue rather than the value stored in it.
  llvm::Value *generateAddress(const AST::Node *node);
  llvm::Value *generateCast(llvm::Value *value, Type from, Type to);
  llvm::Value *generatePointerArithmetic(const AST::BinaryOpNode &node,
                                         llvm::Value *left, llvm::Value *right,
                                         Type leftType, Type rightType);
  llvm::Value *generateCall(const AST::FuncCallNode &node);
  llvm::Function *getPrintfFunction();
};
