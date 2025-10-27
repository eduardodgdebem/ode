#include "Lexer/Lexer.hpp"
#include <print>

std::vector<Token> Lexer::tokenize() {
  std::vector<Token> tokens;
  Token::Scanner scanner(source_);
  Token::Builder builder(scanner);

  Token::Type lastType = Token::Type::None;

  while (!scanner.isAtEnd()) {
    scanner.skipWhitespace();

    if (scanner.isAtEnd())
      break;

    std::optional<Token> token;

    if (auto t = builder.tryIdentifier()) {
      token = std::move(t);
    } else if (auto t = builder.tryNumber(lastType)) {
      token = std::move(t);
    } else if (auto t = builder.tryTwoCharOperator()) {
      token = std::move(t);
    } else if (auto t = builder.trySingleChar()) {
      token = std::move(t);
    }

    if (token) {
      std::println("{}", token.value().value);
      lastType = token->type;
      tokens.push_back(std::move(*token));
    }
  }

  return tokens;
}
