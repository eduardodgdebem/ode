#include "IRGenerator.hpp"

namespace {
// Mirrors the analyzer's notion of an lvalue, so codegen knows whether a
// struct operand has storage it can point at.
bool isAddressable(const AST::Node *node) {
  if (dynamic_cast<const AST::IdentifierNode *>(node) ||
      dynamic_cast<const AST::FieldAccessNode *>(node) ||
      dynamic_cast<const AST::IndexNode *>(node)) {
    return true;
  }
  if (auto *unary = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    return unary->op().type == Token::Type::Multiply;
  }
  return false;
}
} // namespace

llvm::Value *IRGenerator::generateAddress(const AST::Node *node) {
  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    return variableAddress(ident->name().value);
  }

  if (auto *field = dynamic_cast<const AST::FieldAccessNode *>(node)) {
    Type objectType = typeOf(field->object());

    // `p.field` follows one level of pointer automatically, so the base is
    // either the pointer's value or the address of a struct variable.
    llvm::Value *base = objectType.isPointer()
                            ? generateExpr(field->object())
                            : generateAddress(field->object());
    Type structType =
        objectType.isPointer() ? objectType.pointee() : objectType;

    int index = structs_.at(structType.structName()).indexOf(field->field().value);
    if (index < 0) {
      throw Error(std::format("struct '{}' has no field '{}'",
                              structType.structName(), field->field().value));
    }

    return builder_.CreateStructGEP(getLLVMType(structType), base,
                                    static_cast<unsigned>(index),
                                    field->field().value);
  }

  if (auto *index = dynamic_cast<const AST::IndexNode *>(node)) {
    Type baseType = typeOf(index->base());
    llvm::Value *pointer = generateExpr(index->base());
    llvm::Value *offset = generateCast(generateExpr(index->index()),
                                       typeOf(index->index()),
                                       Type(Type::Kind::I64));

    return builder_.CreateGEP(getLLVMType(baseType.pointee()), pointer,
                              {offset}, "elem");
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

// a && b  evaluates b only when a is true.
// a || b  evaluates b only when a is false.
//
// The result comes from a phi over the two paths, whose incoming blocks are
// read from the builder rather than assumed: either operand may itself
// contain a short circuit and leave the builder somewhere else.
llvm::Value *IRGenerator::generateShortCircuit(const AST::BinaryOpNode &node) {
  const bool isAnd = node.op().type == Token::Type::And;
  const char *name = isAnd ? "and" : "or";

  llvm::Function *func = builder_.GetInsertBlock()->getParent();
  llvm::BasicBlock *rhsBB =
      llvm::BasicBlock::Create(context_, std::format("{}.rhs", name), func);
  llvm::BasicBlock *endBB =
      llvm::BasicBlock::Create(context_, std::format("{}.end", name), func);

  llvm::Value *left = generateExpr(node.left());
  llvm::BasicBlock *leftBB = builder_.GetInsertBlock();

  if (isAnd) {
    builder_.CreateCondBr(left, rhsBB, endBB);
  } else {
    builder_.CreateCondBr(left, endBB, rhsBB);
  }

  builder_.SetInsertPoint(rhsBB);
  llvm::Value *right = generateExpr(node.right());
  llvm::BasicBlock *rightBB = builder_.GetInsertBlock();
  builder_.CreateBr(endBB);

  builder_.SetInsertPoint(endBB);
  llvm::PHINode *result =
      builder_.CreatePHI(llvm::Type::getInt1Ty(context_), 2, name);

  // Taking the short path means the left operand already fixed the answer:
  // false for &&, true for ||.
  result->addIncoming(
      llvm::ConstantInt::get(llvm::Type::getInt1Ty(context_), !isAnd), leftBB);
  result->addIncoming(right, rightBB);

  return result;
}

llvm::Value *IRGenerator::generateExpr(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    if (binOp->op().type == Token::Type::And ||
        binOp->op().type == Token::Type::Or) {
      return generateShortCircuit(*binOp);
    }

    llvm::Value *left = generateExpr(binOp->left());
    llvm::Value *right = generateExpr(binOp->right());
    Type leftType = typeOf(binOp->left());
    Type rightType = typeOf(binOp->right());

    const bool isFloat = leftType.isFloat();
    // Pointers compare as unsigned; integers follow their declared signedness.
    const bool isSigned = leftType.isSigned();

    switch (binOp->op().type) {
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
    case Token::Type::Percent:
      return isSigned ? builder_.CreateSRem(left, right)
                      : builder_.CreateURem(left, right);
    case Token::Type::Ampersand:
      return builder_.CreateAnd(left, right);
    case Token::Type::Pipe:
      return builder_.CreateOr(left, right);
    case Token::Type::Caret:
      return builder_.CreateXor(left, right);
    case Token::Type::ShiftLeft:
      return builder_.CreateShl(left, right);
    case Token::Type::ShiftRight:
      // A signed right shift keeps the sign bit; an unsigned one shifts zeros
      // in, so `255 as u8 >> 4 as u8` is 15 rather than -1.
      return isSigned ? builder_.CreateAShr(left, right)
                      : builder_.CreateLShr(left, right);
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

    case Token::Type::Plus:
      return generateExpr(unaryOp->operand());

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

  if (auto *field = dynamic_cast<const AST::FieldAccessNode *>(node)) {
    Type objectType = typeOf(field->object());

    // A struct that has no storage -- a call result, say -- cannot be GEPed
    // into, so read the field straight out of the aggregate value.
    if (!objectType.isPointer() && !isAddressable(field->object())) {
      Type structType = objectType;
      int index =
          structs_.at(structType.structName()).indexOf(field->field().value);
      return builder_.CreateExtractValue(generateExpr(field->object()),
                                         {static_cast<unsigned>(index)},
                                         field->field().value);
    }

    return builder_.CreateLoad(getLLVMType(typeOf(node)),
                               generateAddress(node), field->field().value);
  }

  if (dynamic_cast<const AST::IndexNode *>(node)) {
    return builder_.CreateLoad(getLLVMType(typeOf(node)),
                               generateAddress(node), "elem");
  }

  if (auto *literal = dynamic_cast<const AST::StructLiteralNode *>(node)) {
    Type type = Type::structType(literal->typeName().value);
    const StructLayout &layout = structs_.at(literal->typeName().value);
    auto *structType = llvm::cast<llvm::StructType>(getLLVMType(type));

    // Evaluate in the order written so side effects stay predictable, then
    // place each value at its declared position.
    std::vector<std::pair<unsigned, llvm::Value *>> values;
    values.reserve(literal->fields().size());
    for (const auto &init : literal->fields()) {
      int index = layout.indexOf(init.name.value);
      values.emplace_back(static_cast<unsigned>(index),
                          generateExpr(init.value.get()));
    }

    llvm::Value *aggregate = llvm::UndefValue::get(structType);
    for (const auto &[index, value] : values) {
      aggregate = builder_.CreateInsertValue(aggregate, value, {index});
    }
    return aggregate;
  }

  if (auto *sizeOf = dynamic_cast<const AST::SizeOfNode *>(node)) {
    Type type = SemanticAnalyzer::parseType(sizeOf->type());
    return llvm::ConstantInt::get(llvm::Type::getInt64Ty(context_),
                                  sizeInBytes(type));
  }

  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    if (num->value().value.find('.') != std::string::npos) {
      float val = std::stof(num->value().value);
      return llvm::ConstantFP::get(llvm::Type::getFloatTy(context_), val);
    }
    long long val = std::stoll(num->value().value);
    return llvm::ConstantInt::get(llvm::Type::getInt32Ty(context_), val);
  }

  if (auto *str = dynamic_cast<const AST::StringLiteralNode *>(node)) {
    return createStringConstant(str->value().value);
  }

  if (auto *character = dynamic_cast<const AST::CharLiteralNode *>(node)) {
    return llvm::ConstantInt::get(
        llvm::Type::getInt8Ty(context_),
        static_cast<unsigned char>(character->value().value[0]));
  }

  if (auto *boolean = dynamic_cast<const AST::BooleanNode *>(node)) {
    bool val = boolean->value().value == "true";
    return llvm::ConstantInt::get(llvm::Type::getInt1Ty(context_), val);
  }

  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    return builder_.CreateLoad(getLLVMType(typeOf(node)),
                               variableAddress(ident->name().value),
                               ident->name().value);
  }

  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    return generateCall(*call);
  }

  throw Error("unknown expression node type");
}
