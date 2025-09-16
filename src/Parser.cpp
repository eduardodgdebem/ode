#include <stdexcept>

#include "include/ASTNode.h"
#include "include/Parser.h"
#include "include/Token.h"

ASTNode *Parser::parse() { return parseProgram(); }

Token Parser::currentToken() {
  if (pos >= tokens.size()) {
    return Token{End, ""};
  }
  return tokens.at(pos);
}

void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
};

ASTNode *Parser::parseProgram() {
  ASTNode *program = new ASTNode(Program);

  while (currentToken().type != End) {
    ASTNode *stm = parseStatement();
    if (stm)
      program->addChild(stm);
  }

  return program;
}

ASTNode *Parser::parseStatement() {
  Token token = currentToken();

  if (token.type == Let) {
    return parseVarDecl();
  } else if (token.type == Ident) {
    return parseAssign();
  } else {
    return parseExprStm();
  }
}

ASTNode *Parser::parseVarDecl() {
  if (currentToken().type != Let) {
    throw std::runtime_error("Assign should start with LET");
  }
  consumeToken();

  return parseAssign(true);
}

ASTNode *Parser::parseAssign(bool isVarDecl) {
  if (currentToken().type != Ident) {
    throw std::runtime_error("After LET should be an IDENT");
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != Equal) {
    throw std::runtime_error("Expected a =");
  }
  consumeToken();

  ASTNode *expr = parseExpr();
  ASTNode *assignNode = new ASTNode(isVarDecl ? VarDecl : Assign, ident);
  assignNode->addChild(expr);

  consumeToken();
  return assignNode;
}

ASTNode *Parser::parseExprStm() {
  ASTNode *expr = parseExpr();

  if (!expr) {
    throw std::runtime_error("Expected expression before ;");
  }

  if (currentToken().type != Semicolumn) {
    throw std::runtime_error("Expected ; after expression");
  }
  consumeToken();

  ASTNode *exprStmt = new ASTNode(ExprStmt);
  exprStmt->addChild(expr);
  return exprStmt;
}

ASTNode *Parser::parseExpr() {
  ASTNode *node = parseTerm();

  while (currentToken().type == Plus || currentToken().type == Minus) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseTerm();
    if (!right)
      throw std::runtime_error("Expected term after operator");

    ASTNode *newNode = new ASTNode(Expr, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseTerm() {
  ASTNode *node = parseFactor();

  while (currentToken().type == Multiply || currentToken().type == Divide) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseFactor();
    if (!right)
      throw std::runtime_error("Expected factor after operator");

    ASTNode *newNode = new ASTNode(Term, op);
    newNode->addChild(node);
    newNode->addChild(right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseFactor() {
  auto curr = currentToken();
  if (curr.type == Number) {
    consumeToken();
    return new ASTNode(Factor, curr);
  } else if (curr.type == Lparen) {
    consumeToken();
    ASTNode *node = parseExpr();
    consumeToken();
    return node;
  } else if (curr.type == Ident) {
    consumeToken();
    return new ASTNode(Factor, curr);
  } else {
    throw std::runtime_error("Expected number, identifier, or '('");
  }
}
