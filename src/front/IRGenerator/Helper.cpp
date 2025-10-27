#include "IRGenerator.hpp"

llvm::Type *IRGenerator::getLLVMType(Type type) {
  switch (type) {
  case Type::I32:
    return llvm::Type::getInt32Ty(context_);
  case Type::F32:
    return llvm::Type::getFloatTy(context_);
  case Type::Bool:
    return llvm::Type::getInt1Ty(context_);
  case Type::Void:
    return llvm::Type::getVoidTy(context_);
  default:
    throw Error("unknown type");
  }
}

llvm::AllocaInst *IRGenerator::createEntryBlockAlloca(llvm::Function *func,
                                                      const std::string &name,
                                                      llvm::Type *type) {
  llvm::IRBuilder<> tmpBuilder(&func->getEntryBlock(),
                               func->getEntryBlock().begin());
  return tmpBuilder.CreateAlloca(type, nullptr, name);
}

void IRGenerator::storeVariable(const std::string &name, llvm::Value *val) {
  auto it = allocaMap_.find(name);
  if (it != allocaMap_.end()) {
    builder_.CreateStore(val, it->second);
  } else {
    throw Error(std::format("variable '{}' not found", name));
  }
}

llvm::Value *IRGenerator::loadVariable(const std::string &name) {
  auto it = allocaMap_.find(name);
  if (it != allocaMap_.end()) {
    return builder_.CreateLoad(it->second->getAllocatedType(), it->second);
  }
  throw Error(std::format("variable '{}' not found", name));
}

llvm::Function *IRGenerator::getPrintfFunction() {
  llvm::Function *printfFunc = module_->getFunction("printf");
  if (!printfFunc) {
    llvm::FunctionType *printfType = llvm::FunctionType::get(
        llvm::Type::getInt32Ty(context_),
        llvm::PointerType::get(llvm::Type::getInt8Ty(context_), 0), true);
    printfFunc = llvm::Function::Create(
        printfType, llvm::Function::ExternalLinkage, "printf", module_.get());
  }
  return printfFunc;
}
