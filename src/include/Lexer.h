#pragma once
#include <string>
#include <vector>

#include "Token.h"

class Lexer {
private:
  size_t pos;
  std::string _src;

public:
  Lexer(std::string src) { _src = src; }

  bool nextToken(Token *token);

  std::vector<Token> tokenize();
};
