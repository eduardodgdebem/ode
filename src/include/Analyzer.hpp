#include "ASTNode.hpp"
#include <memory>
#include <string>
#include <unordered_map>

using SymbolID = std::string;

struct Symbol {
  SymbolID id;
};

using SymbolPointer = std::shared_ptr<Symbol>;
using SymbolsTable = std::unordered_map<SymbolID, SymbolPointer>;

class Analyzer {
private:
  SymbolsTable symbolsTable;

public:
  ASTNodePointer analyze(ASTNodePointer root);
};
