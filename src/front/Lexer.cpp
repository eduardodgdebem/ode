// Lexer.cpp
#include "Lexer.hpp"

std::vector<Token> Lexer::tokenize() {
  std::vector<Token> tokens;
  tokens.reserve(source_.length() / 4);

  while (auto token = nextToken()) {
    tokens.push_back(std::move(*token));
  }

  tokens.shrink_to_fit();
  return tokens;
}

void Lexer::skipWhitespace() noexcept {
  while (pos_ < source_.length() &&
         std::isspace(static_cast<unsigned char>(source_[pos_]))) {
    ++pos_;
  }
}

bool Lexer::shouldParseNegativeNumber() const noexcept {
  if (!std::isdigit(static_cast<unsigned char>(peek(1)))) {
    return false;
  }

  return lastTokenType_ == TokenType::None ||
         TokenUtils::isOperatorOrDelimiter(lastTokenType_);
}

std::optional<Token> Lexer::parseIdentifierOrKeyword() {
  const size_t start = pos_;

  while (pos_ < source_.length()) {
    const char c = source_[pos_];
    if (!std::isalnum(static_cast<unsigned char>(c)) && c != '_') {
      break;
    }
    ++pos_;
  }

  std::string_view value = source_.substr(start, pos_ - start);
  return makeToken(TokenUtils::getTokenTypeByString(value), std::string(value));
}

std::optional<Token> Lexer::parseNumber(bool negative) {
  std::string value;

  if (negative) {
    value += '-';
    ++pos_;
  }

  const size_t start = pos_;
  while (pos_ < source_.length() &&
         std::isdigit(static_cast<unsigned char>(source_[pos_]))) {
    ++pos_;
  }

  value += source_.substr(start, pos_ - start);
  return makeToken(TokenType::Number, std::move(value));
}

std::optional<Token> Lexer::parseOperatorOrSymbol() {
  const char current = peek();
  const char next = peek(1);

  if (current == '=' && next == '=') {
    pos_ += 2;
    return makeToken(TokenType::EqualOp, "==");
  }
  if (current == '!' && next == '=') {
    pos_ += 2;
    return makeToken(TokenType::DiffOp, "!=");
  }
  if (current == '|' && next == '|') {
    pos_ += 2;
    return makeToken(TokenType::Or, "||");
  }
  if (current == '&' && next == '&') {
    pos_ += 2;
    return makeToken(TokenType::And, "&&");
  }
  if (current == '<' && next == '=') {
    pos_ += 2;
    return makeToken(TokenType::LesserEqualOp, "<=");
  }
  if (current == '>' && next == '=') {
    pos_ += 2;
    return makeToken(TokenType::GreaterEqualOp, ">=");
  }

  const char c = consume();
  switch (c) {
  case '{':
    return makeToken(TokenType::LBraket, "{");
  case '}':
    return makeToken(TokenType::RBraket, "}");
  case '(':
    return makeToken(TokenType::LParen, "(");
  case ')':
    return makeToken(TokenType::RParen, ")");
  case ';':
    return makeToken(TokenType::Semicolumn, ";");
  case '+':
    return makeToken(TokenType::Plus, "+");
  case '-':
    return makeToken(TokenType::Minus, "-");
  case '*':
    return makeToken(TokenType::Multiply, "*");
  case '/':
    return makeToken(TokenType::Divide, "/");
  case ',':
    return makeToken(TokenType::Comma, ",");
  case ':':
    return makeToken(TokenType::Colon, ":");
  case '=':
    return makeToken(TokenType::Equal, "=");
  case '<':
    return makeToken(TokenType::LesserOp, "<");
  case '>':
    return makeToken(TokenType::GreaterOp, ">");
  case '"':
    return makeToken(TokenType::DoubleQuotes, "\"");
  default:
    return makeToken(TokenType::Identifier, std::string(1, c));
  }
}

std::optional<Token> Lexer::nextToken() {
  skipWhitespace();

  if (pos_ >= source_.length()) {
    return std::nullopt;
  }

  const char current = peek();

  if (std::isalpha(static_cast<unsigned char>(current)) || current == '_') {
    return parseIdentifierOrKeyword();
  }

  if (current == '-' && shouldParseNegativeNumber()) {
    return parseNumber(true);
  }

  if (std::isdigit(static_cast<unsigned char>(current))) {
    return parseNumber(false);
  }

  return parseOperatorOrSymbol();
}
