#pragma once
#include <algorithm>
#include <string>
#include <unordered_map>

enum class TokenType {
  None,
  Let,
  Identifier,
  If,
  Else,
  Boolean,
  Fn,
  While,
  Equal,
  Or,
  And,
  EqualOp,
  DiffOp,
  GreaterOp,
  GreaterEqualOp,
  LesserOp,
  LesserEqualOp,
  LParen,
  RParen,
  LBraket,
  RBraket,
  Semicolumn,
  DoubleQuotes,
  Number,
  Char,
  Plus,
  Minus,
  Multiply,
  Divide,
  Comma,
  Skip,
  End
};

struct Token {
  TokenType type;
  std::string value;
};

namespace {
bool is_digits(const std::string &str) {
  return !str.empty() && std::all_of(str.begin(), str.end(), ::isdigit);
}
} // namespace

constexpr TokenType getTokenTypeByChar(char character) {
  if (std::isalpha(character)) {
    return TokenType::Identifier;
  } else if (std::isspace(character)) {
    return TokenType::Skip;
  } else if (std::isdigit(character)) {
    return TokenType::Number;
  }

  switch (character) {
  case '+':
    return TokenType::Plus;
  case '-':
    return TokenType::Minus;
  case '*':
    return TokenType::Multiply;
  case '/':
    return TokenType::Divide;
  case '(':
    return TokenType::LParen;
  case ')':
    return TokenType::RParen;
  case '=':
    return TokenType::Equal;
  case ';':
    return TokenType::Semicolumn;
  case '"':
    return TokenType::DoubleQuotes;
  case '{':
    return TokenType::LBraket;
  case '}':
    return TokenType::RBraket;
  case '>':
    return TokenType::GreaterOp;
  case '<':
    return TokenType::LesserOp;
  case ',':
    return TokenType::Comma;
  default:
    return TokenType::Identifier;
  }
}

constexpr TokenType getTokenTypeByString(std::string value) {
  if (value.size() == 1) {
    return getTokenTypeByChar(value.at(0));
  }

  static const std::unordered_map<std::string, TokenType> keywordMap = {
      {"let", TokenType::Let},
      {"while", TokenType::While},
      {"fn", TokenType::Fn},
      {"if", TokenType::If},
      {"else", TokenType::Else},
      {"true", TokenType::Boolean},
      {"false", TokenType::Boolean},
      {"==", TokenType::EqualOp},
      {"!=", TokenType::DiffOp},
      {"||", TokenType::Or},
      {"&&", TokenType::And},
      {"<=", TokenType::LesserEqualOp},
      {">=", TokenType::GreaterEqualOp},
  };

  if (auto it = keywordMap.find(value); it != keywordMap.end()) {
    return it->second;
  }

  if (is_digits(value)) {
    return TokenType::Number;
  }

  return TokenType::Identifier;
}
