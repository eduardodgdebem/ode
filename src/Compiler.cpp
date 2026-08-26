#include "Compiler.hpp"

#include <format>
#include <memory>
#include <string>
#include <vector>

#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Linker.hpp"
#include "Parser/AST.hpp"
#include "Parser/ASTPrinter.hpp"
#include "Parser/Parser.hpp"
#include "Reader.hpp"
#include "SourceError.hpp"
#include "SemanticAnalyzer.hpp"

Compiler::Compiler(const char *filePath) : filePath(filePath) {}

void Compiler::run() {
  try {
    compile();
  } catch (const SourceError &error) {
    // Only the driver knows which file is being compiled, so it is what
    // turns a line:column into a full file:line:column reference.
    throw std::runtime_error(
        error.hasPosition()
            ? std::format("{}:{}:{}: error: {}", filePath, error.line(),
                          error.column(), error.message())
            : std::format("{}: error: {}", filePath, error.message()));
  }
}

void Compiler::compile() {
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
      std::make_unique<IRGenerator>("myProgram", analyzer->resolvedTypes(),
                                    analyzer->structs());

  irgen->generate(*root);
  irgen->emitToFile(std::format("{}.ll", reader->getFileName()));
  auto objectPath = std::format("{}.o", reader->getFileName());
  irgen->emitObjectFile(objectPath);

  auto linker = std::make_unique<Linker>(objectPath);
  linker->link(reader->getFileName());
}
