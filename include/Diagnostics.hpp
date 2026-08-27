#pragma once
#include "SourceError.hpp"

#include <cstddef>
#include <string>
#include <vector>

// One recorded error. A line of 0 means the position is unknown, which is
// what internal errors and whole-program checks report.
struct Diagnostic {
  std::string message;
  int line = 0;
  int column = 0;
};

// Collects diagnostics so that a phase can keep going after an error instead
// of stopping at the first one. Each phase reports into the same bag and the
// driver prints whatever accumulated.
class Diagnostics {
public:
  // Past this many the list stops being useful and starts being noise, so
  // further reports are counted but not kept.
  static constexpr size_t limit = 20;

  void report(const SourceError &error) {
    report(Diagnostic{error.message(), error.line(), error.column()});
  }

  void report(Diagnostic diagnostic) {
    ++count_;
    // A construct reached twice would otherwise say the same thing twice.
    if (!entries_.empty() && entries_.back().line == diagnostic.line &&
        entries_.back().column == diagnostic.column &&
        entries_.back().message == diagnostic.message) {
      --count_;
      return;
    }
    if (entries_.size() < limit) {
      entries_.push_back(std::move(diagnostic));
    }
  }

  bool empty() const { return count_ == 0; }
  // Every error seen, including any past the limit that were not kept.
  size_t count() const { return count_; }
  const std::vector<Diagnostic> &entries() const { return entries_; }

private:
  std::vector<Diagnostic> entries_;
  size_t count_ = 0;
};
