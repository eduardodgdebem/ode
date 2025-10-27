#include "Lexer/Token.hpp"
#include <cctype>

const Token::TokenTypeMap &Token::Classifier::getTokenMap() {
  static const Token::TokenTypeMap tokens = {
      {"let", Token::Type::Let},       {"while", Token::Type::While},
      {"fn", Token::Type::Fn},         {"if", Token::Type::If},
      {"else", Token::Type::Else},     {"return", Token::Type::Return},
      {"print", Token::Type::Print},   {"true", Token::Type::Boolean},
      {"false", Token::Type::Boolean}, {"i32", Token::Type::Type},
      {"f32", Token::Type::Type},     {"bool", Token::Type::Type},
      {"void", Token::Type::Type},    {"char", Token::Type::Type},
      {"=", Token::Type::Assign},
      {"==", Token::Type::Equal},      {"!=", Token::Type::NotEqual},
      {"<", Token::Type::Less},        {"<=", Token::Type::LessEqual},
      {">", Token::Type::Greater},     {">=", Token::Type::GreaterEqual},
      {"+", Token::Type::Plus},        {"-", Token::Type::Minus},
      {"*", Token::Type::Multiply},    {"/", Token::Type::Divide},
      {"||", Token::Type::Or},         {"&&", Token::Type::And},
      {"(", Token::Type::LParen},      {")", Token::Type::RParen},
      {"{", Token::Type::LBrace},      {"}", Token::Type::RBrace},
      {";", Token::Type::Semicolon},   {",", Token::Type::Comma},
      {":", Token::Type::Colon},       {"\"", Token::Type::DoubleQuotes},
      {"!", Token::Type::Not}};

  return tokens;
}

Token::Type Token::Classifier::classify(std::string_view str) {
  auto it = getTokenMap().find(str);
  if (it != getTokenMap().end()) {
    return it->second;
  }

  if (isNumber(str)) {
    return Token::Type::Number;
  }

  return Token::Type::Identifier;
}

bool Token::Classifier::isNumber(std::string_view str) {
  if (str.empty()) {
    return false;
  }

  size_t start = (str[0] == '-') ? 1 : 0;
  if (start >= str.length()) {
    return false;
  }

  bool hasDecimal = false;
  for (size_t i = start; i < str.length(); ++i) {
    if (str[i] == '.') {
      if (hasDecimal) {
        return false;
      }
      hasDecimal = true;
    } else if (!std::isdigit(static_cast<unsigned char>(str[i]))) {
      return false;
    }
  }

  return true;
}

bool Token::Classifier::isIdentifierStart(char c) {
  return std::isalpha(static_cast<unsigned char>(c)) ||
         IDENTIFIER_EXTRA_CHARS.find(c) != std::string_view::npos;
}

bool Token::Classifier::isIdentifierChar(char c) {
  return std::isalnum(static_cast<unsigned char>(c)) ||
         IDENTIFIER_EXTRA_CHARS.find(c) != std::string_view::npos;
}

bool Token::Classifier::isOperatorOrDelimiter(Token::Type type) {
  return type == Token::Type::Equal || type == Token::Type::LParen ||
         type == Token::Type::LBrace || type == Token::Type::Comma ||
         type == Token::Type::Colon || type == Token::Type::Equal ||
         type == Token::Type::NotEqual || type == Token::Type::Greater ||
         type == Token::Type::GreaterEqual || type == Token::Type::Less ||
         type == Token::Type::LessEqual || type == Token::Type::Plus ||
         type == Token::Type::Minus || type == Token::Type::Multiply ||
         type == Token::Type::Divide || type == Token::Type::Or ||
         type == Token::Type::And || type == Token::Type::Return;
}

bool Token::Classifier::isKeywordOrOperator(std::string_view str) {
  return getTokenMap().find(str) != getTokenMap().end();
}
