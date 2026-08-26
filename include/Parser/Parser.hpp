#pragma once
#include "AST.hpp"
#include "SourceError.hpp"

#include <format>
#include <vector>

class Parser {
public:
  explicit Parser(std::vector<Token> &tokens);

  class Error : public SourceError {
  public:
    Error(const std::string &expected, const Token &got)
        : SourceError(std::format("expected '{}' but got '{}'", expected,
                                  got.value.empty() ? "end of file"
                                                    : got.value),
                      got.line, got.column) {}
    explicit Error(const std::string &msg) : SourceError(msg) {}
  };

  AST::NodePtr parse();

private:
  std::vector<Token> tokens_;
  size_t pos_;

  // Stamps a freshly built node with the position of the token it started
  // at, leaving any node that already has one alone.
  static AST::NodePtr located(AST::NodePtr node, const Token &at);

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
  AST::NodePtr parsePostfix();
  AST::NodePtr parseCast();
  AST::NodePtr parsePrimary();
  AST::NodePtr parseStatement();
  AST::NodePtr parseStatementInner();
  AST::NodePtr parseVarDecl();
  AST::NodePtr parseExprStmt();
  AST::NodePtr parseBlock();
  AST::NodePtr parseIfStmt();
  AST::NodePtr parseWhileStmt();
  AST::NodePtr parseBreakStmt();
  AST::NodePtr parseContinueStmt();
  AST::NodePtr parseReturnStmt();
  AST::NodePtr parsePrintStmt();
  AST::NodePtr parseFuncDecl();
  AST::NodePtr parseExternDecl();
  AST::NodePtr parseStructDecl();
  AST::NodePtr parseStructLiteral();
  AST::NodePtr parseSizeOf();
  AST::NodePtr parseFuncCall();
  AST::NodePtr parseParamList();
  AST::NodePtr parseArgList();
  AST::NodePtr parseType();
};
