# The self-hosted compiler

Ode's reason to exist is compiling itself. This directory holds the compiler
written in Ode; `build/ode` (the C++ one) compiles it.

## Building and testing

```bash
cmake --build ./build      # the C++ compiler, which compiles the Ode one
./selfhost/build.sh        # concatenate and compile -> build/ode1
./selfhost/difftest.sh     # compare ode1 against ode, phase by phase
```

## Why the sources are concatenated

Ode has no modules, so the compiler has to be one file. Keeping it as one file
to *edit* would be miserable, so the sources are split here and `build.sh`
concatenates them in name order into `build/ode1.ode`, which is what actually
gets compiled.

Order does not affect meaning: function signatures, globals and struct names
are all hoisted before any body is checked, so a function in `00_prelude.ode`
may call one in `90_main.ode`. The numbering exists to keep the generated file
stable and diffable, not to satisfy the compiler.

| File | Holds |
|---|---|
| `00_prelude.ode` | libc externs, growable text, failure, file I/O |
| `10_token.ode` | token kinds, `Token`, `TokenList` |
| `20_lexer.ode` | the lexer |
| `30_ast.ode` | the node arena |
| `40_parser.ode` | expressions |
| `50_parser_stmt.ode` | statements and declarations |
| `80_dump.ode` | the token and tree dumps |
| `90_main.ode` | the driver |

## How correctness is checked

`difftest.sh` runs both compilers over every `examples/*.ode`, every
`tests/invalid/*.ode`, and the self-hosted compiler's own source, and compares
their output byte for byte. The C++ compiler is the reference; any difference
is a porting bug.

Right now that means the token stream (`--dump-tokens`) and the parsed tree
(`--dump-ast`), both of which each compiler prints in the same format. Later
phases get compared the same way as they land. This is the answer to the gap
`LIMITATIONS.md` section 8.1 describes: two compilers that have to agree need
something better than bisecting a failing program.

The dump formats are a contract. `ASTPrinter` in the C++ compiler and
`80_dump.ode` here have to be changed together, and `difftest.sh` is what
catches it when they are not.

Real defects have come out of it already, none of which a by-eye reading would
have caught:

- Type names lex as their own kind, not as identifiers.
- A leading `-` folds into a number literal, but only where the previous token
  cannot end an expression. `print(-17 % 5)` is one negative literal; `x = 5 - 3`
  is a subtraction; and because `=` is not in that set, `let c: i32 = --5;` is a
  negation of `-5`.
- A token cannot hold its text as a NUL-terminated string, because `'\0'` is a
  token whose text is one NUL byte. Tokens carry an explicit length instead.

## What the port has to stay inside

The self-hosted compiler is compiled by the C++ one, so it can only use what
the C++ compiler already supports. A feature added to the Ode-written compiler
is usable by the compiler's own source only one generation later. In practice:

- No function pointers, so dispatch is `if`/`else if` chains.
- No implicit conversions, so widths change through `as`.
- No variadic `extern`, so decimal formatting is written out by hand.
- Globals are initialised from constants and assigned at start-up.
- One `.` follows one pointer level.

## The AST

Nodes live in one arena and refer to each other by index rather than by
pointer, because the arena moves when it grows and a held pointer would
dangle. There are no sum types, so every node is the same struct with a kind
tag: `a`, `b` and `c` are the fixed children and mean different things per
kind, and `items` is the child list that only some kinds use.

Children are stored in the order they print, so the dumper walks `a`, `b`, `c`
and then `items` for every kind without a case per node type.

## What is not ported yet

- **Error recovery.** The C++ compiler reports every error in a run; this one
  stops at the first. `difftest.sh` therefore only requires that both reject
  the same sources, not that they produce the same diagnostics.
- **The analyzer and the IR emitter**, which are what come next.

## Where it is going

Lexer, then parser, then analyzer, then a textual LLVM IR emitter that shells
out to `clang` -- the backend plan, verified end to end before any of this was
written. Bootstrap finishes when `ode1` compiling its own source produces a
compiler byte-identical to itself.
