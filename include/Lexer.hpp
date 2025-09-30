// Lexer.hpp
#pragma once
#include "Token.hpp"
#include <optional>
#include <string_view>
#include <vector>

class Lexer {
public:
  explicit Lexer(std::string_view text)
      : source_(text), pos_(0), lastTokenType_(TokenType::None) {}

  std::vector<Token> tokenize();
  std::optional<Token> nextToken();

private:
  std::string_view source_;
  size_t pos_;
  TokenType lastTokenType_;

  void skipWhitespace() noexcept;
  bool shouldParseNegativeNumber() const noexcept;
  std::optional<Token> parseIdentifierOrKeyword();
  std::optional<Token> parseNumber(bool negative = false);
  std::optional<Token> parseOperatorOrSymbol();

  char peek(size_t offset = 0) const noexcept {
    return (pos_ + offset < source_.length()) ? source_[pos_ + offset] : '\0';
  }

  char consume() noexcept {
    return (pos_ < source_.length()) ? source_[pos_++] : '\0';
  }

  Token makeToken(TokenType type, std::string value) noexcept {
    lastTokenType_ = type;
    return Token(type, std::move(value));
  }
};
