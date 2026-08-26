#include "Compiler.hpp"
#include <format>
#include <iostream>
#include <stdexcept>
#include <string_view>
#include <utility>

namespace {

constexpr std::string_view usage =
    "usage: ode [-o <path>] [--no-intermediates] <input.ode>\n"
    "\n"
    "  -o <path>           write the executable to <path>; the .ll and .o\n"
    "                      are written alongside it as <path>.ll and <path>.o\n"
    "  --no-intermediates  delete the .ll and .o once linking succeeds\n"
    "  -h, --help          show this message";

Compiler::Options parseArguments(int argc, char *argv[]) {
  Compiler::Options options;

  for (int i = 1; i < argc; ++i) {
    std::string_view argument = argv[i];

    if (argument == "-o") {
      if (++i == argc) {
        throw std::runtime_error(
            std::format("ode: error: -o requires a path\n{}", usage));
      }
      options.outputPath = argv[i];
    } else if (argument == "--no-intermediates") {
      options.keepIntermediates = false;
    } else if (argument.starts_with('-') && argument.size() > 1) {
      throw std::runtime_error(
          std::format("ode: error: unknown option '{}'\n{}", argument, usage));
    } else if (!options.inputPath.empty()) {
      throw std::runtime_error(
          std::format("ode: error: more than one input file\n{}", usage));
    } else {
      options.inputPath = argument;
    }
  }

  if (options.inputPath.empty()) {
    throw std::runtime_error("ode: error: no input file");
  }

  return options;
}

} // namespace

int main(int argc, char *argv[]) {
  try {
    for (int i = 1; i < argc; ++i) {
      std::string_view argument = argv[i];
      if (argument == "-h" || argument == "--help") {
        std::cout << usage << std::endl;
        return 0;
      }
    }

    Compiler compiler(parseArguments(argc, argv));
    compiler.run();
  } catch (const std::exception &e) {
    // Diagnostics arrive already formatted as file:line:column: error: ...
    // so that an editor can jump straight to them.
    std::cerr << e.what() << std::endl;
    return 1;
  }
  return 0;
}
