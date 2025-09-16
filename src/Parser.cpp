#include <stdexcept>

#include "include/ASTNode.h"
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
  Token token = currentToken();

  switch (token.type) {
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

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::runtime_error("Expected ; after expression");
  }
  consumeToken();

  ASTNode *exprStmt = new ASTNode(ASTType::ExprStmt);
  exprStmt->addChild(expr);
  return exprStmt;
}

ASTNode *Parser::parseExpr() {
  ASTNode *node = parseTerm();

  while (currentToken().type == TokenType::Plus ||
         currentToken().type == TokenType::Minus) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseTerm();
    if (!right)
      throw std::runtime_error("Expected term after operator");

    ASTNode *newNode = new ASTNode(ASTType::Expr, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseTerm() {
  ASTNode *node = parseFactor();

  while (currentToken().type == TokenType::Multiply ||
         currentToken().type == TokenType::Divide) {
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
  auto curr = currentToken();
  if (curr.type == TokenType::Number) {
    consumeToken();
    return new ASTNode(ASTType::Factor, curr);
  } else if (curr.type == TokenType::LParen) {
    consumeToken();
    ASTNode *node = parseExpr();
    consumeToken();
    return node;
  } else if (curr.type == TokenType::Ident) {
    consumeToken();
    return new ASTNode(ASTType::Factor, curr);
  } else {
    throw std::runtime_error("Expected number, identifier, or '('");
  }
}
