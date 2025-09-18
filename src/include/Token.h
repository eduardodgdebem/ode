#pragma once
#include <string>

enum class TokenType {
  None,
  Let,
  Ident,
  If,
  Else,
  True,
  False,
  Fn,
  While,
  Equal,
  Or,
  And,
  EqualOp,
  DiffOp,
  GreaterOp,
  GreaterEqualOp,
  LesserOp,
  LesserEqualOp,
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
  TokenType type;
  std::string value;
};

TokenType getTokenTypeByChar(char character);
TokenType getTokenTypeByString(std::string value);
