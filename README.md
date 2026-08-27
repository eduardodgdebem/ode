# Ode

Ode is a simple imperative programming language, built for educational purposes. This repository contains the source code for the Ode compiler, which is written in C++ and uses LLVM for code generation.

## Building the Compiler

To build the `ode` compiler, you need to have `cmake` and `llvm` installed on your system.

```bash
cmake -B build -S .
cmake --build ./build
```

This will create the `ode` executable in the `build` directory.

## Diagnostics

Errors are reported as `file:line:column: error: message`, which most editors
can jump to directly:

```
examples/broken.ode:12:3: error: type mismatch in declaration of 'wrong': declared as 'bool' but assigned 'i32'
```

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

`tests/run_tests.sh` is the regression suite. It compiles, links and runs every
`examples/*.ode` and diffs its stdout against `tests/valid/<name>.out`, then
compiles every `tests/invalid/*.ode` and diffs the diagnostic it must produce
against `tests/invalid/<name>.expected`. It exits non-zero if anything differs,
and works in a temporary directory so the repository stays clean.

```bash
cmake --build ./build          # the suite runs the compiler you just built
./tests/run_tests.sh
```

It is also registered with CTest:

```bash
ctest --test-dir build --output-on-failure
```

`--filter <substring>` narrows a run to the cases whose name matches, and
`--ode <path>` points at a compiler somewhere other than `build/ode`.

### Re-baselining

After a deliberate change to the language, regenerate every expectation in one
command and read the diff before committing it:

```bash
./tests/run_tests.sh --update
```

`--update` rewrites `tests/valid/*.out` and `tests/invalid/*.expected` from what
the compiler does now, so `git diff tests/` is the exact list of behaviour that
changed. An invalid case that has started compiling is still reported as a
failure rather than being silently dropped.

Adding a case is dropping a file in: an `examples/*.ode` for a program that
should run, or a `tests/invalid/*.ode` for one that must be rejected, then
`--update` to record what it does.

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

### Examples

`examples/` holds a program per feature — `mutual_recursion.ode`,
`pointers.ode`, `casts.ode`, `extern.ode`, `structs.ode`, `linked_list.ode`,
`arrays.ode`, `expr_tree.ode`, `strings.ode`, `nested_control.ode`,
`shadowing.ode`, `tokenizer.ode` and `short_circuit.ode` cover the ones above.

### Grammar

For the complete grammar of the Ode language, please see the [EBNF grammar file](gramma.md).

### Limitations

[LIMITATIONS.md](LIMITATIONS.md) records what does not work yet and what is
deliberately absent.
