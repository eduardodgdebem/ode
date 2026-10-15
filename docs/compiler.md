# The compiler

The Ode compiler is written in Ode, in [`compiler/`](../compiler), and
compiles itself. This is how it is put together. Building and testing it are
in [development.md](development.md).

## The pipeline

```
main.ode          read the entry file
syntax/lexer      source text -> tokens
syntax/parser     tokens -> nodes in one shared arena, following imports
semantics/modules give every top-level name its IR name; check imports
semantics/        resolve names, check every type, record them per node
codegen/          nodes + types -> textual LLVM IR
codegen/toolchain clang assembles the .ll and links the .o
```

Every file a program imports is lexed and parsed into the same arena and the
same program node, breadth first, each file once. Every node records which
file it came from, which is what diagnostics, name resolution and the per-file
scopes are built on.

Lexing errors end the compile at once. Parse errors and type errors are
collected: a failed construct raises `FAILED`, everything on the way out
returns, and the enclosing statement loop puts its state back and moves on,
so one run reports every error it can find. Syntax errors are reported on
their own, because types inferred from a tree with holes in it would be
guesses.

## Source layout

| Path | Holds |
|---|---|
| `main.ode` | the driver: arguments, loading the program, running the phases |
| `support/libc.ode` | the C library functions the compiler uses, declared by hand |
| `support/text.ode` | `Buf`, the growable buffer, and helpers on C strings |
| `support/diagnostics.ode` | collecting and printing errors; fatal failure |
| `support/system.ode` | running programs, pipes, files, paths, directories |
| `syntax/token.ode` | token kinds, `Token`, `TokenList` |
| `syntax/lexer.ode` | the lexer |
| `syntax/ast.ode` | node kinds and the node arena |
| `syntax/parser.ode` | the `Parser`, error recovery, and types |
| `syntax/expressions.ode` | expressions, one function per precedence level |
| `syntax/statements.ode` | statements, declarations, imports and exports |
| `syntax/dump.ode` | `--dump-tokens`, `--dump-ast`, `--dump-types` |
| `semantics/types.ode` | `Type`, and struct layouts |
| `semantics/symbols.ode` | the scoped symbol table |
| `semantics/modules.ode` | files as modules: IR names, imports, per-file scopes |
| `semantics/analyzer.ode` | the analyzer and the passes over the top level |
| `semantics/expressions.ode` | checking expressions |
| `semantics/statements.ode` | checking statements and function bodies |
| `semantics/methods.ode` | methods: registration, calls, bodies |
| `codegen/emitter.ode` | the emitter's state, lines, labels, locals, constants |
| `codegen/layout.ode` | LLVM type names, sizes and alignment |
| `codegen/expressions.ode` | emitting expressions |
| `codegen/statements.ode` | emitting statements |
| `codegen/program.ode` | functions, globals, and the module as a whole |
| `codegen/toolchain.ode` | which C compiler and SDK assemble and link |
| `tool/build.ode` | `ode build`, `bootstrap` and `seed` |
| `tool/testsuite.ode` | `ode build test` |

Each file exports what the others use and imports what it uses. Declaration
order does not matter, within a file or across files: signatures, globals and
struct names are hoisted before any body is checked, and modules import from
each other in cycles freely.

The compiler's data structures are structs with methods -- `Buf`, `TokenList`,
`Ast`, `Lexer`, `Parser`, `Type`, `StructTable`, `SymbolTable`, `Analyzer`,
`Emitter` -- so text is built with `out.add(...)` and tokens consumed with
`parser.expect(...)`. The passes themselves, `parseX`, `checkX` and `genX`,
are free functions taking the parser, analyzer or emitter: they span several
files, and a method has to be written inside its struct.

## The AST

Nodes live in one arena and refer to each other by index rather than by
pointer, because the arena moves when it grows and a held pointer would
dangle. There are no sum types, so every node is the same struct with a kind
tag: `a`, `b` and `c` are the fixed children and mean different things per
kind -- `syntax/ast.ode` lists them -- and `items` is the child list that only
some kinds use. A struct's items are its fields and its methods.

Children are stored in the order they print, so the dumper walks `a`, `b`, `c`
and then `items` for every kind without a case per node type.

## Types

A type is a base kind plus a pointer depth, with a name as well for structs.
Types are small values with methods -- `t.isPointer()`, `a.equals(b)` -- and
are passed by value.

Resolved types live in one array indexed by node, parallel to the arena, with
`TY_NONE` for nodes that are not expressions. The emitter reads every type it
needs from there rather than inferring it again.

There is no `~` operator, so the integer maxima that literal range checking
needs are built by shifting rather than by complementing zero.

## Modules

Before the analyzer proper runs, `semantics/modules.ode` keeps the files
apart:

- Every top-level declaration gets the name it carries in the IR. The entry
  file claims names first and keeps them, so a one-file program compiles to
  exactly the IR it would have anyway; a later file whose name is taken gets
  `<stem>.<name>`, which no source can spell. Methods are `Struct.method`.
- Struct references are rewritten to the struct's IR name on the tree, which
  is safe because nothing can shadow a struct name.
- Every import is checked against what its module exports.

Values can be shadowed, so those are resolved by the analyzer itself: each
file's bodies are checked in a scope holding its own declarations and its
imports, and nothing else.

## Code generation

The IR is written as text rather than built through the LLVM C API, so the
compiler links against nothing and needs clang only at the end.

Temporaries and labels are named (`%t0`, `L0`) rather than numbered, because
LLVM requires unnamed values to run 0, 1, 2... with no gaps, counting the
parameters. Naming them sidesteps the rule instead of tracking it.

Sizes and alignment are computed here rather than asked of LLVM, because
there is no data layout to consult from textual IR. They follow the rules
LLVM uses for a non-packed struct: every field starts at its own alignment,
and the whole is rounded up to the widest field's. `sizeof` and pointer
arithmetic both depend on getting that right.

clang is run through `fork` and `execvp` rather than `system`. A shell would
need every path quoted against spaces and metacharacters; an argument vector
has none, so each argument arrives exactly as written.

## What the language makes the compiler do by hand

The compiler can only use what the language supports, and a feature added to
the compiler is usable by its own source only once the seed has it. Today
that means:

- No function pointers, so dispatch is `if`/`else if` chains on kind tags.
- No sum types, so a node is one struct with a kind and generic children.
- No implicit conversions, so widths change through `as`.
- No variadic `extern`, so there is no printf and numbers are formatted by
  hand.
- No `stat` or `readdir`, whose structs differ per platform, so the build
  tool hashes file contents and lists directories with `ls`.

## History

The compiler was first written in C++, then ported to Ode one phase at a
time. While both existed, a comparison harness ran them over every example,
every rejection case and the Ode compiler's own source, and required the
token streams, trees, resolved types and diagnostics to match byte for byte;
codegen was compared by what the compiled programs print. All 284 comparisons
matched before the C++ compiler was removed.

That comparison found defects that reading would not have: type names
lexing as identifiers; when a leading `-` folds into a number literal (only
where the previous token cannot end an expression, so `x = 5 - 3` subtracts
and `let c: i32 = --5;` negates `-5`); tokens needing an explicit length
because `'\0'` is a token whose text is one NUL byte; an unassignable target
reported at the expression instead of the assignment; and the end-of-input
token's position. Porting error recovery found two more, both in code that
had been correct only because failure never returned.
