#include <memory>
#include <string>

#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Parser/Parser.hpp"
#include "Reader.hpp"
#include "SemanticAnalyzer.hpp"
#include "Parser/ASTPrinter.hpp"

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
  AST::NodePtr root = parser->parse();

  auto printer = std::make_unique<ASTPrinter>();
  // printer->visit(static_cast<const AST::ProgramNode&>(*root));

  auto analyzer = std::make_unique<SemanticAnalyzer>();
  analyzer->analyze(*root);

  std::unique_ptr<IRGenerator> irgen =
      std::make_unique<IRGenerator>("myProgram");

  irgen->generate(*root);
  irgen->emitToFile(std::format("{}.ll", filePath));
  irgen->emitObjectFile(std::format("{}.o", filePath));
}
