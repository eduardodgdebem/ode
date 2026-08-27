# The self-hosted compiler

Ode's reason to exist is compiling itself. This directory holds the compiler
written in Ode; `build/ode` (the C++ one) compiles it.

## Building and testing

```bash
cmake --build ./build      # the C++ compiler, which compiles the Ode one
./selfhost/build.sh        # concatenate and compile -> build/ode1
./selfhost/difftest.sh     # compare ode1 against ode, phase by phase
./selfhost/bootstrap.sh    # run the bootstrap to its fixed point
```

The compiler is self-hosting. `bootstrap.sh` has `ode1` compile the sources
into `ode2` and `ode2` compile them into `ode3`, and checks that `ode2` and
`ode3` are byte-identical. `ode1` is not expected to match them: it came out
of a different compiler, through the LLVM API rather than from this
compiler's own textual IR, so it differs in layout while meaning the same
thing. `ode2` passes all 284 comparisons in `difftest.sh`, the same as `ode1`.

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
| `60_type.ode` | types and struct layouts |
| `65_symbols.ode` | the symbol table |
| `70_analyzer.ode` | the semantic analyzer |
| `75_ir.ode` | the textual LLVM IR emitter |
| `80_dump.ode` | the token, tree and type dumps |
| `90_main.ode` | the driver |

## How correctness is checked

`difftest.sh` runs both compilers over every `examples/*.ode`, every
`tests/invalid/*.ode`, and the self-hosted compiler's own source, and compares
their output byte for byte. The C++ compiler is the reference; any difference
is a porting bug.

Right now that means the token stream (`--dump-tokens`), the parsed tree
(`--dump-ast`) and the tree with every resolved expression type
(`--dump-types`), each of which both compilers print in the same format. Later
phases get compared the same way as they land.

Sources the C++ compiler *rejects* are compared too: where it reports a single
error, the diagnostic itself has to match character for character. Only where
it recovers and reports several -- which the self-hosted compiler cannot do
yet -- is the weaker "both reject" all that is required.

**Codegen is the exception, and has to be.** The C++ compiler builds IR
through the LLVM API and this one writes the text, so the two `.ll` files
never match even when they mean the same thing -- LLVM's printer picks its own
formatting and numbering. What can be compared is behaviour, and
`tests/valid/<name>.out` already records what the C++ compiler's binaries
print. So the `run` phase builds every example with the self-hosted compiler
and diffs what it prints. All 23 match byte for byte. This is the answer to the gap
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
- An unassignable target is reported at the assignment, not at the expression
  that turned out not to be one, so `1 + 1 = 2;` points at the statement.
- The end-of-input token carries no position, because the C++ parser
  synthesises one that way and a diagnostic about running out of input names
  the file rather than pointing past its last line.

Comparing diagnostics is what found the last three of those. While only
"both reject" was required, all three passed.

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

## Types

A type is a base kind plus a pointer depth, with a name as well for structs.
They are passed by value, which Ode allows between its own functions, so the
checks read the way the C++ `Type` class does.

Resolved types live in one array indexed by node, parallel to the arena, with
`TY_NONE` for the nodes that are not expressions. That is the same information
the C++ analyzer keeps in a map keyed by node pointer, and `--dump-types` is
what makes the two comparable.

There is no `~` operator, so the integer maxima that literal range checking
needs are built by shifting rather than by complementing zero.

## Code generation

Temporaries and labels are named (`%t0`, `L0`) rather than numbered, because
LLVM requires unnamed values to run 0, 1, 2... with no gaps, counting the
parameters. Naming them sidesteps the rule instead of tracking it.

Sizes and alignment are computed here rather than asked of LLVM, because there
is no data layout to consult from textual IR. They follow the rules LLVM uses
for a non-packed struct: every field starts at its own alignment, and the
whole is rounded up to the widest field's. `sizeof` and pointer arithmetic
both depend on getting that right.

Linking runs `clang` through `fork` and `execvp` rather than `system`. A shell
would need every path quoted against spaces and metacharacters; an argument
vector has no shell in it, so each argument arrives exactly as written. The
cost is that `WIFEXITED` and `WEXITSTATUS` are C macros and have to be written
out by hand.

## What is not ported yet

- **Error recovery.** The C++ compiler reports every error in a run; this one
  stops at the first. Where the C++ compiler reports several errors,
  `difftest.sh` can only require that both reject.
- **Object files.** The C++ compiler emits a `.o` through LLVM and links that;
  this one hands the `.ll` to clang and lets it do both.
- **`-O` and the driver flags** beyond `-o` and `--emit-llvm`.

## Where it is going

Lexer, then parser, then analyzer, then a textual LLVM IR emitter that shells
out to `clang` -- the backend plan, verified end to end before any of this was
written. Bootstrap finishes when `ode1` compiling its own source produces a
compiler byte-identical to itself.
