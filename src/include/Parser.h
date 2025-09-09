#pragma once
#include <vector>

#include "Token.h"

struct ASTNode {
  Token value;
  ASTNode *left;
  ASTNode *right;

  ASTNode(Token v, ASTNode *l, ASTNode *r) : value(v), left(l), right(r) {}
};

class Parser {
private:
  std::vector<Token> tokens;
  size_t pos;

  ASTNode *parseExpr();
  ASTNode *parseTerm();
  ASTNode *parseFactor();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> t) : tokens(t) {}

  ASTNode *parse();
};
