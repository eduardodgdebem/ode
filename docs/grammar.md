# Grammar (EBNF Notation)

## Program Structure

- **Program** → TopLevel*
- **TopLevel** → ImportDecl | ExportDecl | FuncDecl | ExternDecl | StructDecl | EnumDecl | ErrorEnumDecl | TestDecl | Statement
- **Statement** → VarDecl | Assign | IfStmt | WhileStmt | ForStmt | MatchStmt | BreakStmt | ContinueStmt | ReturnStmt | ExprStmt | Block

A **VarDecl** written directly at program level declares a global.

`fn`, `extern`, `struct`, `import` and `export` are top-level only. Writing
one inside a block is an error; there are no nested functions or block-local
types.

---

## Modules

- **ImportDecl** → `import` `{` (ImportName (`,` ImportName)* `,`?)? `}` `from` STRING `;`
- **ImportName** → IDENT (`as` IDENT)?
- **ExportDecl** → `export` (FuncDecl | ExternDecl | StructDecl | EnumDecl | VarDecl)

Every file is a module. Its top-level names are private to it unless they are
declared with `export`, and another file sees them only by importing them by
name. `as` renames an import within the importing file.

The STRING is a path. One that does not start with `/` is taken from the
importing file's directory, not from where the compiler was run, and `.ode` is
appended when it is left off: `"./lib"` and `"./lib.ode"` name the same file.
Each file is loaded once however many files import it, so imports may form
cycles.

`from` is not a keyword; it is recognised only in this position. `import` and
`export` are.

---

## Declarations & Statements

- **VarDecl** → `let` IDENT `:` Type `=` Expr `;`
- **Assign** → LValue (`=` | `+=` | `-=` | `*=` | `/=` | `%=`) Expr `;`
- **IfStmt** → `if` `(` Expr `)` Block (`else` (Block | IfStmt))?
- **WhileStmt** → `while` `(` Expr `)` Block
- **ForStmt** → `for` `(` IDENT `in` Expr `..` Expr `)` Block
- **BreakStmt** → `break` `;`
- **ContinueStmt** → `continue` `;`
- **FuncDecl** → `fn` IDENT TypeParams? `(` ParamList? `)` `:` Type Block
- **TypeParams** → `<` IDENT (`,` IDENT)* `>`
- **TypeArgs** → `<` Type (`,` Type)* `>`
- **ExternDecl** → `extern` `fn` IDENT `(` ParamList? `)` `:` Type `;`
- **ErrorEnumDecl** → `error` EnumDecl, whose members have no written values — `error` is an IDENT anywhere `enum` does not follow it
- **DeclaredType** → Type (`|` Type)* — the type of a variable, parameter, field or return; a union is a value type, then error enums
- **TestDecl** → `test` STRING Block — `test` is an IDENT anywhere a STRING does not follow it
- **StructDecl** → `struct` IDENT TypeParams? `{` (FieldDecl | FuncDecl)* `}`
- **FieldDecl** → IDENT `:` Type `,`?
- **EnumDecl** → `enum` IDENT `{` (EnumMember (`,` EnumMember)* `,`?)? `}`
- **EnumMember** → IDENT (`=` `-`? NUMBER)?
- **MatchStmt** → `match` `(` Expr `)` `{` MatchArm* `}`
- **MatchArm** → (Pattern (`,` Pattern)* | `else`) `=>` Block
- **Pattern** → IDENT `.` IDENT | `-`? NUMBER | CHAR
- **TryExpr** → `try` Unary
- **CatchExpr** → Coalesce `catch` `(` IDENT `)` Block — the lowest precedence; the block must leave
- **Coalesce** → LogicOr (`??` LogicOr)* — below `||`
- **IsExpr** → Shift `is` Type — at comparison level; `is` is an IDENT elsewhere
- **ReturnStmt** → `return` Expr? `;`
- **ExprStmt** → Expr `;`
- **Block** → `{` Statement* `}`
- **LValue** → IDENT | `*` Unary | Postfix `.` IDENT | Postfix `[` Expr `]`

---

## Functions

- **ParamList** → Param (`,` Param)* (`,` `...`)? | `...`
- **Param** → IDENT `:` Type
- **FuncCall** → IDENT TypeArgs? `(` ArgList? `)`
- **ArgList** → Expr (`,` Expr)*

---

## Expressions (by precedence, lowest to highest)

- **Expr** → LogicOr
- **LogicOr** → LogicAnd (`||` LogicAnd)*
- **LogicAnd** → BitOr (`&&` BitOr)*
- **BitOr** → BitXor (`|` BitXor)*
- **BitXor** → BitAnd (`^` BitAnd)*
- **BitAnd** → Equality (`&` Equality)*
- **Equality** → Comparison ((`==` | `!=`) Comparison)*
- **Comparison** → Shift ((`<` | `<=` | `>` | `>=`) Shift)*
- **Shift** → Term ((`<<` | `>>`) Term)*
- **Term** → Factor ((`+` | `-`) Factor)*
- **Factor** → Cast ((`*` | `/` | `%`) Cast)*
- **Cast** → Unary (`as` Type)*
- **Unary** → (`-` | `+` | `!` | `*` | `&`) Unary | Postfix
- **Postfix** → Primary (`.` IDENT | `.` IDENT `(` ArgList? `)` | `[` Expr `]` | `(` ArgList? `)`)*
- **Primary** → NUMBER | STRING | CHAR | BOOLEAN | `null` | IDENT | FuncCall | StructLiteral | SizeOf | `(` Expr `)`
- **StructLiteral** → IDENT TypeArgs? `{` FieldInit* `}`
- **FieldInit** → IDENT `:` Expr `,`?
- **SizeOf** → `sizeof` `(` Type `)`

---

## Types

- **Type** → `*`* (BaseType | IDENT TypeArgs? | FnType)
- **FnType** → `fn` `(` (Type (`,` Type)*)? `)` `:` Type
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
- **STRING** → `"` Char* `"` | RawString
- **CHAR** → `'` Char `'`
- **Char** → any character except the closing quote or a newline, or an Escape
- **Escape** → `\n` | `\t` | `\r` | `\0` | `\\` | `\"` | `\'` | `\x` HexDigit HexDigit
- **RawString** → `` ` `` any characters but `` ` `` `` ` ``, which may span lines and holds no escapes; `${` in one is an error. One whose opening backtick ends its line is a block: the indentation its lines share, and a last line of only whitespace, are dropped
- **Operator** → `...` if it matches, otherwise a two-character operator if
  one matches, otherwise a single-character one
- **TwoCharOp** → `==` | `!=` | `<=` | `>=` | `&&` | `||` | `<<` | `>>` |
  `+=` | `-=` | `*=` | `/=` | `%=` | `=>` | `..`
- **OneCharOp** → `+` | `-` | `*` | `/` | `%` | `&` | `|` | `^` | `!` | `<` |
  `>` | `=` | `.`
- **Comment** → `//` to the end of the line

A STRING has type `*i8` and points at a NUL-terminated constant. A CHAR is
the byte's value, typed like a NUMBER below, and `i8` by default. Comments are recognised by the lexer, so a `//` inside a string
literal is text.

A NUMBER takes the numeric type its context expects: the declared type of a
`let`, the target of an assignment, a parameter, a field in a struct literal,
the return type, or the type of the other operand of a binary operator. An
integer literal must fit that type, and may stand for a float; a decimal one
only for a float. With no context it is `i32`, or `f32` when it contains a
`.`. `sizeof` is typed the same way, and is `u64` by default.

Under a cast a literal is read as itself: it stays `i32` when `i32` can hold
it, so `300 as i8` still means "truncate an in-range `i32`" and yields 44, and
otherwise takes the cast's integer type — `3000000000 as i64`,
`-3000000000 as i64` — or `i64` for a float one: `3000000000 as f64`.

The lexer looks no further than two characters when matching an operator, so
`<<=` and `>>=` are not tokens: they lex as `<<` followed by `=`, which no
rule accepts.
---

## Operator Precedence (highest to lowest)

1. Primary (literals, identifiers, parentheses, function calls, struct literals, `sizeof`)
2. Postfix (`.` field access, `[]` indexing)
3. Unary (`-`, `+`, `!`, `*` dereference, `&` address-of)
4. Cast (`as`)
5. Factor (`*`, `/`, `%`)
6. Term (`+`, `-`)
7. Shift (`<<`, `>>`)
8. Comparison (`<`, `<=`, `>`, `>=`)
9. Equality (`==`, `!=`)
10. BitAnd (`&`)
11. BitXor (`^`)
12. BitOr (`|`)
13. LogicAnd (`&&`)
14. LogicOr (`||`)

`as` binds looser than unary, so `*p as i32` means `(*p) as i32`. Postfix binds
tighter than unary, so `*p.next` means `*(p.next)`.

The ordering is C's, so `a & b == c` is `a & (b == c)` and `a + b << c` is
`(a + b) << c`. A single `&` is address-of only where no left operand has been
parsed yet; anywhere else it is bitwise and, and `&&` is a separate token.

---

## Notes

- Left-associative: All binary operators
- Right-associative: Unary operators (allows `--5`, `!-x`)
- Short-circuit evaluation: `a && b` evaluates `b` only when `a` is true, and
  `a || b` only when `a` is false
- `%`, `&`, `|`, `^`, `<<` and `>>` take two integers of the same type;
  floats, pointers and `bool` are rejected. `%` is `srem` on a signed type
  and `urem` on an unsigned one, and `>>` is arithmetic on a signed type and
  logical on an unsigned one, so `-1 >> 4` is `-1` while
  `(255 as u8) >> 4` is `15`
- `a op= b` is sugar for `a = a op b`, for `op` in `+ - * / %`. The target is
  written into the tree twice, so a side effect in it -- `a[next()] += 1` --
  happens twice. There are no compound forms of the bitwise operators or the
  shifts
- Unary `+` accepts any numeric operand and does nothing
- Functions may be called before they are declared; the compiler collects
  every signature before checking any body, so mutual recursion works.
- There are no implicit conversions between typed values: an `i32` variable
  needs `as i64` to be used as an `i64`. Literals have no type of their own
  until their context gives them one (see NUMBER), so `let n: i64 = 0;` needs
  no cast.
- Pointer arithmetic: `p + i`, `i + p` and `p - i` step by elements, and
  `p - q` yields the `i64` number of elements between two pointers of the
  same type. `*void` supports neither arithmetic nor dereference; cast it to
  a concrete pointer type first.
- `a[i]` is `*(a + i)`, so indexing works on any pointer and is assignable.
- Struct declarations may appear in any order and may refer to each other. A
  struct that contains itself *by value* is rejected; go through a pointer.
- A function's name used other than to call it is a value of its function
  type, written `fn(T1, T2): R`. Two function types are the same when their
  parameter and result types are. A function value is called like a function
  -- through a variable, a struct field (`ops.run(x)`, when the struct has no
  method of that name), or any expression (`table[i](x)`) -- compares with
  `==` and `!=`, accepts `null`, and converts to and from pointers with `as`.
  It is a pointer to code, so it passes to C as a function pointer.
- A struct or function declared with type parameters is generic, and is used
  with type arguments written out: `List<i32>`, `max<i64>(a, b)`,
  `List<i32>.new()`, `Pair<i32, bool> { ... }`. Each distinct set of
  arguments makes an instance -- a copy of the declaration with the arguments
  in place of the parameters -- which is checked and compiled on its own, so
  an error in a generic's body is reported for each instance it appears in.
  A generic's names mean what they mean in the file that declares it. In an
  expression, `Name<` starts type arguments when what follows looks like a
  type list closed by `>` and followed by `(`, `{` or `.`; a comparison in
  that position, `f(a < b, c > (d))`, is written with parentheses.
- `null` is the pointer that points at nothing. It has a type of its own that
  every pointer type accepts -- in a declaration, an assignment, an argument,
  a `return` or a struct field -- and compares with `==` and `!=` against any
  pointer, from either side. It is not an integer, so `let n: i32 = null;` is
  an error, and it is not a pointer to anything, so it cannot be
  dereferenced or offset. `null as *T` names its type explicitly.
- `.` follows pointers automatically, however many, so `node.next` works
  whether `node` is a `Node`, a `*Node` or a `**Node`.
- A struct literal must initialise every field exactly once, in any order.
- An enum is a type of its own whose values are written `Name.Member`. A
  member without a value takes the one after the member before it, and the
  first takes 0. Enums compare with `==` and `!=` but cannot be ordered or
  used in arithmetic, and convert to and from integers only through `as`.
  Underneath, an enum is an `i32`. Struct and enum names share one
  namespace, and an enum is imported and exported like a struct.
- `match` runs the arm whose pattern equals its value. On an enum the
  patterns are members, and every member has to be handled or there has to
  be an `else` arm. On an integer or a character the patterns are literals,
  which take the matched value's type when they fit it, and an `else` arm is
  required. A value may appear in only one pattern, and `else` comes last.
  `break` and `continue` inside an arm act on the enclosing loop.
- A `fn` inside a struct is a method. If its first parameter is `self`, typed
  as the struct or a pointer to it, it is called on a value: `v.len()`. The
  receiver is adapted to `self` -- a struct is passed by address to a `*T`
  `self`, and a pointer is followed for a `T` one -- so the call reads the same
  on a value and on a pointer. A by-pointer method cannot be called on a
  temporary, which has no address. Any method can also be called on the
  struct's name with every parameter written out, `self` included, and one
  without `self` can only be called that way: `Vec2.new(1, 2)`,
  `Vec2.len(v)`. In `Name.method(...)`, a variable called `Name` wins over a
  struct.
- Methods belong to their struct: they are visible wherever the struct is,
  including through an import of it under another name.
- `sizeof(T)` is a constant: it takes the integer type wanted of it, and is a
  `usize` otherwise. It is what sizes an allocation for a struct.
- Globals may only be initialised from constants, worked out at compile time.
  An integer global may be any arithmetic on literals, `sizeof`, enum members
  and globals declared before it; any other global a literal or an earlier
  global. Every global is visible to every function in
  its file regardless of declaration order.
- Structs may be passed and returned by value between Ode functions, but not
  across `extern`, where the C ABI would need target-specific lowering.
- `*i8` is Ode's string type, the one C's `char *` maps to.
- An `extern` whose ParamList ends in `...` is variadic: it takes any number
  of arguments after the ones it names, each promoted as C promotes it
  (narrower integers and `bool` to `i32`, `f32` to `f64`). Only an `extern`
  may be variadic, a struct cannot go through `...`, and a variadic extern
  has no value as a function.
- `else if` chains without nesting: the `if` after an `else` becomes the else
  branch directly, so no wrapping block is needed.
- `for (i in start..end)` runs its body with `i` taking each value from
  `start` up to, but not including, `end`. Both bounds are evaluated once,
  before the first pass, and are integers of one type: a bound that is not a
  bare literal decides it, so `0..count` counts in `count`'s type, and two
  literals count in `i32`. `i` is a new variable for each loop, scoped to its
  body; assigning to it does not change how many passes there are. `in` is
  only a keyword here.
- `break` and `continue` act on the innermost enclosing `while` or `for`, and
  are rejected outside a loop. In a `for`, `continue` moves on to the next
  value. A function written inside a loop does not see it.
- `return;` is only valid in a `void` function, and `return expr;` only in a
  non-void one, where the expression's type must match the declared return
  type. A non-void function must return on every path: its body's last
  reachable statement is a `return`, an `if` with an `else` or a `match` whose
  every branch returns, or a `while (true)` with no `break` of its own. A
  `void` or `void | E` function may fall off its end.
- `assert(cond)`, `assert(cond, message)` and `assertEq(actual, expected)` are
  built-in calls, unless the program declares a function of that name. They
  return `void`. `assertEq` takes two values of one type — a literal takes the
  other's — that is not a struct, and compares two `*i8`s by their text.
- A TestDecl is checked and compiled only by `ode test`, as a `void`
  function with no parameters.
