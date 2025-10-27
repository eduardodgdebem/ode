# Grammar (EBNF Notation)

## Program Structure

- **Program** → Statement*
- **Statement** → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ReturnStmt | PrintStmt | ExprStmt | Block

---

## Declarations & Statements

- **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- **Assign** → IDENT `=` Expr `;`
- **IfStmt** → `if` `(` Expr `)` Block (`else` Block)?
- **WhileStmt** → `while` `(` Expr `)` Block
- **FuncDecl** → `fn` IDENT `(` ParamList? `)` `:` Type Block
- **ReturnStmt** → `return` Expr `;`
- **PrintStmt** → `print` `(` Expr `)` `;`
- **ExprStmt** → Expr `;`
- **Block** → `{` Statement* `}`

---

## Functions

- **ParamList** → Param (`,` Param)*
- **Param** → IDENT `:` Type
- **FuncCall** → IDENT `(` ArgList? `)`
- **ArgList** → Expr (`,` Expr)*

---

## Expressions (by precedence, lowest to highest)

- **Expr** → LogicOr
- **LogicOr** → LogicAnd (`||` LogicAnd)*
- **LogicAnd** → Equality (`&&` Equality)*
- **Equality** → Comparison ((`==` | `!=`) Comparison)*
- **Comparison** → Term ((`<` | `<=` | `>` | `>=`) Term)*
- **Term** → Factor ((`+` | `-`) Factor)*
- **Factor** → Unary ((`*` | `/`) Unary)*
- **Unary** → (`-` | `!`) Unary | Primary
- **Primary** → NUMBER | BOOLEAN | IDENT | FuncCall | `(` Expr `)`

---

## Types

- **Type** → `i32` | `f32` | `bool` | `void`

---

## Lexical Elements

- **IDENT** → [a-zA-Z_][a-zA-Z0-9_]*
- **NUMBER** → [0-9]+
- **BOOLEAN** → `true` | `false`

---

## Operator Precedence (highest to lowest)

1. Primary (literals, identifiers, parentheses, function calls)
2. Unary (`-`, `!`)
3. Factor (`*`, `/`)
4. Term (`+`, `-`)
5. Comparison (`<`, `<=`, `>`, `>=`)
6. Equality (`==`, `!=`)
7. LogicAnd (`&&`)
8. LogicOr (`||`)

---

## Notes

- Left-associative: All binary operators
- Right-associative: Unary operators (allows `--5`, `!-x`)
- Short-circuit evaluation: `&&` and `||` should short-circuit
