#pragma once
#include <string>

enum TokenTypes {
  Let,
  Ident,
  If,
  Else,
  Fn,
  While,
  Equal,
  Lparen,
  Rparen,
  Semicolumn,
  Number,
  Char,
  Plus,
  Minus,
  Multiply,
  Divide,
  Skip,
  End
};

struct Token {
  TokenTypes type;
  std::string value;
};

TokenTypes getTokenTypeByChar(char character);
TokenTypes getTokenTypeByString(std::string value);
