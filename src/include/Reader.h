#pragma once
#include <fstream>
#include <functional>
#include <string>

class Reader {
private:
  std::ifstream _inputFile;

public:
  Reader(std::string fileName);

  ~Reader();

  void forEachLine(std::function<void(std::string)> callBack);

  std::string readAll();
};
