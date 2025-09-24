#include "include/Helper.h"
#include "include/Lexer.h"
#include "include/Parser.h"
#include "include/Reader.h"
#include "include/Token.h"

void printTree(std::unique_ptr<ASTNode> &node, int depth) {
  if (node == nullptr)
    return;

  std::string padding = "";
  for (int i = 0; i < depth; ++i) {
    padding += "  ";
  }

  std::println("");
  std::println("{}AST type: {}", padding, getAstTypeName(node->type));
  std::println("{}value: {}", padding, node->token.value);
  std::println("{}type: {}", padding, getTokenTypeName(node->token.type));

  for (auto &c : node->children) {
    printTree(c, depth + 1);
  }
}

int main(int argc, char *argv[]) {
  const char *filePath = argc >= 1 ? argv[1] : nullptr;
  if (filePath == nullptr) {
    throw std::runtime_error("No input file found");
  }

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  std::string fileText = reader->readAll();

  std::unique_ptr<Lexer> lexer = std::make_unique<Lexer>(fileText);
  std::vector<Token> tokens = lexer->tokenize();

  std::unique_ptr<Parser> parser = std::make_unique<Parser>(tokens);
  std::unique_ptr<ASTNode> root = parser->parse();

  printTree(root, 0);
}
