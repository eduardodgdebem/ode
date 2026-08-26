#include "Compiler.hpp"
#include <iostream>
#include <stdexcept>

int main(int argc, char *argv[]) {
  try {
    if (argc <= 1) {
      throw std::runtime_error("ode: error: no input file");
    }

    const char *filePath = argv[1];
    Compiler compiler(filePath);
    compiler.run();
  } catch (const std::exception &e) {
    // Diagnostics arrive already formatted as file:line:column: error: ...
    // so that an editor can jump straight to them.
    std::cerr << e.what() << std::endl;
    return 1;
  }
  return 0;
}
