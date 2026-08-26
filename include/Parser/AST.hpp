#pragma once
#include <memory>
#include <vector>

#include "Lexer/Token.hpp"

class AST {
public:
  class Visitor;

  class Node {
  public:
    virtual ~Node() = default;
    virtual void accept(Visitor &visitor) const = 0;

    // Where this construct starts in the source, so that a diagnostic raised
    // long after parsing can still point at it. Zero means unknown.
    int line() const { return line_; }
    int column() const { return column_; }
    void setLocation(int line, int column) {
      line_ = line;
      column_ = column;
    }

  private:
    int line_ = 0;
    int column_ = 0;
  };

  using NodePtr = std::unique_ptr<Node>;

  class ProgramNode : public Node {
  public:
    void accept(Visitor &visitor) const override;

    void addStatement(NodePtr stmt) { statements_.push_back(std::move(stmt)); }
    const std::vector<NodePtr> &statements() const { return statements_; }

  private:
    std::vector<NodePtr> statements_;
  };

  class BlockNode : public Node {
  public:
    void accept(Visitor &visitor) const override;

    void addStatement(NodePtr stmt) { statements_.push_back(std::move(stmt)); }
    const std::vector<NodePtr> &statements() const { return statements_; }

  private:
    std::vector<NodePtr> statements_;
  };

  class VarDeclNode : public Node {
  public:
    VarDeclNode(Token name, NodePtr type, NodePtr expr)
        : name_(std::move(name)), type_(std::move(type)),
          expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }
    const Node *type() const { return type_.get(); }
    const Node *expr() const { return expr_.get(); }

  private:
    Token name_;
    NodePtr type_;
    NodePtr expr_;
  };

  // `target` is an lvalue expression: an identifier or a pointer
  // dereference (`*p = v;`).
  class AssignNode : public Node {
  public:
    AssignNode(NodePtr target, NodePtr expr)
        : target_(std::move(target)), expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    const Node *target() const { return target_.get(); }
    const Node *expr() const { return expr_.get(); }

  private:
    NodePtr target_;
    NodePtr expr_;
  };

  class IfStmtNode : public Node {
  public:
    IfStmtNode(NodePtr condition, NodePtr thenBlock,
               NodePtr elseBlock = nullptr)
        : condition_(std::move(condition)), thenBlock_(std::move(thenBlock)),
          elseBlock_(std::move(elseBlock)) {}

    void accept(Visitor &visitor) const override;

    const Node *condition() const { return condition_.get(); }
    const Node *thenBlock() const { return thenBlock_.get(); }
    const Node *elseBlock() const { return elseBlock_.get(); }
    bool hasElse() const { return elseBlock_ != nullptr; }

  private:
    NodePtr condition_;
    NodePtr thenBlock_;
    NodePtr elseBlock_;
  };

  class WhileStmtNode : public Node {
  public:
    WhileStmtNode(NodePtr condition, NodePtr body)
        : condition_(std::move(condition)), body_(std::move(body)) {}

    void accept(Visitor &visitor) const override;

    const Node *condition() const { return condition_.get(); }
    const Node *body() const { return body_.get(); }

  private:
    NodePtr condition_;
    NodePtr body_;
  };

  // `break;` -- leaves the innermost enclosing loop.
  class BreakStmtNode : public Node {
  public:
    void accept(Visitor &visitor) const override;
  };

  // `continue;` -- jumps to the innermost enclosing loop's condition.
  class ContinueStmtNode : public Node {
  public:
    void accept(Visitor &visitor) const override;
  };

  class FuncDeclNode : public Node {
  public:
    FuncDeclNode(Token name, NodePtr returnType, NodePtr params, NodePtr body)
        : name_(std::move(name)), returnType_(std::move(returnType)),
          params_(std::move(params)), body_(std::move(body)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }
    const Node *returnType() const { return returnType_.get(); }
    const Node *params() const { return params_.get(); }
    const Node *body() const { return body_.get(); }

  private:
    Token name_;
    NodePtr returnType_;
    NodePtr params_;
    NodePtr body_;
  };

  // `struct Token { kind: i32, length: i64, }`
  class StructDeclNode : public Node {
  public:
    struct FieldDecl {
      Token name;
      NodePtr type;
    };

    explicit StructDeclNode(Token name) : name_(std::move(name)) {}

    void accept(Visitor &visitor) const override;

    void addField(Token name, NodePtr type) {
      fields_.push_back({std::move(name), std::move(type)});
    }

    const Token &name() const { return name_; }
    const std::vector<FieldDecl> &fields() const { return fields_; }

  private:
    Token name_;
    std::vector<FieldDecl> fields_;
  };

  // A body-less declaration of a function provided by the C runtime or
  // another object file: `extern fn malloc(size: i64): *i8;`
  class ExternFuncDeclNode : public Node {
  public:
    ExternFuncDeclNode(Token name, NodePtr returnType, NodePtr params)
        : name_(std::move(name)), returnType_(std::move(returnType)),
          params_(std::move(params)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }
    const Node *returnType() const { return returnType_.get(); }
    const Node *params() const { return params_.get(); }

  private:
    Token name_;
    NodePtr returnType_;
    NodePtr params_;
  };

  class FuncCallNode : public Node {
  public:
    FuncCallNode(Token name, NodePtr args)
        : name_(std::move(name)), args_(std::move(args)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }
    const Node *args() const { return args_.get(); }

  private:
    Token name_;
    NodePtr args_;
  };

  class ReturnStmtNode : public Node {
  public:
    explicit ReturnStmtNode(NodePtr expr = nullptr) : expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    // Null for a bare `return;`, which is only valid in a void function.
    const Node *expr() const { return expr_.get(); }

  private:
    NodePtr expr_;
  };

  class PrintStmtNode : public Node {
  public:
    explicit PrintStmtNode(NodePtr expr) : expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    const Node *expr() const { return expr_.get(); }

  private:
    NodePtr expr_;
  };

  class ExprStmtNode : public Node {
  public:
    explicit ExprStmtNode(NodePtr expr) : expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    const Node *expr() const { return expr_.get(); }

  private:
    NodePtr expr_;
  };

  class UnaryOpNode : public Node {
  public:
    UnaryOpNode(Token op, NodePtr operand)
        : op_(std::move(op)), operand_(std::move(operand)) {}

    void accept(Visitor &visitor) const override;

    const Token &op() const { return op_; }
    const Node *operand() const { return operand_.get(); }

  private:
    Token op_;
    NodePtr operand_;
  };

  class BinaryOpNode : public Node {
  public:
    BinaryOpNode(Token op, NodePtr left, NodePtr right)
        : op_(std::move(op)), left_(std::move(left)), right_(std::move(right)) {
    }

    void accept(Visitor &visitor) const override;

    const Token &op() const { return op_; }
    const Node *left() const { return left_.get(); }
    const Node *right() const { return right_.get(); }

  private:
    Token op_;
    NodePtr left_;
    NodePtr right_;
  };

  // `object.field`. `object` may be a struct or a pointer to one, in which
  // case it is dereferenced automatically.
  class FieldAccessNode : public Node {
  public:
    FieldAccessNode(NodePtr object, Token field)
        : object_(std::move(object)), field_(std::move(field)) {}

    void accept(Visitor &visitor) const override;

    const Node *object() const { return object_.get(); }
    const Token &field() const { return field_; }

  private:
    NodePtr object_;
    Token field_;
  };

  // `base[index]`, which is `*(base + index)` for any pointer.
  class IndexNode : public Node {
  public:
    IndexNode(NodePtr base, NodePtr index)
        : base_(std::move(base)), index_(std::move(index)) {}

    void accept(Visitor &visitor) const override;

    const Node *base() const { return base_.get(); }
    const Node *index() const { return index_.get(); }

  private:
    NodePtr base_;
    NodePtr index_;
  };

  // `Token { kind: 1, length: 0 }`
  class StructLiteralNode : public Node {
  public:
    struct FieldInit {
      Token name;
      NodePtr value;
    };

    explicit StructLiteralNode(Token typeName)
        : typeName_(std::move(typeName)) {}

    void accept(Visitor &visitor) const override;

    void addField(Token name, NodePtr value) {
      fields_.push_back({std::move(name), std::move(value)});
    }

    const Token &typeName() const { return typeName_; }
    const std::vector<FieldInit> &fields() const { return fields_; }

  private:
    Token typeName_;
    std::vector<FieldInit> fields_;
  };

  // `sizeof(T)`, in bytes, as a usize.
  class SizeOfNode : public Node {
  public:
    explicit SizeOfNode(NodePtr type) : type_(std::move(type)) {}

    void accept(Visitor &visitor) const override;

    const Node *type() const { return type_.get(); }

  private:
    NodePtr type_;
  };

  // `expr as T`
  class CastNode : public Node {
  public:
    CastNode(NodePtr expr, NodePtr type)
        : expr_(std::move(expr)), type_(std::move(type)) {}

    void accept(Visitor &visitor) const override;

    const Node *expr() const { return expr_.get(); }
    const Node *type() const { return type_.get(); }

  private:
    NodePtr expr_;
    NodePtr type_;
  };

  class NumberNode : public Node {
  public:
    explicit NumberNode(Token value) : value_(std::move(value)) {}

    void accept(Visitor &visitor) const override;

    const Token &value() const { return value_; }

  private:
    Token value_;
  };

  // A NUL-terminated byte string. Its type is `*i8`, pointing at a private
  // constant in the module.
  class StringLiteralNode : public Node {
  public:
    explicit StringLiteralNode(Token value) : value_(std::move(value)) {}

    void accept(Visitor &visitor) const override;

    // Already decoded: escapes were resolved by the lexer.
    const Token &value() const { return value_; }

  private:
    Token value_;
  };

  // A single byte, typed `i8`.
  class CharLiteralNode : public Node {
  public:
    explicit CharLiteralNode(Token value) : value_(std::move(value)) {}

    void accept(Visitor &visitor) const override;

    const Token &value() const { return value_; }

  private:
    Token value_;
  };

  class BooleanNode : public Node {
  public:
    explicit BooleanNode(Token value) : value_(std::move(value)) {}

    void accept(Visitor &visitor) const override;

    const Token &value() const { return value_; }

  private:
    Token value_;
  };

  class IdentifierNode : public Node {
  public:
    explicit IdentifierNode(Token name) : name_(std::move(name)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }

  private:
    Token name_;
  };

  class TypeNode : public Node {
  public:
    explicit TypeNode(Token type, int pointerDepth = 0)
        : type_(std::move(type)), pointerDepth_(pointerDepth) {}

    void accept(Visitor &visitor) const override;

    const Token &type() const { return type_; }
    int pointerDepth() const { return pointerDepth_; }

  private:
    Token type_;
    int pointerDepth_;
  };

  class ParamListNode : public Node {
  public:
    struct Parameter {
      Token name;
      NodePtr type;
    };

    void accept(Visitor &visitor) const override;

    void addParam(Token name, NodePtr type) {
      params_.push_back({std::move(name), std::move(type)});
    }

    const std::vector<Parameter> &params() const { return params_; }

  private:
    std::vector<Parameter> params_;
  };

  class ArgListNode : public Node {
  public:
    void accept(Visitor &visitor) const override;

    void addArg(NodePtr arg) { args_.push_back(std::move(arg)); }
    const std::vector<NodePtr> &args() const { return args_; }

  private:
    std::vector<NodePtr> args_;
  };

  class Visitor {
  public:
    virtual ~Visitor() = default;

    virtual void visit(const ProgramNode &node) = 0;
    virtual void visit(const BlockNode &node) = 0;
    virtual void visit(const VarDeclNode &node) = 0;
    virtual void visit(const AssignNode &node) = 0;
    virtual void visit(const IfStmtNode &node) = 0;
    virtual void visit(const WhileStmtNode &node) = 0;
    virtual void visit(const BreakStmtNode &node) = 0;
    virtual void visit(const ContinueStmtNode &node) = 0;
    virtual void visit(const FuncDeclNode &node) = 0;
    virtual void visit(const ExternFuncDeclNode &node) = 0;
    virtual void visit(const StructDeclNode &node) = 0;
    virtual void visit(const FuncCallNode &node) = 0;
    virtual void visit(const ReturnStmtNode &node) = 0;
    virtual void visit(const PrintStmtNode &node) = 0;
    virtual void visit(const ExprStmtNode &node) = 0;
    virtual void visit(const BinaryOpNode &node) = 0;
    virtual void visit(const UnaryOpNode &node) = 0;
    virtual void visit(const CastNode &node) = 0;
    virtual void visit(const FieldAccessNode &node) = 0;
    virtual void visit(const IndexNode &node) = 0;
    virtual void visit(const StructLiteralNode &node) = 0;
    virtual void visit(const SizeOfNode &node) = 0;
    virtual void visit(const NumberNode &node) = 0;
    virtual void visit(const StringLiteralNode &node) = 0;
    virtual void visit(const CharLiteralNode &node) = 0;
    virtual void visit(const BooleanNode &node) = 0;
    virtual void visit(const IdentifierNode &node) = 0;
    virtual void visit(const TypeNode &node) = 0;
    virtual void visit(const ParamListNode &node) = 0;
    virtual void visit(const ArgListNode &node) = 0;
  };
};
