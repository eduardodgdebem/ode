#include "Parser/AST.hpp"

void AST::ProgramNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::BlockNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::VarDeclNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::AssignNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::IfStmtNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::WhileStmtNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::FuncDeclNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::FuncCallNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::ReturnStmtNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::PrintStmtNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::ExprStmtNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::BinaryOpNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::NumberNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::BooleanNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::IdentifierNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::TypeNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::ParamListNode::accept(AST::Visitor &v) const { v.visit(*this); }
void AST::ArgListNode::accept(AST::Visitor &v) const { v.visit(*this); }
