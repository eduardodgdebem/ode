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
} // namespace

// Every expression the analyzer proves well-typed is recorded here, so that
// the IR generator can look the answer up instead of re-deriving it.
Type SemanticAnalyzer::checkExpr(const AST::Node *node) {
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
      throw Error("sizeof(void) is not allowed");
    }
    return Type(Type::Kind::U64);
  }
  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    return checkNumberLiteral(*num);
  }
  if (dynamic_cast<const AST::BooleanNode *>(node)) {
    return Type(Type::Kind::Bool);
  }
  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    const Symbol *sym = symbols_.lookup(ident->name().value);
    if (!sym) {
      throw Error(std::format("undefined variable '{}'", ident->name().value));
    }
    if (sym->kind() != Symbol::Kind::Variable) {
      throw Error(std::format("'{}' is a function, not a variable",
                              ident->name().value));
    }
    return sym->type();
  }
  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    return checkCall(*call);
  }
  throw Error("unknown expression node type");
}

Type SemanticAnalyzer::checkAssignTarget(const AST::Node *target) {
  if (!isLValue(target)) {
    throw Error("left-hand side of assignment is not assignable");
  }
  return checkExpr(target);
}

Type SemanticAnalyzer::checkCall(const AST::FuncCallNode &node) {
  const Symbol *sym = symbols_.lookup(node.name().value);
  if (!sym) {
    throw Error(std::format("undefined function '{}'", node.name().value));
  }
  if (sym->kind() != Symbol::Kind::Function) {
    throw Error(std::format("'{}' is not a function", node.name().value));
  }

  const auto *args = dynamic_cast<const AST::ArgListNode *>(node.args());
  size_t argCount = args ? args->args().size() : 0;
  const auto &params = sym->params();

  if (argCount != params.size()) {
    throw Error(std::format("wrong number of arguments to '{}'",
                            node.name().value),
                std::format("expected {} but got {}", params.size(), argCount));
  }

  if (args) {
    for (size_t i = 0; i < argCount; ++i) {
      Type argType = checkExpr(args->args()[i].get());
      if (argType != params[i]) {
        throw Error(std::format("argument {} of '{}' has the wrong type",
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
      throw Error("cannot take the address of a temporary value");
    }
    Type operandType = checkExpr(node.operand());
    if (operandType.isVoid()) {
      throw Error("cannot take the address of a void value");
    }
    return operandType.pointerTo();
  }

  Type operandType = checkExpr(node.operand());

  switch (node.op().type) {
  case Token::Type::Minus:
    if (!operandType.isNumeric()) {
      throw Error("unary minus requires a numeric operand",
                  std::format("got '{}'", operandType.toString()));
    }
    return operandType;

  case Token::Type::Not:
    if (!operandType.isBool()) {
      throw Error("logical NOT requires boolean operand",
                  std::format("got '{}'", operandType.toString()));
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Multiply:
    if (!operandType.isPointer()) {
      throw Error("cannot dereference a non-pointer value",
                  std::format("got '{}'", operandType.toString()));
    }
    if (operandType.pointee().isVoid()) {
      throw Error("cannot dereference '*void'",
                  "cast it to a concrete pointer type first");
    }
    return operandType.pointee();

  default:
    throw Error(std::format("unknown unary operator '{}'", node.op().value));
  }
}

Type SemanticAnalyzer::checkBinaryOp(const AST::BinaryOpNode &node) {
  Type left = checkExpr(node.left());
  Type right = checkExpr(node.right());

  switch (node.op().type) {
  case Token::Type::Or:
  case Token::Type::And:
    if (!left.isBool() || !right.isBool()) {
      throw Error("logical operators require boolean operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Equal:
  case Token::Type::NotEqual:
    if (left != right) {
      throw Error("equality operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (left.isVoid()) {
      throw Error("cannot compare void values");
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Greater:
  case Token::Type::GreaterEqual:
  case Token::Type::Less:
  case Token::Type::LessEqual:
    if (left != right) {
      throw Error("comparison operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (left.isBool() || left.isVoid()) {
      throw Error("cannot compare boolean or void values");
    }
    return Type(Type::Kind::Bool);

  case Token::Type::Plus:
  case Token::Type::Minus: {
    // Pointer arithmetic: p + i, i + p, p - i, and p - q.
    if (left.isPointer() || right.isPointer()) {
      if (left.isPointer() && right.isPointer()) {
        if (node.op().type != Token::Type::Minus) {
          throw Error("cannot add two pointers");
        }
        if (left != right) {
          throw Error("pointer difference requires identical pointer types",
                      std::format("got '{}' and '{}'", left.toString(),
                                  right.toString()));
        }
        if (left.pointee().isVoid()) {
          throw Error("cannot take the difference of '*void' pointers");
        }
        return Type(Type::Kind::I64);
      }

      Type ptr = left.isPointer() ? left : right;
      Type offset = left.isPointer() ? right : left;

      if (right.isPointer() && node.op().type == Token::Type::Minus) {
        throw Error("cannot subtract a pointer from an integer");
      }
      if (!offset.isInteger()) {
        throw Error("pointer arithmetic requires an integer offset",
                    std::format("got '{}'", offset.toString()));
      }
      if (ptr.pointee().isVoid()) {
        throw Error("cannot do arithmetic on '*void'",
                    "cast it to a concrete pointer type first");
      }
      return ptr;
    }
  }
    [[fallthrough]];
  case Token::Type::Multiply:
  case Token::Type::Divide:
    if (left.isPointer() || right.isPointer()) {
      throw Error("pointers do not support this operator");
    }
    if (left != right) {
      throw Error("arithmetic operators require same type operands",
                  std::format("got '{}' and '{}'", left.toString(),
                              right.toString()));
    }
    if (!left.isNumeric()) {
      throw Error("arithmetic requires numeric operands",
                  std::format("got '{}'", left.toString()));
    }
    return left;

  default:
    throw Error("unknown binary operator");
  }
}

Type SemanticAnalyzer::checkCast(const AST::CastNode &node) {
  Type from = checkExpr(node.expr());
  Type to = parseType(node.type());

  auto reject = [&](const std::string &why) {
    throw Error(std::format("cannot cast '{}' to '{}'", from.toString(),
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

Type SemanticAnalyzer::checkNumberLiteral(const AST::NumberNode &node) {
  if (node.value().value.find('.') != std::string::npos) {
    return Type(Type::Kind::F32);
  }
  long long value = std::stoll(node.value().value);
  if (value <= INT32_MIN || value >= INT32_MAX) {
    throw Error("number is out of range for i32",
                "use an explicit cast such as `... as i64`");
  }
  return Type(Type::Kind::I32);
}

Type SemanticAnalyzer::parseType(const AST::Node *node) {
  auto *typeNode = dynamic_cast<const AST::TypeNode *>(node);
  if (!typeNode) {
    throw Error("expected type annotation");
  }

  // Built-in types lex as a Type keyword; anything else is a struct name.
  if (typeNode->type().type == Token::Type::Identifier) {
    return Type::structType(typeNode->type().value, typeNode->pointerDepth());
  }

  Type::Kind kind;
  if (!Type::kindFromName(typeNode->type().value, kind)) {
    throw Error(std::format("unknown type '{}'", typeNode->type().value));
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
    throw Error(context, std::format("unknown type '{}'", type.toString()));
  }
}

const StructLayout &SemanticAnalyzer::layoutOf(const Type &type,
                                               const std::string &context) const {
  auto it = structs_.find(type.structName());
  if (it == structs_.end()) {
    throw Error(context, std::format("unknown type '{}'", type.toString()));
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
    throw Error(std::format("cannot read field '{}'", node.field().value),
                std::format("'{}' is not a struct", objectType.toString()));
  }

  const StructLayout &layout =
      layoutOf(structType, std::format("field '{}'", node.field().value));

  const StructLayout::Field *field = layout.find(node.field().value);
  if (!field) {
    throw Error(std::format("struct '{}' has no field '{}'",
                            structType.structName(), node.field().value));
  }

  return field->type;
}

Type SemanticAnalyzer::checkIndex(const AST::IndexNode &node) {
  Type baseType = checkExpr(node.base());
  Type indexType = checkExpr(node.index());

  if (!baseType.isPointer()) {
    throw Error("cannot index a non-pointer value",
                std::format("got '{}'", baseType.toString()));
  }
  if (baseType.pointee().isVoid()) {
    throw Error("cannot index '*void'",
                "cast it to a concrete pointer type first");
  }
  if (!indexType.isInteger()) {
    throw Error("index must be an integer",
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
      throw Error(std::format("struct '{}' has no field '{}'",
                              node.typeName().value, init.name.value));
    }
    if (initialised[index]) {
      throw Error(std::format("field '{}' is initialised twice",
                              init.name.value));
    }
    initialised[index] = true;

    Type valueType = checkExpr(init.value.get());
    Type fieldType = layout.fields()[index].type;
    if (valueType != fieldType) {
      throw Error(std::format("field '{}' of '{}' has the wrong type",
                              init.name.value, node.typeName().value),
                  std::format("expected '{}' but got '{}'",
                              fieldType.toString(), valueType.toString()));
    }
  }

  for (size_t i = 0; i < initialised.size(); ++i) {
    if (!initialised[i]) {
      throw Error(std::format("field '{}' of '{}' is missing",
                              layout.fields()[i].name, node.typeName().value));
    }
  }

  return type;
}

bool SemanticAnalyzer::isConstantExpr(const AST::Node *node) {
  if (dynamic_cast<const AST::NumberNode *>(node) ||
      dynamic_cast<const AST::BooleanNode *>(node) ||
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
