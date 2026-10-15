# The compiler

Ode's reason to exist is compiling itself, and it now does. This directory
holds the compiler, written in Ode. The C++ implementation it was ported from
is gone; `bootstrap/ode.ll` is what a machine with no Ode compiler starts
from.

## Building and testing

```bash
./selfhost/build.sh              # first time only: seed, then build/ode
./build/ode build                # build the compiler -> build/ode
./build/ode build test           # the regression suite
./build/ode build bootstrap      # run the bootstrap to its fixed point
./build/ode build seed           # refresh the checked-in seed
```

`build.sh` turns `bootstrap/ode.ll` into a compiler with clang when there is
none -- the one step that cannot be written in Ode -- and hands over to `ode
build`, which is `buildtool.ode` and `testsuite.ode` here. `bootstrap` goes
furthest: the compiler compiles its own sources, the result compiles them
again, and the last two binaries must be byte-identical. A compiler that
miscompiles itself stops reproducing itself, which the fixed point catches
even when every test passes.

## How the sources are laid out

The compiler is a set of modules entered at `main.ode`. Each file exports
what the others use and imports what it uses, so building compiles
`main.ode` and the rest come along through its imports. Declaration order
does not matter, within a file or across files: signatures, globals and
struct names are all hoisted before any body is checked, and the modules
import from each other in cycles freely.

The compiler's data structures are structs with methods -- `Buf`,
`TokenList`, `Ast`, `Lexer`, `Parser`, `Type`, `StructTable`, `SymbolTable`,
`NameSet` -- so text is built with `out.add(...)` and tokens consumed with
`parser.expect(...)`. The passes themselves -- `parseX`, `checkX`, `genX` --
stay free functions taking the parser, analyzer or emitter: they are spread
over several files, and a method has to be written inside its struct, which
lives in one.

Until the language had `import`, these files were concatenated into one in
name order, which is what their old numeric prefixes were for. The seed in
`bootstrap/ode.ll` has to understand any feature the sources use, so it was
refreshed before they switched over.

| File | Holds |
|---|---|
| `main.ode` | the driver, and the entry module |
| `prelude.ode` | libc externs, growable text, failure, file I/O |
| `token.ode` | token kinds, `Token`, `TokenList` |
| `lexer.ode` | the lexer |
| `ast.ode` | the node arena |
| `parser.ode` | expressions |
| `parser_stmt.ode` | statements and declarations |
| `type.ode` | types and struct layouts |
| `symbols.ode` | the symbol table |
| `modules.ode` | files as modules: IR names, imports, per-file scopes |
| `analyzer.ode` | the semantic analyzer |
| `ir.ode` | the textual LLVM IR emitter |
| `dump.ode` | the token, tree and type dumps |
| `system.ode` | running programs, files and directories, through libc |
| `toolchain.ode` | the C compiler and SDK that assemble and link the IR |
| `buildtool.ode` | `ode build`: building, bootstrapping, refreshing the seed |
| `testsuite.ode` | `ode build test`: the regression suite |

## How correctness is checked

While the C++ compiler existed, `difftest.sh` ran both over every example,
every rejection case and this compiler's own source, comparing tokens, trees,
resolved types, diagnostics and program output byte for byte. All 284
comparisons matched before it was removed, and every divergence it found is
recorded below.

With the reference gone, two things stand in its place: `ode build test`,
which pins the output of every example and the diagnostic of every rejection
case, and `ode build bootstrap`, which requires the compiler to reproduce
itself exactly.

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
`dump.ode` here have to be changed together, and `difftest.sh` is what
catches it when they are not.

Every defect below came out of that comparison, and none would have been
caught by reading:

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

Two more came out of porting error recovery, both from code that had been
correct only because failure never returned: `parserExpect` reported the token
it did not want and then consumed it anyway, swallowing the `}` recovery
needed to see; and a pointer-typed global initialised from `0` emitted
`global ptr 0`, which LLVM rejects.

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

## What the compiler still does not do

- **No backend of its own.** It emits textual LLVM IR and runs `clang` twice,
  once to assemble and once to link.
- **No `-O`**, and no way to ask for optimisation.
- **No unit tests.** A fault is found by bisecting a failing program, not by a
  failing assertion. `ode build bootstrap` is the backstop: a compiler that
  miscompiles itself stops reproducing itself.

## Where it is going

Lexer, then parser, then analyzer, then a textual LLVM IR emitter that shells
out to `clang` -- the backend plan, verified end to end before any of this was
written. Bootstrap finishes when `ode1` compiling its own source produces a
compiler byte-identical to itself.
