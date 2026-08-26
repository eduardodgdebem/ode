#include "Reader.hpp"

#include <iterator>
#include <string>

Reader::Reader(std::filesystem::path fp) {
  _inputFile.open(fp, std::ios::in);
  filePath = fp;
}

Reader::~Reader() { _inputFile.close(); }

std::string Reader::readAll() {
  if (!_inputFile.is_open()) {
    return {};
  }

  return std::string(std::istreambuf_iterator<char>(_inputFile),
                     std::istreambuf_iterator<char>());
}

std::string Reader::getFileName() const { return filePath.stem().string(); }
