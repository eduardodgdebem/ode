# Grammar (EBNF Notation)

## Program Structure

- **Program** → TopLevel*
- **TopLevel** → FuncDecl | ExternDecl | StructDecl | Statement
- **Statement** → VarDecl | Assign | IfStmt | WhileStmt | BreakStmt | ContinueStmt | ReturnStmt | PrintStmt | ExprStmt | Block

A **VarDecl** written directly at program level declares a global.

`fn`, `extern` and `struct` are top-level only. Writing one inside a block is
an error; there are no nested functions or block-local types.

---

## Declarations & Statements

- **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- **Assign** → LValue `=` Expr `;`
- **IfStmt** → `if` `(` Expr `)` Block (`else` (Block | IfStmt))?
- **WhileStmt** → `while` `(` Expr `)` Block
- **BreakStmt** → `break` `;`
- **ContinueStmt** → `continue` `;`
- **FuncDecl** → `fn` IDENT `(` ParamList? `)` `:` Type Block
- **ExternDecl** → `extern` `fn` IDENT `(` ParamList? `)` `:` Type `;`
- **StructDecl** → `struct` IDENT `{` FieldDecl* `}`
- **FieldDecl** → IDENT `:` Type `,`?
- **ReturnStmt** → `return` Expr? `;`
- **PrintStmt** → `print` `(` Expr `)` `;`
- **ExprStmt** → Expr `;`
- **Block** → `{` Statement* `}`
- **LValue** → IDENT | `*` Unary | Postfix `.` IDENT | Postfix `[` Expr `]`

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
- **Unary** → (`-` | `!` | `*` | `&`) Unary | Postfix
- **Postfix** → Primary (`.` IDENT | `[` Expr `]`)*
- **Primary** → NUMBER | STRING | CHAR | BOOLEAN | IDENT | FuncCall | StructLiteral | SizeOf | `(` Expr `)`
- **StructLiteral** → IDENT `{` FieldInit* `}`
- **FieldInit** → IDENT `:` Expr `,`?
- **SizeOf** → `sizeof` `(` Type `)`

---

## Types

- **Type** → `*`* (BaseType | IDENT)
- **BaseType** → IntType | FloatType | `bool` | `void`
- **IntType** → `i8` | `u8` | `i16` | `u16` | `i32` | `u32` | `i64` | `u64` | `usize`
- **FloatType** → `f32` | `f64`

`usize` is a spelling of `u64`. A leading `*` makes a pointer, and pointers
nest: `*i8` is a pointer to `i8`, `**i8` a pointer to that. An IDENT in type
position names a struct.

---

## Lexical Elements

- **IDENT** → [a-zA-Z_][a-zA-Z0-9_]*
- **NUMBER** → [0-9]+
- **BOOLEAN** → `true` | `false`
- **STRING** → `"` Char* `"`
- **CHAR** → `'` Char `'`
- **Char** → any character except the closing quote or a newline, or an Escape
- **Escape** → `\n` | `\t` | `\r` | `\0` | `\\` | `\"` | `\'`
- **Comment** → `//` to the end of the line

A STRING has type `*i8` and points at a NUL-terminated constant. A CHAR has
type `i8`. Comments are recognised by the lexer, so a `//` inside a string
literal is text.

A NUMBER is `i32`, or `f32` when it contains a `.`. The one exception is a
literal written directly as the operand of a cast: it takes the cast's target
type when `i32` (or `f32`) cannot hold it, which is what makes
`3000000000 as i64` and `18446744073709551615 as u64` expressible. A value
that does fit stays `i32`, so `300 as i8` still means "truncate an in-range
`i32`" and yields 44.

---

## Operator Precedence (highest to lowest)

1. Primary (literals, identifiers, parentheses, function calls, struct literals, `sizeof`)
2. Postfix (`.` field access, `[]` indexing)
3. Unary (`-`, `!`, `*` dereference, `&` address-of)
4. Cast (`as`)
5. Factor (`*`, `/`)
6. Term (`+`, `-`)
7. Comparison (`<`, `<=`, `>`, `>=`)
8. Equality (`==`, `!=`)
9. LogicAnd (`&&`)
10. LogicOr (`||`)

`as` binds looser than unary, so `*p as i32` means `(*p) as i32`. Postfix binds
tighter than unary, so `*p.next` means `*(p.next)`.

---

## Notes

- Left-associative: All binary operators
- Right-associative: Unary operators (allows `--5`, `!-x`)
- Short-circuit evaluation: `a && b` evaluates `b` only when `a` is true, and
  `a || b` only when `a` is false
- Functions may be called before they are declared; the compiler collects
  every signature before checking any body, so mutual recursion works.
- There are no implicit conversions. Integer literals are `i32`, so any other
  width needs an explicit `as` (`let n: i64 = 0 as i64;`). A literal too wide
  for `i32` takes the type it is cast to instead of being rejected.
- Pointer arithmetic: `p + i`, `i + p` and `p - i` step by elements, and
  `p - q` yields the `i64` number of elements between two pointers of the
  same type. `*void` supports neither arithmetic nor dereference; cast it to
  a concrete pointer type first.
- `a[i]` is `*(a + i)`, so indexing works on any pointer and is assignable.
- Struct declarations may appear in any order and may refer to each other. A
  struct that contains itself *by value* is rejected; go through a pointer.
- `.` follows one level of pointer automatically, so `node.next` works whether
  `node` is a `Node` or a `*Node`.
- A struct literal must initialise every field exactly once, in any order.
- `sizeof(T)` is a `usize` and is what sizes an allocation for a struct.
- Globals may only be initialised from constants — literals, `sizeof`, and
  casts or negations of those. Every global is visible to every function
  regardless of declaration order.
- Structs may be passed and returned by value between Ode functions, but not
  across `extern`, where the C ABI would need target-specific lowering.
- `*i8` is Ode's string type: `print` renders it as text, while every other
  pointer prints as an address.
- `else if` chains without nesting: the `if` after an `else` becomes the else
  branch directly, so no wrapping block is needed.
- `break` and `continue` act on the innermost enclosing `while`, and are
  rejected outside a loop. A function written inside a loop does not see it.
- `return;` is only valid in a `void` function, and `return expr;` only in a
  non-void one, where the expression's type must match the declared return
  type. Falling off the end of a non-void function is still permitted and
  yields a zero value; there is no all-paths-return analysis.
