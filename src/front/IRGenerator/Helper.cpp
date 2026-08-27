#include "IRGenerator.hpp"

#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalVariable.h>

llvm::Type *IRGenerator::getLLVMType(Type type) {
  // Pointers are opaque in modern LLVM, so every pointer depth lowers to the
  // same `ptr`; the pointee only matters for GEP and load/store.
  if (type.isPointer()) {
    return llvm::PointerType::get(context_, 0);
  }

  if (type.kind() == Type::Kind::Struct) {
    auto it = structTypes_.find(type.structName());
    if (it == structTypes_.end()) {
      throw Error(std::format("unknown struct '{}'", type.structName()));
    }
    return it->second;
  }

  switch (type.kind()) {
  case Type::Kind::I8:
  case Type::Kind::U8:
    return llvm::Type::getInt8Ty(context_);
  case Type::Kind::I16:
  case Type::Kind::U16:
    return llvm::Type::getInt16Ty(context_);
  case Type::Kind::I32:
  case Type::Kind::U32:
    return llvm::Type::getInt32Ty(context_);
  case Type::Kind::I64:
  case Type::Kind::U64:
    return llvm::Type::getInt64Ty(context_);
  case Type::Kind::F32:
    return llvm::Type::getFloatTy(context_);
  case Type::Kind::F64:
    return llvm::Type::getDoubleTy(context_);
  case Type::Kind::Bool:
    return llvm::Type::getInt1Ty(context_);
  case Type::Kind::Void:
    return llvm::Type::getVoidTy(context_);
  default:
    break;
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

void IRGenerator::enterScope() { allocaScopes_.push_back({}); }

void IRGenerator::exitScope() { allocaScopes_.pop_back(); }

void IRGenerator::declareLocal(const std::string &name,
                               llvm::AllocaInst *alloca) {
  allocaScopes_.back()[name] = alloca;
}

llvm::Value *IRGenerator::variableAddress(const std::string &name) {
  // Innermost first, so a shadowed name resolves to the slot the analyzer
  // type-checked it against.
  for (auto scope = allocaScopes_.rbegin(); scope != allocaScopes_.rend();
       ++scope) {
    auto it = scope->find(name);
    if (it != scope->end()) {
      return it->second;
    }
  }
  if (llvm::GlobalVariable *global = module_->getNamedGlobal(name)) {
    return global;
  }
  throw Error(std::format("variable '{}' not found", name));
}

unsigned IRGenerator::sizeInBytes(Type type) {
  return static_cast<unsigned>(
      module_->getDataLayout().getTypeAllocSize(getLLVMType(type)));
}

// Named struct types are created empty first and given bodies afterwards, so
// that two structs may hold pointers to each other.
void IRGenerator::createStructTypes() {
  for (const auto &[name, _] : structs_) {
    structTypes_[name] = llvm::StructType::create(context_, name);
  }

  for (const auto &[name, layout] : structs_) {
    std::vector<llvm::Type *> fieldTypes;
    fieldTypes.reserve(layout.fields().size());
    for (const auto &field : layout.fields()) {
      fieldTypes.push_back(getLLVMType(field.type));
    }
    structTypes_[name]->setBody(fieldTypes);
  }
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

llvm::Constant *IRGenerator::createStringConstant(const std::string &value) {
  llvm::Constant *data =
      llvm::ConstantDataArray::getString(context_, value, /*AddNull=*/true);

  auto *global = new llvm::GlobalVariable(
      *module_, data->getType(), /*isConstant=*/true,
      llvm::GlobalValue::PrivateLinkage, data, ".str");
  global->setUnnamedAddr(llvm::GlobalValue::UnnamedAddr::Global);

  return global;
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
