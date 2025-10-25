# Grammar (Todo List)

- **Program** → Statement*
- **Statement** → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ReturnStmt | ExprStmt
- **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- **Assign** → IDENT `=` Expr `;`
- **IfStmt** → `if` `(` Expr `)` Block (`else` Block)?
- **WhileStmt** → `while` `(` Expr `)` Block
- **FuncDecl** → `fn` IDENT `(` ParamList? `)` `:` Type Block
- **ParamList** → Param (`,` Param)*
- **Param** → IDENT `:` Type
- **FuncCall** → IDENT `(` ArgList? `)`
- **ArgList** → Expr (`,` Expr)*
- **ReturnStmt** → `return` Expr `;`
- **ExprStmt** → Expr `;`

---

- **Block** → `{` Statement* `}`

---

- **Expr** → LogicOr
- **LogicOr** → LogicAnd (`||` LogicAnd)*
- **LogicAnd** → Equality (`&&` Equality)*
- **Equality** → Comparison ((`==` | `!=`) Comparison)*
- **Comparison** → Term ((`<` | `<=` | `>` | `>=`) Term)*
- **Term** → Factor ((`+` | `-`) Factor)*
- **Factor** → Primary ((`*` | `/`) Primary)*
- **Primary** → NUMBER | IDENT | BOOLEAN | `(` Expr `)`
- **Type** → i32 | bool
