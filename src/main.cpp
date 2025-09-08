#include <cctype>
#include <print>
#include <string>

#include "include/Lexer.h"
#include "include/Reader.h"
#include "include/Token.h"

const std::string FILE_PATH = "../../sla.txt";

int main(int argc, char *argv[]) {
  std::unique_ptr<Reader> reader = std::make_unique<Reader>(FILE_PATH);
  auto fileText = reader->ReadAll();

  std::println("{}", fileText);

  auto lexer = std::make_unique<Lexer>(fileText);
  Token token{};

  while (lexer->GetNextToken(&token)) {
    printToken(&token);
  }
}
