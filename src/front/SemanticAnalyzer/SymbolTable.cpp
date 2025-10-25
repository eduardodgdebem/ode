#include "SemanticAnalyzer.hpp"

Symbol::Symbol(std::string name, Kind kind, Type type)
    : name_(std::move(name)), kind_(kind), type_(type) {}

SymbolTable::SymbolTable() { enterScope(); }

void SymbolTable::enterScope() { scopes_.push_back({}); }

void SymbolTable::exitScope() {
  if (!scopes_.empty()) {
    scopes_.pop_back();
  }
}

void SymbolTable::declare(const std::string &name, Symbol::Kind kind,
                          Type type) {
  auto &current = scopes_.back();
  if (current.find(name) != current.end()) {
    throw SemanticAnalyzer::Error(
        std::format("symbol '{}' already declared in this scope", name));
  }

  current.emplace(name, Symbol(name, kind, type));
}

const Symbol *SymbolTable::lookup(const std::string &name) const {
  for (auto it = scopes_.rbegin(); it != scopes_.rend(); ++it) {
    auto found = it->find(name);
    if (found != it->end()) {
      return &found->second;
    }
  }
  return nullptr;
}
