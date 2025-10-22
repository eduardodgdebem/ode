#include <format>
#include <memory>
#include <stdexcept>

#include "ASTNode.hpp"
#include "Lexer/Token.hpp"
#include "Parser.hpp"

ASTNodePointer Parser::parse() { return parseProgram(); }

Token Parser::currentToken() {
  if (pos >= tokens.size()) {
    return Token{Token::Type::End, ""};
  }
  return tokens.at(pos);
}

Token Parser::peekToken(int offset) {
  if (pos >= tokens.size()) {
    return Token{Token::Type::End, ""};
  }
  return tokens.at(pos + offset);
}

void Parser::consumeToken() {
  if (pos < tokens.size()) {
    pos++;
  }
}

ASTNodePointer Parser::parseProgram() {
  auto program = std::make_unique<ASTNode>(ASTType::Program);

  while (currentToken().type != Token::Type::End) {
    auto stm = parseStatement();
    if (stm)
      program->addChild(std::move(stm));
  }

  return program;
}

ASTNodePointer Parser::parseBlock() {
  if (currentToken().type != Token::Type::LBraket) {
    throw std::logic_error(
        std::format("Expected '{}' but got {}", "{", currentToken().value));
  }

  consumeToken();

  auto newNode = std::make_unique<ASTNode>(ASTType::Block);
  while (currentToken().type != Token::Type::RBraket &&
         currentToken().type != Token::Type::End) {
    auto statement = parseStatement();
    newNode->addChild(std::move(statement));
  }

  if (currentToken().type != Token::Type::RBraket) {
    throw std::logic_error(
        std::format("Expected '}}' but got {}", currentToken().value));
  }

  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseFuncDecl() {
  if (currentToken().type != Token::Type::Fn) {
    throw std::logic_error(
        std::format("Expected 'fn' but got {}", currentToken().value));
  }
  consumeToken();

  if (currentToken().type != Token::Type::Identifier) {
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

  if (currentToken().type != Token::Type::Colon) {
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
  if (currentToken().type != Token::Type::Return) {
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

  if (currentToken().type != Token::Type::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parsePrintStmt() {
  if (currentToken().type != Token::Type::Print) {
    throw std::logic_error(
        std::format("Expected 'print' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::PrintStmt, currentToken());

  consumeToken();

  auto expr = parseExpr();
  if (!expr) {
    throw std::logic_error(
        std::format("Expected expression but got {}", currentToken().value));
  }

  newNode->addChild(std::move(expr));

  if (currentToken().type != Token::Type::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseParamList() {
  if (currentToken().type != Token::Type::LParen) {
    throw std::logic_error(
        std::format("Expected '(' but got {}", currentToken().value));
  }
  consumeToken();

  auto newNode = std::make_unique<ASTNode>(ASTType::ParamList, currentToken());

  if (currentToken().type == Token::Type::RParen) {
    consumeToken();
    return newNode;
  }

  while (currentToken().type != Token::Type::RParen) {
    if (currentToken().type != Token::Type::Identifier) {
      throw std::logic_error(std::format("expected parameter name but got: {}",
                                         currentToken().value));
    }
    auto param = std::make_unique<ASTNode>(ASTType::Primary, currentToken());
    consumeToken();

    if (currentToken().type != Token::Type::Colon) {
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

    if (currentToken().type == Token::Type::Comma) {
      consumeToken();
    }
  }

  if (currentToken().type != Token::Type::RParen) {
    throw std::logic_error(std::format(
        "param list should end with ')' but got: {}", currentToken().value));
  }
  consumeToken();

  return newNode;
}

ASTNodePointer Parser::parseWhileStmnt() {
  if (currentToken().type != Token::Type::While) {
    throw std::logic_error(
        std::format("Expected 'while' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::WhileStmt, currentToken());

  consumeToken();

  if (currentToken().type != Token::Type::LParen) {
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
  if (currentToken().type != Token::Type::If) {
    throw std::logic_error(
        std::format("Expected 'if' but got {}", currentToken().value));
  }

  auto newNode = std::make_unique<ASTNode>(ASTType::IfStmt, currentToken());

  consumeToken();

  if (currentToken().type != Token::Type::LParen) {
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

  if (currentToken().type == Token::Type::Else) {
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
  case Token::Type::Let:
    return parseVarDecl();
  case Token::Type::Identifier: {
    if (peekToken().type == Token::Type::Equal) {
      return parseAssign();
    }
    return parseExprStm();
  }
  case Token::Type::LBraket:
    return parseBlock();
  case Token::Type::If:
    return parseIfStmnt();
  case Token::Type::While:
    return parseWhileStmnt();
  case Token::Type::Fn:
    return parseFuncDecl();
  case Token::Type::Return:
    return parseReturnStmt();
  case Token::Type::Print:
    return parsePrintStmt();
  default:
    return parseExprStm();
  }
}
ASTNodePointer Parser::parseVarDecl() {
  if (currentToken().type != Token::Type::Let) {
    throw std::logic_error(
        std::format("Expected 'let' but got {}", currentToken().value));
  }

  consumeToken();

  if (currentToken().type != Token::Type::Identifier) {
    throw std::logic_error(
        std::format("Expected identifier but got {}", currentToken().value));
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != Token::Type::Colon) {
    throw std::logic_error(
        std::format("Expected ':' but got {}", currentToken().value));
  }
  consumeToken();

  auto type = parseType();
  if (!type) {
    throw std::logic_error(
        std::format("Expected type but got {}", currentToken().value));
  }

  if (currentToken().type != Token::Type::Equal) {
    throw std::logic_error(
        std::format("Expected '=' but got {}", currentToken().value));
  }
  consumeToken();

  auto expr = parseExpr();
  auto assignNode = std::make_unique<ASTNode>(ASTType::VarDecl, ident);
  assignNode->addChild(std::move(type));
  assignNode->addChild(std::move(expr));

  if (currentToken().type != Token::Type::Semicolumn) {
    throw std::logic_error(
        std::format("Expected ';' but got {}", currentToken().value));
  }

  consumeToken();

  return assignNode;
}

ASTNodePointer Parser::parseAssign() {
  if (currentToken().type != Token::Type::Identifier) {
    throw std::logic_error(
        std::format("Expected identifier but got {}", currentToken().value));
  }
  Token ident = currentToken();
  consumeToken();

  if (currentToken().type != Token::Type::Equal) {
    throw std::logic_error(
        std::format("Expected '=' but got {}", currentToken().value));
  }
  consumeToken();

  auto expr = parseExpr();
  auto assignNode = std::make_unique<ASTNode>(ASTType::Assign, ident);
  assignNode->addChild(std::move(expr));

  if (currentToken().type != Token::Type::Semicolumn) {
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

  if (currentToken().type != Token::Type::Semicolumn) {
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

  while (currentToken().type == Token::Type::Or) {
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

  while (currentToken().type == Token::Type::And) {
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

  while (currentToken().type == Token::Type::EqualOp ||
         currentToken().type == Token::Type::DiffOp) {
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

  while (currentToken().type == Token::Type::GreaterOp ||
         currentToken().type == Token::Type::GreaterEqualOp ||
         currentToken().type == Token::Type::LesserOp ||
         currentToken().type == Token::Type::LesserEqualOp) {
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

  while (currentToken().type == Token::Type::Plus ||
         currentToken().type == Token::Type::Minus) {
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

  while (currentToken().type == Token::Type::Multiply ||
         currentToken().type == Token::Type::Divide) {
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

ASTNodePointer Parser::parseArgList() {
  auto argListNode = std::make_unique<ASTNode>(ASTType::ArgList);

  if (currentToken().type == Token::Type::RParen) {
    return argListNode;
  }

  while (true) {
    auto expr = parseExpr();
    if (!expr) {
      throw std::logic_error(
          std::format("Expected expression in argument list, got {}",
                      currentToken().value));
    }
    argListNode->addChild(std::move(expr));

    if (currentToken().type == Token::Type::Comma) {
      consumeToken();
    } else {
      break;
    }
  }

  return argListNode;
}

ASTNodePointer Parser::parseFuncCall() {
  auto token = currentToken();
  auto callNode = std::make_unique<ASTNode>(ASTType::FuncCall, token);
  consumeToken(); // consume identifier

  if (currentToken().type != Token::Type::LParen) {
    throw std::logic_error(std::format(
        "Expected '(' after function name but got {}", currentToken().value));
  }
  consumeToken(); // consume '('

  auto argList = parseArgList();
  callNode->addChild(std::move(argList));

  if (currentToken().type != Token::Type::RParen) {
    throw std::logic_error(
        std::format("Expected ')' after function arguments but got {}",
                    currentToken().value));
  }
  consumeToken(); // consume ')'

  return callNode;
}

ASTNodePointer Parser::parsePrimary() {
  auto curr = currentToken();
  switch (curr.type) {
  case Token::Type::LParen: {
    consumeToken();
    auto node = parseExpr();
    if (currentToken().type != Token::Type::RParen) {
      throw std::logic_error(std::format(
          "Expected ')' after expression but got {}", currentToken().value));
    }
    consumeToken();
    return node;
  }
  case Token::Type::Number: {
    consumeToken();
    return std::make_unique<ASTNode>(ASTType::Primary, curr);
  }
  case Token::Type::Identifier: {
    if (peekToken().type == Token::Type::LParen) {
      return parseFuncCall();
    }
    consumeToken();
    return std::make_unique<ASTNode>(ASTType::Primary, curr);
  }
  case Token::Type::Boolean: {
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
  if (currentToken().type != Token::Type::Type) {
    return nullptr;
  }

  auto node = std::make_unique<ASTNode>(ASTType::Type, currentToken());
  consumeToken();
  return node;
}
