#include "IRGenerator.hpp"

llvm::Type *IRGenerator::getLLVMType(Type type) {
  // Pointers are opaque in modern LLVM, so every pointer depth lowers to the
  // same `ptr`; the pointee only matters for GEP and load/store.
  if (type.isPointer()) {
    return llvm::PointerType::get(context_, 0);
  }

  switch (type.kind()) {
  case Type::Kind::I8:
  case Type::Kind::U8:
    return llvm::Type::getInt8Ty(context_);
  case Type::Kind::I32:
    return llvm::Type::getInt32Ty(context_);
  case Type::Kind::I64:
  case Type::Kind::U64:
    return llvm::Type::getInt64Ty(context_);
  case Type::Kind::F32:
    return llvm::Type::getFloatTy(context_);
  case Type::Kind::Bool:
    return llvm::Type::getInt1Ty(context_);
  case Type::Kind::Void:
    return llvm::Type::getVoidTy(context_);
  }

  throw Error("unknown type");
}

llvm::AllocaInst *IRGenerator::createEntryBlockAlloca(llvm::Function *func,
                                                      const std::string &name,
                                                      llvm::Type *type) {
  llvm::IRBuilder<> tmpBuilder(&func->getEntryBlock(),
                               func->getEntryBlock().begin());
  return tmpBuilder.CreateAlloca(type, nullptr, name);
}

llvm::Value *IRGenerator::loadVariable(const std::string &name) {
  auto it = allocaMap_.find(name);
  if (it != allocaMap_.end()) {
    return builder_.CreateLoad(it->second->getAllocatedType(), it->second);
  }
  throw Error(std::format("variable '{}' not found", name));
}

llvm::Function *IRGenerator::declarePrototype(const std::string &name,
                                              const AST::Node *returnType,
                                              const AST::Node *params) {
  if (llvm::Function *existing = module_->getFunction(name)) {
    return existing;
  }

  Type retType = SemanticAnalyzer::parseType(returnType);
  std::vector<Type> paramTypes = SemanticAnalyzer::parseParamTypes(params);

  std::vector<llvm::Type *> llvmParams;
  llvmParams.reserve(paramTypes.size());
  for (Type param : paramTypes) {
    llvmParams.push_back(getLLVMType(param));
  }

  llvm::FunctionType *funcType =
      llvm::FunctionType::get(getLLVMType(retType), llvmParams, false);
  llvm::Function *func = llvm::Function::Create(
      funcType, llvm::Function::ExternalLinkage, name, module_.get());

  const auto *paramList = dynamic_cast<const AST::ParamListNode *>(params);
  if (paramList) {
    unsigned idx = 0;
    for (auto &arg : func->args()) {
      arg.setName(paramList->params()[idx++].name.value);
    }
  }

  funcReturnTypes_[name] = retType;
  return func;
}

// Re-derives the Ode type of an expression. The semantic analyzer has already
// rejected anything ill-typed, so this deliberately skips validation and only
// answers the questions codegen needs: signedness, pointee types and widths.
Type IRGenerator::typeOf(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    switch (binOp->op().type) {
    case Token::Type::Or:
    case Token::Type::And:
    case Token::Type::Equal:
    case Token::Type::NotEqual:
    case Token::Type::Greater:
    case Token::Type::GreaterEqual:
    case Token::Type::Less:
    case Token::Type::LessEqual:
      return Type(Type::Kind::Bool);
    default:
      break;
    }

    Type left = typeOf(binOp->left());
    Type right = typeOf(binOp->right());
    if (left.isPointer() && right.isPointer()) {
      return Type(Type::Kind::I64); // pointer difference
    }
    if (right.isPointer()) {
      return right;
    }
    return left;
  }

  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    switch (unaryOp->op().type) {
    case Token::Type::Not:
      return Type(Type::Kind::Bool);
    case Token::Type::Multiply:
      return typeOf(unaryOp->operand()).pointee();
    case Token::Type::Ampersand:
      return typeOf(unaryOp->operand()).pointerTo();
    default:
      return typeOf(unaryOp->operand());
    }
  }

  if (auto *cast = dynamic_cast<const AST::CastNode *>(node)) {
    return SemanticAnalyzer::parseType(cast->type());
  }

  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    if (num->value().value.find('.') != std::string::npos) {
      return Type(Type::Kind::F32);
    }
    return Type(Type::Kind::I32);
  }

  if (dynamic_cast<const AST::BooleanNode *>(node)) {
    return Type(Type::Kind::Bool);
  }

  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    auto it = varTypes_.find(ident->name().value);
    if (it == varTypes_.end()) {
      throw Error(std::format("variable '{}' not found", ident->name().value));
    }
    return it->second;
  }

  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    auto it = funcReturnTypes_.find(call->name().value);
    if (it == funcReturnTypes_.end()) {
      throw Error(
          std::format("undefined function: {}", call->name().value));
    }
    return it->second;
  }

  throw Error("unknown expression node type");
}

llvm::Function *IRGenerator::getPrintfFunction() {
  llvm::Function *printfFunc = module_->getFunction("printf");
  if (!printfFunc) {
    llvm::Type *i8PtrType = llvm::PointerType::get(context_, 0);

    llvm::FunctionType *printfType = llvm::FunctionType::get(
        llvm::Type::getInt32Ty(context_), {i8PtrType}, true);

    printfFunc = llvm::Function::Create(
        printfType, llvm::Function::ExternalLinkage, "printf", module_.get());
  }
  return printfFunc;
}
