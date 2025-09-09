#include <print>

#include "include/Token.h"

TokenTypes getTokenTypeByChar(char character) {
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

  if (character == '(') {
    return LPAREN;
  }

  if (character == ')') {
    return RPAREN;
  }

  return SKIP;
}

std::string tokenTypeToString(TokenTypes TokenType) {
  switch (TokenType) {
  case NUMBER:
    return "NUMBER";
  case STRING:
    return "STRING";
  case IDENTITY:
    return "IDENTITY";
  case PLUS:
    return "PLUS";
  case MINUS:
    return "MINUS";
  case MULTIPLY:
    return "MULTIPLY";
  case DIVIDE:
    return "DIVIDE";
  case SKIP:
    return "SKIP";
  case LPAREN:
    return "LPAREN";
  case RPAREN:
    return "RPAREN";
  case END:
    return "END";
  }
}

void printToken(Token *token) {
  std::println("{}", '{');
  std::println("  type: {}", tokenTypeToString(token->type));
  std::println("  value: {}", token->value);
  std::println("{}", '}');
}
