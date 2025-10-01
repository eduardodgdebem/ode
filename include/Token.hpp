#pragma once
#include <algorithm>
#include <cctype>
#include <string>
#include <string_view>
#include <unordered_map>

enum class TokenType {
  None,
  Let,
  Identifier,
  If,
  Else,
  Boolean,
  Fn,
  Return,
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
  Colon,
  Type,
  Skip,
  End
};

struct Token {
  TokenType type;
  std::string value;

  Token() : type(TokenType::None), value("") {}
  Token(TokenType t, std::string v) : type(t), value(std::move(v)) {}
};

namespace TokenUtils {

inline constexpr bool isOperatorOrDelimiter(TokenType type) noexcept {
  switch (type) {
  case TokenType::Equal:
  case TokenType::LParen:
  case TokenType::LBraket:
  case TokenType::Comma:
  case TokenType::Colon:
  case TokenType::EqualOp:
  case TokenType::DiffOp:
  case TokenType::GreaterOp:
  case TokenType::GreaterEqualOp:
  case TokenType::LesserOp:
  case TokenType::LesserEqualOp:
  case TokenType::Plus:
  case TokenType::Minus:
  case TokenType::Multiply:
  case TokenType::Divide:
  case TokenType::Or:
  case TokenType::And:
  case TokenType::Return:
    return true;
  default:
    return false;
  }
}

inline bool isNumber(std::string_view str) noexcept {
  if (str.empty())
    return false;

  const size_t start = (str[0] == '-') ? 1 : 0;
  if (start >= str.length())
    return false;

  return std::all_of(str.begin() + start, str.end(),
                     [](unsigned char c) { return std::isdigit(c); });
}

inline TokenType getTokenTypeByString(std::string_view value) {
  if (value.size() == 1) {
    const char c = value[0];
    if (std::isalpha(c))
      return TokenType::Identifier;
    if (std::isdigit(c))
      return TokenType::Number;

    switch (c) {
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
    case ':':
      return TokenType::Colon;
    default:
      return TokenType::Identifier;
    }
  }

  static const std::unordered_map<std::string_view, TokenType> keywords = {
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
      {"return", TokenType::Return},
      {"number", TokenType::Type},
      {"bool", TokenType::Type},
      {"void", TokenType::Type},
  };

  if (auto it = keywords.find(value); it != keywords.end()) {
    return it->second;
  }

  return isNumber(value) ? TokenType::Number : TokenType::Identifier;
}

} // namespace TokenUtils
