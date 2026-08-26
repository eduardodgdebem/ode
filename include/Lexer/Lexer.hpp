#pragma once
#include "Token.hpp"

#include "SourceError.hpp"

#include <format>
#include <string>
#include <vector>

class Lexer {
public:
  class Error : public SourceError {
  public:
    Error(const std::string &msg, int line = 0, int column = 0)
        : SourceError(msg, line, column) {}
  };

  explicit Lexer(std::string_view source) : source_(std::move(source)) {}

  std::vector<Token> tokenize();

private:
  std::string source_;
};
