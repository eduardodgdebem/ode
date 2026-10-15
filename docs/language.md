# The Ode language

A tour of the language, feature by feature. The precise syntax is in
[grammar.md](grammar.md), and what is missing or deliberately left out is in
[limitations.md](limitations.md). Every program in [`examples/`](../examples)
compiles and runs, and the test suite checks that each still prints what it
should.

## A first program

```rust
fn main(): i32 {
  print("Hello, World!");
  return 0;
}
```

Execution starts at `main`, and what it returns is the process's exit status.
`print` writes any value but a struct, followed by a newline.

Functions declare every parameter's type and their return type, and may be
called before they are declared:

```rust
fn main(): i32 {
  print(sum(1, -1));
  return 0;
}

fn sum(a: i32, b: i32): i32 {
  return a + b;
}
```

Variables are declared with `let`, always with a type and an initial value:

```rust
let count: i32 = 0;
let ready: bool = count == 0;
```

## Control flow

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

## Types

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

## Pointers

`&` takes the address of a variable, `*` reads or writes through a pointer,
and `p + i` steps by elements.

```rust
fn increment(target: *i32): void {
  *target = *target + 1;
}
```

## Calling C

`extern` declares a function supplied by the C runtime or another object
file. This is how an Ode program gets heap memory and I/O without either
being built into the language.

```rust
extern fn malloc(size: i64): *i8;
extern fn free(block: *i8): void;
extern fn putchar(character: i32): i32;
```

## Structs

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

## Methods

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
struct is enough to call them. [`examples/methods.ode`](../examples/methods.ode) shows the rest.

## Strings

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

## Arrays

An array is a pointer plus indexing. `values[i]` is `*(values + i)`, and
works on either side of an assignment:

```rust
let values: *i32 = malloc(sizeof(i32) as i64 * 8 as i64) as *i32;
values[0] = 41;
print(values[0]);
```

## Globals

A `let` at program level is a global, visible to every function regardless of
declaration order. Initialisers must be constant — literals, `sizeof`, or a
cast or negation of one:

```rust
let KIND_NUMBER: i32 = 0;
let allocations: i32 = 0;
```

Ode has no sum types yet, so a kind tag plus one struct holding every
variant's fields stands in for them. [`examples/expr_tree.ode`](../examples/expr_tree.ode)
builds and evaluates an expression tree that way.

## Modules

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
[`examples/modules.ode`](../examples/modules.ode) and the files under
`examples/modules/` show all of it.
