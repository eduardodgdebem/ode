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

  return func;
}

// The semantic analyzer resolved every expression's type already; codegen
// only has to look it up. A miss means a node was generated that was never
// analyzed, which is a compiler bug rather than a problem with the input.
Type IRGenerator::typeOf(const AST::Node *node) const {
  auto it = resolvedTypes_.find(node);
  if (it == resolvedTypes_.end()) {
    throw Error("internal error",
                "expression has no resolved type; the semantic analyzer must "
                "run before code generation");
  }
  return it->second;
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
