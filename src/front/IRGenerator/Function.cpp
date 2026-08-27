#include "IRGenerator.hpp"
#include "SemanticAnalyzer.hpp"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/IR/Value.h"
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>

void IRGenerator::visit(const AST::FuncDeclNode &node) {
  llvm::Function *func =
      declarePrototype(node.name().value, node.returnType(), node.params());

  if (!func->empty()) {
    throw Error(
        std::format("function '{}' defined more than once", node.name().value));
  }

  Type retType = SemanticAnalyzer::parseType(node.returnType());
  llvm::Type *llvmRetType = getLLVMType(retType);

  llvm::BasicBlock *block = llvm::BasicBlock::Create(context_, "entry", func);
  builder_.SetInsertPoint(block);

  currentFunc_ = func;
  allocaScopes_.clear();
  loops_.clear();

  // The parameters live one scope outside the body, so that a `let` at the
  // top of the body may shadow a parameter of the same name.
  enterScope();
  for (auto &arg : func->args()) {
    std::string name = arg.getName().str();
    llvm::AllocaInst *alloca =
        createEntryBlockAlloca(func, name, arg.getType());
    declareLocal(name, alloca);
    builder_.CreateStore(&arg, alloca);
  }

  node.body()->accept(*this);
  exitScope();

  llvm::BasicBlock *currentBlock = builder_.GetInsertBlock();
  if (!currentBlock->getTerminator()) {
    if (retType.isVoid()) {
      builder_.CreateRetVoid();
    } else {
      // getNullValue works for every return type, including floats and
      // pointers, where a zero i32 constant would not.
      builder_.CreateRet(llvm::Constant::getNullValue(llvmRetType));
    }
  }

  currentFunc_ = nullptr;
}

// The prototype pass already emitted the declaration; nothing is left to do.
void IRGenerator::visit(const AST::ExternFuncDeclNode &node) {
  declarePrototype(node.name().value, node.returnType(), node.params());
}

llvm::Value *IRGenerator::generateCall(const AST::FuncCallNode &node) {
  llvm::Function *func = module_->getFunction(node.name().value);
  if (!func) {
    throw Error("undefined function: " + node.name().value);
  }

  std::vector<llvm::Value *> args;
  auto *argsNode = dynamic_cast<const AST::ArgListNode *>(node.args());
  if (argsNode) {
    for (auto &arg : argsNode->args()) {
      args.push_back(generateExpr(arg.get()));
    }
  }

  return builder_.CreateCall(
      func, args, func->getReturnType()->isVoidTy() ? "" : "calltmp");
}

void IRGenerator::visit(const AST::FuncCallNode &node) { generateCall(node); }

void IRGenerator::visit(const AST::ReturnStmtNode &node) {
  if (!node.expr()) {
    builder_.CreateRetVoid();
    return;
  }

  builder_.CreateRet(generateExpr(node.expr()));
}

void IRGenerator::visit(const AST::ParamListNode &node) {
  // Handled by FuncDeclNode
}

void IRGenerator::visit(const AST::ArgListNode &node) {
  // Handled by FuncCallNode
}
