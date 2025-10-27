#include "IRGenerator.hpp"

#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
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
#include <memory>

void IRGenerator::emitToFile(const std::string &filename) {
  try {
    std::error_code ec;
    llvm::raw_fd_ostream file(filename, ec, llvm::sys::fs::OF_None);
    if (ec) {
      throw Error("could not open file", ec.message());
    }
    module_->print(file, nullptr);
    file.close();
  } catch (Error err) {
    module_->print(llvm::errs(), nullptr);
  }
}

void IRGenerator::emitObjectFile(const std::string &filename) {
  llvm::InitializeAllTargetInfos();
  llvm::InitializeAllTargets();
  llvm::InitializeAllTargetMCs();
  llvm::InitializeAllAsmParsers();
  llvm::InitializeAllAsmPrinters();

  llvm::Triple targetTriple(llvm::sys::getDefaultTargetTriple());
  module_->setTargetTriple(targetTriple);

  std::string error;
  auto target =
      llvm::TargetRegistry::lookupTarget(targetTriple.getTriple(), error);
  if (!target)
    throw Error("could not find target", error);

  llvm::TargetOptions opt;
  auto targetMachine = target->createTargetMachine(
      targetTriple, "generic", "", opt, std::nullopt, std::nullopt,
      llvm::CodeGenOptLevel::Default);
  if (!targetMachine)
    throw Error("could not create target machine");

  module_->setDataLayout(targetMachine->createDataLayout());

  std::error_code ec;
  llvm::raw_fd_ostream dest(filename, ec, llvm::sys::fs::OF_None);
  if (ec) {
    throw Error("could not open file", ec.message());
  }

  llvm::legacy::PassManager pass;
  auto fileType = llvm::CodeGenFileType::ObjectFile;

  if (targetMachine->addPassesToEmitFile(pass, dest, nullptr, fileType)) {
    throw Error("target machine could not emit object file");
  }

  pass.run(*module_);
  dest.close();
}

void IRGenerator::printIR() { module_->print(llvm::outs(), nullptr); }
