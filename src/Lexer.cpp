#include "include/Lexer.h"
#include "include/Helper.h"
#include "include/Token.h"
#include <cctype>
#include <stdexcept>
#include <utility>
#include <vector>

std::vector<Token> Lexer::tokenize() {
  std::vector<Token> tokens;
  while (auto tokenOpt = nextToken()) {
    printToken(&tokenOpt.value());
    tokens.push_back(std::move(*tokenOpt));
  }
  tokens.push_back({TokenType::End, ""});
  return tokens;
}

std::optional<Token> Lexer::nextToken() {
  skipWhitespace();

  if (isAtEnd()) {
    return std::nullopt;
  }

  char c = peek();

  if (std::isdigit(c)) {
    return makeNumber();
  }

  if (std::isalpha(c) || c == '_') {
    return makeIdentifier();
  }

  advance();

  switch (c) {
  case '(':
    return Token{TokenType::LParen, "("};
  case ')':
    return Token{TokenType::RParen, ")"};
  case '{':
    return Token{TokenType::LBraket, "{"};
  case '}':
    return Token{TokenType::RBraket, "}"};
  case ';':
    return Token{TokenType::Semicolumn, ";"};
  case '+':
    return Token{TokenType::Plus, "+"};
  case '-':
    return Token{TokenType::Minus, "-"};
  case '*':
    return Token{TokenType::Multiply, "*"};
  case '/':
    return Token{TokenType::Divide, "/"};

  case '=':
    if (peek() == '=') {
      advance();
      return Token{TokenType::EqualOp, "=="};
    }
    return Token{TokenType::Equal, "="};
  case '!':
    if (peek() == '=') {
      advance();
      return Token{TokenType::DiffOp, "!="};
    }
    break;
  case '>':
    if (peek() == '=') {
      advance();
      return Token{TokenType::GreaterEqualOp, ">="};
    }
    return Token{TokenType::GreaterOp, ">"};
  case '<':
    if (peek() == '=') {
      advance();
      return Token{TokenType::LesserEqualOp, "<="};
    }
    return Token{TokenType::LesserOp, "<"};
  case '&':
    if (peek() == '&') {
      advance();
      return Token{TokenType::And, "&&"};
    }
    break;
  case '|':
    if (peek() == '|') {
      advance();
      return Token{TokenType::Or, "||"};
    }
    break;
  }

  throw std::runtime_error("Lexer Error: Unexpected character: " +
                           std::string(1, c));
}

bool Lexer::isAtEnd() const { return pos >= fileText.length(); }

char Lexer::peek(size_t offset) const {
  if (pos + offset >= fileText.length()) {
    return '\0';
  }
  return fileText[pos + offset];
}

char Lexer::advance() {
  if (!isAtEnd()) {
    return fileText[pos++];
  }
  return '\0';
}

void Lexer::skipWhitespace() {
  while (!isAtEnd()) {
    char c = peek();
    if (c == ' ' || c == '\r' || c == '\t' || c == '\n') {
      advance();
    } else {
      return;
    }
  }
}

Token Lexer::makeNumber() {
  size_t start = pos;
  while (!isAtEnd() && std::isdigit(peek())) {
    advance();
  }
  return Token{TokenType::Number, fileText.substr(start, pos - start)};
}

Token Lexer::makeIdentifier() {
  size_t start = pos;
  while (!isAtEnd() && (std::isalnum(peek()) || peek() == '_')) {
    advance();
  }
  std::string value = fileText.substr(start, pos - start);

  TokenType type = getTokenTypeByString(value);
  return Token{type, value};
}
