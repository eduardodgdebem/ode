#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseStatement() {
  switch (current().type) {
  case Token::Type::Let:
    return parseVarDecl();
  case Token::Type::Identifier:
    if (peek().type == Token::Type::Assign) {
      return parseAssign();
    }
    return parseExprStmt();
  case Token::Type::LBrace:
    return parseBlock();
  case Token::Type::If:
    return parseIfStmt();
  case Token::Type::While:
    return parseWhileStmt();
  case Token::Type::Fn:
    return parseFuncDecl();
  case Token::Type::Return:
    return parseReturnStmt();
  case Token::Type::Print:
    return parsePrintStmt();
  default:
    return parseExprStmt();
  }
}

AST::NodePtr Parser::parseVarDecl() {
  consume(Token::Type::Let, "let");
  Token name = consume(Token::Type::Identifier, "identifier");
  consume(Token::Type::Colon, ":");
  auto type = parseType();
  consume(Token::Type::Assign, "=");
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");

  return std::make_unique<AST::VarDeclNode>(name, std::move(type),
                                            std::move(expr));
}

AST::NodePtr Parser::parseAssign() {
  Token name = consume(Token::Type::Identifier, "identifier");
  consume(Token::Type::Assign, "=");
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");

  return std::make_unique<AST::AssignNode>(name, std::move(expr));
}

AST::NodePtr Parser::parseExprStmt() {
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::ExprStmtNode>(std::move(expr));
}

AST::NodePtr Parser::parseBlock() {
  consume(Token::Type::LBrace, "{");

  auto block = std::make_unique<AST::BlockNode>();

  while (current().type != Token::Type::RBrace &&
         current().type != Token::Type::End) {
    block->addStatement(parseStatement());
  }

  consume(Token::Type::RBrace, "}");
  return block;
}

AST::NodePtr Parser::parseIfStmt() {
  consume(Token::Type::If, "if");
  consume(Token::Type::LParen, "(");
  auto condition = parseExpr();
  consume(Token::Type::RParen, ")");
  auto thenBlock = parseBlock();

  AST::NodePtr elseBlock = nullptr;
  if (current().type == Token::Type::Else) {
    advance();
    elseBlock = parseBlock();
  }

  return std::make_unique<AST::IfStmtNode>(
      std::move(condition), std::move(thenBlock), std::move(elseBlock));
}

AST::NodePtr Parser::parseWhileStmt() {
  consume(Token::Type::While, "while");
  consume(Token::Type::LParen, "(");
  auto condition = parseExpr();
  consume(Token::Type::RParen, ")");
  auto body = parseBlock();

  return std::make_unique<AST::WhileStmtNode>(std::move(condition),
                                              std::move(body));
}

AST::NodePtr Parser::parseReturnStmt() {
  consume(Token::Type::Return, "return");
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::ReturnStmtNode>(std::move(expr));
}

AST::NodePtr Parser::parsePrintStmt() {
  consume(Token::Type::Print, "print");
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::PrintStmtNode>(std::move(expr));
}
