#include "ASTNode.hpp"
#include "Analyzer.hpp"
#include "Helper.hpp"
#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Parser.hpp"
#include "Reader.hpp"
#include <memory>

void printTree(ASTNodePointer &node, int depth = 0) {
  if (node == nullptr)
    return;

  std::string padding = "";
  for (int i = 0; i < depth; ++i) {
    padding += "  ";
  }

  std::println("");
  std::println("{}AST type: {}", padding, getAstTypeName(node->type));
  std::println("{}value: {}", padding, node->token.value);
  std::println("{}type: {}", padding, getTokenType(node->token.type));

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
  ASTNodePointer root = parser->parse();

  AnalyzerPointer analyzer = std::make_unique<Analyzer>();
  analyzer->analyze(root.get());

  std::unique_ptr<IRGenerator> irgen =
      std::make_unique<IRGenerator>("myProgram");

  irgen->generate(root.get());
  irgen->emitToFile("output.ll");
  irgen->emitObjectFile("output.o");
}
