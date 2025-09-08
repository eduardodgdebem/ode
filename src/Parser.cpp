#include "include/Parser.h"
#include "include/Token.h"

ASTNode *Parser::parse() {
  auto root = new ASTNode;

  for (auto t : tokens) {
    printToken(&t);
  }

  return root;
}
