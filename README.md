# Ode

Ode is a small, statically typed, imperative language that compiles to native
code through LLVM. Its compiler is written in Ode and compiles itself.

```rust
struct Counter {
  hits: i32,

  fn bump(self: *Counter): void {
    self.hits = self.hits + 1;
  }
}

import { printf } from "std/c";

fn main(): i32 {
  let c: Counter = Counter { hits: 0 };
  c.bump();
  printf("%d\n", c.hits);
  return 0;
}

test "bump counts" {
  let c: Counter = Counter { hits: 0 };
  c.bump();
  assertEq(c.hits, 1);
}
```

The language has integers of every width, floats, pointers, structs with
methods, generics, enums and `match`, functions as values, modules with `import` and `export`, tests written beside the code they
test, a small [standard library](docs/std.md), and direct calls into C through `extern`. It has no garbage collector and no implicit conversions: what it compiles
to is close to what is written.

## Quick start

You need `clang`. Nothing else.

```bash
./build.sh                       # build the compiler into build/ode
./build/ode examples/hello.ode   # compile a program...
./hello                          # ...and run it
```

`ode file.ode` compiles the file and every file it imports, and links an
executable named after it. `-o <path>` puts the executable elsewhere, and the
`--keep-intermediates` keeps the `.ll` and `.o` it was built from beside it.
`--emit-llvm` prints the IR instead of linking, and `--dump-tokens`,
`--dump-ast` and `--dump-types` print what a phase produced. `ode test
file.ode` runs the `test` blocks written in a file and the files it imports.

`-l <lib>`, `-L <dir>` and `-framework <name>` link a C library, for `ode`
and `ode test` alike. `--target <arch-os[-abi]>` builds for another machine:
`x86_64` or `aarch64`, `macos` or `linux`, and `gnu` or `musl` on Linux.

```bash
./build/ode -L vendor/lib -lraylib -framework Cocoa game.ode
./build/ode --target x86_64-macos game.ode             # an Intel Mac binary, from any Mac
./build/ode --target aarch64-linux --emit-object game.ode   # game.o, for linking elsewhere
./build/ode --target aarch64-linux --sysroot /path/to/linux-sysroot game.ode
```

Building for another target always gets as far as the object file. Linking
needs that target's C library, which Ode does not ship: macOS's comes with
its SDK, and Linux's from a `--sysroot`, linked with `lld` from a Mac.

A project says all of that once, in Ode, in a `build.ode` that `ode build`
runs, as Zig's `build.zig` does: see [Building a project](docs/build.md).

Errors are reported as `file:line:column: error: message`, and one run
reports every error it can find:

```
broken.ode:4:3: error: type mismatch in declaration of 'a': declared as 'bool' but assigned 'i32'
broken.ode:11:3: error: if condition must be boolean: got 'i32'
2 errors generated.
```

## Documentation

- [The language](docs/language.md) -- a tour, feature by feature
- [Grammar](docs/grammar.md) -- the syntax, in EBNF
- [The standard library](docs/std.md) -- `std/...`: memory, lists, text, I/O, files
- [Building a project](docs/build.md) -- `build.ode`, `ode build`, targets and libraries
- [Limitations](docs/limitations.md) -- what is missing, and what is left out on purpose
- [Working on Ode](docs/development.md) -- building, testing, the bootstrap
- [The compiler](docs/compiler.md) -- how it is put together

## Repository layout

```
compiler/          the compiler, written in Ode; main.ode is its entry
  driver/          the commands: compiling, testing, the pipeline between phases
  syntax/          tokens, lexer, AST, parser
  link/            files into one program, generics into instances
  types/           types, sizes, symbols
  check/           the type checker, a file per family of rules
  codegen/         the LLVM IR emitter, and the C toolchain that links it
  diagnostics/     problems, their words, and how they are printed
  os/              processes, files, output
  tool/            `ode build`: building, testing, bootstrapping
  testkit/         the tools the compiler's own tests use
std/               the standard library, imported as "std/..."
bootstrap/ode.ll   the compiler's own IR, which a fresh checkout starts from
examples/          programs that show the language off
tests/             the regression suite
docs/              the documentation above
editors/           tree-sitter grammar and Neovim support
build.sh           turns the seed into a first compiler, then hands over
```
