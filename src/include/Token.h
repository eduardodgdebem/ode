#pragma once
#include <string>

enum TokenTypes {
  None,
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
  DoubleQuotes,
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
