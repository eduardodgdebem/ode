#pragma once
#include <optional>
#include <string>
#include <vector>

#include "Token.h"

class Lexer {
private:
  size_t pos;
  std::string fileText;

  void skipWhitespace();
  char peek(size_t offset = 0) const;
  char advance();
  bool isAtEnd() const;

  Token makeNumber();
  Token makeIdentifier();
  Token makeString();

  std::optional<Token> nextToken();

public:
  Lexer(std::string &src) : fileText(src), pos(0) {}

  std::vector<Token> tokenize();
};
