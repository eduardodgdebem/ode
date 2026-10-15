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

```bash
./build/ode build test                  # builds first, then tests what it built
./build/ode build test --filter struct  # only the cases whose name matches
./build/ode build test --ode <path>     # test some other compiler instead
```

The suite works in a temporary directory, so the repository stays clean, and
exits non-zero if anything differs. Its cases:

| Directory | What a case is | Compared against |
|---|---|---|
| `tests/run/` | a program that compiles and runs | the `<name>.out` beside it |
| `examples/` | the same, for the showcase programs | `tests/examples/<name>.out` |
| `tests/invalid/` | a program that must be rejected | the `<name>.expected` beside it |
| `tests/modules/` | a directory of files entered at `main.ode` | `tests/modules/<name>.expected` |
| `tests/unit/` | a file of tests, run by `ode test` | the `<name>.out` beside it, with the exit status |

A module case is compared against its diagnostics if it fails to compile and
against what it prints if it runs. Four more checks exercise the driver's
flags: `-o`, `--no-intermediates`, an output path holding shell
metacharacters, and running with no input.

The suite also runs the compiler's own tests -- the `test` blocks in
`compiler/` -- with `ode test compiler/main.ode`, and fails if any does. To
run them alone, or only some:

```bash
./build/ode test compiler/main.ode          # every test in the compiler
./build/ode test compiler/main.ode lexer    # the ones whose name says lexer
```

Adding a case is dropping a file in, then recording what it does with
`--update`.

### Re-baselining

After a deliberate change to the language, regenerate every expectation in one
command and read the diff before committing it:

```bash
./build/ode build test --update
```

`git diff tests/` is then the exact list of behaviour that changed. A case
that should be rejected but has started compiling is still reported as a
failure rather than being silently re-recorded.

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
