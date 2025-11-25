#include "Compiler.hpp"
#include <iostream>
#include <stdexcept>

int main(int argc, char *argv[]) {
  try {
    if (argc <= 1) {
      throw std::runtime_error("No input file found");
    }

    const char *filePath = argv[1];
    Compiler compiler(filePath);
    compiler.run();
  } catch (const std::exception &e) {
    std::cerr << "Error: " << e.what() << std::endl;
    return 1;
  }
  return 0;
}
