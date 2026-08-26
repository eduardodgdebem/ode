#include "Compiler.hpp"

#include <filesystem>
#include <format>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Linker.hpp"
#include "Parser/AST.hpp"
#include "Parser/ASTPrinter.hpp"
#include "Parser/Parser.hpp"
#include "Reader.hpp"
#include "SemanticAnalyzer.hpp"
#include "SourceError.hpp"

Compiler::Compiler(Options options) : options(std::move(options)) {}

void Compiler::run() {
  try {
    compile();
  } catch (const SourceError &error) {
    // Only the driver knows which file is being compiled, so it is what
    // turns a line:column into a full file:line:column reference.
    throw std::runtime_error(
        error.hasPosition()
            ? std::format("{}:{}:{}: error: {}", options.inputPath.string(),
                          error.line(), error.column(), error.message())
            : std::format("{}: error: {}", options.inputPath.string(),
                          error.message()));
  }
}

void Compiler::compile() {
  std::unique_ptr<Reader> reader = std::make_unique<Reader>(options.inputPath);
  std::string fileText = reader->readAll();

  std::unique_ptr<Lexer> lexer = std::make_unique<Lexer>(fileText);
  std::vector<Token> tokens = lexer->tokenize();

  std::unique_ptr<Parser> parser = std::make_unique<Parser>(tokens);
  AST::NodePtr root = parser->parse();

  auto printer = std::make_unique<ASTPrinter>();
  // printer->visit(static_cast<const AST::ProgramNode&>(*root));

  auto analyzer = std::make_unique<SemanticAnalyzer>();
  analyzer->analyze(*root);

  std::unique_ptr<IRGenerator> irgen = std::make_unique<IRGenerator>(
      "myProgram", analyzer->resolvedTypes(), analyzer->structs());

  irgen->generate(*root);

  std::filesystem::path executablePath =
      options.outputPath.empty() ? std::filesystem::path(reader->getFileName())
                                 : options.outputPath;
  // The intermediates hang off the executable rather than the input so that
  // -o keeps a whole build in one directory.
  auto irPath = std::format("{}.ll", executablePath.string());
  auto objectPath = std::format("{}.o", executablePath.string());

  irgen->emitToFile(irPath);
  irgen->emitObjectFile(objectPath);

  auto linker = std::make_unique<Linker>(objectPath);
  linker->link(executablePath);

  if (!options.keepIntermediates) {
    std::filesystem::remove(irPath);
    std::filesystem::remove(objectPath);
  }
}
