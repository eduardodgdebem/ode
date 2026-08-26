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

    // For a token that is valid syntax in the wrong place, where there is no
    // single thing that was expected instead.
    static Error at(const Token &token, const std::string &msg) {
      return Error(msg, token.line, token.column);
    }

  private:
    Error(const std::string &msg, int line, int column)
        : SourceError(msg, line, column) {}
  };

  AST::NodePtr parse();

private:
  std::vector<Token> tokens_;
  size_t pos_;
  // False as soon as a block is opened. `fn`, `extern` and `struct` are
  // file-level constructs, and a body is not the file level.
  bool atTopLevel_ = true;

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
  // Rejects a declaration written anywhere but the top level of the program.
  void requireTopLevel(const std::string &construct);
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
