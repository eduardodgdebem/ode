#pragma once

#include "Diagnostics.hpp"

#include <filesystem>
#include <string>

class Compiler {
public:
  struct Options {
    std::filesystem::path inputPath;
    // Empty means the input's stem in the working directory, which is what
    // `ode foo.ode` has always done.
    std::filesystem::path outputPath;
    bool keepIntermediates = true;
    // Print the token stream and stop. This exists so the C++ lexer and the
    // self-hosted one in selfhost/ can be diffed against each other.
    bool dumpTokens = false;
    // Print the parsed tree and stop, for the same reason.
    bool dumpAst = false;
    // Print the tree with every resolved expression type, for the same reason.
    bool dumpTypes = false;
  };

  explicit Compiler(Options options);
  void run();

private:
  void compile();
  // Renders every diagnostic as file:line:column: error: message, which is
  // what an editor can jump to.
  std::string formatDiagnostics(const Diagnostics &diagnostics) const;
  void stopIfErrors(const Diagnostics &diagnostics) const;

  Options options;
};
