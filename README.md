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

### Examples

`examples/` holds a program per feature — `mutual_recursion.ode`,
`pointers.ode`, `casts.ode` and `extern.ode` cover the ones above.

### Grammar

For the complete grammar of the Ode language, please see the [EBNF grammar file](gramma.md).
