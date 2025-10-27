#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseExpr() { return parseLogicOr(); }

AST::NodePtr Parser::parseLogicOr() {
  auto left = parseLogicAnd();

  while (current().type == Token::Type::Or) {
    Token op = current();
    advance();
    auto right = parseLogicAnd();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }

  return left;
}

AST::NodePtr Parser::parseLogicAnd() {
  auto left = parseEquality();

  while (current().type == Token::Type::And) {
    Token op = current();
    advance();
    auto right = parseEquality();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }

  return left;
}

AST::NodePtr Parser::parseEquality() {
  auto left = parseComparison();

  while (current().type == Token::Type::Equal ||
         current().type == Token::Type::NotEqual) {
    Token op = current();
    advance();
    auto right = parseComparison();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }

  return left;
}

AST::NodePtr Parser::parseComparison() {
  auto left = parseTerm();

  while (current().type == Token::Type::Greater ||
         current().type == Token::Type::GreaterEqual ||
         current().type == Token::Type::Less ||
         current().type == Token::Type::LessEqual) {
    Token op = current();
    advance();
    auto right = parseTerm();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }

  return left;
}

AST::NodePtr Parser::parseTerm() {
  auto left = parseFactor();

  while (current().type == Token::Type::Plus ||
         current().type == Token::Type::Minus) {
    Token op = current();
    advance();
    auto right = parseFactor();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }

  return left;
}

AST::NodePtr Parser::parseFactor() {
  auto left = parseUnary();
  while (current().type == Token::Type::Multiply ||
         current().type == Token::Type::Divide) {
    Token op = current();
    advance();
    auto right = parseUnary();
    left = std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                               std::move(right));
  }
  return left;
}

AST::NodePtr Parser::parseUnary() {
  if (current().type == Token::Type::Minus ||
      current().type == Token::Type::Not) {
    Token op = current();
    advance();

    auto operand = parseUnary();

    if (!operand) {
      throw Error("expression after unary operator", current());
    }

    return std::make_unique<AST::UnaryOpNode>(op, std::move(operand));
  }

  return parsePrimary();
}

AST::NodePtr Parser::parsePrimary() {
  Token curr = current();

  switch (curr.type) {
  case Token::Type::LParen: {
    advance();
    auto expr = parseExpr();
    consume(Token::Type::RParen, ")");
    return expr;
  }
  case Token::Type::Number: {
    advance();
    return std::make_unique<AST::NumberNode>(curr);
  }
  case Token::Type::Boolean: {
    advance();
    return std::make_unique<AST::BooleanNode>(curr);
  }
  case Token::Type::Identifier: {
    if (peek().type == Token::Type::LParen) {
      return parseFuncCall();
    }
    advance();
    return std::make_unique<AST::IdentifierNode>(curr);
  }
  default:
    throw Error("number, boolean, identifier, or '('", curr);
  }
}
