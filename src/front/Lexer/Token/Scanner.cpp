#include "Lexer/Token.hpp"
#include <cctype>

char Token::Scanner::peek(size_t offset) const {
  size_t index = pos_ + offset;
  return index < source_.length() ? source_[index] : '\0';
}

char Token::Scanner::consume() {
  if (pos_ >= source_.length()) {
    return '\0';
  }

  char c = source_[pos_++];
  if (c == '\n') {
    ++line_;
    column_ = 1;
  } else {
    ++column_;
  }

  return c;
}

void Token::Scanner::skipWhitespace() {
  while (pos_ < source_.length()) {
    if (std::isspace(static_cast<unsigned char>(source_[pos_]))) {
      consume();
      continue;
    }

    // A comment runs to the end of the line. This is handled here rather than
    // while reading the file so that `//` inside a string literal is left
    // alone.
    if (source_[pos_] == '/' && peek(1) == '/') {
      while (pos_ < source_.length() && source_[pos_] != '\n') {
        consume();
      }
      continue;
    }

    return;
  }
}
