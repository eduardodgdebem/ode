#include "Analyzer.hpp"
#include "ASTNode.hpp"
#include "Helper.hpp"
#include <format>
#include <memory>
#include <optional>
#include <stdexcept>
#include <unordered_map>

void ScopedSymbolTable::enterScope() { scopes.push_back({}); }

void ScopedSymbolTable::exitScope() {
  if (!scopes.empty()) {
    scopes.pop_back();
  }
}

void ScopedSymbolTable::declare(SymbolPointer symbol) {
  auto &current = scopes.back();
  if (current.find(symbol->getId()) != current.end()) {
    throw std::runtime_error(std::format(
        "Symbol already declared in this scope: {}", symbol->getId()));
  }
  current[symbol->getId()] = symbol;
}

std::optional<SymbolPointer> ScopedSymbolTable::lookup(SymbolID id) {
  for (auto it = scopes.rbegin(); it != scopes.rend(); ++it) {
    auto found = it->find(id);
    if (found != it->end()) {
      return found->second;
    }
  }
  return std::nullopt;
}

void Analyzer::analyze(ASTNode *node) {
  for (auto &child : node->children) {
    validateNode(child.get());
    analyze(child.get());
  }
}

void Analyzer::validateNode(ASTNode *node) {
  switch (node->type) {
  case ASTType::Block:
    validateBlock(node);
    break;
  case ASTType::VarDecl:
    validateVarDecl(node);
    break;
  case ASTType::Assign:
    validateAssign(node);
    break;
    // case ASTType::FuncDecl:
    //   validateFuncDecl(node);
    //   break;
    // case ASTType::FuncCall:
    //   validateFuncCall(node);
    //   break;
  }
}

void Analyzer::validateBlock(ASTNode *block) {
  if (block->type != ASTType::Block) {
    throw std::logic_error("ValidateBlock should only validate a Block node");
  }
  symbolsTable.enterScope();
  for (auto &child : block->children) {
    validateNode(child.get());
  }
  symbolsTable.exitScope();
}

void Analyzer::validateVarDecl(ASTNode *node) {
  if (node->type != ASTType::VarDecl) {
    throw std::logic_error(
        "ValidateVarDecl should only validate a VarDecl node");
  }

  auto symbol = symbolsTable.lookup(node->token.value);
  if (symbol.has_value()) {
    throw std::runtime_error(
        std::format("variable '{}' cannot be declared more than once",
                    symbol.value()->getId()));
  }

  if (node->children.empty()) {
    throw std::logic_error("VarDecl node missing type child");
  }

  VarType declaredType = tokenTypeToVarType(node->children[0]->token.value);

  if (node->children.size() < 2) {
    throw std::logic_error("VarDecl node missing expression child");
  }

  VarType exprType = validateExpr(node->children[1].get());

  if (declaredType != exprType) {
    throw std::runtime_error(
        std::format("type mismatch in variable '{}' declaration: declared as "
                    "'{}' but assigned '{}'",
                    node->token.value, node->children[0]->token.value,
                    exprType == VarType::I32   ? "i32"
                    : exprType == VarType::I64 ? "i64"
                                               : "bool"));
  }

  SymbolPointer newSymbol = std::make_shared<Symbol>(
      node->token.value, SymbolType::Variable, declaredType);
  symbolsTable.declare(newSymbol);
}

void Analyzer::validateAssign(ASTNode *node) {
  if (node->type != ASTType::Assign) {
    throw std::logic_error(
        "ValidateAssign should only validate an Assign node");
  }

  auto symbol = symbolsTable.lookup(node->token.value);

  if (!symbol.has_value()) {
    throw std::runtime_error(std::format(
        "variable '{}' is not declared in this scope", node->token.value));
  }

  if (node->children.empty()) {
    throw std::logic_error("Assign node missing expression child");
  }

  VarType exprType = validateExpr(node->children[0].get());
  VarType varType = symbol.value()->getLinkedType();

  if (varType != exprType) {
    throw std::runtime_error(
        std::format("type mismatch in assignment to '{}': variable is '{}' but "
                    "expression is '{}'",
                    node->token.value,
                    varType == VarType::I32   ? "i32"
                    : varType == VarType::I64 ? "i64"
                                              : "bool",
                    exprType == VarType::I32   ? "i32"
                    : exprType == VarType::I64 ? "i64"
                                               : "bool"));
  }
}

void Analyzer::validateFuncDecl(ASTNode *node) {
  if (node->type != ASTType::FuncDecl) {
    throw std::logic_error(
        "ValidateFuncDecl should only validate an FuncDecl node");
  }

  auto symbol = symbolsTable.lookup(node->token.value);

  if (symbol.has_value()) {
    throw std::runtime_error(
        std::format("Function '{}' is already declared", node->token.value));
  }

  if (node->children.empty()) {
    throw std::logic_error("Function node missing expression child");
  }

  VarType declaredType = tokenTypeToVarType(node->children[0]->token.value);
  auto params = node->children[1].get();
  auto body = node->children[2].get();

  for (auto &param : params->children) {
    validatePrimary(param.get());
  }

  validateBlock(body);

  SymbolPointer newSymbol = std::make_shared<Symbol>(
      node->token.value, SymbolType::Function, declaredType);
  symbolsTable.declare(newSymbol);
}

void Analyzer::validateFuncCall(ASTNode *node) {
  if (node->type != ASTType::FuncCall) {
    throw std::logic_error(
        "validateFuncCall should only validate an FuncCall node");
  }

  auto symbol = symbolsTable.lookup(node->token.value);

  if (!symbol.has_value()) {
    throw std::runtime_error(std::format(
        "Function '{}' is not declared in this scope", node->token.value));
  }
}

VarType Analyzer::tokenTypeToVarType(const std::string &typeStr) {
  if (typeStr == "number")
    return VarType::I32;
  if (typeStr == "bool")
    return VarType::Boolean;
  if (typeStr == "void")
    return VarType::Void;

  throw std::runtime_error(std::format("unknown type: {}", typeStr));
}

VarType Analyzer::validateExpr(ASTNode *node) {
  if (node->type != ASTType::Expr) {
    throw std::logic_error("validateExpr should only validate an Expr node");
  }

  if (node->children.empty()) {
    throw std::logic_error("Expr node has no children");
  }

  return validateAnyExpr(node->children[0].get());
}

VarType Analyzer::validateAnyExpr(ASTNode *node) {
  switch (node->type) {
  case ASTType::Expr:
    return validateExpr(node);
  case ASTType::LogicOr:
    return validateLogicOr(node);
  case ASTType::LogicAnd:
    return validateLogicAnd(node);
  case ASTType::Equality:
    return validateEquality(node);
  case ASTType::Comparison:
    return validateComparison(node);
  case ASTType::Term:
    return validateTerm(node);
  case ASTType::Factor:
    return validateFactor(node);
  case ASTType::Primary:
    return validatePrimary(node);
  default:
    throw std::logic_error(std::format("unexpected node type in expression: {}",
                                       static_cast<int>(node->type)));
  }
}

VarType Analyzer::validateLogicOr(ASTNode *node) {
  if (node->type != ASTType::LogicOr) {
    throw std::logic_error(
        "validateLogicOr should only validate a LogicOr node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("LogicOr node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType != VarType::Boolean || rightType != VarType::Boolean) {
    throw std::runtime_error("logical OR operator requires boolean operands");
  }

  return VarType::Boolean;
}

VarType Analyzer::validateLogicAnd(ASTNode *node) {
  if (node->type != ASTType::LogicAnd) {
    throw std::logic_error(
        "validateLogicAnd should only validate a LogicAnd node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("LogicAnd node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType != VarType::Boolean || rightType != VarType::Boolean) {
    throw std::runtime_error("logical AND operator requires boolean operands");
  }

  return VarType::Boolean;
}

VarType Analyzer::validateEquality(ASTNode *node) {
  if (node->type != ASTType::Equality) {
    throw std::logic_error(
        "validateEquality should only validate an Equality node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("Equality node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType != rightType) {
    throw std::runtime_error(
        std::format("equality comparison requires operands of the same type"));
  }

  return VarType::Boolean;
}

VarType Analyzer::validateComparison(ASTNode *node) {
  if (node->type != ASTType::Comparison) {
    throw std::logic_error(
        "validateComparison should only validate a Comparison node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("Comparison node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType != rightType) {
    throw std::runtime_error("comparison requires operands of the same type");
  }

  if (leftType == VarType::Boolean) {
    throw std::runtime_error(
        "comparison operators cannot be used with boolean values");
  }

  return VarType::Boolean;
}

VarType Analyzer::validateTerm(ASTNode *node) {
  if (node->type != ASTType::Term) {
    throw std::logic_error("validateTerm should only validate a Term node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("Term node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType == VarType::Boolean || rightType == VarType::Boolean) {
    throw std::runtime_error(
        "arithmetic operators cannot be used with boolean values");
  }

  if (leftType != rightType) {
    throw std::runtime_error(
        std::format("arithmetic operation requires operands of the same type"));
  }

  return leftType;
}

VarType Analyzer::validateFactor(ASTNode *node) {
  if (node->type != ASTType::Factor) {
    throw std::logic_error("validateFactor should only validate a Factor node");
  }

  if (node->children.size() != 2) {
    throw std::logic_error("Factor node must have exactly 2 children");
  }

  VarType leftType = validateAnyExpr(node->children[0].get());
  VarType rightType = validateAnyExpr(node->children[1].get());

  if (leftType == VarType::Boolean || rightType == VarType::Boolean) {
    throw std::runtime_error(
        "arithmetic operators cannot be used with boolean values");
  }

  if (leftType != rightType) {
    throw std::runtime_error(
        std::format("arithmetic operation requires operands of the same type"));
  }

  return leftType;
}

VarType Analyzer::validatePrimary(ASTNode *node) {
  if (node->type != ASTType::Primary) {
    throw std::logic_error(
        "validatePrimary should only validate a Primary node");
  }

  switch (node->token.type) {
  case Token::Type::Number: {
    std::string numStr = node->token.value;
    bool isNegative = numStr[0] == '-';

    long long value = std::stoll(numStr);

    constexpr long long i32_min = std::numeric_limits<int32_t>::min();
    constexpr long long i32_max = std::numeric_limits<int32_t>::max();

    if (value >= i32_min && value <= i32_max) {
      return VarType::I32;
    }

    return VarType::I64;
  }
  case Token::Type::Boolean: {
    return VarType::Boolean;
  }
  case Token::Type::Identifier: {
    // Look up the variable
    auto symbol = symbolsTable.lookup(node->token.value);
    if (!symbol.has_value()) {
      throw std::runtime_error(
          std::format("undefined variable: '{}'", node->token.value));
    }
    return symbol.value()->getLinkedType();
  }
  default:
    throw std::logic_error(std::format(
        "unexpected token type in primary expression: {}", node->token.value));
  }
}
