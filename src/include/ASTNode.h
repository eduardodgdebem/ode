#pragma once
#include <vector>

#include "Token.h"

enum ASTType {
  Program,
  Statement,
  Vardecl,
  Assign,
  IfStmt,
  WhileStmt,
  FuncDecl,
  ParamList,
  ReturnStmt,
  ExprStmt,
  Block,
  Expr,
  Term,
  Factor
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
