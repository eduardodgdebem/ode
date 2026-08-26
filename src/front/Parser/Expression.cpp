#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseExpr() { return parseLogicOr(); }

AST::NodePtr Parser::parseLogicOr() {
  auto left = parseLogicAnd();

  while (current().type == Token::Type::Or) {
    Token op = current();
    advance();
    auto right = parseLogicAnd();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseLogicAnd() {
  auto left = parseBitOr();

  while (current().type == Token::Type::And) {
    Token op = current();
    advance();
    auto right = parseBitOr();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseBitOr() {
  auto left = parseBitXor();

  while (current().type == Token::Type::Pipe) {
    Token op = current();
    advance();
    auto right = parseBitXor();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseBitXor() {
  auto left = parseBitAnd();

  while (current().type == Token::Type::Caret) {
    Token op = current();
    advance();
    auto right = parseBitAnd();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

// The lexer has already split `&&` off as its own token, so an `&` reaching
// here is always the binary form; the unary one is only ever reached from a
// position where no left operand has been parsed.
AST::NodePtr Parser::parseBitAnd() {
  auto left = parseEquality();

  while (current().type == Token::Type::Ampersand) {
    Token op = current();
    advance();
    auto right = parseEquality();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
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
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseComparison() {
  auto left = parseShift();

  while (current().type == Token::Type::Greater ||
         current().type == Token::Type::GreaterEqual ||
         current().type == Token::Type::Less ||
         current().type == Token::Type::LessEqual) {
    Token op = current();
    advance();
    auto right = parseShift();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseShift() {
  auto left = parseTerm();

  while (current().type == Token::Type::ShiftLeft ||
         current().type == Token::Type::ShiftRight) {
    Token op = current();
    advance();
    auto right = parseTerm();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
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
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }

  return left;
}

AST::NodePtr Parser::parseFactor() {
  auto left = parseCast();
  while (current().type == Token::Type::Multiply ||
         current().type == Token::Type::Divide ||
         current().type == Token::Type::Percent) {
    Token op = current();
    advance();
    auto right = parseCast();
    left = located(std::make_unique<AST::BinaryOpNode>(op, std::move(left),
                                                       std::move(right)),
                   op);
  }
  return left;
}

// Cast -> Unary ('as' Type)*
// Looser than unary, so `*p as i32` is `(*p) as i32`.
AST::NodePtr Parser::parseCast() {
  auto expr = parseUnary();

  while (current().type == Token::Type::As) {
    Token op = current();
    advance();
    auto type = parseType();
    expr = located(
        std::make_unique<AST::CastNode>(std::move(expr), std::move(type)), op);
  }

  return expr;
}

// Unary -> ('-' | '+' | '!' | '*' | '&') Unary | Primary
// '*' dereferences a pointer, '&' takes the address of an lvalue. '+' does
// nothing but is kept as a node so that the analyzer can still reject a
// non-numeric operand.
AST::NodePtr Parser::parseUnary() {
  if (current().type == Token::Type::Minus ||
      current().type == Token::Type::Plus ||
      current().type == Token::Type::Not ||
      current().type == Token::Type::Multiply ||
      current().type == Token::Type::Ampersand) {
    Token op = current();
    advance();

    auto operand = parseUnary();

    if (!operand) {
      throw Error("expression after unary operator", current());
    }

    return located(std::make_unique<AST::UnaryOpNode>(op, std::move(operand)),
                   op);
  }

  return parsePostfix();
}

// Postfix -> Primary ('.' IDENT | '[' Expr ']')*
// Binds tighter than unary, so `*p.next` is `*(p.next)` and `&a[i]` is
// `&(a[i])`.
AST::NodePtr Parser::parsePostfix() {
  auto expr = parsePrimary();

  while (true) {
    if (current().type == Token::Type::Dot) {
      Token dot = current();
      advance();
      Token field = consume(Token::Type::Identifier, "field name");
      expr = located(
          std::make_unique<AST::FieldAccessNode>(std::move(expr), field), dot);
      continue;
    }

    if (current().type == Token::Type::LBracket) {
      Token bracket = current();
      advance();
      auto index = parseExpr();
      consume(Token::Type::RBracket, "]");
      expr = located(std::make_unique<AST::IndexNode>(std::move(expr),
                                                      std::move(index)),
                     bracket);
      continue;
    }

    return expr;
  }
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
    return located(std::make_unique<AST::NumberNode>(curr), curr);
  }
  case Token::Type::Boolean: {
    advance();
    return located(std::make_unique<AST::BooleanNode>(curr), curr);
  }
  case Token::Type::String: {
    advance();
    return located(std::make_unique<AST::StringLiteralNode>(curr), curr);
  }
  case Token::Type::Char: {
    advance();
    return located(std::make_unique<AST::CharLiteralNode>(curr), curr);
  }
  case Token::Type::SizeOf:
    return parseSizeOf();
  case Token::Type::Identifier: {
    if (peek().type == Token::Type::LParen) {
      return parseFuncCall();
    }
    // Nothing else in the grammar puts a block directly after an expression,
    // so `Name {` is unambiguously a struct literal.
    if (peek().type == Token::Type::LBrace) {
      return parseStructLiteral();
    }
    advance();
    return located(std::make_unique<AST::IdentifierNode>(curr), curr);
  }
  default:
    throw Error("number, string, character, boolean, identifier, or '('",
                curr);
  }
}
