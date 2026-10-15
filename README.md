# Ode

Ode is a simple imperative programming language, built for educational
purposes. The compiler is **written in Ode** and compiles itself: it emits
textual LLVM IR and hands it to `clang`.

## Building the Compiler

You need `clang` on your `PATH`. Nothing else.

```bash
./selfhost/build.sh
```

This writes the `ode` executable into `build/`.

The compiler is written in the language it compiles, so something has to
compile it first. With no compiler present, `build.sh` seeds one from
`bootstrap/ode.ll` -- a checked-in copy of the compiler's own output that
`clang` can turn into a working binary -- and uses that to build the real one.
That is all the script does. Building, testing and bootstrapping are `ode
build`, which is part of the compiler and written in Ode:

```bash
./build/ode build              # rebuild build/ode, if anything changed
./build/ode build test         # the regression suite
./build/ode build bootstrap    # run the bootstrap to its fixed point
./build/ode build seed         # refresh the checked-in seed
```

`selfhost/build.sh <command>` does the same, seeding first on a fresh
checkout. `ode build` works from anywhere inside the repository.

A build is skipped when nothing it depends on has changed: the compiler's
sources, found by following its imports, and the C compiler and SDK it links
with. `--force` builds anyway.

`bootstrap` runs the compiler to its fixed point: it compiles its own sources,
the result compiles them again, and the last two binaries must be
byte-identical.

After a change that makes the compiler depend on a language feature the seed
predates, refresh the seed with `seed` and commit it. A stale seed breaks the
build for anyone starting from a fresh checkout.

### Choosing the C compiler

The compiler assembles and links through `clang`, or whatever `ODE_CC`
names. On macOS it also passes `-isysroot` with the SDK to link against,
taken from `SDKROOT` or else from `xcrun --show-sdk-path`. That is what lets a
Homebrew clang link on an OS newer than the SDKs its configuration names.

## Diagnostics

Errors are reported as `file:line:column: error: message`, which most editors
can jump to directly:

```
examples/broken.ode:12:3: error: type mismatch in declaration of 'wrong': declared as 'bool' but assigned 'i32'
```

The compiler does not stop at the first one. Both the parser and the analyzer
recover at the next statement boundary and keep checking, so one run reports
everything it can find:

```
broken.ode:4:3: error: type mismatch in declaration of 'a': declared as 'bool' but assigned 'i32'
broken.ode:11:3: error: if condition must be boolean: got 'i32'
broken.ode:15:3: error: while condition must be boolean: got 'i32'
3 errors generated.
```

Syntax errors are reported on their own, without the type errors that would be
guessed from a tree that did not parse. See `LIMITATIONS.md` section 5.1.

## Running the Compiler

To compile an Ode source file, you can run the following command:

```bash
./build/ode <source_file.ode>
```

This compiles, emits LLVM IR and an object file, and links an executable, so
`ode examples/structs.ode` leaves `structs.ll`, `structs.o` and the runnable
`structs` in the working directory.

`-o` moves the executable, and the intermediates follow it so that a whole
build stays in one directory:

```bash
./build/ode -o build/structs examples/structs.ode
```

writes `build/structs`, `build/structs.ll` and `build/structs.o`. The `.ll` and
`.o` are kept by default because they are the two things worth looking at when
codegen misbehaves; `--no-intermediates` deletes them once linking succeeds.

```bash
./build/ode --no-intermediates -o build/structs examples/structs.ode
```

## Testing

`ode build test` is the regression suite. It compiles, links and runs every
`examples/*.ode` and diffs its stdout against `tests/valid/<name>.out`, then
compiles every `tests/invalid/*.ode` and diffs the diagnostic it must produce
against `tests/invalid/<name>.expected`. Programs of several files live in
`tests/modules/<name>/`, entered at `main.ode`, and are diffed against
`tests/modules/<name>.expected` -- their diagnostics if they fail to compile,
their output if they run. It exits non-zero if anything differs,
and works in a temporary directory so the repository stays clean.

```bash
./build/ode build test         # builds first, then tests what it built
```

`--filter <substring>` narrows a run to the cases whose name matches, and
`--ode <path>` tests a compiler somewhere else instead of building one.

### Re-baselining

After a deliberate change to the language, regenerate every expectation in one
command and read the diff before committing it:

```bash
./build/ode build test --update
```

`--update` rewrites `tests/valid/*.out`, `tests/invalid/*.expected` and
`tests/modules/*.expected` from what
the compiler does now, so `git diff tests/` is the exact list of behaviour that
changed. An invalid case that has started compiling is still reported as a
failure rather than being silently dropped.

Adding a case is dropping a file in: an `examples/*.ode` for a program that
should run, a `tests/invalid/*.ode` for one that must be rejected, or a
`tests/modules/<name>/` directory for one that spans files, then `--update` to
record what it does.

## The Ode Language

### "Hello, World!" Example

A simple program looks like this:

```rust
fn sum(n1: i32, n2:i32): i32 {
    return n1 + n2;
}

fn main(): i32 {
  let a: i32 = 1;
  let b: i32 = -1;

  let result: i32 = sum(a, b);
  print(result);

  return 0;
}
```

### Control flow

`if` / `else if` / `else`, and `while` with `break` and `continue`:

```rust
fn classify(c: i8): i32 {
  if (isDigit(c)) {
    return KIND_NUMBER;
  } else if (isAlpha(c)) {
    return KIND_IDENT;
  } else {
    return KIND_UNKNOWN;
  }
}
```

`break` and `continue` act on the innermost `while`. A `void` function returns
with a bare `return;`, and the compiler checks that every `return` matches the
declared return type.

`&&` and `||` short-circuit, so a guard reads naturally:

```rust
while (i < length && text[i] != '\0') {
  i = i + 1 as i64;
}
```

### Types

Integers in every width and signedness — `i8`, `u8`, `i16`, `u16`, `i32`,
`u32`, `i64`, `u64` (also spelled `usize`) — the floats `f32` and `f64`, plus
`bool`, `void`, and pointers to any of them (`*i8`, `**i8`).

There are no implicit conversions. Integer literals are `i32`, so every other
width is reached with an explicit cast:

```rust
let size: i64 = 4096 as i64;
let byte: u8 = size as u8;
let ratio: f64 = size as f64 / 3.0 as f64;
```

A literal too wide for `i32` takes the type it is cast to, so `3000000000 as
i64` is written directly. One that does fit keeps `i32`, so a narrowing cast
still truncates: `300 as i8` is 44.

### Pointers

`&` takes the address of a variable, `*` reads or writes through a pointer,
and `p + i` steps by elements.

```rust
fn increment(target: *i32): void {
  *target = *target + 1;
}
```

### Calling C

`extern` declares a function supplied by the C runtime or another object
file. This is how an Ode program gets heap memory and I/O without either
being built into the language.

```rust
extern fn malloc(size: i64): *i8;
extern fn free(block: *i8): void;
extern fn putchar(character: i32): i32;
```

### Structs

```rust
struct Node {
  value: i32,
  next: *Node,
}
```

Declarations may appear in any order and may refer to each other; only a
struct that contains itself *by value* is rejected. A literal initialises
every field exactly once, in any order:

```rust
let node: Point = Point { x: 3, y: 4 };
```

`.` follows one level of pointer on its own, so `node.next.value` reads
through two pointers without a single `*`. Fields are assignable, and
`sizeof(T)` gives the byte size needed to allocate one:

```rust
let node: *Node = malloc(sizeof(Node) as i64) as *Node;
node.value = 1;
```

Structs pass and return by value between Ode functions, but not across
`extern` — that would need target-specific C ABI lowering.

### Methods

A function written inside a struct is a method of it. If its first parameter
is `self`, it is called on a value; otherwise it is called on the struct's
name, like an associated function in Rust:

```rust
struct Vec2 {
  x: i32,
  y: i32,

  fn new(x: i32, y: i32): Vec2 {
    return Vec2 { x: x, y: y };
  }

  fn lengthSquared(self: Vec2): i32 {      // gets a copy
    return self.x * self.x + self.y * self.y;
  }

  fn scale(self: *Vec2, by: i32): void {   // can change the receiver
    self.x = self.x * by;
    self.y = self.y * by;
  }
}

let v: Vec2 = Vec2.new(3, 4);
v.scale(2);                // passed &v
let p: *Vec2 = &v;
print(p.lengthSquared());  // passed *p
```

As in Go, the receiver is adapted to `self`: a variable is passed by address
to a `*Vec2` method, and a pointer is followed for a `Vec2` one. `self` is an
ordinary, explicitly typed parameter, as in Zig, so `Vec2.scale(&v, 2)` is the
same call written out. Methods come with their struct, so importing the
struct is enough to call them. `examples/methods.ode` shows the rest.

### Strings

A string literal has type `*i8` and points at a NUL-terminated constant; a
character literal has type `i8`. Escapes are `\n`, `\t`, `\r`, `\0`, `\\`,
`\"` and `\'`.

```rust
extern fn strlen(text: *i8): i64;

let GREETING: *i8 = "Ode";

fn isDigit(c: i8): bool {
  return c >= '0' && c <= '9';
}
```

`print` renders `*i8` as text; every other pointer prints as an address.
Indexing a string yields its bytes, so `GREETING[0]` is `'O'`. Comments are
recognised by the lexer, so a `//` inside a literal is just text.

### Arrays

An array is a pointer plus indexing. `values[i]` is `*(values + i)`, and
works on either side of an assignment:

```rust
let values: *i32 = malloc(sizeof(i32) as i64 * 8 as i64) as *i32;
values[0] = 41;
print(values[0]);
```

### Globals

A `let` at program level is a global, visible to every function regardless of
declaration order. Initialisers must be constant — literals, `sizeof`, or a
cast or negation of one:

```rust
let KIND_NUMBER: i32 = 0;
let allocations: i32 = 0;
```

Ode has no sum types yet, so a kind tag plus one struct holding every
variant's fields stands in for them. `examples/expr_tree.ode` builds and
evaluates an expression tree that way.

### Modules

Every file is a module. Top-level declarations are private to their file
unless marked `export`, and other files import them by name, the way
TypeScript does:

```rust
// geometry.ode
export struct Vec2 {
  x: i32,
  y: i32,
}

export fn vecAdd(a: Vec2, b: Vec2): Vec2 {
  return Vec2 { x: a.x + b.x, y: a.y + b.y };
}

fn helper(): i32 {      // private to geometry.ode
  return 0;
}
```

```rust
// main.ode
import { Vec2, vecAdd as add } from "./geometry";

fn main(): i32 {
  let v: Vec2 = add(Vec2 { x: 1, y: 2 }, Vec2 { x: 3, y: 4 });
  print(v.y);
  return 0;
}
```

`fn`, `extern fn`, `struct` and `let` can all be exported. A path is relative
to the file that imports it, and `.ode` may be left off. Every file is loaded
once, so imports may be cyclic. Compile the entry file as usual (`ode
main.ode`) and the files it imports come along. Two files may each have a
private declaration of the same name without colliding.
`examples/modules.ode` and the files under `examples/modules/` show all of
it.

### Examples

`examples/` holds a program per feature — `mutual_recursion.ode`,
`pointers.ode`, `casts.ode`, `extern.ode`, `structs.ode`, `linked_list.ode`,
`arrays.ode`, `expr_tree.ode`, `strings.ode`, `nested_control.ode`,
`shadowing.ode`, `tokenizer.ode`, `short_circuit.ode`, `modules.ode` and
`methods.ode` cover the ones above.

### Grammar

For the complete grammar of the Ode language, please see the [EBNF grammar file](gramma.md).

### Limitations

[LIMITATIONS.md](LIMITATIONS.md) records what does not work yet and what is
deliberately absent.
