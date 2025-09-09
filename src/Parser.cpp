#include "include/Parser.h"
#include "include/Token.h"
#include <stdexcept>

ASTNode *Parser::parse() {
  ASTNode *node = parseExpr();
  auto last = currentToken();
  if (currentToken().type != END) {
    throw std::runtime_error("Extra tokens after valid expression");
  }
  return node;
}

Token Parser::currentToken() { return tokens.at(pos); }
void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
};

ASTNode *Parser::parseExpr() {
  ASTNode *node = parseTerm();

  while (currentToken().type == PLUS || currentToken().type == MINUS) {
    Token op = currentToken();
    consumeToken();
    ASTNode *right = parseTerm();

    ASTNode *newNode = new ASTNode(op, node, right);

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

    ASTNode *newNode = new ASTNode(op, node, right);

    node = newNode;
  }

  return node;
}

ASTNode *Parser::parseFactor() {
  auto curr = currentToken();
  if (curr.type == NUMBER) {
    consumeToken();
    return new ASTNode(curr, nullptr, nullptr);
  } else if (curr.type == LPAREN) {
    consumeToken();
    ASTNode *node = parseExpr();
    consumeToken();
    return node;
  } else {
    throw std::runtime_error("Sintax error");
  }
}
