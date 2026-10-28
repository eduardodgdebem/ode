# The compiler

The Ode compiler is written in Ode, in [`compiler/`](../compiler), and
compiles itself. This is how it is put together. Building and testing it are
in [development.md](development.md).

## The pipeline

```
driver/           read the entry file, and run the phases below
syntax/lexer      source text -> tokens
syntax/parser     tokens -> nodes in one shared arena, following imports
link/modules      give every top-level name its IR name; check imports
link/generics     make each generic's instances
check/            resolve names, check every type, record them per node
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

The folders follow the phases, in the order a program goes through them,
with the pieces around them on either side:

| Folder | Holds |
|---|---|
| `main.ode` | the command line, handed to the driver |
| `driver/` | `compile.ode` (`ode file.ode`), `test.ode` (`ode test`), `options.ode` (what was asked), `pipeline.ode` (loading files and imports, linking an executable), `library.ode` (finding std) |
| `syntax/` | tokens, the lexer, the AST, the parser -- `expressions.ode` one function per precedence level, `statements.ode` declarations and imports -- and `dump.ode` for the `--dump-*` flags |
| `link/` | `modules.ode`: files into one program, each with its own scope and IR names; `generics.ode`: each generic's instances, before checking |
| `types/` | `types.ode` (`Type` and struct layouts), `layout.ode` (sizes and alignment), `symbols.ode` (the scoped symbol table) |
| `check/` | `analyzer.ode` (the passes over the top level), and a file per family of rules: `expressions`, `statements`, `functions`, `lambdas`, `methods`, `enums`, `constants`, `errors` (error enums, unions, `try`, `??`, `catch`, `is`), `testing` (`test`, `assert`, `assertEq`) |
| `codegen/` | the IR emitter: `emitter.ode` (state, labels, locals), `expressions`, `statements`, `program` (functions and the module), `errors`, `testing`, `layout` (LLVM type names), `target` (what is built for), `abi` (structs across `extern`, per target), `toolchain` (which C compiler links, and with what) |
| `diagnostics/` | `problems.ode` (every `Problem`, its `Facts`, and `describe()`, the only place one becomes words), `report.ode` (collecting them), `render.ode` (printing them as Zig does) |
| `os/` | `process.ode` (running programs, forking, the environment), `files.ode` (paths, directories, scratch space), `output.ode` |
| `tool/` | `ode build`: running a project's `build.ode` and carrying out its plan |
| `lsp/` | `ode lsp`: `protocol.ode` (the framing, URIs, and LSP's positions against the compiler's), `analysis.ode` (diagnostics, definitions, hovers and completion, from a checked file), `server.ode` (the open files, and a forked child per answer) |
| `testkit/` | the tests' tools; only test files import it, so it is never part of the compiler |

The compiler is built on the [standard library](std.md), as any Ode program
can be: `std/c`, `std/mem` for allocation, `std/list` for its lists,
`std/text` for building and comparing text, and `std/fs` for files. What can
fail says so in its type: reading a file gives `*i8 | FileError`, running a
program `i32 | ProcessError`, parsing the command line `CompileOptions |
UsageError`.

Tests sit beside what they test: `test` blocks in a file for its functions,
`x.test.ode` for a phase on a fragment, `x.int.ode` for whole programs; see
[development.md](development.md#testing).

Each file exports what the others use and imports what it uses. Declaration
order does not matter, within a file or across files: signatures, globals and
struct names are hoisted before any body is checked, and modules import from
each other in cycles freely.

The compiler's data structures are structs with methods -- `Builder`, `TokenList`,
`Ast`, `Lexer`, `Parser`, `Type`, `StructTable`, `SymbolTable`, `Analyzer`,
`Emitter` -- so text is built with `out.add(...)` and tokens consumed with
`parser.expect(...)`. Their growable parts are std's `List<T>`:
locals, scopes and loop labels in the emitter, the symbol table's scope
stack, names, argument lists, modules and function signatures. The passes themselves, `parseX`, `checkX` and `genX`,
are free functions taking the parser, analyzer or emitter: they span several
files, and a method has to be written inside its struct.

## The AST

Nodes live in one arena and refer to each other by index rather than by
pointer, because the arena moves when it grows and a held pointer would
dangle. What a node holds is its `syntax`: a union with a struct per kind --
`If { condition, then, otherwise }`, `Call { name, args, typeArgs }` -- so
every part is read by its name, and a kind added to the union is an error
at every `match` on it that does not handle it. The node keeps its kind,
where it was written, and the file it came from.

The checker and code generation dispatch on a node's syntax once and hand
each kind its own struct. The walks that go through every node without
caring what each is -- cloning a generic, marking a template, dumping --
ask `syntaxChildren` and `withChildren`, the one place that knows where each
kind keeps its children; linking, which renames, asks `nodeName` and
`setNodeName`.

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

Before the analyzer proper runs, `link/modules.ode` keeps the files
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

- Dispatch on a kind is a `match` rather than a table of handlers: function
  values exist now, but a `match` is checked for every kind and a table is
  not.
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
