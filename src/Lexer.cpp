#include <string>

#include "include/Lexer.h"
#include "include/Token.h"

bool Lexer::GetNextToken(Token *token) {
  TokenTypes currTokenType = SKIP;
  TokenTypes prevTokenType = SKIP;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenTypeByChar(currValue);

    if (currTokenType == SKIP) {
      if (!value.empty()) {
        token->type = prevTokenType;
        token->value = value;
        return true;
      }
      continue;
    }

    if (prevTokenType != currTokenType && !value.empty()) {
      pos--;
      token->type = prevTokenType;
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
