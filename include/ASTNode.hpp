#pragma once
#include <memory>
#include <vector>

#include "Lexer/Token.hpp"

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
  PrintStmt,
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
  FuncCall,
  ArgList,
  Type
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

using ASTNodePointer = std::unique_ptr<ASTNode>;
