# Grammar (Todo List)

- [X] **Program** → Statement*
- [X] **Statement** → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ReturnStmt | ExprStmt
- [X] **VarDecl** → `let` IDENT `=` Expr `;`
- [X] **Assign** → IDENT `=` Expr `;`
- [X] **IfStmt** → `if` `(` Expr `)` Block (`else` Block)?
- [X] **WhileStmt** → `while` `(` Expr `)` Block
- [ ] **FuncDecl** → `fn` IDENT `(` ParamList? `)` Block
- [X] **ParamList** → Primary (`,` Primary)*
- [ ] **ReturnStmt** → `return` Expr `;`
- [X] **ExprStmt** → Expr `;`

---

- [X] **Block** → `{` Statement* `}`

---

- [X] **Expr** → LogicOr
- [X] **LogicOr** → LogicAnd (`||` LogicAnd)*
- [X] **LogicAnd** → Equality (`&&` Equality)*
- [X] **Equality** → Comparison ((`==` | `!=`) Comparison)*
- [X] **Comparison** → Term ((`<` | `<=` | `>` | `>=`) Term)*
- [X] **Term** → Factor ((`+` | `-`) Factor)*
- [X] **Factor** → Primary ((`*` | `/`) Primary)*
- [X] **Primary** → NUMBER | IDENT | BOOLEAN | `(` Expr `)`
