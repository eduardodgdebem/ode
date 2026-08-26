# Ode

Ode is a simple imperative programming language, built for educational purposes. This repository contains the source code for the Ode compiler, which is written in C++ and uses LLVM for code generation.

## Building the Compiler

To build the `ode` compiler, you need to have `cmake` and `llvm` installed on your system.

```bash
cmake -B build -S .
cmake --build ./build
```

This will create the `ode` executable in the `build` directory.

## Running the Compiler

To compile an Ode source file, you can run the following command:

```bash
./build/ode <source_file.ode>
```

This will generate an object file named `output.o`. You can then link this object file to create an executable.

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

### Types

`i8`, `u8`, `i32`, `i64`, `u64` (also spelled `usize`), `f32`, `bool` and
`void`, plus pointers to any of them (`*i8`, `**i8`).

There are no implicit conversions. Integer literals are `i32`, so every other
width is reached with an explicit cast:

```rust
let size: i64 = 4096 as i64;
let byte: u8 = size as u8;
```

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
`arrays.ode`, `expr_tree.ode`, `strings.ode` and `nested_control.ode` cover
the ones above.

### Grammar

For the complete grammar of the Ode language, please see the [EBNF grammar file](gramma.md).
