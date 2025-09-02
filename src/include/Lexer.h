#pragma once
#include <string>

enum TokenTypes {
  NUMBER,
  STRING,
  IDENT,
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  INVALID
};

struct Token {
  TokenTypes type;
  std::string value;
};

class Lexer {
private:
  std::string _src;
  size_t pos;

  TokenTypes getTokenType(char character);

public:
  Lexer(std::string src) { _src = src; }

  Token GetNextToken();
};
