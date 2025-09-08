#include <vector>

#include "Token.h"

struct ASTNode {
  Token value;
  ASTNode *left;
  ASTNode *right;
};

class Parser {
private:
  std::vector<Token> tokens;

  ASTNode *parseExpr();
  ASTNode *parseTerm();
  ASTNode *parseFactor();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> t) : tokens(t) {}

  ASTNode *parse();
};
