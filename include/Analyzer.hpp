#include "ASTNode.hpp"
#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

using SymbolID = std::string;

struct Symbol {
  SymbolID id;
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
};

class Analyzer {
private:
  ScopedSymbolTable symbolsTable;

  void validateNode(ASTNodePointer node);
  void validateBlock(ASTNodePointer node);
  void validateVarDecl(ASTNodePointer node);
  void validateAssign(ASTNodePointer node);
  void validateFuncDecl(ASTNodePointer node);
  void validateFuncCall(ASTNodePointer node);

public:
  void analyze(ASTNodePointer root);
};
