#include <cctype>
#include <print>
#include <string>

#include "include/Lexer.h"
#include "include/Reader.h"

const std::string FILE_PATH = "../../sla.txt";

int main(int argc, char *argv[]) {
  std::unique_ptr<Reader> reader = std::make_unique<Reader>(FILE_PATH);
  auto fileText = reader->ReadAll();

  std::println("{}", fileText);

  auto lexer = std::make_unique<Lexer>(fileText);
  auto token = lexer->GetNextToken();

  while (!token.value.empty()) {
    std::println("==========");
    std::println("type: {}", static_cast<int>(token.type));
    std::println("value: {}", token.value);

    token = lexer->GetNextToken();
  }
}
