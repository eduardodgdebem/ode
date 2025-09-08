#include <cctype>
#include <memory>

#include "include/Lexer.h"
#include "include/Parser.h"
#include "include/Reader.h"

int main(int argc, char *argv[]) {
  auto filePath = argc >= 1 ? argv[1] : "../../sla.txt";

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  auto fileText = reader->readAll();

  auto lexer = std::make_unique<Lexer>(fileText);
  auto tokens = lexer->tokenize();

  auto parser = std::make_unique<Parser>(tokens);
  auto root = parser->parse();
}
