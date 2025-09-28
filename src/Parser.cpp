#include <format>
#include <memory>
#include <stdexcept>

#include "include/ASTNode.hpp"
#include "include/Parser.hpp"
#include "include/Token.hpp"

ASTNodePointer Parser::parse() { return parseProgram(); }

Token Parser::currentToken() {
  if (pos >= tokens.size()) {
    return Token{TokenType::End, ""};
  }
  return tokens.at(pos);
}

void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
}

ASTNodePointer Parser::parseProgram() {
  auto program = std::make_unique<ASTNode>(ASTType::Program);

  while (currentToken().type != TokenType::End) {
    auto stm = parseStatement();
    if (stm)
      program->addChild(std::move(stm));
  }

  return program;
}

ASTNodePointer Parser::parseBlock() {
  if (currentToken().type != TokenType::LBraket) {
    throw std::logic_error(
        std::format("Expected '{}' but got {}", "{", currentToken().value));
  }

  consumeToken();

  auto newNode = std::make_unique<ASTNode>(ASTType::Block);
  while (currentToken().type != TokenType::RBraket &&
         currentToken().type != TokenType::End) {
    auto statement = parseStatement();
    newNode->addChild(std::move(statement));
  }

  if (currentToken().type != TokenType::RBraket) {
    throw std::logic_error(
        std::format("Expected '}}' but got {}", currentToken().value));
  }

  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseFuncDecl() {
  if (currentToken().type != TokenType::Fn) {
    throw std::logic_error(
        std::format("Expected 'fn' but got {}", currentToken().value));
  }
  consumeToken();

  if (currentToken().type != TokenType::Identifier) {
    throw std::logic_error(
        std::format("Expected identifier but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::FuncDecl, currentToken());
  consumeToken();

  auto paramList = parseParamList();
  if (!paramList) {
    throw std::logic_error(std::format(
        "Expected function parameters but got {}", currentToken().value));
  }

  if (currentToken().type != TokenType::Colon) {
    throw std::logic_error(
        std::format("Expected ':' but got {}", currentToken().value));
  }
  consumeToken();

  auto type = parseType();
  if (!type) {
    throw std::logic_error(
        std::format("Expected type but got {}", currentToken().value));
  }
  newNode->addChild(std::move(type));

  newNode->addChild(std::move(paramList));

  auto block = parseBlock();
  if (!block) {
    throw std::logic_error(
        std::format("Expected function body but got {}", currentToken().value));
  }
  newNode->addChild(std::move(block));

  return newNode;
}

ASTNodePointer Parser::parseReturnStmt() {
  if (currentToken().type != TokenType::Return) {
    throw std::logic_error(
        std::format("Expected 'return' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::ReturnStmt, currentToken());

  consumeToken();

  auto expr = parseExpr();
  if (!expr) {
    throw std::logic_error(
        std::format("Expected expression but got {}", currentToken().value));
  }

  newNode->addChild(std::move(expr));

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseParamList() {
  if (currentToken().type != TokenType::LParen) {
    throw std::logic_error(
        std::format("Expected '(' but got {}", currentToken().value));
  }
  consumeToken();

  auto newNode = std::make_unique<ASTNode>(ASTType::ParamList, currentToken());

  if (currentToken().type == TokenType::RParen) {
    consumeToken();
    return newNode;
  }

  while (currentToken().type != TokenType::RParen) {
    if (currentToken().type != TokenType::Identifier) {
      throw std::logic_error(std::format("expected parameter name but got: {}",
                                         currentToken().value));
    }
    auto param = std::make_unique<ASTNode>(ASTType::Primary, currentToken());
    consumeToken();

    if (currentToken().type != TokenType::Colon) {
      throw std::logic_error(
          std::format("expected ':' after parameter name but got: {}",
                      currentToken().value));
    }
    consumeToken();

    auto type = parseType();
    if (!type) {
      throw std::logic_error(std::format("expected type after ':' but got: {}",
                                         currentToken().value));
    }
    param->addChild(std::move(type));
    newNode->addChild(std::move(param));

    if (currentToken().type == TokenType::Comma) {
      consumeToken();
    }
  }

  if (currentToken().type != TokenType::RParen) {
    throw std::logic_error(std::format(
        "param list should end with ')' but got: {}", currentToken().value));
  }
  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseWhileStmnt() {
  if (currentToken().type != TokenType::While) {
    throw std::logic_error(
        std::format("Expected 'while' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::WhileStmt, currentToken());

  consumeToken();

  if (currentToken().type != TokenType::LParen) {
    throw std::logic_error(
        std::format("Expected '(' but got {}", currentToken().value));
  }

  auto expr = parseExpr();

  if (expr == nullptr) {
    throw std::logic_error(
        std::format("Expected expression but got {}", currentToken().value));
  }

  newNode->addChild(std::move(expr));

  auto block = parseBlock();

  if (block == nullptr) {
    throw std::logic_error(
        std::format("Expected block but got {}", currentToken().value));
  }

  newNode->addChild(std::move(block));

  return newNode;
}

ASTNodePointer Parser::parseIfStmnt() {
  if (currentToken().type != TokenType::If) {
    throw std::logic_error(
        std::format("Expected 'if' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::IfStmt, currentToken());

  consumeToken();

  if (currentToken().type != TokenType::LParen) {
    throw std::logic_error(
        std::format("Expected '(' but got {}", currentToken().value));
  }

  auto expr = parseExpr();

  if (expr == nullptr) {
    throw std::logic_error(
        std::format("Expected expression but got {}", currentToken().value));
  }

  newNode->addChild(std::move(expr));

  auto ifBlock = parseBlock();

  if (ifBlock == nullptr) {
    throw std::logic_error(
        std::format("Expected block but got {}", currentToken().value));
  }

  newNode->addChild(std::move(ifBlock));

  if (currentToken().type == TokenType::Else) {
    consumeToken();

    auto elseBlock = parseBlock();
    if (!elseBlock) {
      throw std::logic_error(
          std::format("Expected block but got {}", currentToken().value));
    }

    newNode->addChild(std::move(elseBlock));
  }

  return newNode;
}

ASTNodePointer Parser::parseStatement() {
  switch (currentToken().type) {
  case TokenType::Let:
    return parseVarDecl();
  case TokenType::Identifier:
    return parseAssign();
  case TokenType::LBraket:
    return parseBlock();
  case TokenType::If:
    return parseIfStmnt();
  case TokenType::While:
    return parseWhileStmnt();
  case TokenType::Fn:
    return parseFuncDecl();
  case TokenType::Return:
    return parseReturnStmt();
  default:
    return parseExprStm();
  }
}
ASTNodePointer Parser::parseVarDecl() {
  if (currentToken().type != TokenType::Let) {
    throw std::logic_error(
        std::format("Expected 'let' but got {}", currentToken().value));
  }

  consumeToken();

  if (currentToken().type != TokenType::Identifier) {
    throw std::logic_error(
        std::format("Expected identifier but got {}", currentToken().value));
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != TokenType::Colon) {
    throw std::logic_error(
        std::format("Expected ':' but got {}", currentToken().value));
  }
  consumeToken();

  auto type = parseType();
  if (!type) {
    throw std::logic_error(
        std::format("Expected type but got {}", currentToken().value));
  }

  if (currentToken().type != TokenType::Equal) {
    throw std::logic_error(
        std::format("Expected '=' but got {}", currentToken().value));
  }
  consumeToken();

  auto expr = parseExpr();
  auto assignNode = std::make_unique<ASTNode>(ASTType::VarDecl, ident);
  assignNode->addChild(std::move(type));
  assignNode->addChild(std::move(expr));

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return assignNode;
}

ASTNodePointer Parser::parseAssign() {
  if (currentToken().type != TokenType::Identifier) {
    throw std::logic_error(
        std::format("Expected identifier but got {}", currentToken().value));
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != TokenType::Equal) {
    throw std::logic_error(
        std::format("Expected '=' but got {}", currentToken().value));
  }
  consumeToken();

  auto expr = parseExpr();
  auto assignNode = std::make_unique<ASTNode>(ASTType::Assign, ident);
  assignNode->addChild(std::move(expr));

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return assignNode;
}

ASTNodePointer Parser::parseExprStm() {
  auto expr = parseExpr();

  if (!expr) {
    throw std::logic_error(
        std::format("Expected expression but got {}", currentToken().value));
  }

  auto curr = currentToken();

  if (currentToken().type != TokenType::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }
  consumeToken();

  auto exprStmt = std::make_unique<ASTNode>(ASTType::ExprStmt);
  exprStmt->addChild(std::move(expr));
  return exprStmt;
}

ASTNodePointer Parser::parseExpr() {
  auto node = parseLogicOr();
  if (!node) {
    throw std::logic_error(
        std::format("Invalid expression, got {}", currentToken().value));
  }
  auto exprNode = std::make_unique<ASTNode>(ASTType::Expr);
  exprNode->addChild(std::move(node));
  return exprNode;
}

ASTNodePointer Parser::parseLogicOr() {
  auto node = parseLogicAnd();

  while (currentToken().type == TokenType::Or) {
    Token op = currentToken();
    consumeToken();
    auto right = parseLogicAnd();
    if (!right)
      throw std::logic_error(std::format(
          "Expected expression after '||' but got {}", currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::LogicOr, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseLogicAnd() {
  auto node = parseEquality();

  while (currentToken().type == TokenType::And) {
    Token op = currentToken();
    consumeToken();
    auto right = parseEquality();
    if (!right)
      throw std::logic_error(std::format(
          "Expected expression after '&&' but got {}", currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::LogicAnd, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseEquality() {
  auto node = parseComparison();

  while (currentToken().type == TokenType::EqualOp ||
         currentToken().type == TokenType::DiffOp) {
    Token op = currentToken();
    consumeToken();
    auto right = parseComparison();
    if (!right)
      throw std::logic_error(
          std::format("Expected expression after equality operator but got {}",
                      currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::Equality, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseComparison() {
  auto node = parseTerm();

  while (currentToken().type == TokenType::GreaterOp ||
         currentToken().type == TokenType::GreaterEqualOp ||
         currentToken().type == TokenType::LesserOp ||
         currentToken().type == TokenType::LesserEqualOp) {
    Token op = currentToken();
    consumeToken();

    auto right = parseTerm();
    if (!right)
      throw std::logic_error(
          std::format("Expected expression after operator but got {}",
                      currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::Comparison, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseTerm() {
  auto node = parseFactor();

  while (currentToken().type == TokenType::Plus ||
         currentToken().type == TokenType::Minus) {
    Token op = currentToken();
    consumeToken();
    auto right = parseFactor();
    if (!right)
      throw std::logic_error(
          std::format("Expected expression after operator but got {}",
                      currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::Term, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseFactor() {
  auto node = parsePrimary();

  while (currentToken().type == TokenType::Multiply ||
         currentToken().type == TokenType::Divide) {
    Token op = currentToken();
    consumeToken();
    auto right = parsePrimary();
    if (!right)
      throw std::logic_error(
          std::format("Expected expression after operator but got {}",
                      currentToken().value));

    auto newNode = std::make_unique<ASTNode>(ASTType::Factor, op);
    newNode->addChild(std::move(node));
    newNode->addChild(std::move(right));

    node = std::move(newNode);
  }

  return node;
}

ASTNodePointer Parser::parseCall(Token token) {
  auto callNode = std::make_unique<ASTNode>(ASTType::FuncCall, token);

  consumeToken();

  while (currentToken().type != TokenType::RParen) {
    auto arg = parseExpr();
    if (!arg) {
      throw std::logic_error(std::format(
          "Invalid expression in function call, got {}", currentToken().value));
    }
    callNode->addChild(std::move(arg));

    if (currentToken().type == TokenType::Comma) {
      consumeToken();
    } else if (currentToken().type != TokenType::RParen) {
      throw std::logic_error(
          std::format("Expected ')' or ',' in function call but got {}",
                      currentToken().value));
    }
  }

  consumeToken();
  return callNode;
}

ASTNodePointer Parser::parsePrimary() {
  auto curr = currentToken();
  switch (curr.type) {
  case TokenType::LParen: {
    consumeToken();
    auto node = parseExpr();
    if (currentToken().type != TokenType::RParen) {
      throw std::logic_error(std::format(
          "Expected ')' after expression but got {}", currentToken().value));
    }
    consumeToken();
    return node;
  }
  case TokenType::Number: {
    consumeToken();
    return std::make_unique<ASTNode>(ASTType::Primary, curr);
  }
  case TokenType::Identifier: {
    consumeToken();
    if (currentToken().type == TokenType::LParen) {
      return parseCall(curr);
    }
    return std::make_unique<ASTNode>(ASTType::Primary, curr);
  }
  case TokenType::Boolean: {
    consumeToken();
    return std::make_unique<ASTNode>(ASTType::Primary, curr);
  }
  default:
    throw std::logic_error(std::format(
        "Expected number, true, false, identifier, or '(' but got {}",
        currentToken().value));
  }
}

ASTNodePointer Parser::parseType() {
  if (currentToken().type != TokenType::Type) {
    return nullptr;
  }

  auto node = std::make_unique<ASTNode>(ASTType::Type, currentToken());
  consumeToken();
  return node;
}
