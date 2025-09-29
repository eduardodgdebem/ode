#include "Analyzer.hpp"
#include "ASTNode.hpp"
#include <format>
#include <optional>
#include <stdexcept>

void ScopedSymbolTable::enterScope() { scopes.push_back({}); }
void ScopedSymbolTable::exitScope() {
  if (!scopes.empty()) {
    scopes.pop_back();
  }
}
void ScopedSymbolTable::declare(SymbolPointer symbol) {
  auto &current = scopes.back();
  if (current.find(symbol->id) != current.end()) {
    throw std::runtime_error(
        std::format("Symbol already declared in this scope: {}", symbol->id));
  }

  current[symbol->id] = symbol;
}

std::optional<SymbolPointer> ScopedSymbolTable::lookup(SymbolID id) {
  for (auto it = scopes.begin(); it != scopes.end(); ++it) {
    auto found = it->find(id);
    if (found != it->end()) {
      return found->second;
    }
  }

  return std::nullopt;
}

void Analyzer::analyze(ASTNodePointer node) {
  for (auto &child : node->children) {
    validateNode(std::move(child));
  }
}

void Analyzer::validateNode(ASTNodePointer node) {
  switch (node->type) {
  case ASTType::Block:
    validateBlock(std::move(node));
    break;
  case ASTType::VarDecl:
    break;
  case ASTType::Assign:
    break;
  case ASTType::FuncDecl:
    break;
  case ASTType::FuncCall:
    break;
  default:
    return;
  }
}

void Analyzer::validateBlock(ASTNodePointer block) {
  if (block->type != ASTType::Block) {
    throw std::logic_error("validateBlock should only validate a Block node");
  }

  symbolsTable.enterScope();

  for (auto &child : block->children) {
    validateNode(std::move(child));
  }

  symbolsTable.exitScope();
}

void Analyzer::validateVarDecl(ASTNodePointer node) {}
