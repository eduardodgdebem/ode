#include <algorithm>
#include <cctype>
#include <string>

#include "include/Token.h"

bool is_digits(const std::string &str) {
  return std::all_of(str.begin(), str.end(), ::isdigit);
}

TokenTypes getTokenTypeByChar(char character) {
  if (std::isalpha(character)) {
    return Ident;
  }

  if (std::isspace(character)) {
    return Skip;
  }

  if (std::isdigit(character)) {
    return Number;
  }

  if (character == '+') {
    return Plus;
  }

  if (character == '-') {
    return Minus;
  }

  if (character == '*') {
    return Multiply;
  }

  if (character == '/') {
    return Divide;
  }

  if (character == '(') {
    return LParen;
  }

  if (character == ')') {
    return RParen;
  }

  if (character == '=') {
    return Equal;
  }

  if (character == ';') {
    return Semicolumn;
  }

  if (character == '"') {
    return DoubleQuotes;
  }

  if (character == '{') {
    return LBraket;
  }

  if (character == '}') {
    return RBraket;
  }

  if (character == '>') {
    return GreaterOp;
  }

  return Skip;
}

TokenTypes getTokenTypeByString(std::string value) {
  if (value.size() == 1) {
    return getTokenTypeByChar(value.at(0));
  }

  if (value == "let") {
    return Let;
  }

  if (value == "while") {
    return While;
  }

  if (value == "fn") {
    return Fn;
  }

  if (value == "if") {
    return If;
  }

  if (value == "==") {
    return EqualOp;
  }

  if (is_digits(value)) {
    return Number;
  }

  return Ident;
}
