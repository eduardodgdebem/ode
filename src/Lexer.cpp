#include "include/Lexer.hpp"
#include "include/Token.hpp"
#include <optional>
#include <tuple>
#include <vector>

std::vector<Token> Lexer::tokenize() const {
  std::vector<Token> list;
  while (auto token = nextToken()) {
    list.push_back(token.value());
  }
  return list;
}

std::optional<Token> Lexer::nextToken() const {
  while (pos < fileText.length()) {
    char currentChar = fileText[pos];

    if (isspace(currentChar)) {
      pos++;
      continue;
    }

    if (isalpha(currentChar) || currentChar == '_') {
      std::string value;
      while (pos < fileText.length() &&
             (isalnum(fileText[pos]) || fileText[pos] == '_')) {
        value += fileText[pos];
        pos++;
      }
      return Token{getTokenTypeByString(value), value};
    }

    if (isdigit(currentChar)) {
      std::string value;
      while (pos < fileText.length() && isdigit(fileText[pos])) {
        value += fileText[pos];
        pos++;
      }
      return Token{TokenType::Number, value};
    }

    auto [type, value] = getTokenDetails();
    return Token{type, value};
  }
  return std::nullopt;
}

std::tuple<TokenType, std::string> Lexer::getTokenDetails() const {
  char currentChar = fileText[pos];
  switch (currentChar) {
  case '{':
    pos++;
    return {TokenType::LBraket, "{"};
  case '}':
    pos++;
    return {TokenType::RBraket, "}"};
  case '(':
    pos++;
    return {TokenType::LParen, "("};
  case ')':
    pos++;
    return {TokenType::RParen, ")"};
  case ';':
    pos++;
    return {TokenType::Semicolumn, ";"};
  case '+':
    pos++;
    return {TokenType::Plus, "+"};
  case '-':
    pos++;
    return {TokenType::Minus, "-"};
  case '*':
    pos++;
    return {TokenType::Multiply, "*"};
  case '/':
    pos++;
    return {TokenType::Divide, "/"};
  case ',':
    pos++;
    return {TokenType::Comma, ","};
  case ':':
    pos++;
    return {TokenType::Colon, ":"};
  case '=':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '=') {
      pos += 2;
      return {TokenType::EqualOp, "=="};
    }
    pos++;
    return {TokenType::Equal, "="};
  case '!':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '=') {
      pos += 2;
      return {TokenType::DiffOp, "!="};
    }
    break;
  case '|':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '|') {
      pos += 2;
      return {TokenType::Or, "||"};
    }
    break;
  case '&':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '&') {
      pos += 2;
      return {TokenType::And, "&&"};
    }
    break;
  case '<':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '=') {
      pos += 2;
      return {TokenType::LesserEqualOp, "<="};
    }
    pos++;
    return {TokenType::LesserOp, "<"};
  case '>':
    if (pos + 1 < fileText.length() && fileText[pos + 1] == '=') {
      pos += 2;
      return {TokenType::GreaterEqualOp, ">="};
    }
    pos++;
    return {TokenType::GreaterOp, ">"};
  }

  pos++;
  return {TokenType::Identifier, std::string(1, currentChar)};
}
