# Grammar (EBNF Notation)

## Program Structure

- **Program** → Statement*
- **Statement** → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ExternDecl | ReturnStmt | PrintStmt | ExprStmt | Block

---

## Declarations & Statements

- **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- **Assign** → LValue `=` Expr `;`
- **IfStmt** → `if` `(` Expr `)` Block (`else` Block)?
- **WhileStmt** → `while` `(` Expr `)` Block
- **FuncDecl** → `fn` IDENT `(` ParamList? `)` `:` Type Block
- **ExternDecl** → `extern` `fn` IDENT `(` ParamList? `)` `:` Type `;`
- **ReturnStmt** → `return` Expr `;`
- **PrintStmt** → `print` `(` Expr `)` `;`
- **ExprStmt** → Expr `;`
- **Block** → `{` Statement* `}`
- **LValue** → IDENT | `*` Unary

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
- **Factor** → Cast ((`*` | `/`) Cast)*
- **Cast** → Unary (`as` Type)*
- **Unary** → (`-` | `!` | `*` | `&`) Unary | Primary
- **Primary** → NUMBER | BOOLEAN | IDENT | FuncCall | `(` Expr `)`

---

## Types

- **Type** → `*`* BaseType
- **BaseType** → `i8` | `u8` | `i32` | `i64` | `u64` | `usize` | `f32` | `bool` | `void`

`usize` is a spelling of `u64`. A leading `*` makes a pointer, and pointers
nest: `*i8` is a pointer to `i8`, `**i8` a pointer to that.

---

## Lexical Elements

- **IDENT** → [a-zA-Z_][a-zA-Z0-9_]*
- **NUMBER** → [0-9]+
- **BOOLEAN** → `true` | `false`

---

## Operator Precedence (highest to lowest)

1. Primary (literals, identifiers, parentheses, function calls)
2. Unary (`-`, `!`, `*` dereference, `&` address-of)
3. Cast (`as`)
4. Factor (`*`, `/`)
5. Term (`+`, `-`)
6. Comparison (`<`, `<=`, `>`, `>=`)
7. Equality (`==`, `!=`)
8. LogicAnd (`&&`)
9. LogicOr (`||`)

`as` binds looser than unary, so `*p as i32` means `(*p) as i32`.

---

## Notes

- Left-associative: All binary operators
- Right-associative: Unary operators (allows `--5`, `!-x`)
- Short-circuit evaluation: `&&` and `||` should short-circuit
- Functions may be called before they are declared; the compiler collects
  every signature before checking any body, so mutual recursion works.
- There are no implicit conversions. Integer literals are `i32`, so any other
  width needs an explicit `as` (`let n: i64 = 0 as i64;`).
- Pointer arithmetic: `p + i`, `i + p` and `p - i` step by elements, and
  `p - q` yields the `i64` number of elements between two pointers of the
  same type. `*void` supports neither arithmetic nor dereference; cast it to
  a concrete pointer type first.
