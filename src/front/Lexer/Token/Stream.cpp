#include "Lexer/Token.hpp"

Token Token::Stream::current() const {
  if (isAtEnd())
    return Token{Token::Type::End, ""};
  return tokens_[pos_];
}

Token Token::Stream::peek(size_t offset) const {
  size_t index = pos_ + offset;
  if (index >= tokens_.size())
    return Token{Token::Type::End, ""};
  return tokens_[index];
}

void Token::Stream::consume() {
  if (pos_ < tokens_.size())
    ++pos_;
}
