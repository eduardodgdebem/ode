#pragma once

#include "Token.hpp"
#include <optional>
#include <string>
#include <tuple>
#include <vector>

class Lexer {
public:
  Lexer(std::string fileText) : fileText(fileText), pos(0) {}
  std::vector<Token> tokenize() const;

private:
  std::string fileText;
  mutable int pos;
  std::optional<Token> nextToken() const;
  std::tuple<TokenType, std::string> getTokenDetails() const;
};
