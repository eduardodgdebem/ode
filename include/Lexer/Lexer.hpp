#pragma once
#include "Token.hpp"

#include <string>
#include <vector>
class Lexer {
public:
  explicit Lexer(std::string_view source) : source_(std::move(source)) {}

  std::vector<Token> tokenize();

private:
  std::string source_;
};
