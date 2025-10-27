#include "Lexer/Token.hpp"

std::optional<Token> Token::Builder::tryIdentifier() {
  if (!Token::Classifier::isIdentifierStart(scanner_.peek())) {
    return std::nullopt;
  }

  size_t start = scanner_.position();

  while (!scanner_.isAtEnd() &&
         Token::Classifier::isIdentifierChar(scanner_.peek())) {
    scanner_.consume();
  }

  std::string value(scanner_.substr(start, scanner_.position() - start));
  Token::Type type = Token::Classifier::classify(value);

  return Token{type, std::move(value)};
}

std::optional<Token> Token::Builder::tryNumber(Token::Type lastType) {
  bool isNegative = false;

  if (scanner_.peek() == '-') {
    if (!std::isdigit(static_cast<unsigned char>(scanner_.peek(1)))) {
      return std::nullopt;
    }

    if (lastType != Token::Type::None &&
        !Token::Classifier::isOperatorOrDelimiter(lastType)) {
      return std::nullopt;
    }

    isNegative = true;
    scanner_.consume();
  }

  if (!std::isdigit(static_cast<unsigned char>(scanner_.peek()))) {
    return std::nullopt;
  }

  size_t start = scanner_.position();

  while (!scanner_.isAtEnd() &&
         (std::isdigit(static_cast<unsigned char>(scanner_.peek())) ||
          scanner_.peek() == '.')) {
    scanner_.consume();
  }

  std::string value;
  if (isNegative)
    value = "-";
  value += scanner_.substr(start, scanner_.position() - start);

  return Token{Token::Type::Number, std::move(value)};
}

std::optional<Token> Token::Builder::tryTwoCharOperator() {
  char first = scanner_.peek();
  char second = scanner_.peek(1);

  if (second == '\0')
    return std::nullopt;

  std::string op{first, second};

  if (Token::Classifier::isKeywordOrOperator(op)) {
    scanner_.consume();
    scanner_.consume();
    return Token{Token::Classifier::classify(op), std::move(op)};
  }

  return std::nullopt;
}

std::optional<Token> Token::Builder::trySingleChar() {
  char c = scanner_.consume();
  std::string str(1, c);

  Token::Type type = Token::Classifier::classify(str);
  return Token{type, std::move(str)};
}
