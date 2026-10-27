# Working on Ode

Everything here runs through `ode build`, and the compiler is built the way
any Ode project is: [`build.ode`](../build.ode) at the root says what to
build and which steps there are, as described in
[Building a project](build.md). It works from anywhere inside the
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
is all the script does; after it, `./build.sh <step>` is the same as
`./build/ode build <step>`:

```bash
./build/ode build              # rebuild build/ode, if anything changed
./build/ode build test         # build, then run the regression suite
./build/ode build bootstrap    # build, then run the bootstrap to its fixed point
./build/ode build seed         # build, then refresh bootstrap/ode.ll
./build/ode build --help       # the steps, and what each does
```

`build/ode` rebuilds itself in place. The suite, the bootstrap and the seed
are not part of the compiler: they are `tools/dev.ode`, a program of its own
that `build.ode` builds into `build/dev` and its steps run.

A build is skipped when nothing it depends on has changed: the compiler's
sources, found by following its imports, the flags it is built with, and the
C compiler and SDK it links with. `--force` builds anyway.

### The C compiler

The compiler assembles and links what it emits through `clang`, or whatever
`ODE_CC` names. On macOS it also passes `-isysroot` with the SDK to link
against, taken from `SDKROOT` or else from `xcrun --show-sdk-path`, which is
what lets a clang that is not Apple's link on an OS newer than the SDKs its
own configuration names.

## Testing

Tests are written in Ode, beside the code they test, at three levels:

| Level | Where | What it tests |
|---|---|---|
| Unit | `test` blocks inside the source file itself | one function, called with real values: `Type.accepts`, `fitsIn`, `dedent`, `describe` |
| Component | `x.test.ode`, beside `x.ode` | one phase on a fragment: an expression or statements checked in a `Scope`, declarations, a lexer input |
| Integration | `x.int.ode` | the whole pipeline: programs built and run, programs of several files, rules about a program as a whole |

They ask what was decided, never how it was worded. Every diagnostic is a
`Problem` with `Facts` -- the names, types and counts it is about -- and
`describe()` in `compiler/diagnostics/problems.ode` is the only place one becomes
words, so changing how errors read changes no test but the few that test the
rendering itself.

```rust
test "arithmetic needs one type" {
  let scope: *Scope = Scope.new().local("small", "i32").local("wide", "i64");
  let checked: Checked = scope.check("small + wide");
  assertEq(checked.problem(), Problem.ArithmeticTypes);
  assertEq(checked.problems.at(0).column, 7);
  assert(scope.check("wide + 1").type.equals(Type.make(TypeKind.I64, 0)));
}
```

`compiler/testkit/testkit.ode` has the tools. A test runs in a process of its own, so
each starts with the compiler's state fresh:

| Tool | Gives |
|---|---|
| `Scope.new().declare(source).local(name, type).returning(type)` | a scope for a fragment: declarations it can see, locals, the function's return type |
| `scope.check(expression)` | a `Checked`: the problems, and the type checking settled on |
| `scope.run(statements)` | the problems in statements checked as a function body |
| `scope.problems()` | the problems in the declarations alone |
| `problemsIn(source)`, `problemsInFiles(files, entry)` | the problems in a whole program, or one of several files |
| `typeOf(setup, expression)`, `parse(source)`, `irOf(source)` | a type, a tree to walk, the IR of a clean snippet |
| `outputOf(source)`, `outputOfFiles(files, entry)` | what a program prints when built and run -- the slow ones, which link with clang |

A generic's instances are made when a whole file is linked, so a fragment
that uses one is checked as declarations, where linking runs.

```bash
./build/ode test compiler            # every test in the compiler, all three levels
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
./build/ode build test -- --ode <path>  # test some other compiler instead
./build/ode build test -- --update      # re-record the .out files; read the diff
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
