#pragma once
#include "Token.hpp"

#include <format>
#include <stdexcept>
#include <string>
#include <vector>

class Lexer {
public:
  class Error : public std::runtime_error {
  public:
    explicit Error(const std::string &msg) : std::runtime_error(msg) {}
  };

  explicit Lexer(std::string_view source) : source_(std::move(source)) {}

  std::vector<Token> tokenize();

private:
  std::string source_;
};
