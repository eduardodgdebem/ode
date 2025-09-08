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
};

std::string tokenTypeToString(TokenTypes TokenType);

void printToken(Token *token);

TokenTypes getTokenTypeByChar(char character);
