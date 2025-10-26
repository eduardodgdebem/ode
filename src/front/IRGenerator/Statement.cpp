#include "IRGenerator.hpp"

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

  builder_.SetInsertPoint(thenBB);
  node.thenBlock()->accept(*this);
  if (!thenBB->getTerminator()) {
    builder_.CreateBr(mergeBB);
  }

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

  builder_.SetInsertPoint(condBB);
  llvm::Value *condVal = generateExpr(node.condition());

  if (condVal->getType() != llvm::Type::getInt1Ty(context_)) {
    condVal = builder_.CreateICmpNE(
        condVal, llvm::ConstantInt::get(condVal->getType(), 0));
  }

  builder_.CreateCondBr(condVal, bodyBB, endBB);

  builder_.SetInsertPoint(bodyBB);
  node.body()->accept(*this);
  if (!bodyBB->getTerminator()) {
    builder_.CreateBr(condBB);
  }

  builder_.SetInsertPoint(endBB);
}
void IRGenerator::visit(const AST::PrintStmtNode &node) {
  llvm::Value *expr = generateExpr(node.expr());

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
