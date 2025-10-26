#include "IRGenerator.hpp"
#include "SemanticAnalyzer.hpp"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/IR/Value.h"
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>

void IRGenerator::visit(const AST::FuncDeclNode &node) {
  Type retType = SemanticAnalyzer::parseType(node.returnType());
  llvm::Type *llvmRetType = getLLVMType(retType);

  std::vector<llvm::Type *> paramTypes;
  std::vector<std::string> paramNames;

  const auto *params = dynamic_cast<const AST::ParamListNode *>(node.params());
  if (params) {
    for (const auto &param : params->params()) {
      Type paramType = SemanticAnalyzer::parseType(param.type.get());
      paramTypes.push_back(getLLVMType(paramType));
      paramNames.push_back(param.name.value);
    }
  }

  llvm::FunctionType *funcType =
      llvm::FunctionType::get(llvmRetType, paramTypes, false);
  llvm::Function *func =
      llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                             node.name().value, module_.get());

  unsigned idx = 0;
  for (auto &arg : func->args()) {
    arg.setName(paramNames[idx++]);
  }

  llvm::BasicBlock *block = llvm::BasicBlock::Create(context_, "entry", func);
  builder_.SetInsertPoint(block);

  currentFunc_ = func;
  allocaMap_.clear();

  for (auto &arg : func->args()) {
    llvm::AllocaInst *alloca =
        createEntryBlockAlloca(func, arg.getName().str(), arg.getType());
    allocaMap_[arg.getName().str()] = alloca;
    builder_.CreateStore(&arg, alloca);
  }

  node.body()->accept(*this);

  llvm::BasicBlock *currentBlock = builder_.GetInsertBlock();
  if (!currentBlock->getTerminator()) {
    if (retType == Type::Void) {
      builder_.CreateRetVoid();
    } else {
      builder_.CreateRet(llvm::ConstantInt::get(llvmRetType, 0));
    }
  }

  currentFunc_ = nullptr;
}

void IRGenerator::visit(const AST::FuncCallNode &node) {
  llvm::Function *func = module_->getFunction(node.name().value);
  if (!func)
    throw Error("undefined function: " + node.name().value);

  std::vector<llvm::Value *> args;
  auto *argsNode = dynamic_cast<const AST::ArgListNode *>(node.args());

  if (argsNode) {
    for (auto &arg : argsNode->args()) {
      llvm::Value *llvmArg = generateExpr(arg.get());
      args.push_back(llvmArg);
    }
  }

  llvm::CallInst *call = builder_.CreateCall(func, args);

  if (!func->getReturnType()->isVoidTy()) {
    call->setName("unused_call");
  }
}

void IRGenerator::visit(const AST::ReturnStmtNode &node) {
  llvm::Value *retVal = generateExpr(node.expr());
  builder_.CreateRet(retVal);
}

void IRGenerator::visit(const AST::ParamListNode &node) {
  // Handled by FuncDeclNode
}

void IRGenerator::visit(const AST::ArgListNode &node) {
  // Handled by FuncCallNode
}
