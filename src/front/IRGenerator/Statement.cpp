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

  // The branch has to be added to whichever block the builder ended up in,
  // not the one it started in: a nested if or while leaves the insert point
  // on its own trailing block.
  builder_.SetInsertPoint(thenBB);
  node.thenBlock()->accept(*this);
  if (!builder_.GetInsertBlock()->getTerminator()) {
    builder_.CreateBr(mergeBB);
  }

  if (elseBB) {
    builder_.SetInsertPoint(elseBB);
    node.elseBlock()->accept(*this);
    if (!builder_.GetInsertBlock()->getTerminator()) {
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
  loops_.push_back({condBB, endBB});
  node.body()->accept(*this);
  loops_.pop_back();

  if (!builder_.GetInsertBlock()->getTerminator()) {
    builder_.CreateBr(condBB);
  }

  builder_.SetInsertPoint(endBB);
}

void IRGenerator::visit(const AST::BreakStmtNode &node) {
  if (loops_.empty()) {
    throw Error("break used outside of a loop");
  }
  builder_.CreateBr(loops_.back().breakTarget);
}

void IRGenerator::visit(const AST::ContinueStmtNode &node) {
  if (loops_.empty()) {
    throw Error("continue used outside of a loop");
  }
  builder_.CreateBr(loops_.back().continueTarget);
}
void IRGenerator::visit(const AST::PrintStmtNode &node) {
  Type type = typeOf(node.expr());
  llvm::Value *expr = generateExpr(node.expr());

  std::string formatStr;
  if (type.isPointer()) {
    // `*i8` is Ode's string type, so print it as text. Any other pointer is
    // printed as an address.
    formatStr = type == Type(Type::Kind::I8, 1) ? "%s\n" : "%p\n";
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

void IRGenerator::visit(const AST::FieldAccessNode &node) {
  throw Error(
      "FieldAccessNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::IndexNode &node) {
  throw Error("IndexNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::StructLiteralNode &node) {
  throw Error(
      "StructLiteralNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::SizeOfNode &node) {
  throw Error("SizeOfNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::NumberNode &node) {
  throw Error("NumberNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::StringLiteralNode &node) {
  throw Error(
      "StringLiteralNode should not be visited directly - use generateExpr()");
}

void IRGenerator::visit(const AST::CharLiteralNode &node) {
  throw Error(
      "CharLiteralNode should not be visited directly - use generateExpr()");
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
