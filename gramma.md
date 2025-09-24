# Grammar (Todo List)

- [X] **Program** → Statement*
- [X] **Statement** → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ReturnStmt | ExprStmt
- [X] **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- [X] **Assign** → IDENT `=` Expr `;`
- [X] **IfStmt** → `if` `(` Expr `)` Block (`else` Block)?
- [X] **WhileStmt** → `while` `(` Expr `)` Block
- [X] **FuncDecl** → `fn` IDENT `(` ParamList? `)` `:` Type Block
- [X] **ParamList** → Param (`,` Param)*
- [X] **Param** → IDENT `:` Type
- [X] **FuncCall** → IDENT `(` ArgList? `)`
- [X] **ArgList** → Expr (`,` Expr)*
- [X] **ReturnStmt** → `return` Expr `;`
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
- [X] **Type** → i32 | i64 | bool
