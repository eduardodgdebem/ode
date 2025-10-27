#include "SemanticAnalyzer.hpp"

Type SemanticAnalyzer::checkExpr(const AST::Node *node) {
  if (auto *binOp = dynamic_cast<const AST::BinaryOpNode *>(node)) {
    return checkBinaryOp(*binOp);
  }
  if (auto *unaryOp = dynamic_cast<const AST::UnaryOpNode *>(node)) {
    return checkUnaryOp(*unaryOp);
  }
  if (auto *num = dynamic_cast<const AST::NumberNode *>(node)) {
    return checkNumberLiteral(*num);
  }
  if (auto *boolean = dynamic_cast<const AST::BooleanNode *>(node)) {
    return Type::Bool;
  }
  if (auto *ident = dynamic_cast<const AST::IdentifierNode *>(node)) {
    const Symbol *sym = symbols_.lookup(ident->name().value);
    if (!sym) {
      throw Error(std::format("undefined variable '{}'", ident->name().value));
    }
    return sym->type();
  }
  if (auto *call = dynamic_cast<const AST::FuncCallNode *>(node)) {
    const Symbol *sym = symbols_.lookup(call->name().value);
    if (!sym) {
      throw Error(std::format("undefined function '{}'", call->name().value));
    }
    return sym->type();
  }
  throw Error("unknown expression node type");
}

Type SemanticAnalyzer::checkUnaryOp(const AST::UnaryOpNode &node) {
  Type operandType = checkExpr(node.operand());

  switch (node.op().type) {
  case Token::Type::Minus:
    if (operandType == Type::Bool) {
      throw Error("cannot apply unary minus to boolean value");
    }
    if (operandType == Type::Void) {
      throw Error("cannot apply unary minus to void");
    }
    return operandType;

  case Token::Type::Not:
    if (operandType != Type::Bool) {
      throw Error("logical NOT requires boolean operand",
                  std::format("got '{}'", typeToString(operandType)));
    }
    return Type::Bool;

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
    if (left != Type::Bool || right != Type::Bool) {
      throw Error("logical operators require boolean operands",
                  std::format("got '{}' and '{}'", typeToString(left),
                              typeToString(right)));
    }
    return Type::Bool;

  case Token::Type::Equal:
  case Token::Type::NotEqual:
    if (left != right) {
      throw Error("equality operators require same type operands",
                  std::format("got '{}' and '{}'", typeToString(left),
                              typeToString(right)));
    }
    return Type::Bool;

  case Token::Type::Greater:
  case Token::Type::GreaterEqual:
  case Token::Type::Less:
  case Token::Type::LessEqual:
    if (left != right) {
      throw Error("comparison operators require same type operands",
                  std::format("got '{}' and '{}'", typeToString(left),
                              typeToString(right)));
    }
    if (left == Type::Bool || left == Type::Void) {
      throw Error("cannot compare boolean or void values");
    }
    return Type::Bool;

  case Token::Type::Plus:
  case Token::Type::Minus:
  case Token::Type::Multiply:
  case Token::Type::Divide:
    if (left != right) {
      throw Error("arithmetic operators require same type operands",
                  std::format("got '{}' and '{}'", typeToString(left),
                              typeToString(right)));
    }
    if (left == Type::Bool) {
      throw Error("cannot perform arithmetic on boolean values");
    }
    return left;

  default:
    throw Error("unknown binary operator");
  }
}

Type SemanticAnalyzer::checkNumberLiteral(const AST::NumberNode &node) {
  if (node.value().value.find('.') != std::string::npos) {
    return Type::F32;
  }
  long long value = std::stoll(node.value().value);
  if (value <= INT32_MIN || value >= INT32_MAX) {
    throw Error("number is out of range for i32");
  }
  return Type::I32;
}

Type SemanticAnalyzer::parseType(const AST::Node *node) {
  auto *typeNode = dynamic_cast<const AST::TypeNode *>(node);
  if (!typeNode) {
    throw Error("expected type annotation");
  }

  const std::string &typeStr = typeNode->type().value;
  if (typeStr == "i32")
    return Type::I32;
  if (typeStr == "f32")
    return Type::F32;
  if (typeStr == "bool")
    return Type::Bool;
  if (typeStr == "void")
    return Type::Void;

  throw Error(std::format("unknown type '{}'", typeStr));
}

std::string SemanticAnalyzer::typeToString(Type t) {
  switch (t) {
  case Type::I32:
    return "i32";
  case Type::F32:
    return "f32";
  case Type::Bool:
    return "bool";
  case Type::Void:
    return "void";
  }
  return "unknown";
}
