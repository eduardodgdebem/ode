#pragma once
#include "SourceError.hpp"

#include <filesystem>
#include <fstream>
#include <string>

class Reader {
private:
  std::ifstream _inputFile;
  std::filesystem::path filePath;

public:
  class Error : public SourceError {
  public:
    explicit Error(const std::string &msg) : SourceError(msg) {}
  };

  Reader(std::filesystem::path filePath);

  ~Reader();

  // The file verbatim, newlines and comments included. Stripping comments
  // here would corrupt any `//` inside a string literal, so the lexer does
  // it instead.
  std::string readAll();

  std::string getFileName() const;
};
