#include "Parser/Parser.hpp"

AST::NodePtr Parser::parseFuncDecl() {
  consume(Token::Type::Fn, "fn");
  Token name = consume(Token::Type::Identifier, "identifier");
  auto params = parseParamList();
  consume(Token::Type::Colon, ":");
  auto returnType = parseType();
  auto body = parseBlock();

  return std::make_unique<AST::FuncDeclNode>(
      name, std::move(returnType), std::move(params), std::move(body));
}

AST::NodePtr Parser::parseFuncCall() {
  Token name = current();
  advance();
  consume(Token::Type::LParen, "(");
  auto args = parseArgList();
  consume(Token::Type::RParen, ")");

  return std::make_unique<AST::FuncCallNode>(name, std::move(args));
}

AST::NodePtr Parser::parseParamList() {
  consume(Token::Type::LParen, "(");

  auto paramList = std::make_unique<AST::ParamListNode>();

  if (current().type == Token::Type::RParen) {
    advance();
    return paramList;
  }

  while (true) {
    Token paramName = consume(Token::Type::Identifier, "parameter name");
    consume(Token::Type::Colon, ":");
    auto type = parseType();
    paramList->addParam(paramName, std::move(type));

    if (current().type != Token::Type::Comma)
      break;
    advance();
  }

  consume(Token::Type::RParen, ")");
  return paramList;
}

AST::NodePtr Parser::parseArgList() {
  auto argList = std::make_unique<AST::ArgListNode>();

  if (current().type == Token::Type::RParen) {
    return argList;
  }

  while (true) {
    argList->addArg(parseExpr());

    if (current().type != Token::Type::Comma)
      break;
    advance();
  }

  return argList;
}
