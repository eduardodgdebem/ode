#pragma once
#include <string>
#include <vector>

#include "Token.h"

class Lexer {
private:
  size_t pos;
  std::string fileText;

  bool nextToken(Token *token);

public:
  Lexer(std::string &src) : fileText(src), pos(0) {}

  std::vector<Token> tokenize();
};
