#pragma once
#include <string>

enum TokenTypes {
  NUMBER,
  STRING,
  IDENTITY,
  PLUS,
  MINUS,
  MULTIPLY,
  DIVIDE,
  SKIP,
  END
};

struct Token {
  TokenTypes type;
  std::string value;

  void Print();
};

class Lexer {
private:
  size_t pos;
  std::string _src;

  TokenTypes getTokenType(char character);

public:
  Lexer(std::string src) { _src = src; }

  void GetNextToken(Token *token);
};
