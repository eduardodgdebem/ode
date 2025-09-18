#include <ios>
#include <print>
#include <stdexcept>

#include "include/ASTNode.h"
#include "include/Helper.h"
#include "include/Parser.h"
#include "include/Token.h"

ASTNode *Parser::parse() { return parseProgram(); }

Token Parser::currentToken() {
  if (pos >= tokens.size()) {
    return Token{TokenType::End, ""};
  }
  return tokens.at(pos);
}

void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
}

ASTNode *Parser::parseProgram() {
  ASTNode *program = new ASTNode(ASTType::Program);

  while (currentToken().type != TokenType::End) {
    ASTNode *stm = parseStatement();
    if (stm)
      program->addChild(stm);
  }

  return program;
}

ASTNode *Parser::parseBlock() {
  if (currentToken().type != TokenType::LBraket) {
    std::runtime_error("Block should initialize with {");
  }

  consumeToken();

  ASTNode *newNode = new ASTNode(ASTType::Block);
  while (currentToken().type != TokenType::RBraket &&
         currentToken().type != TokenType::End) {
    ASTNode *statement = parseStatement();
    newNode->addChild(statement);
  }

  if (currentToken().type != TokenType::RBraket) {
    std::runtime_error("Block should end with }");
  }

  consumeToken();

  return newNode;
}

ASTNode *Parser::parseIfStmnt() {
  std::println("OPA");
  if (currentToken().type != TokenType::If) {
    throw std::runtime_error("If should start with If");
  }

  ASTNode *newNode = new ASTNode(ASTType::IfStmt, currentToken());

  consumeToken();

  if (currentToken().type != TokenType::LParen) {
    throw std::runtime_error("Missing expr");
  }

  ASTNode *expr = parseExpr();

  if (expr == nullptr) {
    throw std::runtime_error("There should be a expresion for a If");
  }

  newNode->addChild(expr);

  ASTNode *block = parseBlock();

  if (block == nullptr) {
    throw std::runtime_error("There should be a block for the if");
  }

  newNode->addChild(block);

  return newNode;
}

ASTNode *Parser::parseStatement() {
  switch (currentToken().type) {
  case TokenType::Let:
    return parseVarDecl();
  case TokenType::Ident:
    return parseAssign();
  case TokenType::LBraket:
    return parseBlock();
  case TokenType::If:
    return parseIfStmnt();
  default:
    return parseExprStm();
  }
}

ASTNode *Parser::parseVarDecl() {
  if (currentToken().type != TokenType::Let) {
    throw std::runtime_error("Assign should start with LET");
  }

  consumeToken();

  return parseAssign(true);
}

ASTNode *Parser::parseAssign(bool isVarDecl) {
  if (currentToken().type != TokenType::Ident) {
    throw std::runtime_error("After LET should be an IDENT");
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != TokenType::Equal) {
    throw std::runtime_error("Expected a =");
  }
  consumeToken();

  ASTNode *expr = parseExpr();
  ASTNode *assignNode =
      new ASTNode(isVarDecl ? ASTType::VarDecl : ASTType::Assign, ident);
  assignNode->addChild(expr);

  consumeToken();

  return assignNode;
}

ASTNode *Parser::parseExprStm() {
  ASTNode *expr = parseExpr();

  if (!expr) {
    throw std::runtime_error("Expected expression before ;");
  }

  auto curr = currentToken();

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::runtime_error("Expected ; after expression");
  }
  consumeToken();

  ASTNode *exprStmt = new ASTNode(ASTType::ExprStmt);
  exprStmt->addChild(expr);
  return exprStmt;
}

ASTNode *Parser::parseExpr() {
  ASTNode *node = parseLogicOr();
  if (!node) {
    throw std::runtime_error("Invalid expression");
  }
  ASTNode *exprNode = new ASTNode(ASTType::Expr);
  exprNode->addChild(node);
  return exprNode;
}

ASTNode *Parser::parseLogicOr() {
  ASTNode *node = parseLogicAnd();

  while (currentToken().type == TokenType::Or) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseLogicAnd();
    if (!right)
      throw std::runtime_error("Expected expression after ||");

    ASTNode *newNode = new ASTNode(ASTType::LogicOr, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseLogicAnd() {
  ASTNode *node = parseEquality();

  while (currentToken().type == TokenType::And) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseEquality();
    if (!right)
      throw std::runtime_error("Expected expression after &&");

    ASTNode *newNode = new ASTNode(ASTType::LogicAnd, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseEquality() {
  ASTNode *node = parseComparison();

  while (currentToken().type == TokenType::EqualOp ||
         currentToken().type == TokenType::DiffOp) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseComparison();
    if (!right)
      throw std::runtime_error("Expected expression after equality operator");

    ASTNode *newNode = new ASTNode(ASTType::Equality, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseComparison() {
  ASTNode *node = parseTerm();

  while (currentToken().type == TokenType::GreaterOp ||
         currentToken().type == TokenType::GreaterEqualOp ||
         currentToken().type == TokenType::LesserOp ||
         currentToken().type == TokenType::LesserEqualOp) {
    Token op = currentToken();
    consumeToken();

    ASTNode *right = parseTerm();
    if (!right)
      throw std::runtime_error("Expected factor after operator");

    ASTNode *newNode = new ASTNode(ASTType::Comparison, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseTerm() {
  ASTNode *node = parseFactor();

  while (currentToken().type == TokenType::Plus ||
         currentToken().type == TokenType::Minus) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseFactor();
    if (!right)
      throw std::runtime_error("Expected factor after operator");

    ASTNode *newNode = new ASTNode(ASTType::Term, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseFactor() {
  ASTNode *node = parsePrimary();

  while (currentToken().type == TokenType::Multiply ||
         currentToken().type == TokenType::Divide) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parsePrimary();
    if (!right)
      throw std::runtime_error("Expected primary after operator");

    ASTNode *newNode = new ASTNode(ASTType::Factor, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parsePrimary() {
  auto curr = currentToken();
  switch (curr.type) {
  case TokenType::Number: {
    consumeToken();
    return new ASTNode(ASTType::Primary, curr);
  }
  case TokenType::LParen: {
    consumeToken();
    ASTNode *node = parseExpr();
    if (currentToken().type != TokenType::RParen) {
      throw std::runtime_error("Expected ')' after expression");
    }
    consumeToken();
    return node;
  }
  case TokenType::Ident: {
    consumeToken();
    return new ASTNode(ASTType::Primary, curr);
  }
  case TokenType::True: {
    consumeToken();
    return new ASTNode(ASTType::Primary, curr);
  }
  default:
    throw std::runtime_error(
        "Expected number, true, false, identifier, or '('");
  }
}
