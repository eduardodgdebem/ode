#pragma once
#include "Type.hpp"

#include <string>
#include <unordered_map>
#include <vector>

// The declared shape of one struct. Field order is the declaration order, and
// it is also the order of the LLVM struct's elements, so a field's position in
// this vector is its GEP index.
class StructLayout {
public:
  struct Field {
    std::string name;
    Type type;
  };

  void addField(std::string name, Type type) {
    fields_.push_back({std::move(name), type});
  }

  const std::vector<Field> &fields() const { return fields_; }

  // Returns -1 when the struct has no such field.
  int indexOf(const std::string &name) const {
    for (size_t i = 0; i < fields_.size(); ++i) {
      if (fields_[i].name == name) {
        return static_cast<int>(i);
      }
    }
    return -1;
  }

  const Field *find(const std::string &name) const {
    int index = indexOf(name);
    return index < 0 ? nullptr : &fields_[index];
  }

private:
  std::vector<Field> fields_;
};

using StructTable = std::unordered_map<std::string, StructLayout>;
