#include <cctype>
#include <memory>
#include <print>

#include "include/Lexer.h"
#include "include/Parser.h"
#include "include/Reader.h"
#include "include/Token.h"

void printTree(ASTNode *node, int depth) {
  if (node == nullptr)
    return;

  for (int i = 0; i < depth; ++i) {
    std::print("  ");
  }

  std::println("value: {}", node->value.value);

  printTree(node->left, depth + 1);
  printTree(node->right, depth + 1);
}

float evaluate(ASTNode *node) {
  if (!node->left && !node->right) {
    return std::stoi(node->value.value);
  }

  float leftVal = evaluate(node->left);
  float rightVal = evaluate(node->right);

  if (node->value.type == PLUS)
    return leftVal + rightVal;
  if (node->value.type == MINUS)
    return leftVal - rightVal;
  if (node->value.type == MULTIPLY)
    return leftVal * rightVal;
  if (node->value.type == DIVIDE)
    return leftVal / rightVal;

  throw std::runtime_error("Operador desconhecido");
}

int main(int argc, char *argv[]) {
  auto filePath = argc >= 1 ? argv[1] : "../../sla.txt";

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  auto fileText = reader->readAll();

  auto lexer = std::make_unique<Lexer>(fileText);
  auto tokens = lexer->tokenize();

  auto parser = std::make_unique<Parser>(tokens);
  auto root = parser->parse();

  printTree(root, 0);

  float result = evaluate(root);

  std::println("{}", result);
}
