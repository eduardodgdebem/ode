#include "IRGenerator.hpp"

void IRGenerator::visit(const AST::VarDeclNode &node) {
  Type varType = SemanticAnalyzer::parseType(node.type());
  llvm::Type *llvmType = getLLVMType(varType);

  llvm::AllocaInst *alloca =
      createEntryBlockAlloca(currentFunc_, node.name().value, llvmType);
  allocaMap_[node.name().value] = alloca;
  varTypes_[node.name().value] = varType;

  llvm::Value *val = generateExpr(node.expr());
  builder_.CreateStore(val, alloca);
}

void IRGenerator::visit(const AST::AssignNode &node) {
  // The target may be a plain variable or a dereferenced pointer, so resolve
  // it to an address rather than looking a name up directly.
  llvm::Value *address = generateAddress(node.target());
  llvm::Value *val = generateExpr(node.expr());
  builder_.CreateStore(val, address);
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
  Type type = typeOf(node.expr());
  llvm::Value *expr = generateExpr(node.expr());

  std::string formatStr;
  if (type.isPointer()) {
    formatStr = "%p\n";
  } else {
    switch (type.kind()) {
    case Type::Kind::Bool:
    case Type::Kind::I8:
    case Type::Kind::U8:
    case Type::Kind::I32:
      formatStr = "%d\n";
      break;
    case Type::Kind::I64:
      formatStr = "%lld\n";
      break;
    case Type::Kind::U64:
      formatStr = "%llu\n";
      break;
    case Type::Kind::F32:
      formatStr = "%f\n";
      break;
    default:
      throw Error("unsupported type for print statement");
    }
  }

  // printf is variadic, so narrow integers must be promoted to i32 and floats
  // to double before the call.
  if (type.isBool() || type.kind() == Type::Kind::I8 ||
      type.kind() == Type::Kind::U8) {
    expr = generateCast(expr, type, Type(Type::Kind::I32));
  } else if (type.isFloat()) {
    expr = builder_.CreateFPExt(expr, llvm::Type::getDoubleTy(context_),
                                "promote");
  }

  llvm::Value *formatStrVal = builder_.CreateGlobalString(formatStr);
  llvm::Function *printfFunc = getPrintfFunction();

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

void IRGenerator::visit(const AST::UnaryOpNode &node) {
  throw Error(
      "UnaryOpNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::CastNode &node) {
  throw Error("CastNode should not be visited directly - use generateExpr()");
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
