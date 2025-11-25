#pragma once
#include <fstream>
#include <functional>
#include <string>
#include <filesystem>

class Reader {
private:
  std::ifstream _inputFile;
  std::filesystem::path filePath;

public:
  Reader(std::filesystem::path filePath);

  ~Reader();

  void forEachLine(std::function<void(std::string)> callBack);

  std::string readAll();

  std::string getFileName() const;
};
