#include "Lexer/Token.hpp"
#include <cctype>

char Token::Scanner::peek(size_t offset) const {
  size_t index = pos_ + offset;
  return index < source_.length() ? source_[index] : '\0';
}

char Token::Scanner::consume() {
  return pos_ < source_.length() ? source_[pos_++] : '\0';
}

void Token::Scanner::skipWhitespace() {
  while (pos_ < source_.length() &&
         std::isspace(static_cast<unsigned char>(source_[pos_]))) {
    ++pos_;
  }
}
