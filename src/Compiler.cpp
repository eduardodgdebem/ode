#include "Compiler.hpp"

#include <filesystem>
#include <iostream>
#include <format>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Diagnostics.hpp"
#include "IRGenerator.hpp"
#include "Lexer/Lexer.hpp"
#include "Linker.hpp"
#include "Parser/AST.hpp"
#include "Parser/ASTPrinter.hpp"
#include "Parser/Parser.hpp"
#include "Reader.hpp"
#include "SemanticAnalyzer.hpp"
#include "SourceError.hpp"

namespace {

// The names the self-hosted lexer prints, so that the two dumps compare
// directly. Operators name themselves.
std::string tokenKindName(Token::Type type) {
  switch (type) {
  case Token::Type::Identifier: return "ident";
  case Token::Type::Number: return "number";
  case Token::Type::String: return "string";
  case Token::Type::Char: return "char";
  case Token::Type::Boolean: return "bool";
  case Token::Type::Type: return "type";
  case Token::Type::Let: return "let";
  case Token::Type::If: return "if";
  case Token::Type::Else: return "else";
  case Token::Type::Fn: return "fn";
  case Token::Type::Extern: return "extern";
  case Token::Type::Struct: return "struct";
  case Token::Type::SizeOf: return "sizeof";
  case Token::Type::Return: return "return";
  case Token::Type::While: return "while";
  case Token::Type::Break: return "break";
  case Token::Type::Continue: return "continue";
  case Token::Type::Print: return "print";
  case Token::Type::As: return "as";
  case Token::Type::Assign: return "=";
  case Token::Type::Plus: return "+";
  case Token::Type::Minus: return "-";
  case Token::Type::Multiply: return "*";
  case Token::Type::Divide: return "/";
  case Token::Type::Percent: return "%";
  case Token::Type::Not: return "!";
  case Token::Type::Ampersand: return "&";
  case Token::Type::Pipe: return "|";
  case Token::Type::Caret: return "^";
  case Token::Type::ShiftLeft: return "<<";
  case Token::Type::ShiftRight: return ">>";
  case Token::Type::And: return "&&";
  case Token::Type::Or: return "||";
  case Token::Type::Equal: return "==";
  case Token::Type::NotEqual: return "!=";
  case Token::Type::Less: return "<";
  case Token::Type::LessEqual: return "<=";
  case Token::Type::Greater: return ">";
  case Token::Type::GreaterEqual: return ">=";
  case Token::Type::PlusAssign: return "+=";
  case Token::Type::MinusAssign: return "-=";
  case Token::Type::MultiplyAssign: return "*=";
  case Token::Type::DivideAssign: return "/=";
  case Token::Type::PercentAssign: return "%=";
  case Token::Type::LParen: return "(";
  case Token::Type::RParen: return ")";
  case Token::Type::LBrace: return "{";
  case Token::Type::RBrace: return "}";
  case Token::Type::LBracket: return "[";
  case Token::Type::RBracket: return "]";
  case Token::Type::Dot: return ".";
  case Token::Type::Semicolon: return ";";
  case Token::Type::Comma: return ",";
  case Token::Type::Colon: return ":";
  case Token::Type::End: return "end";
  default: return "?";
  }
}

// An operator's text is its own name, so printing both would say nothing.
bool tokenCarriesText(Token::Type type) {
  switch (type) {
  case Token::Type::Identifier:
  case Token::Type::Number:
  case Token::Type::String:
  case Token::Type::Char:
  case Token::Type::Boolean:
  case Token::Type::Type:
    return true;
  default:
    return false;
  }
}

} // namespace

Compiler::Compiler(Options options) : options(std::move(options)) {}

void Compiler::run() {
  try {
    compile();
  } catch (const SourceError &error) {
    // An error that escaped a phase's recovery, so it is the only one there
    // is to report.
    Diagnostics single;
    single.report(error);
    throw std::runtime_error(formatDiagnostics(single));
  }
}

// Only the driver knows which file is being compiled, so it is what turns a
// line:column into a full file:line:column reference.
std::string Compiler::formatDiagnostics(const Diagnostics &diagnostics) const {
  std::string report;

  for (const Diagnostic &diagnostic : diagnostics.entries()) {
    if (!report.empty()) {
      report += '\n';
    }
    report += diagnostic.line > 0
                  ? std::format("{}:{}:{}: error: {}",
                                options.inputPath.string(), diagnostic.line,
                                diagnostic.column, diagnostic.message)
                  : std::format("{}: error: {}", options.inputPath.string(),
                                diagnostic.message);
  }

  // A single error reads better on its own; a count is only worth printing
  // once there is more than one thing to count. Past the limit the count and
  // the list disagree, so the summary says which is which rather than letting
  // a truncated list read as the whole story.
  if (diagnostics.count() > diagnostics.entries().size()) {
    report += std::format("\n{} errors generated, showing the first {}.",
                          diagnostics.count(), diagnostics.entries().size());
  } else if (diagnostics.count() > 1) {
    report += std::format("\n{} errors generated.", diagnostics.count());
  }

  return report;
}

// Stops the compile if the phase that just ran found anything, so that the
// next phase never runs on a tree that is known to be wrong.
void Compiler::stopIfErrors(const Diagnostics &diagnostics) const {
  if (!diagnostics.empty()) {
    throw std::runtime_error(formatDiagnostics(diagnostics));
  }
}

void Compiler::compile() {
  std::unique_ptr<Reader> reader = std::make_unique<Reader>(options.inputPath);
  std::string fileText = reader->readAll();

  std::unique_ptr<Lexer> lexer = std::make_unique<Lexer>(fileText);
  std::vector<Token> tokens = lexer->tokenize();

  if (options.dumpTokens) {
    std::string dump;
    for (const Token &token : tokens) {
      dump += std::format("{}:{} {}", token.line, token.column,
                          tokenKindName(token.type));
      if (tokenCarriesText(token.type)) {
        dump += std::format(" '{}'", token.value);
      }
      dump += '\n';
    }
    std::cout << dump;
    return;
  }

  Diagnostics diagnostics;

  std::unique_ptr<Parser> parser =
      std::make_unique<Parser>(tokens, diagnostics);
  AST::NodePtr root = parser->parse();

  // A tree with a hole in it says nothing trustworthy about types, so the
  // syntax errors are reported on their own rather than alongside whatever
  // the analyzer would invent from the wreckage.
  stopIfErrors(diagnostics);

  auto printer = std::make_unique<ASTPrinter>();
  // printer->visit(static_cast<const AST::ProgramNode&>(*root));

  auto analyzer = std::make_unique<SemanticAnalyzer>(diagnostics);
  analyzer->analyze(*root);
  stopIfErrors(diagnostics);

  std::unique_ptr<IRGenerator> irgen = std::make_unique<IRGenerator>(
      "myProgram", analyzer->resolvedTypes(), analyzer->structs());

  irgen->generate(*root);

  std::filesystem::path executablePath =
      options.outputPath.empty() ? std::filesystem::path(reader->getFileName())
                                 : options.outputPath;
  // The intermediates hang off the executable rather than the input so that
  // -o keeps a whole build in one directory.
  auto irPath = std::format("{}.ll", executablePath.string());
  auto objectPath = std::format("{}.o", executablePath.string());

  irgen->emitToFile(irPath);
  irgen->emitObjectFile(objectPath);

  auto linker = std::make_unique<Linker>(objectPath);
  linker->link(executablePath);

  if (!options.keepIntermediates) {
    std::filesystem::remove(irPath);
    std::filesystem::remove(objectPath);
  }
}
