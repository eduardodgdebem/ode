#include "Compiler.hpp"

#include <filesystem>
#include <format>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Diagnostics.hpp"
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
    // An error that escaped a phase's recovery, so it is the only one there
    // is to report.
    Diagnostics single;
    single.report(error);
    throw std::runtime_error(formatDiagnostics(single));
  }
}

// Only the driver knows which file is being compiled, so it is what turns a
// line:column into a full file:line:column reference.
std::string Compiler::formatDiagnostics(const Diagnostics &diagnostics) const {
  std::string report;

  for (const Diagnostic &diagnostic : diagnostics.entries()) {
    if (!report.empty()) {
      report += '\n';
    }
    report += diagnostic.line > 0
                  ? std::format("{}:{}:{}: error: {}",
                                options.inputPath.string(), diagnostic.line,
                                diagnostic.column, diagnostic.message)
                  : std::format("{}: error: {}", options.inputPath.string(),
                                diagnostic.message);
  }

  // A single error reads better on its own; a count is only worth printing
  // once there is more than one thing to count. Past the limit the count and
  // the list disagree, so the summary says which is which rather than letting
  // a truncated list read as the whole story.
  if (diagnostics.count() > diagnostics.entries().size()) {
    report += std::format("\n{} errors generated, showing the first {}.",
                          diagnostics.count(), diagnostics.entries().size());
  } else if (diagnostics.count() > 1) {
    report += std::format("\n{} errors generated.", diagnostics.count());
  }

  return report;
}

// Stops the compile if the phase that just ran found anything, so that the
// next phase never runs on a tree that is known to be wrong.
void Compiler::stopIfErrors(const Diagnostics &diagnostics) const {
  if (!diagnostics.empty()) {
    throw std::runtime_error(formatDiagnostics(diagnostics));
  }
}

void Compiler::compile() {
  std::unique_ptr<Reader> reader = std::make_unique<Reader>(options.inputPath);
  std::string fileText = reader->readAll();

  std::unique_ptr<Lexer> lexer = std::make_unique<Lexer>(fileText);
  std::vector<Token> tokens = lexer->tokenize();

  Diagnostics diagnostics;

  std::unique_ptr<Parser> parser =
      std::make_unique<Parser>(tokens, diagnostics);
  AST::NodePtr root = parser->parse();

  // A tree with a hole in it says nothing trustworthy about types, so the
  // syntax errors are reported on their own rather than alongside whatever
  // the analyzer would invent from the wreckage.
  stopIfErrors(diagnostics);

  auto printer = std::make_unique<ASTPrinter>();
  // printer->visit(static_cast<const AST::ProgramNode&>(*root));

  auto analyzer = std::make_unique<SemanticAnalyzer>(diagnostics);
  analyzer->analyze(*root);
  stopIfErrors(diagnostics);

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
