#include "Parser/Parser.hpp"

Parser::Parser(std::vector<Token> &tokens)
    : tokens_(std::move(tokens)), pos_(0) {}

AST::NodePtr Parser::parse() { return parseProgram(); }

Token Parser::current() const {
  if (isAtEnd())
    return Token{Token::Type::End, ""};
  return tokens_[pos_];
}

Token Parser::peek(size_t offset) const {
  size_t index = pos_ + offset;
  if (index >= tokens_.size())
    return Token{Token::Type::End, ""};
  return tokens_[index];
}

void Parser::advance() {
  if (pos_ < tokens_.size())
    ++pos_;
}

bool Parser::isAtEnd() const { return pos_ >= tokens_.size(); }

void Parser::expect(Token::Type type, const std::string &name) {
  if (current().type != type) {
    throw Error(name, current());
  }
}

Token Parser::consume(Token::Type type, const std::string &name) {
  expect(type, name);
  Token tok = current();
  advance();
  return tok;
}
