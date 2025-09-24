#pragma once
#include <memory>
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
  Primary,
  FuncCall
};

class ASTNode {
public:
  ASTType type;
  Token token;
  std::vector<std::unique_ptr<ASTNode>> children;

  ASTNode(ASTType t, Token tok = Token());
  ~ASTNode();

  void addChild(std::unique_ptr<ASTNode> child);
};
