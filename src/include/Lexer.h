#pragma once
#include <string>
#include <vector>

#include "Token.h"

class Lexer {
private:
  size_t pos;
  std::string fileText;

public:
  Lexer(std::string &src) : fileText(src), pos(0) {}

  bool nextToken(Token *token);

  std::vector<Token> tokenize();
};
