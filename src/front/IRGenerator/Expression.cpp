#include "IRGenerator.hpp"

llvm::Value *IRGenerator::generateExpr(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    llvm::Value *left = generateExpr(binOp->left());
    llvm::Value *right = generateExpr(binOp->right());

    switch (binOp->op().type) {
    case Token::Type::Or:
      return builder_.CreateOr(left, right);
    case Token::Type::And:
      return builder_.CreateAnd(left, right);
    case Token::Type::Equal:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpOEQ(left, right);
      return builder_.CreateICmpEQ(left, right);
    case Token::Type::NotEqual:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpONE(left, right);
      return builder_.CreateICmpNE(left, right);
    case Token::Type::Greater:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpOGT(left, right);
      return builder_.CreateICmpSGT(left, right);
    case Token::Type::GreaterEqual:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpOGE(left, right);
      return builder_.CreateICmpSGE(left, right);
    case Token::Type::Less:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpOLT(left, right);
      return builder_.CreateICmpSLT(left, right);
    case Token::Type::LessEqual:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFCmpOLE(left, right);
      return builder_.CreateICmpSLE(left, right);
    case Token::Type::Plus:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFAdd(left, right);
      return builder_.CreateAdd(left, right);
    case Token::Type::Minus:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFSub(left, right);
      return builder_.CreateSub(left, right);
    case Token::Type::Multiply:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFMul(left, right);
      return builder_.CreateMul(left, right);
    case Token::Type::Divide:
      if (left->getType()->isFloatingPointTy())
        return builder_.CreateFDiv(left, right);
      return builder_.CreateSDiv(left, right);
    default:
      throw Error("unknown binary operator");
    }
  }

  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    llvm::Value *operand = generateExpr(unaryOp->operand());

    switch (unaryOp->op().type) {
    case Token::Type::Minus: {
      if (operand->getType()->isFloatingPointTy())
        return builder_.CreateFNeg(operand, "neg");
      llvm::Value *zero = llvm::ConstantInt::get(operand->getType(), 0);
      return builder_.CreateSub(zero, operand, "neg");
    }
    case Token::Type::Not: {
      return builder_.CreateNot(operand, "not");
    }
    default:
      throw Error(
          std::format("unknown unary operator '{}'", unaryOp->op().value));
    }
  }

  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    if (num->value().value.find('.') != std::string::npos) {
      float val = std::stod(num->value().value);
      return llvm::ConstantFP::get(llvm::Type::getFloatTy(context_), val);
    }
    long long val = std::stoll(num->value().value);
    return llvm::ConstantInt::get(llvm::Type::getInt32Ty(context_), val);
  }

  if (auto *boolean = dynamic_cast<const AST::BooleanNode *>(node)) {
    bool val = boolean->value().value == "true";
    return llvm::ConstantInt::get(llvm::Type::getInt1Ty(context_), val);
  }

  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    return loadVariable(ident->name().value);
  }

  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    llvm::Function *func = module_->getFunction(call->name().value);
    if (!func)
      throw Error("undefined function: " + call->name().value);

    std::vector<llvm::Value *> args;
    auto *argsNode = dynamic_cast<const AST::ArgListNode *>(call->args());
    if (argsNode) {
      for (auto &arg : argsNode->args()) {
        args.push_back(generateExpr(arg.get()));
      }
    }

    return builder_.CreateCall(
        func, args, func->getReturnType()->isVoidTy() ? "" : "calltmp");
  }

  throw Error("unknown expression node type");
}
