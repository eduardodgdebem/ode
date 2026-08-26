#include "IRGenerator.hpp"

#include <llvm/IR/Constants.h>
#include <llvm/IR/GlobalVariable.h>

#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Verifier.h>
#include <llvm/MC/TargetRegistry.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/Target/TargetOptions.h>
#include <llvm/TargetParser/Host.h>

IRGenerator::IRGenerator(const std::string &moduleName,
                         const ResolvedTypes &resolvedTypes,
                         const StructTable &structs)
    : module_(std::make_unique<llvm::Module>(moduleName, context_)),
      builder_(context_), resolvedTypes_(resolvedTypes), structs_(structs) {
  initializeTarget();
  createStructTypes();
}

void IRGenerator::generate(const AST::Node &root) {
  root.accept(*this);

  if (llvm::verifyModule(*module_, &llvm::errs())) {
    throw Error("module verification failed");
  }
}

// Mirrors the semantic analyzer: declare every function signature up front so
// that a body may call a function that is defined further down the file.
void IRGenerator::visit(const AST::ProgramNode &node) {
  for (const auto &stmt : node.statements()) {
    if (auto *func = dynamic_cast<const AST::FuncDeclNode *>(stmt.get())) {
      declarePrototype(func->name().value, func->returnType(), func->params());
    } else if (auto *ext =
                   dynamic_cast<const AST::ExternFuncDeclNode *>(stmt.get())) {
      declarePrototype(ext->name().value, ext->returnType(), ext->params());
    }
  }

  // Globals are emitted before any body so that a function may read one that
  // is declared below it.
  for (const auto &stmt : node.statements()) {
    if (auto *global = dynamic_cast<const AST::VarDeclNode *>(stmt.get())) {
      emitGlobal(*global);
    }
  }

  for (const auto &stmt : node.statements()) {
    if (dynamic_cast<const AST::VarDeclNode *>(stmt.get())) {
      continue; // already emitted above
    }
    stmt->accept(*this);
  }
}

// Struct layouts were turned into LLVM types by the constructor.
void IRGenerator::visit(const AST::StructDeclNode &node) {}

void IRGenerator::emitGlobal(const AST::VarDeclNode &node) {
  Type type = SemanticAnalyzer::parseType(node.type());
  llvm::Type *llvmType = getLLVMType(type);

  // The analyzer restricted global initialisers to literals, casts and
  // negations, so IRBuilder folds them all the way to a constant.
  llvm::Value *value = generateExpr(node.expr());
  auto *constant = llvm::dyn_cast<llvm::Constant>(value);
  if (!constant) {
    throw Error("internal error",
                std::format("initialiser of global '{}' did not fold to a "
                            "constant",
                            node.name().value));
  }

  new llvm::GlobalVariable(*module_, llvmType, /*isConstant=*/false,
                           llvm::GlobalValue::InternalLinkage, constant,
                           node.name().value);
}

void IRGenerator::visit(const AST::BlockNode &node) {
  enterScope();
  for (const auto &stmt : node.statements()) {
    if (builder_.GetInsertBlock()->getTerminator()) {
      break;
    }
    stmt->accept(*this);
  }
  exitScope();
}
