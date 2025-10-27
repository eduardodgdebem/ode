#include "Reader.hpp"

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
    auto commentPos = line.find("//");
    if (commentPos != std::string::npos) {
      line = line.substr(0, commentPos);
    }

    line.erase(0, line.find_first_not_of(" \t\n\r"));
    line.erase(line.find_last_not_of(" \t\n\r") + 1);
    callBack(line);
  }
}

std::string Reader::readAll() {
  std::string fullText;

  forEachLine([&fullText](auto line) { fullText += line; });

  return fullText;
}
