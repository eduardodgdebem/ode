#include "Analyzer.hpp"
#include "ASTNode.hpp"
#include "Helper.hpp"
#include <format>
#include <functional>
#include <memory>
#include <optional>
#include <print>
#include <stdexcept>

void ScopedSymbolTable::enterScope() { scopes.push_back({}); }

void ScopedSymbolTable::exitScope() {
  if (!scopes.empty()) {
    scopes.pop_back();
  }
}

void ScopedSymbolTable::declare(SymbolPointer symbol) {
  auto &current = scopes.back();
  if (current.find(symbol->getId()) != current.end()) {
    throw std::runtime_error(std::format(
        "Symbol already declared in this scope: {}", symbol->getId()));
  }

  current[symbol->getId()] = symbol;
}

std::optional<SymbolPointer> ScopedSymbolTable::lookup(SymbolID id) {
  for (auto it = scopes.rbegin(); it != scopes.rend(); ++it) {
    auto found = it->find(id);
    if (found != it->end()) {
      return found->second;
    }
  }

  return std::nullopt;
}

void Analyzer::analyze(ASTNode *node) {
  for (auto &child : node->children) {
    validateNode(child.get());
    analyze(child.get());
  }
}

void Analyzer::traverseTree(ASTNode *node,
                            std::function<void(ASTNode *node)> callBack) {}

void Analyzer::validateNode(ASTNode *node) {
  switch (node->type) {
  case ASTType::Block:
    validateBlock(node);
    break;
  case ASTType::VarDecl:
    validateVarDecl(node);
    break;
    // case ASTType::Assign:
    //   break;
    // case ASTType::FuncDecl:
    //   break;
    // case ASTType::FuncCall:
    //   break;
  }
}

void Analyzer::validateBlock(ASTNode *block) {
  if (block->type != ASTType::Block) {
    throw std::logic_error("ValidateBlock should only validate a Block node");
  }

  symbolsTable.enterScope();

  for (auto &child : block->children) {
    validateNode(child.get());
  }

  symbolsTable.exitScope();
}

void Analyzer::validateVarDecl(ASTNode *node) {
  if (node->type != ASTType::VarDecl) {
    throw std::logic_error("ValidateBlock should only validate a Block node");
  }

  auto symbol = symbolsTable.lookup(node->token.value);

  if (symbol.has_value()) {
    throw std::logic_error(
        std::format("variable {} cannot be declared more than once",
                    symbol.value()->getId()));
  }

  SymbolPointer newSymbol =
      std::make_shared<Symbol>(node->token.value, VarType::I32);

  symbolsTable.declare(newSymbol);
}
