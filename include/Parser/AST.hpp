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

  class AssignNode : public Node {
  public:
    AssignNode(Token name, NodePtr expr)
        : name_(std::move(name)), expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

    const Token &name() const { return name_; }
    const Node *expr() const { return expr_.get(); }

  private:
    Token name_;
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
    explicit ReturnStmtNode(NodePtr expr) : expr_(std::move(expr)) {}

    void accept(Visitor &visitor) const override;

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

  class NumberNode : public Node {
  public:
    explicit NumberNode(Token value) : value_(std::move(value)) {}

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
    explicit TypeNode(Token type) : type_(std::move(type)) {}

    void accept(Visitor &visitor) const override;

    const Token &type() const { return type_; }

  private:
    Token type_;
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
    virtual void visit(const FuncDeclNode &node) = 0;
    virtual void visit(const FuncCallNode &node) = 0;
    virtual void visit(const ReturnStmtNode &node) = 0;
    virtual void visit(const PrintStmtNode &node) = 0;
    virtual void visit(const ExprStmtNode &node) = 0;
    virtual void visit(const BinaryOpNode &node) = 0;
    virtual void visit(const NumberNode &node) = 0;
    virtual void visit(const BooleanNode &node) = 0;
    virtual void visit(const IdentifierNode &node) = 0;
    virtual void visit(const TypeNode &node) = 0;
    virtual void visit(const ParamListNode &node) = 0;
    virtual void visit(const ArgListNode &node) = 0;
  };
};
