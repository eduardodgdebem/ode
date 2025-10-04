#pragma once
#include <vector>

#include "ASTNode.hpp"
#include "Token.hpp"

class Parser {
private:
  std::vector<Token> tokens;
  size_t pos;

  ASTNodePointer parseProgram();
  ASTNodePointer parseStatement();
  ASTNodePointer parseBlock();
  ASTNodePointer parseWhileStmnt();
  ASTNodePointer parseIfStmnt();
  ASTNodePointer parseFuncDecl();
  ASTNodePointer parseFuncCall();
  ASTNodePointer parseArgList();
  ASTNodePointer parseParamList();
  ASTNodePointer parseReturnStmt();
  ASTNodePointer parseVarDecl();
  ASTNodePointer parseAssign();
  ASTNodePointer parseExprStm();
  ASTNodePointer parseExpr();
  ASTNodePointer parseLogicOr();
  ASTNodePointer parseLogicAnd();
  ASTNodePointer parseEquality();
  ASTNodePointer parseComparison();
  ASTNodePointer parseTerm();
  ASTNodePointer parseFactor();
  ASTNodePointer parsePrimary();
  ASTNodePointer parseType();

  Token currentToken();
  Token peekToken(int offset = 1);
  void consumeToken();

public:
  Parser(std::vector<Token> &t) : tokens(t), pos(0) {}

  ASTNodePointer parse();
};
