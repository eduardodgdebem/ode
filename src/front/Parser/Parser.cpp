#include "Parser/Parser.hpp"

Parser::Parser(std::vector<Token> &tokens, Diagnostics &diagnostics)
    : tokens_(std::move(tokens)), diagnostics_(diagnostics), pos_(0) {}

AST::NodePtr Parser::parse() { return parseProgram(); }

AST::NodePtr Parser::located(AST::NodePtr node, const Token &at) {
  if (node && node->line() == 0) {
    node->setLocation(at.line, at.column);
  }
  return node;
}

AST::NodePtr Parser::reparse(size_t start) {
  size_t resume = pos_;
  pos_ = start;
  auto copy = parseExpr();
  pos_ = resume;
  return copy;
}

Token Parser::current() const {
  if (isAtEnd())
    return Token{Token::Type::End, ""};
  return tokens_[pos_];
}

Token Parser::peek(size_t offset) const {
  size_t index = pos_ + offset;
  if (index >= tokens_.size())
    return Token{Token::Type::End, ""};
  return tokens_[index];
}

void Parser::advance() {
  if (pos_ < tokens_.size())
    ++pos_;
}

bool Parser::isAtEnd() const { return pos_ >= tokens_.size(); }

void Parser::expect(Token::Type type, const std::string &name) {
  if (current().type != type) {
    throw Error(name, current());
  }
}

Token Parser::consume(Token::Type type, const std::string &name) {
  expect(type, name);
  Token tok = current();
  advance();
  return tok;
}

bool Parser::startsStatement(Token::Type type) {
  switch (type) {
  case Token::Type::Fn:
  case Token::Type::Extern:
  case Token::Type::Struct:
  case Token::Type::Let:
  case Token::Type::If:
  case Token::Type::While:
  case Token::Type::Return:
  case Token::Type::Print:
  case Token::Type::Break:
  case Token::Type::Continue:
    return true;
  default:
    return false;
  }
}

// Recovery is per statement: everything up to the next `;` or the start of the
// next statement is discarded. A `{` is skipped whole, so a malformed function
// header costs its body rather than turning it into a second round of errors.
void Parser::synchronize() {
  int depth = 0;

  while (!isAtEnd() && current().type != Token::Type::End) {
    Token::Type type = current().type;

    if (type == Token::Type::LBrace) {
      ++depth;
      advance();
      continue;
    }

    if (type == Token::Type::RBrace) {
      // At depth zero this closes the block being parsed, which is the
      // caller's to consume.
      if (depth == 0) {
        return;
      }
      --depth;
      advance();
      if (depth == 0) {
        return;
      }
      continue;
    }

    if (depth == 0) {
      if (type == Token::Type::Semicolon) {
        advance();
        return;
      }
      if (startsStatement(type)) {
        return;
      }
    }

    advance();
  }
}

AST::NodePtr Parser::parseStatementRecovering() {
  size_t start = pos_;

  try {
    return parseStatement();
  } catch (const SourceError &error) {
    diagnostics_.report(error);
    // A statement that failed on its very first token would otherwise be
    // retried forever, so recovery always costs at least one token.
    if (pos_ == start) {
      advance();
    }
    synchronize();
    return nullptr;
  }
}
