#pragma once
#include <format>
#include <stdexcept>
#include <string>

// Base for every diagnostic that can be traced back to a place in the source.
// A line of 0 means the position is unknown, which is what internal errors
// and whole-program checks report.
class SourceError : public std::runtime_error {
public:
  explicit SourceError(std::string message, int line = 0, int column = 0)
      : std::runtime_error(format(message, line, column)),
        message_(std::move(message)), line_(line), column_(column) {}

  const std::string &message() const { return message_; }
  int line() const { return line_; }
  int column() const { return column_; }
  bool hasPosition() const { return line_ > 0; }

private:
  static std::string format(const std::string &message, int line, int column) {
    if (line <= 0) {
      return message;
    }
    return std::format("{}:{}: {}", line, column, message);
  }

  std::string message_;
  int line_;
  int column_;
};
