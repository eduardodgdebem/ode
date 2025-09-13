#include <cctype>
#include <memory>
#include <print>
#include <stdexcept>
#include <string>

#include "include/Lexer.h"
#include "include/Parser.h"
#include "include/Reader.h"
#include "include/Token.h"

void printTree(ASTNode *node, int depth) {
  if (node == nullptr)
    return;

  std::string padding = "";
  for (int i = 0; i < depth; ++i) {
    padding += "  ";
  }
  std::println("{}value: {}", padding, node->token.value);
  std::println("{}type: {}", padding, tokenTypeToString(node->token.type));

  for (auto c : node->children) {
    printTree(c, depth + 1);
  }
}

int main(int argc, char *argv[]) {
  const char *filePath = argc >= 1 ? argv[1] : nullptr;
  if (filePath == nullptr) {
    throw std::runtime_error("No input file found");
  }

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  auto fileText = reader->readAll();

  auto lexer = std::make_unique<Lexer>(fileText);
  auto tokens = lexer->tokenize();

  auto parser = std::make_unique<Parser>(tokens);
  auto root = parser->parse();

  printTree(root, 0);
}
