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

// ExternDecl -> 'extern' 'fn' IDENT '(' ParamList? ')' ':' Type ';'
AST::NodePtr Parser::parseExternDecl() {
  consume(Token::Type::Extern, "extern");
  consume(Token::Type::Fn, "fn");
  Token name = consume(Token::Type::Identifier, "identifier");
  auto params = parseParamList();
  consume(Token::Type::Colon, ":");
  auto returnType = parseType();
  consume(Token::Type::Semicolon, ";");

  return std::make_unique<AST::ExternFuncDeclNode>(name, std::move(returnType),
                                                   std::move(params));
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

// StructDecl -> 'struct' IDENT '{' (IDENT ':' Type ','?)* '}'
AST::NodePtr Parser::parseStructDecl() {
  consume(Token::Type::Struct, "struct");
  Token name = consume(Token::Type::Identifier, "struct name");
  consume(Token::Type::LBrace, "{");

  auto decl = std::make_unique<AST::StructDeclNode>(name);

  while (current().type != Token::Type::RBrace &&
         current().type != Token::Type::End) {
    Token fieldName = consume(Token::Type::Identifier, "field name");
    consume(Token::Type::Colon, ":");
    decl->addField(fieldName, parseType());

    if (current().type == Token::Type::Comma) {
      advance();
    }
  }

  consume(Token::Type::RBrace, "}");
  return decl;
}

// StructLiteral -> IDENT '{' (IDENT ':' Expr ','?)* '}'
AST::NodePtr Parser::parseStructLiteral() {
  Token typeName = consume(Token::Type::Identifier, "struct name");
  consume(Token::Type::LBrace, "{");

  auto literal = std::make_unique<AST::StructLiteralNode>(typeName);

  while (current().type != Token::Type::RBrace &&
         current().type != Token::Type::End) {
    Token fieldName = consume(Token::Type::Identifier, "field name");
    consume(Token::Type::Colon, ":");
    literal->addField(fieldName, parseExpr());

    if (current().type == Token::Type::Comma) {
      advance();
    }
  }

  consume(Token::Type::RBrace, "}");
  return literal;
}

// SizeOf -> 'sizeof' '(' Type ')'
AST::NodePtr Parser::parseSizeOf() {
  consume(Token::Type::SizeOf, "sizeof");
  consume(Token::Type::LParen, "(");
  auto type = parseType();
  consume(Token::Type::RParen, ")");

  return std::make_unique<AST::SizeOfNode>(std::move(type));
}
