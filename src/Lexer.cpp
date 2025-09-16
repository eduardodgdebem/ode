#include "include/Lexer.h"
#include "include/Helper.h"
#include "include/Token.h"
#include <vector>

bool Lexer::nextToken(Token *token) {
  TokenType currTokenType = TokenType::Skip;
  TokenType prevTokenType = TokenType::Skip;
  std::string value;

  while (pos <= _src.length()) {
    auto currValue = _src[pos++];
    currTokenType = getTokenTypeByChar(currValue);

    if (currTokenType == TokenType::Skip) {
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

  token->type = TokenType::End;
  token->value = "";
  return false;
}

std::vector<Token> Lexer::tokenize() {
  std::vector<Token> list;
  Token currToken;

  while (nextToken(&currToken)) {
    printToken(&currToken);
    list.push_back(currToken);
  }
  list.push_back(currToken);

  return list;
}
