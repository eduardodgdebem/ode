#include "Reader.hpp"

#include <iterator>
#include <string>

Reader::Reader(std::filesystem::path fp) {
  _inputFile.open(fp, std::ios::in);
  filePath = fp;
}

Reader::~Reader() { _inputFile.close(); }

std::string Reader::readAll() {
  // An empty string here would be compiled as an empty program and reported
  // much later as a missing `main`, so stop at the reader instead.
  if (!_inputFile.is_open()) {
    throw Error("cannot open file");
  }

  return std::string(std::istreambuf_iterator<char>(_inputFile),
                     std::istreambuf_iterator<char>());
}

std::string Reader::getFileName() const { return filePath.stem().string(); }
