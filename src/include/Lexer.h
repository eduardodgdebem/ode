#pragma once
#include <string>

#include "Token.h"

class Lexer {
private:
  size_t pos;
  std::string _src;

public:
  Lexer(std::string src) { _src = src; }

  bool GetNextToken(Token *token);
};
