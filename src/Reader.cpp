#include "include/Reader.h"

void Reader::ForEachLine(std::function<void(std::string)> callBack) {
  if (!_inputFile.is_open()) {
    return;
  }

  std::string line;

  while (std::getline(_inputFile, line)) {
    callBack(line);
  }
}

std::string Reader::ReadAll() {
  std::string fullText{};

  ForEachLine([&fullText](auto line) { fullText += line; });

  return fullText;
}
