#include "ASTNode.hpp"
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

enum class VarType {
  I32,
  I64,
  Boolean,
};

using SymbolID = std::string;

class Symbol {
  SymbolID id;
  VarType type;

public:
  Symbol(SymbolID id, VarType type) : id(std::move(id)), type(type) {}

  SymbolID getId() const { return id; };
  VarType getType() const { return type; };
};

using SymbolPointer = std::shared_ptr<Symbol>;
using SymbolTable = std::unordered_map<SymbolID, SymbolPointer>;

class ScopedSymbolTable {
  std::vector<SymbolTable> scopes;

public:
  void enterScope();
  void exitScope();
  void declare(SymbolPointer symbol);
  std::optional<SymbolPointer> lookup(SymbolID id);

  ScopedSymbolTable() { enterScope(); }
};

class Analyzer {
private:
  ScopedSymbolTable symbolsTable;

  void traverseTree(ASTNode *node, std::function<void(ASTNode *node)> cb);
  void validateNode(ASTNode *node);
  void validateBlock(ASTNode *node);
  void validateVarDecl(ASTNode *node);
  void validateAssign(ASTNode *node);
  void validateFuncDecl(ASTNode *node);
  void validateFuncCall(ASTNode *node);

public:
  void analyze(ASTNode *node);
};

using AnalyzerPointer = std::unique_ptr<Analyzer>;
