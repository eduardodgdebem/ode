#include "ASTNode.hpp"
#include <utility>

ASTNode::ASTNode(ASTType t, Token tok) : type(t), token(std::move(tok)) {}

ASTNode::~ASTNode() = default;

void ASTNode::addChild(std::unique_ptr<ASTNode> child) {
  if (child) {
    children.push_back(std::move(child));
  }
}
