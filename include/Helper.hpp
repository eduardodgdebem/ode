#pragma once

#include <print>
#include <string>

#include "ASTNode.hpp"
#include "Lexer/Token.hpp"

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

constexpr std::string getTokenType(Token::Type tokenType) {
  switch (tokenType) {
  case Token::Type::None:
    return "None";
  case Token::Type::Number:
    return "NUMBER";
  case Token::Type::Char:
    return "CHAR";
  case Token::Type::Identifier:
    return "IDENTITY";
  case Token::Type::Plus:
    return "PLUS";
  case Token::Type::Minus:
    return "MINUS";
  case Token::Type::Multiply:
    return "MULTIPLY";
  case Token::Type::Divide:
    return "DIVIDE";
  case Token::Type::Skip:
    return "SKIP";
  case Token::Type::LParen:
    return "LPAREN";
  case Token::Type::RParen:
    return "RPAREN";
  case Token::Type::LBraket:
    return "LBRAKET";
  case Token::Type::RBraket:
    return "RBRAKET";
  case Token::Type::End:
    return "END";
  case Token::Type::Let:
    return "LET";
  case Token::Type::If:
    return "IF";
  case Token::Type::Else:
    return "ELSE";
  case Token::Type::Fn:
    return "FN";
  case Token::Type::While:
    return "WHILE";
  case Token::Type::Equal:
    return "EQUAL";
  case Token::Type::Semicolumn:
    return "SEMICOLUMN";
  case Token::Type::DoubleQuotes:
    return "DOUBLEQUOTES";
  case Token::Type::EqualOp:
    return "EQUALOP";
  case Token::Type::Boolean:
    return "BOOLEAN";
  case Token::Type::And:
    return "AND";
  case Token::Type::Or:
    return "OR";
  case Token::Type::GreaterEqualOp:
    return "GREATEREQUALOP";
  case Token::Type::GreaterOp:
    return "GREATEROP";
  case Token::Type::DiffOp:
    return "DIFFOP";
  case Token::Type::LesserOp:
    return "LESSEROP";
  case Token::Type::LesserEqualOp:
    return "LESSEREQUALOP";
  case Token::Type::Comma:
    return "COMMA";
  case Token::Type::Return:
    return "RETURN";
  case Token::Type::Colon:
    return "COLON";
  case Token::Type::Type:
    return "TYPE";
  }

  return "";
}

constexpr void printToken(Token *token) {
  std::println("{}", '{');
  std::println("  type: {}", getTokenType(token->type));
  std::println("  value: {}", token->value);
  std::println("{}", '}');
}
