#pragma once
#include <vector>

#include "Token.h"

enum class ASTType {
  Program,
  Statement,
  VarDecl,
  Assign,
  IfStmt,
  WhileStmt,
  FuncDecl,
  ParamList,
  ReturnStmt,
  ExprStmt,
  Block,
  Expr,
  LogicOr,
  LogicAnd,
  Equality,
  Comparison,
  Term,
  Factor,
  Primary
};

class ASTNode {
public:
  ASTType type;
  Token token;
  std::vector<ASTNode *> children;

  ASTNode(ASTType t, Token tok = Token()) : type(t), token(tok) {}

  void addChild(ASTNode *child) {
    if (child)
      children.push_back(child);
  }
};
