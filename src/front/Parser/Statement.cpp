#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseStatement() {
  Token start = current();
  return located(parseStatementInner(), start);
}

AST::NodePtr Parser::parseStatementInner() {
  switch (current().type) {
  case Token::Type::Let:
    return parseVarDecl();
  case Token::Type::LBrace:
    return parseBlock();
  case Token::Type::If:
    return parseIfStmt();
  case Token::Type::While:
    return parseWhileStmt();
  case Token::Type::Break:
    return parseBreakStmt();
  case Token::Type::Continue:
    return parseContinueStmt();
  case Token::Type::Fn:
    return parseFuncDecl();
  case Token::Type::Extern:
    return parseExternDecl();
  case Token::Type::Struct:
    return parseStructDecl();
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

// Either `expr;` or `lvalue = expr;`. Both start with an expression, so parse
// one and let the following token decide which statement this is. This is what
// lets `*p = v;` work without a separate lookahead rule.
AST::NodePtr Parser::parseExprStmt() {
  auto expr = parseExpr();

  if (current().type == Token::Type::Assign) {
    advance();
    auto value = parseExpr();
    consume(Token::Type::Semicolon, ";");
    return std::make_unique<AST::AssignNode>(std::move(expr),
                                             std::move(value));
  }

  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::ExprStmtNode>(std::move(expr));
}

AST::NodePtr Parser::parseBlock() {
  Token start = current();
  consume(Token::Type::LBrace, "{");

  auto block = std::make_unique<AST::BlockNode>();
  block->setLocation(start.line, start.column);

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
    // `else if` chains by making the next `if` the else branch outright,
    // rather than requiring it to be wrapped in a block.
    elseBlock = current().type == Token::Type::If ? parseIfStmt() : parseBlock();
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

  // `return;` carries no value and is only valid in a void function.
  if (current().type == Token::Type::Semicolon) {
    advance();
    return std::make_unique<AST::ReturnStmtNode>();
  }

  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::ReturnStmtNode>(std::move(expr));
}

AST::NodePtr Parser::parseBreakStmt() {
  consume(Token::Type::Break, "break");
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::BreakStmtNode>();
}

AST::NodePtr Parser::parseContinueStmt() {
  consume(Token::Type::Continue, "continue");
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::ContinueStmtNode>();
}

AST::NodePtr Parser::parsePrintStmt() {
  consume(Token::Type::Print, "print");
  auto expr = parseExpr();
  consume(Token::Type::Semicolon, ";");
  return std::make_unique<AST::PrintStmtNode>(std::move(expr));
}
