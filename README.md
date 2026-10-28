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
`--release` optimises, as clang's `-O2` does; without it a build is
unoptimised, which is quicker to build and easier to debug.
`--emit-llvm` prints the IR instead of linking, and `--dump-tokens`,
`--dump-ast` and `--dump-types` print what a phase produced. `ode test
file.ode` runs the `test` blocks written in a file and the files it imports.
`ode lsp` is a language server, for an editor to run: it underlines the
problems in a file as it is edited, shows what a name is on hover, goes to
where it is declared, and completes names and members; see
[editors](editors/tree-sitter-ode/README.md#the-language-server), Neovim and
Claude Code alike.

`-l <lib>`, `-L <dir>` and `-framework <name>` link a C library, for `ode`
and `ode test` alike. `--target <arch-os[-abi]>` builds for another machine:
`x86_64` or `aarch64`, `macos` or `linux`, and on Linux `musl`, the
default, or `gnu`; or `wasm32`, for WebAssembly.

```bash
./build/ode -L vendor/lib -lraylib -framework Cocoa game.ode
./build/ode --target x86_64-macos game.ode       # an Intel Mac binary, from any Mac
./build/ode --target aarch64-linux game.ode      # a static Linux binary, from anywhere
./build/ode --target x86_64-linux-gnu --sysroot /path/to/sysroot game.ode   # against glibc
```

A Linux program links statically against musl, so it runs on any Linux of
its architecture. Ode bundles musl's source in `vendor/` and builds it the
first time a program is built for a target, in about twenty seconds, into
`~/.cache/ode`; that needs LLVM's `llvm-ar` and `ld.lld` beside clang.
glibc is not bundled: `-gnu` takes the target's own `--sysroot`.
macOS's C library comes with its SDK, and `--emit-object` stops at the
object file for any target.

`ode test` takes `--target` too. Tests built for wasm32 run in Node, one
module instance per test; another machine's run through `--runner`, which
is given the test program and the filter -- an emulator, or a script that
runs it in a container:

```bash
./build/ode test --target wasm32 src
./build/ode test --target aarch64-linux --runner qemu-aarch64 src
```

### WebAssembly

`--target wasm32` builds a module, `<stem>.wasm`, with no C library and no
entry point. What the entry file exports is what the module exports, and
what it declares `extern` it imports from the host's `env`:

```rust
extern fn log(value: i32): void;

export fn fib(n: i32): i32 {
  if (n < 2) {
    return n;
  }
  return fib(n - 1) + fib(n - 2);
}

export fn shout(n: i32): void {
  log(n * 10);
}
```

```js
const { instance } = await WebAssembly.instantiate(bytes, {
  env: { log: (v) => console.log(v) },
});
instance.exports.fib(20);   // 6765
```

Pointers are 4 bytes there, and the module exports its memory as `memory`.
A failed check traps; a program that declares a panic handler is told why
first, with where it failed and the message, both text in that memory:

```rust
extern fn panic(where: *i8, message: *i8): void;   // message may be null
```

```js
env: { panic: (where, message) => console.error(text(where), text(message)) }
```

`std/mem`, `std/list` and `std/text` work there with
nothing from the host: on wasm32 their memory and their bytes are Ode's own
([`std/heap`](docs/std.md#stdheap)), grown with the builtins
`wasmMemorySize()` and `wasmMemoryGrow(pages)`. Building one takes a clang
with the WebAssembly backend, which Apple's lacks, and `wasm-ld`, which comes
with lld.

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
- [The standard library](docs/std.md) -- `std/...`: memory, lists, text, I/O, files, JSON, an HTTP server
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
  tool/            `ode build`: carrying out a project's build.ode
  lsp/             `ode lsp`: the language server editors run
  testkit/         the tools the compiler's own tests use
std/               the standard library, imported as "std/..."
tools/             the suite, the bootstrap and the seed: build/dev
vendor/            musl and compiler-rt's builtins, for Linux targets
runners/           what runs tests built for another machine: wasm32's, in Node
bootstrap/ode.ll   the compiler's own IR, which a fresh checkout starts from
examples/          programs that show the language off
tests/             the regression suite
docs/              the documentation above
editors/           tree-sitter grammar, Neovim support, and the Claude Code plugin
build.ode          how the compiler is built, as any Ode project is
build.sh           turns the seed into a first compiler, then hands over
```
