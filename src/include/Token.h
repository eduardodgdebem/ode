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
  EqualOp,
  GreaterOp,
  LesserOp,
  LParen,
  RParen,
  LBraket,
  RBraket,
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
