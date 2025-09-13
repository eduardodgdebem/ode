#include "include/Parser.h"
#include "include/Token.h"
#include <print>
#include <stdexcept>

ASTNode *Parser::parse() { return parseProgram(); }

Token Parser::currentToken() {
  if (pos >= tokens.size()) {
    return Token{END, ""};
  }
  return tokens.at(pos);
}

void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
};

ASTNode *Parser::parseProgram() {
  ASTNode *program = new ASTNode(PROGRAM);

  while (currentToken().type != END) {
    ASTNode *stm = parseStatement();
    if (stm)
      program->addChild(stm);
  }

  return program;
}

ASTNode *Parser::parseStatement() {
  Token token = currentToken();

  if (token.type == LET) {
    return parseVarDecl();
  } else {
    return parseExprStm();
  }
}

ASTNode *Parser::parseVarDecl() {
  if (currentToken().type != LET) {
    throw std::runtime_error("Assign should start with LET");
  }
  consumeToken();

  if (currentToken().type != IDENT) {
    throw std::runtime_error("After LET should be an IDENT");
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != EQUAL) {
    throw std::runtime_error("Expected a =");
  }
  consumeToken();

  ASTNode *expr = parseExpr();

  ASTNode *assignNode = new ASTNode(ASSIGN, ident);
  assignNode->addChild(expr);

  consumeToken();
  return assignNode;
}

ASTNode *Parser::parseExprStm() {
  ASTNode *expr = parseExpr();

  if (!expr) {
    throw std::runtime_error("Expected expression before ;");
  }

  if (currentToken().type != SEMICOLUMN) {
    throw std::runtime_error("Expected ; after expression");
  }
  consumeToken();

  ASTNode *exprStmt = new ASTNode(EXPRSTMT);
  exprStmt->addChild(expr);
  return exprStmt;
}

ASTNode *Parser::parseExpr() {
  ASTNode *node = parseTerm();

  while (currentToken().type == PLUS || currentToken().type == MINUS) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseTerm();
    if (!right)
      throw std::runtime_error("Expected term after operator");

    ASTNode *newNode = new ASTNode(EXPR, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseTerm() {
  ASTNode *node = parseFactor();

  while (currentToken().type == MULTIPLY || currentToken().type == DIVIDE) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseFactor();
    if (!right)
      throw std::runtime_error("Expected factor after operator");

    ASTNode *newNode = new ASTNode(TERM, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseFactor() {
  auto curr = currentToken();
  if (curr.type == NUMBER) {
    consumeToken();
    return new ASTNode(FACTOR, curr);
  } else if (curr.type == LPAREN) {
    consumeToken();
    ASTNode *node = parseExpr();
    consumeToken();
    return node;
  } else if (curr.type == IDENT) {
    consumeToken();
    return new ASTNode(FACTOR, curr);
  } else {
    printToken(&curr);
    throw std::runtime_error("Expected number, identifier, or '('");
  }
}
