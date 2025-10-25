#pragma once

#include <print>
#include <string>

#include "Lexer/Token.hpp"

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
  case Token::Type::LBrace:
    return "LBRAKET";
  case Token::Type::RBrace:
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
  case Token::Type::Semicolon:
    return "SEMICOLUMN";
  case Token::Type::DoubleQuotes:
    return "DOUBLEQUOTES";
  case Token::Type::Boolean:
    return "BOOLEAN";
  case Token::Type::And:
    return "AND";
  case Token::Type::Or:
    return "OR";
  case Token::Type::GreaterEqual:
    return "GREATEREQUALOP";
  case Token::Type::Greater:
    return "GREATEROP";
  case Token::Type::NotEqual:
    return "DIFFOP";
  case Token::Type::Less:
    return "LESSEROP";
  case Token::Type::LessEqual:
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
