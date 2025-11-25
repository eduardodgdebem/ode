#include "Linker.hpp"

#include <cstdlib>
#include <format>
#include <stdexcept>
#include <string>

Linker::Linker(std::filesystem::path op) : objectPath(std::move(op)) {
  if (!std::filesystem::exists(objectPath)) {
    throw std::runtime_error(
        std::format("Object file not found at {}", objectPath.string()));
  }
}

void Linker::link(const std::filesystem::path &executablePath) {
  std::string command = std::format("clang++ {} -o {}", objectPath.string(),
                                    executablePath.string());
  int result = std::system(command.c_str());
  if (result != 0) {
    throw std::runtime_error(
        std::format("Linking failed with exit code {}", result));
  }
}
