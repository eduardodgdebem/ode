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
  case Token::Type::String:
    return "STRING";
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
  case Token::Type::Percent:
    return "PERCENT";
  case Token::Type::Pipe:
    return "PIPE";
  case Token::Type::Caret:
    return "CARET";
  case Token::Type::ShiftLeft:
    return "SHIFTLEFT";
  case Token::Type::ShiftRight:
    return "SHIFTRIGHT";
  case Token::Type::PlusAssign:
    return "PLUSASSIGN";
  case Token::Type::MinusAssign:
    return "MINUSASSIGN";
  case Token::Type::MultiplyAssign:
    return "MULTIPLYASSIGN";
  case Token::Type::DivideAssign:
    return "DIVIDEASSIGN";
  case Token::Type::PercentAssign:
    return "PERCENTASSIGN";
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
  case Token::Type::Extern:
    return "EXTERN";
  case Token::Type::Struct:
    return "STRUCT";
  case Token::Type::SizeOf:
    return "SIZEOF";
  case Token::Type::LBracket:
    return "LBRACKET";
  case Token::Type::RBracket:
    return "RBRACKET";
  case Token::Type::Dot:
    return "DOT";
  case Token::Type::As:
    return "AS";
  case Token::Type::Ampersand:
    return "AMPERSAND";
  case Token::Type::Assign:
    return "ASSIGN";
  case Token::Type::Not:
    return "NOT";
  case Token::Type::Print:
    return "PRINT";
  case Token::Type::While:
    return "WHILE";
  case Token::Type::Break:
    return "BREAK";
  case Token::Type::Continue:
    return "CONTINUE";
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
