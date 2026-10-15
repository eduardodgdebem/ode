# Working on Ode

Everything here runs through `ode build`, which is part of the compiler and
written in Ode (`compiler/tool/`). It works from anywhere inside the
repository.

## Building

You need `clang` on your `PATH`. Nothing else.

```bash
./build.sh
```

The compiler is written in the language it compiles, so something has to
compile it first. On a fresh checkout `build.sh` turns `bootstrap/ode.ll` -- a
checked-in copy of the compiler's own output -- into a first compiler with
clang, and that compiler builds the real one into `build/ode`. That one step
is all the script does; after it, `./build.sh <command>` is the same as
`./build/ode build <command>`:

```bash
./build/ode build              # rebuild build/ode, if anything changed
./build/ode build test         # build, then run the regression suite
./build/ode build bootstrap    # build, then run the bootstrap to its fixed point
./build/ode build seed         # build, then refresh bootstrap/ode.ll
```

A build is skipped when nothing it depends on has changed: the compiler's
sources, found by following its imports, and the C compiler and SDK it links
with. `--force` builds anyway.

### The C compiler

The compiler assembles and links what it emits through `clang`, or whatever
`ODE_CC` names. On macOS it also passes `-isysroot` with the SDK to link
against, taken from `SDKROOT` or else from `xcrun --show-sdk-path`, which is
what lets a clang that is not Apple's link on an OS newer than the SDKs its
own configuration names.

## Testing

Most tests are unit tests, written in Ode beside the code they test, in
`*.test.ode` files next to the compiler's sources. They run the phases
in-process -- each test is a process of its own, so the compiler's state is
fresh -- and ask what was decided, never how it was worded:

```rust
test "a return of the wrong type" {
  let found: *List<Diagnostic> = problemsIn(`
    fn main(): i32 {
      return true;
    }
  `);
  assertEq(found.count, 1);
  assertEq(found.at(0).problem, Problem.WrongReturnType);
  assertEq(found.at(0).line, 2);
  assertEq(found.at(0).column, 10);
}
```

Every diagnostic is a `Problem` with `Facts` -- the names, types and counts
it is about -- and `describe()` in `compiler/support/problems.ode` is the only
place one becomes words, so changing how errors read changes no test but the
few that test the rendering itself. `compiler/testkit.ode` has the tools:

| Tool | Gives |
|---|---|
| `problemsIn(source)` | the problems checking finds, each with its `Problem`, position and `Facts` |
| `problemsInFiles(files, entry)` | the same, for a program of several files in a scratch `Files` directory |
| `typeOf(setup, expression)` | the `Type` checking settles on |
| `parse(source)` | the tree, to walk its nodes |
| `irOf(source)` | the LLVM IR of a clean snippet |
| `outputOf(source)`, `outputOfFiles(files, entry)` | what a program prints when built and run -- the slow ones, which link with clang |

```bash
./build/ode test compiler            # every test in the compiler
./build/ode test compiler lexer      # the ones whose name says lexer
./build/ode test std                 # the standard library's
```

`ode build test` runs both, and then what only the binary can show:

| Directory | What a case is | Compared against |
|---|---|---|
| `examples/` | a showcase program, built and run | `tests/examples/<name>.out` |
| `tests/runner/` | a file of tests, run through `ode test` | the `<name>.out` beside it, with the exit status |

The runner cases test `ode test` itself, failing tests and crashes
included; `tests/runner/std_failures.ode` holds the library calls that must
stop the program, whose recorded failures are the check. A few more checks
exercise the driver: `-o`, `--keep-intermediates`, an output path holding
shell metacharacters, no input, and a directory as input.

```bash
./build/ode build test                  # builds first, then tests what it built
./build/ode build test --filter math    # only the cases whose name matches
./build/ode build test --ode <path>     # test some other compiler instead
./build/ode build test --update         # re-record the .out files; read the diff
```

The suite works in a temporary directory, so the repository stays clean, and
exits non-zero if anything differs. It points `ODE_STD` at the repository's
`std/`, so whichever compiler is under test uses it.

## The bootstrap

```bash
./build/ode build bootstrap
```

The compiler compiles its own sources, the result compiles them again, and
the last two binaries must be byte-identical. A compiler that miscompiles
itself stops reproducing itself, which the fixed point catches even when
every test passes.

`bootstrap/ode.ll` is what a machine with no Ode compiler starts from, so it
has to be able to compile the current sources. After a change that makes the
compiler use a language feature the committed seed predates, refresh it and
commit the result in the same pull request:

```bash
./build/ode build seed
```

A stale seed breaks the build for anyone starting from a fresh checkout.

## Continuous integration

`.github/workflows/ci.yml` runs the build, the suite and the bootstrap on
macOS and Linux for every push and pull request.

## Editor support

[`editors/tree-sitter-ode`](../editors/tree-sitter-ode) is a tree-sitter
grammar with highlighting, folding and indentation queries, and a script that
installs it into Neovim. It is a separate grammar from the compiler's parser,
so a language change needs it updated too.
