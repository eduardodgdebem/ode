#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseProgram() {
  auto program = std::make_unique<AST::ProgramNode>();

  while (current().type != Token::Type::End) {
    program->addStatement(parseStatement());
  }

  return program;
}
