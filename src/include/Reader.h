#pragma once
#include <fstream>
#include <functional>
#include <ios>
#include <string>

class Reader {
private:
  std::ifstream _inputFile;

public:
  Reader(std::string fileName) { _inputFile.open(fileName, std::ios::in); }

  ~Reader() { _inputFile.close(); }

  void forEachLine(std::function<void(std::string)> callBack);

  std::string readAll();
};
