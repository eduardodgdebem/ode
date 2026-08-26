#include "Parser/Parser.hpp"

// Type -> '*'* BaseType
AST::NodePtr Parser::parseType() {
  int pointerDepth = 0;
  while (current().type == Token::Type::Multiply) {
    ++pointerDepth;
    advance();
  }

  Token type = consume(Token::Type::Type, "type");
  return std::make_unique<AST::TypeNode>(type, pointerDepth);
}
