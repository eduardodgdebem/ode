#pragma once
#include <string>
#include <string_view>

// A value type in Ode: a base kind plus a pointer depth.
// `i32` is {I32, 0}, `*i32` is {I32, 1}, `**i8` is {I8, 2}.
class Type {
public:
  enum class Kind { I8, U8, I32, I64, U64, F32, Bool, Void, Struct };

  Type() : kind_(Kind::Void), pointerDepth_(0) {}
  explicit Type(Kind kind, int pointerDepth = 0)
      : kind_(kind), pointerDepth_(pointerDepth) {}

  static Type structType(std::string name, int pointerDepth = 0) {
    Type type(Kind::Struct, pointerDepth);
    type.structName_ = std::move(name);
    return type;
  }

  Kind kind() const { return kind_; }
  int pointerDepth() const { return pointerDepth_; }
  // Only meaningful when kind() is Struct.
  const std::string &structName() const { return structName_; }

  bool isStruct() const { return !isPointer() && kind_ == Kind::Struct; }
  bool isPointer() const { return pointerDepth_ > 0; }

  Type pointee() const {
    Type type(kind_, pointerDepth_ - 1);
    type.structName_ = structName_;
    return type;
  }
  Type pointerTo() const {
    Type type(kind_, pointerDepth_ + 1);
    type.structName_ = structName_;
    return type;
  }

  bool isInteger() const {
    if (isPointer() || kind_ == Kind::Struct)
      return false;
    return kind_ == Kind::I8 || kind_ == Kind::U8 || kind_ == Kind::I32 ||
           kind_ == Kind::I64 || kind_ == Kind::U64;
  }
  bool isFloat() const { return !isPointer() && kind_ == Kind::F32; }
  bool isBool() const { return !isPointer() && kind_ == Kind::Bool; }
  bool isVoid() const { return !isPointer() && kind_ == Kind::Void; }
  bool isNumeric() const { return isInteger() || isFloat(); }

  // Unsigned kinds use zero-extension, unsigned division and unsigned
  // comparisons; everything else is treated as signed.
  bool isSigned() const {
    return isInteger() && kind_ != Kind::U8 && kind_ != Kind::U64;
  }

  unsigned bitWidth() const {
    switch (kind_) {
    case Kind::I8:
    case Kind::U8:
      return 8;
    case Kind::I32:
      return 32;
    case Kind::I64:
    case Kind::U64:
      return 64;
    default:
      return 0;
    }
  }

  bool operator==(const Type &other) const {
    return kind_ == other.kind_ && pointerDepth_ == other.pointerDepth_ &&
           structName_ == other.structName_;
  }
  bool operator!=(const Type &other) const { return !(*this == other); }

  std::string toString() const {
    std::string out(pointerDepth_, '*');
    switch (kind_) {
    case Kind::I8:
      return out + "i8";
    case Kind::U8:
      return out + "u8";
    case Kind::I32:
      return out + "i32";
    case Kind::I64:
      return out + "i64";
    case Kind::U64:
      return out + "u64";
    case Kind::F32:
      return out + "f32";
    case Kind::Bool:
      return out + "bool";
    case Kind::Void:
      return out + "void";
    case Kind::Struct:
      return out + structName_;
    }
    return out + "unknown";
  }

  // Returns false when `name` is not a known base type keyword.
  static bool kindFromName(std::string_view name, Kind &out) {
    if (name == "i8")
      out = Kind::I8;
    else if (name == "u8")
      out = Kind::U8;
    else if (name == "i32")
      out = Kind::I32;
    else if (name == "i64")
      out = Kind::I64;
    else if (name == "u64" || name == "usize")
      out = Kind::U64;
    else if (name == "f32")
      out = Kind::F32;
    else if (name == "bool")
      out = Kind::Bool;
    else if (name == "void")
      out = Kind::Void;
    else
      return false;
    return true;
  }

private:
  Kind kind_;
  int pointerDepth_;
  std::string structName_;
};
