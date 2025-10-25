#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseType() {
  Token type = consume(Token::Type::Type, "type");
  return std::make_unique<AST::TypeNode>(type);
}
