#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseProgram() {
  auto program = std::make_unique<AST::ProgramNode>();

  while (current().type != Token::Type::End) {
    if (auto stmt = parseStatementRecovering()) {
      program->addStatement(std::move(stmt));
    }
  }

  return program;
}
