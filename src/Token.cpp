#include "include/Token.h"
#include <algorithm>
#include <cctype>
#include <string>
#include <unordered_map>

namespace {
bool is_digits(const std::string &str) {
  return !str.empty() && std::all_of(str.begin(), str.end(), ::isdigit);
}
} // namespace

TokenType getTokenTypeByChar(char character) {
  if (std::isalpha(character)) {
    return TokenType::Ident;
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
  default:
    return TokenType::Skip;
  }
}

TokenType getTokenTypeByString(std::string value) {
  if (value.size() == 1) {
    return getTokenTypeByChar(value.at(0));
  }

  static const std::unordered_map<std::string, TokenType> keywordMap = {
      {"let", TokenType::Let},
      {"while", TokenType::While},
      {"fn", TokenType::Fn},
      {"if", TokenType::If},
      {"true", TokenType::True},
      {"false", TokenType::False},
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

  return TokenType::Ident;
}
