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
  ASTNode *parseBlock();
  ASTNode *parseIfStmnt();
  ASTNode *parseVarDecl();
  ASTNode *parseAssign(bool isVarDecl = false);
  ASTNode *parseExprStm();
  ASTNode *parseExpr();
  ASTNode *parseLogicOr();
  ASTNode *parseLogicAnd();
  ASTNode *parseEquality();
  ASTNode *parseComparison();
  ASTNode *parseTerm();
  ASTNode *parseFactor();
  ASTNode *parsePrimary();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> &t) : tokens(t), pos(0) {}

  ASTNode *parse();
};
