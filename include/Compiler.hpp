#pragma once

#include <string>

class Compiler {
public:
  explicit Compiler(const char *filePath);
  void run();

private:
  void compile();

  const char *filePath;
};
