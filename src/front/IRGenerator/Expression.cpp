#include "IRGenerator.hpp"

namespace {
// Size of one pointee element, used to scale a pointer difference back into a
// count of elements. LLVM's DataLayout is not attached to the module until
// object emission, so the sizes are spelled out here instead.
unsigned sizeInBytes(Type type) {
  if (type.isPointer()) {
    return 8;
  }
  switch (type.kind()) {
  case Type::Kind::I8:
  case Type::Kind::U8:
  case Type::Kind::Bool:
    return 1;
  case Type::Kind::I32:
  case Type::Kind::F32:
    return 4;
  case Type::Kind::I64:
  case Type::Kind::U64:
    return 8;
  case Type::Kind::Void:
    return 0;
  }
  return 0;
}
} // namespace

llvm::Value *IRGenerator::generateAddress(const AST::Node *node) {
  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    auto it = allocaMap_.find(ident->name().value);
    if (it == allocaMap_.end()) {
      throw Error(std::format("variable '{}' not found", ident->name().value));
    }
    return it->second;
  }

  // For `*p` the address to read or write is simply the value of `p`.
  if (auto *unary = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    if (unary->op().type == Token::Type::Multiply) {
      return generateExpr(unary->operand());
    }
  }

  throw Error("expression does not denote an addressable location");
}

llvm::Value *IRGenerator::generateCast(llvm::Value *value, Type from, Type to) {
  if (from == to) {
    return value;
  }

  llvm::Type *target = getLLVMType(to);

  if (from.isPointer() && to.isPointer()) {
    return value; // opaque pointers: nothing to convert
  }
  if (from.isPointer() && to.isInteger()) {
    return builder_.CreatePtrToInt(value, target, "ptrint");
  }
  if (from.isInteger() && to.isPointer()) {
    return builder_.CreateIntToPtr(value, target, "intptr");
  }

  if (from.isBool()) {
    // i1 always widens without sign extension.
    return builder_.CreateZExt(value, target, "boolint");
  }
  if (to.isBool()) {
    return builder_.CreateICmpNE(
        value, llvm::ConstantInt::get(value->getType(), 0), "tobool");
  }

  if (from.isInteger() && to.isInteger()) {
    if (to.bitWidth() == from.bitWidth()) {
      return value;
    }
    if (to.bitWidth() < from.bitWidth()) {
      return builder_.CreateTrunc(value, target, "trunc");
    }
    return from.isSigned() ? builder_.CreateSExt(value, target, "sext")
                           : builder_.CreateZExt(value, target, "zext");
  }

  if (from.isInteger() && to.isFloat()) {
    return from.isSigned() ? builder_.CreateSIToFP(value, target, "sitofp")
                           : builder_.CreateUIToFP(value, target, "uitofp");
  }
  if (from.isFloat() && to.isInteger()) {
    return to.isSigned() ? builder_.CreateFPToSI(value, target, "fptosi")
                         : builder_.CreateFPToUI(value, target, "fptoui");
  }
  if (from.isFloat() && to.isFloat()) {
    return value;
  }

  throw Error(std::format("cannot cast '{}' to '{}'", from.toString(),
                          to.toString()));
}

llvm::Value *IRGenerator::generatePointerArithmetic(
    const AST::BinaryOpNode &node, llvm::Value *left, llvm::Value *right,
    Type leftType, Type rightType) {
  llvm::Type *i64Type = llvm::Type::getInt64Ty(context_);

  // p - q: byte distance scaled down to a count of elements.
  if (leftType.isPointer() && rightType.isPointer()) {
    llvm::Value *leftInt = builder_.CreatePtrToInt(left, i64Type, "lhsint");
    llvm::Value *rightInt = builder_.CreatePtrToInt(right, i64Type, "rhsint");
    llvm::Value *diff = builder_.CreateSub(leftInt, rightInt, "ptrdiff");

    unsigned elementSize = sizeInBytes(leftType.pointee());
    if (elementSize <= 1) {
      return diff;
    }
    return builder_.CreateSDiv(
        diff, llvm::ConstantInt::get(i64Type, elementSize), "ptrdiv");
  }

  llvm::Value *pointer = leftType.isPointer() ? left : right;
  llvm::Value *offset = leftType.isPointer() ? right : left;
  Type pointerType = leftType.isPointer() ? leftType : rightType;
  Type offsetType = leftType.isPointer() ? rightType : leftType;

  // GEP indices are pointer-sized; widen or narrow the offset to match.
  offset = generateCast(offset, offsetType, Type(Type::Kind::I64));

  if (node.op().type == Token::Type::Minus) {
    offset = builder_.CreateNeg(offset, "negoff");
  }

  return builder_.CreateGEP(getLLVMType(pointerType.pointee()), pointer,
                            {offset}, "ptradd");
}

llvm::Value *IRGenerator::generateExpr(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    llvm::Value *left = generateExpr(binOp->left());
    llvm::Value *right = generateExpr(binOp->right());
    Type leftType = typeOf(binOp->left());
    Type rightType = typeOf(binOp->right());

    const bool isFloat = leftType.isFloat();
    // Pointers compare as unsigned; integers follow their declared signedness.
    const bool isSigned = leftType.isSigned();

    switch (binOp->op().type) {
    case Token::Type::Or:
      return builder_.CreateOr(left, right);
    case Token::Type::And:
      return builder_.CreateAnd(left, right);
    case Token::Type::Equal:
      if (isFloat)
        return builder_.CreateFCmpOEQ(left, right);
      return builder_.CreateICmpEQ(left, right);
    case Token::Type::NotEqual:
      if (isFloat)
        return builder_.CreateFCmpONE(left, right);
      return builder_.CreateICmpNE(left, right);
    case Token::Type::Greater:
      if (isFloat)
        return builder_.CreateFCmpOGT(left, right);
      return isSigned ? builder_.CreateICmpSGT(left, right)
                      : builder_.CreateICmpUGT(left, right);
    case Token::Type::GreaterEqual:
      if (isFloat)
        return builder_.CreateFCmpOGE(left, right);
      return isSigned ? builder_.CreateICmpSGE(left, right)
                      : builder_.CreateICmpUGE(left, right);
    case Token::Type::Less:
      if (isFloat)
        return builder_.CreateFCmpOLT(left, right);
      return isSigned ? builder_.CreateICmpSLT(left, right)
                      : builder_.CreateICmpULT(left, right);
    case Token::Type::LessEqual:
      if (isFloat)
        return builder_.CreateFCmpOLE(left, right);
      return isSigned ? builder_.CreateICmpSLE(left, right)
                      : builder_.CreateICmpULE(left, right);
    case Token::Type::Plus:
      if (leftType.isPointer() || rightType.isPointer())
        return generatePointerArithmetic(*binOp, left, right, leftType,
                                         rightType);
      if (isFloat)
        return builder_.CreateFAdd(left, right);
      return builder_.CreateAdd(left, right);
    case Token::Type::Minus:
      if (leftType.isPointer() || rightType.isPointer())
        return generatePointerArithmetic(*binOp, left, right, leftType,
                                         rightType);
      if (isFloat)
        return builder_.CreateFSub(left, right);
      return builder_.CreateSub(left, right);
    case Token::Type::Multiply:
      if (isFloat)
        return builder_.CreateFMul(left, right);
      return builder_.CreateMul(left, right);
    case Token::Type::Divide:
      if (isFloat)
        return builder_.CreateFDiv(left, right);
      return isSigned ? builder_.CreateSDiv(left, right)
                      : builder_.CreateUDiv(left, right);
    default:
      throw Error("unknown binary operator");
    }
  }

  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    switch (unaryOp->op().type) {
    case Token::Type::Ampersand:
      return generateAddress(unaryOp->operand());

    case Token::Type::Multiply: {
      llvm::Value *pointer = generateExpr(unaryOp->operand());
      Type pointee = typeOf(unaryOp->operand()).pointee();
      return builder_.CreateLoad(getLLVMType(pointee), pointer, "deref");
    }

    case Token::Type::Minus: {
      llvm::Value *operand = generateExpr(unaryOp->operand());
      if (operand->getType()->isFloatingPointTy())
        return builder_.CreateFNeg(operand, "neg");
      llvm::Value *zero = llvm::ConstantInt::get(operand->getType(), 0);
      return builder_.CreateSub(zero, operand, "neg");
    }

    case Token::Type::Not:
      return builder_.CreateNot(generateExpr(unaryOp->operand()), "not");

    default:
      throw Error(
          std::format("unknown unary operator '{}'", unaryOp->op().value));
    }
  }

  if (auto *cast = dynamic_cast<const AST::CastNode *>(node)) {
    llvm::Value *value = generateExpr(cast->expr());
    return generateCast(value, typeOf(cast->expr()),
                        SemanticAnalyzer::parseType(cast->type()));
  }

  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    if (num->value().value.find('.') != std::string::npos) {
      float val = std::stof(num->value().value);
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
    return generateCall(*call);
  }

  throw Error("unknown expression node type");
}
