#pragma once

#include <filesystem>

class Compiler {
public:
  struct Options {
    std::filesystem::path inputPath;
    // Empty means the input's stem in the working directory, which is what
    // `ode foo.ode` has always done.
    std::filesystem::path outputPath;
    bool keepIntermediates = true;
  };

  explicit Compiler(Options options);
  void run();

private:
  void compile();

  Options options;
};
