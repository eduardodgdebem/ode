#include "Linker.hpp"

#include <cstdlib>
#include <format>
#include <stdexcept>
#include <string>

namespace {

// std::system hands the whole command to a shell, so a path holding a space
// or a metacharacter would be re-split or executed. Single quotes suppress
// every expansion, and the only character they cannot carry is the quote
// itself, which is closed, escaped and reopened.
std::string shellQuote(const std::string &value) {
  std::string quoted = "'";
  for (char character : value) {
    if (character == '\'') {
      quoted += R"('\'')";
    } else {
      quoted += character;
    }
  }
  quoted += '\'';
  return quoted;
}

} // namespace

Linker::Linker(std::filesystem::path op) : objectPath(std::move(op)) {
  if (!std::filesystem::exists(objectPath)) {
    throw std::runtime_error(
        std::format("Object file not found at {}", objectPath.string()));
  }
}

void Linker::link(const std::filesystem::path &executablePath) {
  std::string command =
      std::format("clang++ {} -o {}", shellQuote(objectPath.string()),
                  shellQuote(executablePath.string()));
  int result = std::system(command.c_str());
  if (result != 0) {
    throw std::runtime_error(
        std::format("Linking failed with exit code {}", result));
  }
}
