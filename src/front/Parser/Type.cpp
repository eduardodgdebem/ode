#include "Parser/Parser.hpp"

// Type -> '*'* BaseType
// A base type is either a built-in keyword (`i32`) or the name of a struct,
// which lexes as an identifier.
AST::NodePtr Parser::parseType() {
  int pointerDepth = 0;
  while (current().type == Token::Type::Multiply) {
    ++pointerDepth;
    advance();
  }

  if (current().type != Token::Type::Type &&
      current().type != Token::Type::Identifier) {
    throw Error("type", current());
  }

  Token type = current();
  advance();
  return std::make_unique<AST::TypeNode>(type, pointerDepth);
}
