#include "IRGenerator.hpp"

#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Verifier.h>
#include <llvm/MC/TargetRegistry.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/Target/TargetOptions.h>
#include <llvm/TargetParser/Host.h>

IRGenerator::IRGenerator(const std::string &moduleName)
    : module_(std::make_unique<llvm::Module>(moduleName, context_)),
      builder_(context_) {}

void IRGenerator::generate(const AST::Node &root) {
  root.accept(*this);

  if (llvm::verifyModule(*module_, &llvm::errs())) {
    throw Error("module verification failed");
  }
}

void IRGenerator::visit(const AST::ProgramNode &node) {
  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }
}

void IRGenerator::visit(const AST::BlockNode &node) {
  for (const auto &stmt : node.statements()) {
    if (builder_.GetInsertBlock()->getTerminator()) {
      break;
    }
    stmt->accept(*this);
  }
}

void IRGenerator::visit(const AST::VarDeclNode &node) {
  Type varType = SemanticAnalyzer::parseType(node.type());
  llvm::Type *llvmType = getLLVMType(varType);

  llvm::AllocaInst *alloca =
      createEntryBlockAlloca(currentFunc_, node.name().value, llvmType);
  allocaMap_[node.name().value] = alloca;

  llvm::Value *val = generateExpr(node.expr());
  builder_.CreateStore(val, alloca);
}

void IRGenerator::visit(const AST::AssignNode &node) {
  llvm::Value *val = generateExpr(node.expr());
  storeVariable(node.name().value, val);
}

void IRGenerator::visit(const AST::IfStmtNode &node) {
  llvm::Value *condVal = generateExpr(node.condition());

  // Convert to i1 if needed
  if (condVal->getType() != llvm::Type::getInt1Ty(context_)) {
    condVal = builder_.CreateICmpNE(
        condVal, llvm::ConstantInt::get(condVal->getType(), 0));
  }

  llvm::Function *func = builder_.GetInsertBlock()->getParent();

  llvm::BasicBlock *thenBB =
      llvm::BasicBlock::Create(context_, "if.then", func);
  llvm::BasicBlock *elseBB =
      node.hasElse() ? llvm::BasicBlock::Create(context_, "if.else", func)
                     : nullptr;
  llvm::BasicBlock *mergeBB =
      llvm::BasicBlock::Create(context_, "if.end", func);

  builder_.CreateCondBr(condVal, thenBB, elseBB ? elseBB : mergeBB);

  // Generate then block
  builder_.SetInsertPoint(thenBB);
  node.thenBlock()->accept(*this);
  if (!thenBB->getTerminator()) {
    builder_.CreateBr(mergeBB);
  }

  // Generate else block if present
  if (elseBB) {
    builder_.SetInsertPoint(elseBB);
    node.elseBlock()->accept(*this);
    if (!elseBB->getTerminator()) {
      builder_.CreateBr(mergeBB);
    }
  }

  builder_.SetInsertPoint(mergeBB);
}

void IRGenerator::visit(const AST::WhileStmtNode &node) {
  llvm::Function *func = builder_.GetInsertBlock()->getParent();

  llvm::BasicBlock *condBB =
      llvm::BasicBlock::Create(context_, "while.cond", func);
  llvm::BasicBlock *bodyBB =
      llvm::BasicBlock::Create(context_, "while.body", func);
  llvm::BasicBlock *endBB =
      llvm::BasicBlock::Create(context_, "while.end", func);

  builder_.CreateBr(condBB);

  // Condition block
  builder_.SetInsertPoint(condBB);
  llvm::Value *condVal = generateExpr(node.condition());

  // Convert to i1 if needed
  if (condVal->getType() != llvm::Type::getInt1Ty(context_)) {
    condVal = builder_.CreateICmpNE(
        condVal, llvm::ConstantInt::get(condVal->getType(), 0));
  }

  builder_.CreateCondBr(condVal, bodyBB, endBB);

  // Body block
  builder_.SetInsertPoint(bodyBB);
  node.body()->accept(*this);
  if (!bodyBB->getTerminator()) {
    builder_.CreateBr(condBB);
  }

  builder_.SetInsertPoint(endBB);
}

void IRGenerator::visit(const AST::FuncDeclNode &node) {
  // Get return type
  Type retType = SemanticAnalyzer::parseType(node.returnType());
  llvm::Type *llvmRetType = getLLVMType(retType);

  // Get parameter types and names
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

  // Create function
  llvm::FunctionType *funcType =
      llvm::FunctionType::get(llvmRetType, paramTypes, false);
  llvm::Function *func =
      llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                             node.name().value, module_.get());

  // Set argument names
  unsigned idx = 0;
  for (auto &arg : func->args()) {
    arg.setName(paramNames[idx++]);
  }

  // Create entry block
  llvm::BasicBlock *block = llvm::BasicBlock::Create(context_, "entry", func);
  builder_.SetInsertPoint(block);

  currentFunc_ = func;
  allocaMap_.clear();

  // Allocate space for parameters
  for (auto &arg : func->args()) {
    llvm::AllocaInst *alloca =
        createEntryBlockAlloca(func, arg.getName().str(), arg.getType());
    allocaMap_[arg.getName().str()] = alloca;
    builder_.CreateStore(&arg, alloca);
  }

  // Generate function body
  node.body()->accept(*this);

  // Add default return if no terminator
  if (!block->getTerminator()) {
    if (retType == Type::Void) {
      builder_.CreateRetVoid();
    } else {
      builder_.CreateRet(llvm::ConstantInt::get(llvmRetType, 0));
    }
  }

  currentFunc_ = nullptr;
}

void IRGenerator::visit(const AST::FuncCallNode &node) {
  throw Todo("function calls");
}

void IRGenerator::visit(const AST::ReturnStmtNode &node) {
  llvm::Value *retVal = generateExpr(node.expr());
  builder_.CreateRet(retVal);
}

void IRGenerator::visit(const AST::PrintStmtNode &node) {
  llvm::Value *expr = generateExpr(node.expr());

  // Create format string based on type
  std::string formatStr;
  if (expr->getType()->isIntegerTy(1)) {
    formatStr = "%d\n";
  } else if (expr->getType()->isIntegerTy(32)) {
    formatStr = "%d\n";
  } else if (expr->getType()->isIntegerTy(64)) {
    formatStr = "%lld\n";
  } else {
    throw Error("unsupported type for print statement");
  }

  llvm::Value *formatStrVal = builder_.CreateGlobalString(formatStr);
  llvm::Function *printfFunc = getPrintfFunction();

  // Extend i1 to i32 for printf
  if (expr->getType()->isIntegerTy(1)) {
    expr = builder_.CreateZExt(expr, llvm::Type::getInt32Ty(context_));
  }

  std::vector<llvm::Value *> args;
  args.push_back(formatStrVal);
  args.push_back(expr);
  builder_.CreateCall(printfFunc, args);
}

void IRGenerator::visit(const AST::ExprStmtNode &node) {
  generateExpr(node.expr());
}

void IRGenerator::visit(const AST::BinaryOpNode &node) {
  throw Error(
      "BinaryOpNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::NumberNode &node) {
  throw Error("NumberNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::BooleanNode &node) {
  throw Error(
      "BooleanNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::IdentifierNode &node) {
  throw Error(
      "IdentifierNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::TypeNode &node) {
  // Type nodes don't generate code
}

void IRGenerator::visit(const AST::ParamListNode &node) {
  // Handled by FuncDeclNode
}

void IRGenerator::visit(const AST::ArgListNode &node) {
  // Handled by FuncCallNode
}
