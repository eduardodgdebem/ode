#pragma once
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/LegacyPassManager.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Verifier.h>
#include <llvm/MC/TargetRegistry.h>
#include <llvm/Support/FileSystem.h>
#include <llvm/Support/TargetSelect.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Target/TargetMachine.h>
#include <llvm/Target/TargetOptions.h>
#include <llvm/TargetParser/Host.h>

#include <format>
#include <memory>
#include <stdexcept>
#include <string>
#include <unordered_map>

#include "ASTNode.hpp"
#include "Analyzer.hpp"

class IRGenerator {
private:
  llvm::LLVMContext context;
  std::unique_ptr<llvm::Module> module;
  llvm::IRBuilder<> builder;
  std::unordered_map<std::string, llvm::Value *> namedValues;
  std::unordered_map<std::string, llvm::AllocaInst *> allocaMap;
  llvm::Function *currentFunc = nullptr;

  llvm::Type *getVarType(VarType t) {
    switch (t) {
    case VarType::I32:
      return llvm::Type::getInt32Ty(context);
    case VarType::I64:
      return llvm::Type::getInt64Ty(context);
    case VarType::Boolean:
      return llvm::Type::getInt1Ty(context);
    case VarType::Void:
      return llvm::Type::getVoidTy(context);
    default:
      throw std::runtime_error("unknown variable type");
    }
  }

  llvm::AllocaInst *createEntryBlockAlloca(llvm::Function *func,
                                           const std::string &name,
                                           llvm::Type *type) {
    llvm::IRBuilder<> tmpBuilder(&func->getEntryBlock(),
                                 func->getEntryBlock().begin());
    return tmpBuilder.CreateAlloca(type, nullptr, name);
  }

  void storeVariable(const std::string &name, llvm::Value *val) {
    auto it = allocaMap.find(name);
    if (it != allocaMap.end()) {
      builder.CreateStore(val, it->second);
    } else {
      throw std::runtime_error(std::format("variable '{}' not found", name));
    }
  }

  llvm::Value *loadVariable(const std::string &name) {
    auto it = allocaMap.find(name);
    if (it != allocaMap.end()) {
      return builder.CreateLoad(it->second->getAllocatedType(), it->second);
    }
    throw std::runtime_error(std::format("variable '{}' not found", name));
  }

public:
  IRGenerator(const std::string &moduleName)
      : module(std::make_unique<llvm::Module>(moduleName, context)),
        builder(context) {}

  void generate(ASTNode *root) {
    if (root->type != ASTType::Program) {
      throw std::logic_error("Root node must be a Program");
    }

    for (auto &child : root->children) {
      if (child->type == ASTType::FuncDecl) {
        generateFuncDecl(child.get());
      }
    }

    if (llvm::verifyModule(*module, &llvm::errs())) {
      throw std::runtime_error("Module verification failed");
    }
  }

  void generateFuncDecl(ASTNode *node) {
    if (node->children.size() < 3) {
      throw std::logic_error("FuncDecl must have at least 3 children");
    }

    ASTNode *retTypeNode = node->children[0].get();
    ASTNode *paramListNode = node->children[1].get();
    ASTNode *blockNode = node->children[2].get();

    VarType retType = Analyzer::tokenTypeToVarType(retTypeNode->token.value);
    llvm::Type *llvmRetType = getVarType(retType);

    std::vector<llvm::Type *> paramTypes;
    std::vector<std::string> paramNames;

    for (auto &param : paramListNode->children) {
      if (param->children.empty()) {
        throw std::logic_error("Parameter missing type");
      }
      VarType paramType =
          Analyzer::tokenTypeToVarType(param->children[0]->token.value);
      paramTypes.push_back(getVarType(paramType));
      paramNames.push_back(param->token.value);
    }

    llvm::FunctionType *funcType =
        llvm::FunctionType::get(llvmRetType, paramTypes, false);
    llvm::Function *func =
        llvm::Function::Create(funcType, llvm::Function::ExternalLinkage,
                               node->token.value, module.get());

    unsigned idx = 0;
    for (auto &arg : func->args()) {
      arg.setName(paramNames[idx++]);
    }

    llvm::BasicBlock *block = llvm::BasicBlock::Create(context, "entry", func);
    builder.SetInsertPoint(block);

    currentFunc = func;
    allocaMap.clear();

    idx = 0;
    for (auto &arg : func->args()) {
      llvm::AllocaInst *alloca =
          createEntryBlockAlloca(func, arg.getName().str(), arg.getType());
      allocaMap[arg.getName().str()] = alloca;
      builder.CreateStore(&arg, alloca);
      idx++;
    }

    generateBlock(blockNode);

    if (!block->getTerminator()) {
      builder.CreateRet(llvm::ConstantInt::get(llvmRetType, 0));
    }

    currentFunc = nullptr;
  }

  void generateBlock(ASTNode *node) {
    if (node->type != ASTType::Block) {
      throw std::logic_error("generateBlock expects a Block node");
    }

    for (auto &child : node->children) {
      if (!builder.GetInsertBlock()->getTerminator()) {
        generateStatement(child.get());
      }
    }
  }

  void generateStatement(ASTNode *node) {
    switch (node->type) {
    case ASTType::VarDecl:
      generateVarDecl(node);
      break;
    case ASTType::Assign:
      generateAssign(node);
      break;
    case ASTType::IfStmt:
      generateIfStmt(node);
      break;
    case ASTType::WhileStmt:
      generateWhileStmt(node);
      break;
    case ASTType::ReturnStmt:
      generateReturnStmt(node);
      break;
    case ASTType::PrintStmt:
      generatePrintStmt(node);
      break;
    case ASTType::ExprStmt:
      generateExprStmt(node);
      break;
    case ASTType::Block:
      generateBlock(node);
      break;
    default:
      break;
    }
  }

  void generateVarDecl(ASTNode *node) {
    if (node->children.size() < 2) {
      throw std::logic_error("VarDecl must have type and expression children");
    }

    ASTNode *typeNode = node->children[0].get();
    ASTNode *exprNode = node->children[1].get();

    VarType varType = Analyzer::tokenTypeToVarType(typeNode->token.value);
    llvm::Type *llvmType = getVarType(varType);

    llvm::AllocaInst *alloca =
        createEntryBlockAlloca(currentFunc, node->token.value, llvmType);
    allocaMap[node->token.value] = alloca;

    llvm::Value *val = generateExpr(exprNode);
    builder.CreateStore(val, alloca);
  }

  void generateAssign(ASTNode *node) {
    if (node->children.empty()) {
      throw std::logic_error("Assign must have expression child");
    }

    llvm::Value *val = generateExpr(node->children[0].get());
    storeVariable(node->token.value, val);
  }

  void generateIfStmt(ASTNode *node) {
    if (node->children.size() < 2) {
      throw std::logic_error("IfStmt must have condition and block");
    }

    llvm::Value *condVal = generateExpr(node->children[0].get());
    condVal = builder.CreateICmpNE(
        condVal, llvm::ConstantInt::get(llvm::Type::getInt1Ty(context), 0));

    llvm::Function *func = builder.GetInsertBlock()->getParent();

    llvm::BasicBlock *thenBB = llvm::BasicBlock::Create(context, "then", func);
    llvm::BasicBlock *elseBB = nullptr;
    llvm::BasicBlock *mergeBB =
        llvm::BasicBlock::Create(context, "merge", func);

    if (node->children.size() >= 3) {
      elseBB = llvm::BasicBlock::Create(context, "else", func);
      builder.CreateCondBr(condVal, thenBB, elseBB);
    } else {
      builder.CreateCondBr(condVal, thenBB, mergeBB);
    }

    builder.SetInsertPoint(thenBB);
    generateBlock(node->children[1].get());
    if (!thenBB->getTerminator()) {
      builder.CreateBr(mergeBB);
    }

    if (elseBB) {
      builder.SetInsertPoint(elseBB);
      generateBlock(node->children[2].get());
      if (!elseBB->getTerminator()) {
        builder.CreateBr(mergeBB);
      }
    }

    builder.SetInsertPoint(mergeBB);
  }

  void generateWhileStmt(ASTNode *node) {
    if (node->children.size() < 2) {
      throw std::logic_error("WhileStmt must have condition and block");
    }

    llvm::Function *func = builder.GetInsertBlock()->getParent();
    llvm::BasicBlock *condBB =
        llvm::BasicBlock::Create(context, "while.cond", func);
    llvm::BasicBlock *bodyBB =
        llvm::BasicBlock::Create(context, "while.body", func);
    llvm::BasicBlock *endBB =
        llvm::BasicBlock::Create(context, "while.end", func);

    builder.CreateBr(condBB);

    builder.SetInsertPoint(condBB);
    llvm::Value *condVal = generateExpr(node->children[0].get());
    condVal = builder.CreateICmpNE(
        condVal, llvm::ConstantInt::get(llvm::Type::getInt1Ty(context), 0));
    builder.CreateCondBr(condVal, bodyBB, endBB);

    builder.SetInsertPoint(bodyBB);
    generateBlock(node->children[1].get());
    if (!bodyBB->getTerminator()) {
      builder.CreateBr(condBB);
    }

    builder.SetInsertPoint(endBB);
  }

  void generateReturnStmt(ASTNode *node) {
    if (node->children.empty()) {
      throw std::logic_error("ReturnStmt must have expression");
    }

    llvm::Value *retVal = generateExpr(node->children[0].get());

    builder.CreateRet(retVal);
  }

  void generatePrintStmt(ASTNode *node) {
    if (node->children.empty()) {
      throw std::logic_error("PrintStmt must have expression");
    }

    llvm::Value *expr = generateExpr(node->children[0].get());

    std::string formatStr = "%d\n";
    llvm::Value *formatStrVal = builder.CreateGlobalString(formatStr);

    llvm::Function *printfFunc = module->getFunction("printf");
    if (!printfFunc) {
      llvm::FunctionType *printfType = llvm::FunctionType::get(
          llvm::Type::getInt32Ty(context),
          llvm::PointerType::get(llvm::Type::getInt8Ty(context), 0), true);
      printfFunc = llvm::Function::Create(
          printfType, llvm::Function::ExternalLinkage, "printf", module.get());
    }

    std::vector<llvm::Value *> args;
    args.push_back(formatStrVal);
    args.push_back(expr);
    builder.CreateCall(printfFunc, args);
  }

  void generateExprStmt(ASTNode *node) {
    if (node->children.empty()) {
      throw std::logic_error("ExprStmt must have expression");
    }
    generateExpr(node->children[0].get());
  }

  llvm::Value *generateExpr(ASTNode *node) {
    if (node->type != ASTType::Expr) {
      throw std::logic_error("generateExpr expects Expr node");
    }
    if (node->children.empty()) {
      throw std::logic_error("Expr node must have children");
    }
    return generateAnyExpr(node->children[0].get());
  }

  llvm::Value *generateAnyExpr(ASTNode *node) {
    switch (node->type) {
    case ASTType::LogicOr:
      return generateLogicOr(node);
    case ASTType::LogicAnd:
      return generateLogicAnd(node);
    case ASTType::Equality:
      return generateEquality(node);
    case ASTType::Comparison:
      return generateComparison(node);
    case ASTType::Term:
      return generateTerm(node);
    case ASTType::Factor:
      return generateFactor(node);
    case ASTType::Primary:
      return generatePrimary(node);
    case ASTType::Expr:
      return generateExpr(node);
    default:
      throw std::logic_error(std::format("unexpected node type: {}",
                                         static_cast<int>(node->type)));
    }
  }

  llvm::Value *generateLogicOr(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());
    return builder.CreateOr(lhs, rhs);
  }

  llvm::Value *generateLogicAnd(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());
    return builder.CreateAnd(lhs, rhs);
  }

  llvm::Value *generateEquality(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());

    std::string op = node->token.value;
    if (op == "==") {
      return builder.CreateICmpEQ(lhs, rhs);
    }
    return builder.CreateICmpNE(lhs, rhs);
  }

  llvm::Value *generateComparison(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());

    std::string op = node->token.value;
    if (op == "<") {
      return builder.CreateICmpSLT(lhs, rhs);
    } else if (op == ">") {
      return builder.CreateICmpSGT(lhs, rhs);
    } else if (op == "<=") {
      return builder.CreateICmpSLE(lhs, rhs);
    }
    return builder.CreateICmpSGE(lhs, rhs);
  }

  llvm::Value *generateTerm(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());

    if (node->token.value == "+") {
      return builder.CreateAdd(lhs, rhs);
    }
    return builder.CreateSub(lhs, rhs);
  }

  llvm::Value *generateFactor(ASTNode *node) {
    llvm::Value *lhs = generateAnyExpr(node->children[0].get());
    llvm::Value *rhs = generateAnyExpr(node->children[1].get());

    if (node->token.value == "*") {
      return builder.CreateMul(lhs, rhs);
    }
    return builder.CreateSDiv(lhs, rhs);
  }

  llvm::Value *generatePrimary(ASTNode *node) {
    if (node->type != ASTType::Primary) {
      throw std::logic_error("generatePrimary expects Primary node");
    }

    if (node->token.type == Token::Type::Number) {
      long long val = std::stoll(node->token.value);
      if (val >= std::numeric_limits<int32_t>::min() &&
          val <= std::numeric_limits<int32_t>::max()) {
        return llvm::ConstantInt::get(llvm::Type::getInt32Ty(context), val);
      }
      return llvm::ConstantInt::get(llvm::Type::getInt64Ty(context), val);
    } else if (node->token.type == Token::Type::Boolean) {
      bool val = node->token.value == "true";
      return llvm::ConstantInt::get(llvm::Type::getInt1Ty(context), val);
    } else if (node->token.type == Token::Type::Identifier) {
      return loadVariable(node->token.value);
    }

    throw std::logic_error("unexpected token type in primary");
  }

  void emitToFile(const std::string &filename) {
    std::error_code ec;
    llvm::raw_fd_ostream file(filename, ec, llvm::sys::fs::OF_None);
    if (ec) {
      throw std::runtime_error(
          std::format("could not open file: {}", ec.message()));
    }
    module->print(file, nullptr);
    file.close();
  }

  void emitObjectFile(const std::string &filename) {
    llvm::InitializeAllTargetInfos();
    llvm::InitializeAllTargets();
    llvm::InitializeAllTargetMCs();
    llvm::InitializeAllAsmParsers();
    llvm::InitializeAllAsmPrinters();

    std::string targetTripleStr = llvm::sys::getDefaultTargetTriple();
    module->setTargetTriple(llvm::Triple(targetTripleStr));

    std::string error;
    auto target = llvm::TargetRegistry::lookupTarget(targetTripleStr, error);
    if (!target) {
      throw std::runtime_error(std::format("could not find target: {}", error));
    }

    llvm::TargetOptions opt;
    auto targetMachine =
        target->createTargetMachine(targetTripleStr, "generic", "", opt,
                                    std::nullopt, // Relocation model
                                    std::nullopt, // Code model
                                    llvm::CodeGenOptLevel::Default,
                                    false // JIT
        );

    if (!targetMachine) {
      throw std::runtime_error("could not create target machine");
    }

    module->setDataLayout(targetMachine->createDataLayout());

    std::error_code ec;
    llvm::raw_fd_ostream dest(filename, ec, llvm::sys::fs::OF_None);
    if (ec) {
      throw std::runtime_error(
          std::format("could not open file: {}", ec.message()));
    }

    llvm::legacy::PassManager pass;
    auto fileType = llvm::CodeGenFileType::ObjectFile;

    if (targetMachine->addPassesToEmitFile(pass, dest, nullptr, fileType)) {
      throw std::runtime_error("target machine could not emit object file");
    }

    pass.run(*module);
    dest.close();
  }

  llvm::Module *getModule() { return module.get(); }

  void printIR() { module->print(llvm::outs(), nullptr); }
};
