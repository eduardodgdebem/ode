#include "include/Lexer.h"
#include <print>
#include <string>

void Token::Print() {
  std::println("{}", '{');
  std::println("  type: {}", static_cast<int>(type));
  std::println("  value: {}", value);
  std::println("{}", '}');
}

TokenTypes Lexer::getTokenType(char character) {
  if (std::isspace(character)) {
    return SKIP;
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

  return SKIP;
}

void Lexer::GetNextToken(Token *token) {
  TokenTypes currTokenType = SKIP;
  TokenTypes prevTokenType = SKIP;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenType(currValue);

    if (currTokenType == SKIP) {
      if (!value.empty()) {
        token->type = prevTokenType;
        token->value = value;
        return;
      }
      continue;
    }

    if (prevTokenType != currTokenType && !value.empty()) {
      pos--;
      token->type = prevTokenType;
      token->value = value;
      return;
    }

    value += currValue;
    prevTokenType = currTokenType;
  }

  token->type = END;
  token->value = "";
}
