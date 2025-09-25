#pragma once
#include <memory>
#include <vector>

#include "ASTNode.hpp"
#include "Token.hpp"

class Parser {
private:
  std::vector<Token> tokens;
  size_t pos;

  std::unique_ptr<ASTNode> parseProgram();
  std::unique_ptr<ASTNode> parseStatement();
  std::unique_ptr<ASTNode> parseBlock();
  std::unique_ptr<ASTNode> parseWhileStmnt();
  std::unique_ptr<ASTNode> parseIfStmnt();
  std::unique_ptr<ASTNode> parseFuncDecl();
  std::unique_ptr<ASTNode> parseCall(Token token);
  std::unique_ptr<ASTNode> parseParamList();
  std::unique_ptr<ASTNode> parseReturnStmt();
  std::unique_ptr<ASTNode> parseVarDecl();
  std::unique_ptr<ASTNode> parseAssign();
  std::unique_ptr<ASTNode> parseExprStm();
  std::unique_ptr<ASTNode> parseExpr();
  std::unique_ptr<ASTNode> parseLogicOr();
  std::unique_ptr<ASTNode> parseLogicAnd();
  std::unique_ptr<ASTNode> parseEquality();
  std::unique_ptr<ASTNode> parseComparison();
  std::unique_ptr<ASTNode> parseTerm();
  std::unique_ptr<ASTNode> parseFactor();
  std::unique_ptr<ASTNode> parsePrimary();
  std::unique_ptr<ASTNode> parseType();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> &t) : tokens(t), pos(0) {}

  std::unique_ptr<ASTNode> parse();
};
