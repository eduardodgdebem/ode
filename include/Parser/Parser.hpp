#pragma once
#include "AST.hpp"
#include <format>
#include <vector>

class Parser {
public:
  explicit Parser(std::vector<Token> &tokens);

  class Error : public std::runtime_error {
  public:
    Error(const std::string &expected, const Token &got)
        : std::runtime_error(
              std::format("Expected '{}' but got '{}'", expected, got.value)) {}
    Error(const std::string &msg) : std::runtime_error(msg) {}
  };

  AST::NodePtr parse();

private:
  std::vector<Token> tokens_;
  size_t pos_;

  Token current() const;
  Token peek(size_t offset = 1) const;
  void advance();
  bool isAtEnd() const;
  void expect(Token::Type type, const std::string &name);
  Token consume(Token::Type type, const std::string &name);

  AST::NodePtr parseProgram();
  AST::NodePtr parseExpr();
  AST::NodePtr parseLogicOr();
  AST::NodePtr parseLogicAnd();
  AST::NodePtr parseEquality();
  AST::NodePtr parseComparison();
  AST::NodePtr parseTerm();
  AST::NodePtr parseFactor();
  AST::NodePtr parseUnary();
  AST::NodePtr parsePrimary();
  AST::NodePtr parseStatement();
  AST::NodePtr parseVarDecl();
  AST::NodePtr parseAssign();
  AST::NodePtr parseExprStmt();
  AST::NodePtr parseBlock();
  AST::NodePtr parseIfStmt();
  AST::NodePtr parseWhileStmt();
  AST::NodePtr parseReturnStmt();
  AST::NodePtr parsePrintStmt();
  AST::NodePtr parseFuncDecl();
  AST::NodePtr parseFuncCall();
  AST::NodePtr parseParamList();
  AST::NodePtr parseArgList();
  AST::NodePtr parseType();
};
