#include <algorithm>
#include <cctype>
#include <print>
#include <string>

#include "include/Token.h"

bool is_digits(const std::string &str) {
  return std::all_of(str.begin(), str.end(), ::isdigit);
}

TokenTypes getTokenTypeByChar(char character) {
  if (std::isspace(character)) {
    return SKIP;
  }

  if (std::isalpha(character)) {
    return CHAR;
  }

  if (std::isdigit(character)) {
    return NUMBER;
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

  if (character == '=') {
    return EQUAL;
  }

  if (character == ';') {
    return SEMICOLUMN;
  }

  return SKIP;
}

std::string tokenTypeToString(TokenTypes TokenType) {
  switch (TokenType) {
  case NUMBER:
    return "NUMBER";
  case CHAR:
    return "CHAR";
  case IDENT:
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
  case LET:
    return "LET";
  case IF:
    return "IF";
  case ELSE:
    return "ELSE";
  case FN:
    return "FN";
  case WHILE:
    return "WHILE";
  case EQUAL:
    return "EQUAL";
  case SEMICOLUMN:
    return "SEMICOLUMN";
  }

  return "";
}

TokenTypes getTokenTypeByString(std::string value) {
  if (value.size() == 1) {
    return getTokenTypeByChar(value.at(0));
  }

  if (value == "let") {
    return LET;
  }

  if (value == "while") {
    return WHILE;
  }

  if (value == "fn") {
    return FN;
  }

  if (value == "if") {
    return ELSE;
  }

  if (is_digits(value)) {
    return NUMBER;
  }

  return IDENT;
}

void printToken(Token *token) {
  std::println("{}", '{');
  std::println("  type: {}", tokenTypeToString(token->type));
  std::println("  value: {}", token->value);
  std::println("{}", '}');
}
