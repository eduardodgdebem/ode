#pragma once
#include <filesystem>
#include <fstream>
#include <string>

class Reader {
private:
  std::ifstream _inputFile;
  std::filesystem::path filePath;

public:
  Reader(std::filesystem::path filePath);

  ~Reader();

  // The file verbatim, newlines and comments included. Stripping comments
  // here would corrupt any `//` inside a string literal, so the lexer does
  // it instead.
  std::string readAll();

  std::string getFileName() const;
};
