#pragma once

#include <print>
#include <string>

#include "ASTNode.h"
#include "Token.h"

constexpr std::string getAstTypeName(ASTType t) {
  switch (t) {
  case ASTType::Program:
    return "PROGRAM";
  case ASTType::Statement:
    return "STATEMENT";
  case ASTType::VarDecl:
    return "VARDECL";
  case ASTType::Assign:
    return "ASSIGN";
  case ASTType::IfStmt:
    return "IFSTMT";
  case ASTType::WhileStmt:
    return "WHILESTMT";
  case ASTType::FuncDecl:
    return "FUNCDECL";
  case ASTType::ParamList:
    return "PARAMLIST";
  case ASTType::ReturnStmt:
    return "RETURNSTMT";
  case ASTType::ExprStmt:
    return "EXPRSTMT";
  case ASTType::Block:
    return "BLOCK";
  case ASTType::Term:
    return "TERM";
  case ASTType::Factor:
    return "FACTOR";
  case ASTType::Primary:
    return "PRIMARY";
  case ASTType::Expr:
    return "EXPR";
  case ASTType::LogicAnd:
    return "LOGICAND";
  case ASTType::LogicOr:
    return "LogicOr";
  case ASTType::Comparison:
    return "COMPARISON";
  case ASTType::Equality:
    return "EQUALITY";
  case ASTType::FuncCall:
    return "FUNCCALL";
  case ASTType::Type:
    return "TYPE";
  }
  return "UNKNOWN";
}

constexpr std::string getTokenTypeName(TokenType TokenType) {
  switch (TokenType) {
  case TokenType::None:
    return "None";
  case TokenType::Number:
    return "NUMBER";
  case TokenType::Char:
    return "CHAR";
  case TokenType::Identifier:
    return "IDENTITY";
  case TokenType::Plus:
    return "PLUS";
  case TokenType::Minus:
    return "MINUS";
  case TokenType::Multiply:
    return "MULTIPLY";
  case TokenType::Divide:
    return "DIVIDE";
  case TokenType::Skip:
    return "SKIP";
  case TokenType::LParen:
    return "LPAREN";
  case TokenType::RParen:
    return "RPAREN";
  case TokenType::LBraket:
    return "LBRAKET";
  case TokenType::RBraket:
    return "RBRAKET";
  case TokenType::End:
    return "END";
  case TokenType::Let:
    return "LET";
  case TokenType::If:
    return "IF";
  case TokenType::Else:
    return "ELSE";
  case TokenType::Fn:
    return "FN";
  case TokenType::While:
    return "WHILE";
  case TokenType::Equal:
    return "EQUAL";
  case TokenType::Semicolumn:
    return "SEMICOLUMN";
  case TokenType::DoubleQuotes:
    return "DOUBLEQUOTES";
  case TokenType::EqualOp:
    return "EQUALOP";
  case TokenType::Boolean:
    return "BOOLEAN";
  case TokenType::And:
    return "AND";
  case TokenType::Or:
    return "OR";
  case TokenType::GreaterEqualOp:
    return "GREATEREQUALOP";
  case TokenType::GreaterOp:
    return "GREATEROP";
  case TokenType::DiffOp:
    return "DIFFOP";
  case TokenType::LesserOp:
    return "LESSEROP";
  case TokenType::LesserEqualOp:
    return "LESSEREQUALOP";
  case TokenType::Comma:
    return "COMMA";
  case TokenType::Return:
    return "RETURN";
  case TokenType::Colon:
    return "COLON";
  case TokenType::Type:
    return "TYPE";
  }

  return "";
}

constexpr void printToken(Token *token) {
  std::println("{}", '{');
  std::println("  type: {}", getTokenTypeName(token->type));
  std::println("  value: {}", token->value);
  std::println("{}", '}');
}
