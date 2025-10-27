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
      return builder_.CreateICmpEQ(left, right);
    case Token::Type::NotEqual:
      return builder_.CreateICmpNE(left, right);
    case Token::Type::Greater:
      return builder_.CreateICmpSGT(left, right);
    case Token::Type::GreaterEqual:
      return builder_.CreateICmpSGE(left, right);
    case Token::Type::Less:
      return builder_.CreateICmpSLT(left, right);
    case Token::Type::LessEqual:
      return builder_.CreateICmpSLE(left, right);
    case Token::Type::Plus:
      return builder_.CreateAdd(left, right);
    case Token::Type::Minus:
      return builder_.CreateSub(left, right);
    case Token::Type::Multiply:
      return builder_.CreateMul(left, right);
    case Token::Type::Divide:
      return builder_.CreateSDiv(left, right);
    default:
      throw Error("unknown binary operator");
    }
  }

  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    llvm::Value *operand = generateExpr(unaryOp->operand());

    switch (unaryOp->op().type) {
    case Token::Type::Minus: {
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
