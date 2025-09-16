#pragma once
#include <vector>

#include "ASTNode.h"
#include "Token.h"

class Parser {
private:
  std::vector<Token> tokens;
  size_t pos;

  ASTNode *parseProgram();
  ASTNode *parseStatement();
  ASTNode *parseExpr();
  ASTNode *parseTerm();
  ASTNode *parseFactor();
  ASTNode *parseVarDecl();
  ASTNode *parseAssign();
  ASTNode *parseExprStm();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> t) : tokens(t), pos(0) {}

  ASTNode *parse();
};
