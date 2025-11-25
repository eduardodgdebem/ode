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

While the language doesn't have a standard library for I/O, a simple program looks like this:

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

### Grammar

For the complete grammar of the Ode language, please see the [EBNF grammar file](gramma.md).
