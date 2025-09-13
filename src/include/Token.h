#pragma once
#include <string>

enum TokenTypes {
  LET,
  IDENT,
  IF,
  ELSE,
  FN,
  WHILE,
  EQUAL,
  LPAREN,
  RPAREN,
  SEMICOLUMN,
  NUMBER,
  CHAR,
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
TokenTypes getTokenTypeByString(std::string value);
