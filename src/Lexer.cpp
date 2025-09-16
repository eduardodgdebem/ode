#include "include/Lexer.h"
#include "include/Token.h"
#include <print>
#include <vector>

bool Lexer::getNextToken(Token *token) {
  TokenTypes currTokenType = Skip;
  TokenTypes prevTokenType = Skip;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenTypeByChar(currValue);

    if (currTokenType == Skip) {
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

  token->type = End;
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
