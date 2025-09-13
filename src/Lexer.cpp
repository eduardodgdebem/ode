#include "include/Lexer.h"
#include "include/Token.h"
#include <print>
#include <vector>

bool Lexer::getNextToken(Token *token) {
  TokenTypes currTokenType = SKIP;
  TokenTypes prevTokenType = SKIP;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenTypeByChar(currValue);

    if (currTokenType == SKIP) {
      if (!value.empty()) {
        token->type = getTokenTypeByString(value);
        token->value = value;
        return true;
      }
      continue;
    }

    if (prevTokenType != currTokenType && !value.empty()) {
      pos--;
      token->type = getTokenTypeByString(value);
      token->value = value;
      return true;
    }

    value += currValue;
    prevTokenType = currTokenType;
  }

  token->type = END;
  token->value = "";
  return false;
}

std::vector<Token> Lexer::tokenize() {
  std::vector<Token> list;
  Token currToken;

  while (getNextToken(&currToken)) {
    list.push_back(currToken);
  }
  list.push_back(currToken);

  return list;
}
