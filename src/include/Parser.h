#pragma once
#include <vector>

#include "Token.h"

enum ASTType {
  PROGRAM,
  STATEMENT,
  VARDECL,
  ASSIGN,
  IFSTMT,
  WHILESTMT,
  FUNCDECL,
  PARAMLIST,
  RETURNSTMT,
  EXPRSTMT,
  BLOCK,
  EXPR,
  TERM,
  FACTOR
};

struct ASTNode {
  ASTType type;
  Token token;
  std::vector<ASTNode *> children;

  ASTNode(ASTType t, Token tok = Token()) : type(t), token(tok) {}

  void addChild(ASTNode *child) {
    if (child)
      children.push_back(child);
  }
};

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
  ASTNode *parseExprStm();

  Token currentToken();
  void consumeToken();

public:
  Parser(std::vector<Token> t) : tokens(t), pos(0) {}

  ASTNode *parse();
};
