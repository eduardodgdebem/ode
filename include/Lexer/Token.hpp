#pragma once
#include <string>
#include <unordered_map>
#include <vector>

class Token {
public:
  enum class Type {
    None,
    Let,
    If,
    Else,
    Fn,
    Return,
    While,
    Print,
    Identifier,
    Number,
    Boolean,
    Char,
    Assign,
    Or,
    And,
    Equal,
    NotEqual,
    Greater,
    GreaterEqual,
    Less,
    LessEqual,
    Plus,
    Minus,
    Multiply,
    Divide,
    LParen,
    RParen,
    LBrace,
    RBrace,
    Semicolon,
    Comma,
    Colon,
    DoubleQuotes,
    Type,
    Skip,
    End
  };

  using TokenTypeMap = std::unordered_map<std::string_view, Type>;

  Type type;
  std::string value;

  Token(Type t = Type::None, std::string v = "")
      : type(t), value(std::move(v)) {}

  class Classifier {
  public:
    static constexpr std::string_view IDENTIFIER_EXTRA_CHARS = "_";

    static Type classify(std::string_view str);
    static bool isKeywordOrOperator(std::string_view str);
    static bool isNumber(std::string_view str);

    static bool isIdentifierStart(char c);
    static bool isIdentifierChar(char c);

    static bool isOperatorOrDelimiter(Type type);

  private:
    static const TokenTypeMap &getTokenMap();
  };

  class Scanner {
  public:
    explicit Scanner(std::string_view source) : source_(source), pos_(0) {}

    char peek(size_t offset = 0) const;
    char consume();
    void skipWhitespace();

    bool isAtEnd() const { return pos_ >= source_.length(); }
    size_t position() const { return pos_; }

    std::string_view substr(size_t start, size_t length) const {
      return source_.substr(start, length);
    }

  private:
    std::string_view source_;
    size_t pos_;
  };

  class Builder {
  public:
    explicit Builder(Scanner &scanner) : scanner_(scanner) {}

    std::optional<Token> tryIdentifier();
    std::optional<Token> tryNumber(Type lastType);
    std::optional<Token> tryTwoCharOperator();
    std::optional<Token> trySingleChar();

  private:
    Scanner &scanner_;
  };

  class Stream {
  public:
    explicit Stream(const std::vector<Token> &tokens)
        : tokens_(tokens), pos_(0) {}

    Token current() const;
    Token peek(size_t offset = 1) const;
    void consume();
    bool isAtEnd() const { return pos_ >= tokens_.size(); }
    size_t position() const { return pos_; }

  private:
    const std::vector<Token> &tokens_;
    size_t pos_;
  };
};
