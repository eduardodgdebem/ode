#include "include/Reader.h"

Reader::Reader(std::string fileName) {
  _inputFile.open(fileName, std::ios::in);
}

Reader::~Reader() { _inputFile.close(); }

void Reader::forEachLine(std::function<void(std::string)> callBack) {
  if (!_inputFile.is_open()) {
    return;
  }

  std::string line;

  while (std::getline(_inputFile, line)) {
    callBack(line);
  }
}

std::string Reader::readAll() {
  std::string fullText;

  forEachLine([&fullText](auto line) { fullText += line; });

  return fullText;
}
