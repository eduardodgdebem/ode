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

fn main(): i32 {
  let c: Counter = Counter { hits: 0 };
  c.bump();
  print(c.hits);
  return 0;
}
```

The language has integers of every width, floats, pointers, structs with
methods, modules with `import` and `export`, and direct calls into C through
`extern`. It has no garbage collector, no implicit conversions and no
generics: what it compiles to is close to what is written.

## Quick start

You need `clang`. Nothing else.

```bash
./build.sh                       # build the compiler into build/ode
./build/ode examples/hello.ode   # compile a program...
./hello                          # ...and run it
```

`ode file.ode` compiles the file and every file it imports, and links an
executable named after it. `-o <path>` puts the executable elsewhere, and the
`.ll` and `.o` it keeps beside it follow; `--no-intermediates` deletes those.
`--emit-llvm` prints the IR instead of linking, and `--dump-tokens`,
`--dump-ast` and `--dump-types` print what a phase produced.

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
- [Limitations](docs/limitations.md) -- what is missing, and what is left out on purpose
- [Working on Ode](docs/development.md) -- building, testing, the bootstrap
- [The compiler](docs/compiler.md) -- how it is put together

## Repository layout

```
compiler/          the compiler, written in Ode; main.ode is its entry
  support/         libc bindings, text, diagnostics, processes and files
  syntax/          tokens, lexer, AST, parser
  semantics/       types, symbols, modules, the type checker
  codegen/         the LLVM IR emitter, and the C toolchain that links it
  tool/            `ode build`: building, testing, bootstrapping
bootstrap/ode.ll   the compiler's own IR, which a fresh checkout starts from
examples/          programs that show the language off
tests/             the regression suite
docs/              the documentation above
editors/           tree-sitter grammar and Neovim support
build.sh           turns the seed into a first compiler, then hands over
```
