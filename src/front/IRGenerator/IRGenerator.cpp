#include "IRGenerator.hpp"

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

IRGenerator::IRGenerator(const std::string &moduleName)
    : module_(std::make_unique<llvm::Module>(moduleName, context_)),
      builder_(context_) {}

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

  for (const auto &stmt : node.statements()) {
    stmt->accept(*this);
  }
}

void IRGenerator::visit(const AST::BlockNode &node) {
  for (const auto &stmt : node.statements()) {
    if (builder_.GetInsertBlock()->getTerminator()) {
      break;
    }
    stmt->accept(*this);
  }
}
