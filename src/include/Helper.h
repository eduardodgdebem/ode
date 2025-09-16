#pragma once

#include <print>
#include <string>

#include "ASTNode.h"
#include "Token.h"

constexpr std::string getAstTypeName(ASTType t) {
  switch (t) {
  case Program:
    return "PROGRAM";
  case Statement:
    return "STATEMENT";
  case VarDecl:
    return "VARDECL";
  case Assign:
    return "ASSIGN";
  case IfStmt:
    return "IFSTMT";
  case WhileStmt:
    return "WHILESTMT";
  case FuncDecl:
    return "FUNCDECL";
  case ParamList:
    return "PARAMLIST";
  case ReturnStmt:
    return "RETURNSTMT";
  case ExprStmt:
    return "EXPRSTMT";
  case Block:
    return "BLOCK";
  case Expr:
    return "EXPR";
  case Term:
    return "TERM";
  case Factor:
    return "FACTOR";
  }
  return "UNKNOWN";
}

constexpr std::string getTokenTypeName(TokenTypes TokenType) {
  switch (TokenType) {
  case Number:
    return "NUMBER";
  case Char:
    return "CHAR";
  case Ident:
    return "IDENTITY";
  case Plus:
    return "PLUS";
  case Minus:
    return "MINUS";
  case Multiply:
    return "MULTIPLY";
  case Divide:
    return "DIVIDE";
  case Skip:
    return "SKIP";
  case LParen:
    return "LPAREN";
  case RParen:
    return "RPAREN";
  case LBraket:
    return "LBRAKET";
  case RBraket:
    return "RBRAKET";
  case End:
    return "END";
  case Let:
    return "LET";
  case If:
    return "IF";
  case Else:
    return "ELSE";
  case Fn:
    return "FN";
  case While:
    return "WHILE";
  case Equal:
    return "EQUAL";
  case Semicolumn:
    return "SEMICOLUMN";
  case DoubleQuotes:
    return "DOUBLEQUOTES";
  case EqualOp:
    return "EQUALOP";
  }

  return "";
}

constexpr void printToken(Token *token) {
  std::println("{}", '{');
  std::println("  type: {}", getTokenTypeName(token->type));
  std::println("  value: {}", token->value);
  std::println("{}", '}');
}
