#include "SemanticAnalyzer.hpp"

namespace {
// Only identifiers and pointer dereferences denote storage that can be
// assigned to or have its address taken.
bool isLValue(const AST::Node *node) {
  if (dynamic_cast<const AST::IdentifierNode *>(node)) {
    return true;
  }
  if (dynamic_cast<const AST::FieldAccessNode *>(node)) {
    return true;
  }
  if (dynamic_cast<const AST::IndexNode *>(node)) {
    return true;
  }
  if (auto *unary = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    return unary->op().type == Token::Type::Multiply;
  }
  return false;
}

// The lexer folds a leading '-' into a number token where the position allows
// it, so a literal carries its own sign. A negative one only fits a signed
// type, and reaches one further from zero than the positive maximum does.
bool fitsIn(unsigned long long magnitude, bool negative, Type type) {
  unsigned bits = type.bitWidth();
  if (!type.isSigned()) {
    return !negative && magnitude <= ~0ULL >> (64 - bits);
  }
  unsigned long long max = ~0ULL >> (65 - bits);
  return magnitude <= (negative ? max + 1 : max);
}
} // namespace

// Every expression the analyzer proves well-typed is recorded here, so that
// the IR generator can look the answer up instead of re-deriving it.
Type SemanticAnalyzer::checkExpr(const AST::Node *node) {
  ErrorContext context(*this, node);

  Type type = inferExprType(node);
  types_[node] = type;
  return type;
}

Type SemanticAnalyzer::inferExprType(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    return checkBinaryOp(*binOp);
  }
  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    return checkUnaryOp(*unaryOp);
  }
  if (auto *cast = dynamic_cast<const AST::CastNode *>(node)) {
    return checkCast(*cast);
  }
  if (auto *field = dynamic_cast<const AST::FieldAccessNode *>(node)) {
    return checkFieldAccess(*field);
  }
  if (auto *index = dynamic_cast<const AST::IndexNode *>(node)) {
    return checkIndex(*index);
  }
  if (auto *literal = dynamic_cast<const AST::StructLiteralNode *>(node)) {
    return checkStructLiteral(*literal);
  }
  if (auto *sizeOf = dynamic_cast<const AST::SizeOfNode *>(node)) {
    Type type = parseType(sizeOf->type());
    validateType(type, "in sizeof");
    if (type.isVoid()) {
      fail("sizeof(void) is not allowed");
    }
    return Type(Type::Kind::U64);
  }
  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    return checkNumberLiteral(*num);
  }
  if (dynamic_cast<const AST::BooleanNode *>(node)) {
    return Type(Type::Kind::Bool);
  }
  // A string literal is a pointer into a private constant, so it behaves like
  // any other `*i8` from there on.
  if (dynamic_cast<const AST::StringLiteralNode *>(node)) {
    return Type(Type::Kind::I8, 1);
  }
  if (dynamic_cast<const AST::CharLiteralNode *>(node)) {
    return Type(Type::Kind::I8);
  }
  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    const Symbol *sym = symbols_.lookup(ident->name().value);
    if (!sym) {
      fail(std::format("undefined variable '{}'", ident->name().value));
    }
    if (sym->kind() != Symbol::Kind::Variable) {
      fail(std::format("'{}' is a function, not a variable",
                              ident->name().value));
    }
    return sym->type();
  }
  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    return checkCall(*call);
  }
  fail("unknown expression node type");
}

Type SemanticAnalyzer::checkAssignTarget(const AST::Node *target) {
  if (!isLValue(target)) {
    fail("left-hand side of assignment is not assignable");
  }
  return checkExpr(target);
}

Type SemanticAnalyzer::checkCall(const AST::FuncCallNode &node) {
  const Symbol *sym = symbols_.lookup(node.name().value);
  if (!sym) {
    fail(std::format("undefined function '{}'", node.name().value));
  }
  if (sym->kind() != Symbol::Kind::Function) {
    fail(std::format("'{}' is not a function", node.name().value));
  }

  const auto *args = dynamic_cast<const AST::ArgListNode *>(node.args());
  size_t argCount = args ? args->args().size() : 0;
  const auto &params = sym->params();

  if (argCount != params.size()) {
    fail(std::format("wrong number of arguments to '{}'",
                            node.name().value),
                std::format("expected {} but got {}", params.size(), argCount));
  }

  if (args) {
    for (size_t i = 0; i < argCount; ++i) {
      Type argType = checkExpr(args->args()[i].get());
      if (argType != params[i]) {
        fail(std::format("argument {} of '{}' has the wrong type",
                                i + 1, node.name().value),
                    std::format("expected '{}' but got '{}'",
                                params[i].toString(), argType.toString()));
      }
    }
  }

  return sym->type();
}

Type SemanticAnalyzer::checkUnaryOp(const AST::UnaryOpNode &node) {
  // Address-of inspects the operand as storage rather than as a value.
  if (node.op().type == Token::Type::Ampersand) {
    if (!isLValue(node.operand())) {
      fail("cannot take the address of a temporary value");
    }
    Type operandType = checkExpr(node.operand());
    if (operandType.isVoid()) {
      fail("cannot take the address of a void value");
    }
    return operandType.pointerTo();
  }

  Type operandType = checkExpr(node.operand());

  switch (node.op().type) {
  case Token::Type::Minus:
    if (!operandType.isNumeric()) {
      fail("unary minus requires a numeric operand",
                  std::format("got '{}'", operandType.toString()));
    }
    return operandType;

  case Token::Type::Not:
    if (!operandType.isBool()) {
      fail("logical NOT requires boolean operand",
                  std::format("got '{}'", operandType.toString()));
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Multiply:
    if (!operandType.isPointer()) {
      fail("cannot dereference a non-pointer value",
                  std::format("got '{}'", operandType.toString()));
    }
    if (operandType.pointee().isVoid()) {
      fail("cannot dereference '*void'",
                  "cast it to a concrete pointer type first");
    }
    return operandType.pointee();

  default:
    fail(std::format("unknown unary operator '{}'", node.op().value));
  }
}

Type SemanticAnalyzer::checkBinaryOp(const AST::BinaryOpNode &node) {
  Type left = checkExpr(node.left());
  Type right = checkExpr(node.right());

  switch (node.op().type) {
  case Token::Type::Or:
  case Token::Type::And:
    if (!left.isBool() || !right.isBool()) {
      fail("logical operators require boolean operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Equal:
  case Token::Type::NotEqual:
    if (left != right) {
      fail("equality operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (left.isVoid()) {
      fail("cannot compare void values");
    }
    // A struct is an aggregate; there is no single machine instruction to
    // compare one, and comparing them field by field would be a feature of
    // its own.
    if (left.isStruct()) {
      fail(std::format("cannot compare struct '{}' values",
                       left.structName()),
           "compare their fields instead");
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Greater:
  case Token::Type::GreaterEqual:
  case Token::Type::Less:
  case Token::Type::LessEqual:
    if (left != right) {
      fail("comparison operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (left.isBool() || left.isVoid()) {
      fail("cannot compare boolean or void values");
    }
    if (left.isStruct()) {
      fail(std::format("cannot order struct '{}' values", left.structName()),
           "compare their fields instead");
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Plus:
  case Token::Type::Minus: {
    // Pointer arithmetic: p + i, i + p, p - i, and p - q.
    if (left.isPointer() || right.isPointer()) {
      if (left.isPointer() && right.isPointer()) {
        if (node.op().type != Token::Type::Minus) {
          fail("cannot add two pointers");
        }
        if (left != right) {
          fail("pointer difference requires identical pointer types",
                      std::format("got '{}' and '{}'", left.toString(),
                                  right.toString()));
        }
        if (left.pointee().isVoid()) {
          fail("cannot take the difference of '*void' pointers");
        }
        return Type(Type::Kind::I64);
      }

      Type ptr = left.isPointer() ? left : right;
      Type offset = left.isPointer() ? right : left;

      if (right.isPointer() && node.op().type == Token::Type::Minus) {
        fail("cannot subtract a pointer from an integer");
      }
      if (!offset.isInteger()) {
        fail("pointer arithmetic requires an integer offset",
                    std::format("got '{}'", offset.toString()));
      }
      if (ptr.pointee().isVoid()) {
        fail("cannot do arithmetic on '*void'",
                    "cast it to a concrete pointer type first");
      }
      return ptr;
    }
  }
    [[fallthrough]];
  case Token::Type::Multiply:
  case Token::Type::Divide:
    if (left.isPointer() || right.isPointer()) {
      fail("pointers do not support this operator");
    }
    if (left != right) {
      fail("arithmetic operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (!left.isNumeric()) {
      fail("arithmetic requires numeric operands",
                  std::format("got '{}'", left.toString()));
    }
    return left;

  default:
    fail("unknown binary operator");
  }
}

Type SemanticAnalyzer::checkCast(const AST::CastNode &node) {
  Type to = parseType(node.type());
  Type from = checkCastOperand(node.expr(), to);

  auto reject = [&](const std::string &why) {
    fail(std::format("cannot cast '{}' to '{}'", from.toString(),
                            to.toString()),
                why);
  };

  if (from.isVoid() || to.isVoid()) {
    reject("void is not a value type");
  }

  if (from == to) {
    return to;
  }

  if (from.isNumeric() && to.isNumeric()) {
    return to;
  }
  if (from.isBool() && to.isInteger()) {
    return to;
  }
  if (from.isInteger() && to.isBool()) {
    return to;
  }
  if (from.isPointer() && to.isPointer()) {
    return to;
  }
  // Pointers only convert to and from a pointer-sized integer.
  if (from.isPointer() && to.isInteger()) {
    if (to.bitWidth() != 64) {
      reject("pointers only convert to a 64-bit integer (i64, u64, usize)");
    }
    return to;
  }
  if (from.isInteger() && to.isPointer()) {
    if (from.bitWidth() != 64) {
      reject("only a 64-bit integer (i64, u64, usize) converts to a pointer");
    }
    return to;
  }

  reject("no such conversion");
  return to;
}

Type SemanticAnalyzer::checkCastOperand(const AST::Node *node, Type target) {
  auto *num = dynamic_cast<const AST::NumberNode *>(node);
  if (!num) {
    return checkExpr(node);
  }

  ErrorContext context(*this, node);
  Type type = checkNumberLiteral(*num, target);
  types_[node] = type;
  return type;
}

Type SemanticAnalyzer::checkNumberLiteral(const AST::NumberNode &node,
                                          Type target) {
  const std::string &text = node.value().value;
  if (text.find('.') != std::string::npos) {
    return target.isFloat() ? target : Type(Type::Kind::F32);
  }

  // A literal that fits `i32` stays `i32` even under a cast, so that a
  // narrowing conversion such as `300 as i8` keeps meaning "truncate an
  // in-range i32" rather than becoming an out-of-range literal. Only a value
  // `i32` cannot hold takes the cast's target type, which is what makes
  // `3000000000 as i64` expressible at all.
  Type fallback(Type::Kind::I32);
  if (!target.isInteger()) {
    target = fallback;
  }

  bool negative = text.front() == '-';
  unsigned long long magnitude;
  try {
    magnitude = std::stoull(negative ? text.substr(1) : text);
  } catch (const std::out_of_range &) {
    fail(std::format("number is out of range for '{}'", target.toString()));
  }

  if (fitsIn(magnitude, negative, fallback)) {
    return fallback;
  }
  if (!fitsIn(magnitude, negative, target)) {
    fail(std::format("number is out of range for '{}'", target.toString()),
                target == fallback
                    ? "use an explicit cast such as `... as i64`"
                    : "the value does not fit the type it is cast to");
  }
  return target;
}

Type SemanticAnalyzer::parseType(const AST::Node *node) {
  auto *typeNode = dynamic_cast<const AST::TypeNode *>(node);
  if (!typeNode) {
    throw Error("expected type annotation", node ? node->line() : 0,
                node ? node->column() : 0);
  }

  // Built-in types lex as a Type keyword; anything else is a struct name.
  if (typeNode->type().type == Token::Type::Identifier) {
    return Type::structType(typeNode->type().value, typeNode->pointerDepth());
  }

  Type::Kind kind;
  if (!Type::kindFromName(typeNode->type().value, kind)) {
    throw Error(std::format("unknown type '{}'", typeNode->type().value),
                typeNode->line(), typeNode->column());
  }

  return Type(kind, typeNode->pointerDepth());
}

std::vector<Type> SemanticAnalyzer::parseParamTypes(const AST::Node *params) {
  std::vector<Type> types;
  const auto *paramList = dynamic_cast<const AST::ParamListNode *>(params);
  if (!paramList) {
    return types;
  }

  for (const auto &param : paramList->params()) {
    types.push_back(parseType(param.type.get()));
  }
  return types;
}

void SemanticAnalyzer::validateType(Type type,
                                    const std::string &context) const {
  if (type.kind() != Type::Kind::Struct) {
    return;
  }
  if (!structs_.contains(type.structName())) {
    fail(context, std::format("unknown type '{}'", type.toString()));
  }
}

const StructLayout &SemanticAnalyzer::layoutOf(const Type &type,
                                               const std::string &context) const {
  auto it = structs_.find(type.structName());
  if (it == structs_.end()) {
    fail(context, std::format("unknown type '{}'", type.toString()));
  }
  return it->second;
}

Type SemanticAnalyzer::checkFieldAccess(const AST::FieldAccessNode &node) {
  Type objectType = checkExpr(node.object());

  // A single level of pointer is followed automatically, so `p.field` works
  // whether `p` is a struct or a pointer to one.
  Type structType =
      objectType.pointerDepth() == 1 ? objectType.pointee() : objectType;

  if (!structType.isStruct()) {
    fail(std::format("cannot read field '{}'", node.field().value),
                std::format("'{}' is not a struct", objectType.toString()));
  }

  const StructLayout &layout =
      layoutOf(structType, std::format("field '{}'", node.field().value));

  const StructLayout::Field *field = layout.find(node.field().value);
  if (!field) {
    fail(std::format("struct '{}' has no field '{}'",
                            structType.structName(), node.field().value));
  }

  return field->type;
}

Type SemanticAnalyzer::checkIndex(const AST::IndexNode &node) {
  Type baseType = checkExpr(node.base());
  Type indexType = checkExpr(node.index());

  if (!baseType.isPointer()) {
    fail("cannot index a non-pointer value",
                std::format("got '{}'", baseType.toString()));
  }
  if (baseType.pointee().isVoid()) {
    fail("cannot index '*void'",
                "cast it to a concrete pointer type first");
  }
  if (!indexType.isInteger()) {
    fail("index must be an integer",
                std::format("got '{}'", indexType.toString()));
  }

  return baseType.pointee();
}

Type SemanticAnalyzer::checkStructLiteral(const AST::StructLiteralNode &node) {
  Type type = Type::structType(node.typeName().value);
  const StructLayout &layout =
      layoutOf(type, std::format("in literal for '{}'", node.typeName().value));

  std::vector<bool> initialised(layout.fields().size(), false);

  for (const auto &init : node.fields()) {
    int index = layout.indexOf(init.name.value);
    if (index < 0) {
      fail(std::format("struct '{}' has no field '{}'",
                              node.typeName().value, init.name.value));
    }
    if (initialised[index]) {
      fail(std::format("field '{}' is initialised twice",
                              init.name.value));
    }
    initialised[index] = true;

    Type valueType = checkExpr(init.value.get());
    Type fieldType = layout.fields()[index].type;
    if (valueType != fieldType) {
      fail(std::format("field '{}' of '{}' has the wrong type",
                              init.name.value, node.typeName().value),
                  std::format("expected '{}' but got '{}'",
                              fieldType.toString(), valueType.toString()));
    }
  }

  for (size_t i = 0; i < initialised.size(); ++i) {
    if (!initialised[i]) {
      fail(std::format("field '{}' of '{}' is missing",
                              layout.fields()[i].name, node.typeName().value));
    }
  }

  return type;
}

bool SemanticAnalyzer::isConstantExpr(const AST::Node *node) {
  if (dynamic_cast<const AST::NumberNode *>(node) ||
      dynamic_cast<const AST::BooleanNode *>(node) ||
      dynamic_cast<const AST::StringLiteralNode *>(node) ||
      dynamic_cast<const AST::CharLiteralNode *>(node) ||
      dynamic_cast<const AST::SizeOfNode *>(node)) {
    return true;
  }
  if (auto *cast = dynamic_cast<const AST::CastNode *>(node)) {
    return isConstantExpr(cast->expr());
  }
  if (auto *unary = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    return unary->op().type == Token::Type::Minus &&
           isConstantExpr(unary->operand());
  }
  return false;
}

void SemanticAnalyzer::fail(const std::string &msg) const {
  throw Error(msg, errorNode_ ? errorNode_->line() : 0,
              errorNode_ ? errorNode_->column() : 0);
}

void SemanticAnalyzer::fail(const std::string &context,
                            const std::string &detail) const {
  throw Error(context, detail, errorNode_ ? errorNode_->line() : 0,
              errorNode_ ? errorNode_->column() : 0);
}
