#include <cctype>
#include <string>

#include "include/Lexer.h"
#include "include/Reader.h"

std::string getFilePath(int argc, char *argv[]) {
  std::string filePath = "../../sla.txt";

  if (argc >= 1) {
    filePath = argv[1];
  }

  return filePath;
}

int main(int argc, char *argv[]) {
  auto filePath = getFilePath(argc, argv);

  std::unique_ptr<Reader> reader = std::make_unique<Reader>(filePath);
  auto fileText = reader->ReadAll();

  auto lexer = std::make_unique<Lexer>(fileText);
  auto tokens = lexer->Tokenize();
}
