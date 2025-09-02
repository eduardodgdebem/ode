#include "include/Lexer.h"

TokenTypes Lexer::getTokenType(char character) {
  if (std::isspace(character)) {
    return INVALID;
  }

  if (std::isdigit(character)) {
    return NUMBER;
  }

  if (std::isalpha(character)) {
    return STRING;
  }

  if (character == '+') {
    return PLUS;
  }

  if (character == '-') {
    return MINUS;
  }

  if (character == '*') {
    return MULTIPLY;
  }

  if (character == '/') {
    return DIVIDE;
  }

  return INVALID;
}

Token Lexer::GetNextToken() {
  TokenTypes currTokenType = INVALID;
  TokenTypes prevTokenType = INVALID;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenType(currValue);

    if (currTokenType == INVALID) {
      if (!value.empty()) {
        return Token{.type = prevTokenType, .value = value};
      }
      continue;
    }

    if (prevTokenType != INVALID && prevTokenType != currTokenType &&
        !value.empty()) {
      pos--;
      return Token{.type = prevTokenType, .value = value};
    }

    value += currValue;
    prevTokenType = currTokenType;
  }

  return Token{};
}
