# The Ode language

A tour of the language, feature by feature. The precise syntax is in
[grammar.md](grammar.md), and what is missing or deliberately left out is in
[limitations.md](limitations.md). Every program in [`examples/`](../examples)
compiles and runs, and the test suite checks that each still prints what it
should.

## A first program

```rust
import { println } from "std/io";

fn main(): i32 {
  println("Hello, World!");
  return 0;
}
```

Execution starts at `main`, and what it returns is the process's exit status.
`std/io` is part of the [standard library](std.md). The examples below use
`printf`, imported from `std/c`, and leave the import out.

Functions declare every parameter's type and their return type, and may be
called before they are declared:

```rust
fn main(): i32 {
  printf("%d\n", sum(1, -1));
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

`for` counts over a range, the start included and the end not:

```rust
for (i in 0..count) {
  total = total + values[i];
}
```

`break` and `continue` act on the innermost `while` or `for`. A `void` function returns
with a bare `return;`, and the compiler checks that every `return` matches the
declared return type.

`&&` and `||` short-circuit, so a guard reads naturally:

```rust
while (i < length && text[i] != '\0') {
  i = i + 1;
}
```

## Types

Integers in every width and signedness — `i8`, `u8`, `i16`, `u16`, `i32`,
`u32`, `i64`, `u64` (also spelled `usize`) — the floats `f32` and `f64`, plus
`bool`, `void`, and pointers to any of them (`*i8`, `**i8`).

A literal takes the type its context expects — the declared type, the
parameter, the field, the return type, or the other operand — so it is
written as itself. A literal that does not fit what is expected is an error,
not a wrap:

```rust
let size: i64 = 4096;
let small: i16 = -12;
let next: i64 = size * 2 + 1;
let ratio: f64 = 3;
let byte: u8 = 300;          // error: number is out of range for 'u8'
```

Characters and `sizeof` work the same way: `'0' + digit` is in the digit's
type, and `malloc(sizeof(Node) * 4)` passes the `i64` malloc wants. With
nothing to go by, an integer literal is `i32` and a decimal one `f32`.

Values that already have a type never convert on their own, though. An `i32`
variable used where an `i64` is wanted needs `as`:

```rust
let byte: u8 = size as u8;
let ratio: f64 = size as f64 / 3.0;
```

A narrowing cast truncates: `300 as i8` is 44.

## Pointers

`&` takes the address of a variable, `*` reads or writes through a pointer,
and `p + i` steps by elements.

```rust
fn increment(target: *i32): void {
  *target = *target + 1;
}
```

`null` is the pointer that points at nothing. It goes wherever a pointer of
any type does, and compares with one from either side:

```rust
fn find(list: *Node, value: i32): *Node {
  let node: *Node = list;
  while (node != null) {
    if (node.value == value) {
      return node;
    }
    node = node.next;
  }
  return null;
}
```

## Functions as values

A function's name, used other than to call it, is a value. Its type is
written `fn(parameter types): result type`:

```rust
fn square(x: i32): i32 { return x * x; }

fn apply(f: fn(i32): i32, x: i32): i32 {
  return f(x);
}

let op: fn(i32): i32 = square;
printf("%d\n", apply(op, 7));  // 49
```

A function value can be kept in a struct and called like a method, kept in a
table and called by index (`table[i](x)`), returned, compared with `==`, and
set to `null` for "no function". It is a pointer to code, so C can call it:
`extern fn qsort(base: *i8, count: i64, size: i64, compare: fn(*i8, *i8): i32): void;`
takes a comparison written in Ode.

## Generics

A struct or a function can take type parameters, and is used with type
arguments written out:

```rust
struct List<T> {
  items: *T,
  count: i32,
  capacity: i32,

  fn new(): *List<T> { ... }
  fn push(self: *List<T>, item: T): void { ... }
  fn at(self: *List<T>, index: i32): T { return self.items[index]; }
}

fn max<T>(a: T, b: T): T {
  if (a > b) { return a; }
  return b;
}

let names: *List<*i8> = List<*i8>.new();
names.push("ode");
printf("%lld\n", max<i64>(3, 9));
```

Each set of arguments makes an instance -- `List<i32>` and `List<*i8>` are
separate structs, compiled separately -- so a generic costs nothing at run
time. A generic's body is checked for each instance, and an error in it is
reported against the instance that hit it.

## Calling C

`extern` declares a function supplied by the C runtime or another object
file. This is how an Ode program gets heap memory and I/O without either
being built into the language.

```rust
extern fn malloc(size: i64): *i8;
extern fn free(block: *i8): void;
extern fn putchar(character: i32): i32;
```

A C function that takes a variable number of arguments is declared with
`...` after the parameters it names, and called with any number after them:

```rust
extern fn printf(format: *i8, ...): i32;

printf("%s is %d\n", name, age);
```

What goes through `...` is promoted as C promotes it — anything narrower than
an `int`, and `bool`, widens to `i32`, and an `f32` to an `f64` — so the
format has to match the promoted type: `%d` for an `i8`, `%f` for an `f32`,
`%lld` for an `i64`, `%s` for a `*i8`. A struct cannot go through `...`, and
only an `extern` can take it.

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

`.` follows pointers on its own, however many there are, so
`node.next.value` reads through two pointers without a single `*`, and a
`**Node` reads its fields the same way. Fields are assignable, and
`sizeof(T)` gives the byte size needed to allocate one:

```rust
let node: *Node = malloc(sizeof(Node)) as *Node;
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
printf("%d\n", p.lengthSquared());  // passed *p
```

As in Go, the receiver is adapted to `self`: a variable is passed by address
to a `*Vec2` method, and a pointer is followed for a `Vec2` one. `self` is an
ordinary, explicitly typed parameter, as in Zig, so `Vec2.scale(&v, 2)` is the
same call written out. Methods come with their struct, so importing the
struct is enough to call them. [`examples/methods.ode`](../examples/methods.ode) shows the rest.

## Enums and match

An enum is a type whose values are a fixed set of names:

```rust
enum Shape { Circle, Square, Triangle }

enum Status { Ok, NotFound = 404, Gone }   // Gone is 405
```

Members are written `Shape.Circle`. An enum is not an integer: it compares
with `==` and `!=`, and becomes one only through `as` (`Status.Gone as i32`).

`match` runs the arm whose pattern equals the value. On an enum it has to
handle every member, so adding one is a compile error everywhere it was
forgotten -- unless the match has an `else` arm:

```rust
fn sides(shape: Shape): i32 {
  match (shape) {
    Shape.Circle => { return 0; }
    Shape.Square => { return 4; }
    Shape.Triangle => { return 3; }
  }
  return -1;
}
```

It works on integers and characters too, with literal patterns and a
required `else`:

```rust
match (c) {
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' => { return "digit"; }
  ' ', '\t', '\n' => { return "space"; }
  else => { return "other"; }
}
```

`nameOf(value)` gives the name of the member an enum value is, as a string:
`nameOf(Color.Red)` is `"Red"`, and a value that is no member's is `"?"`.

## Errors

A function that can fail says so in its return type: its value, or one of
the errors it may give instead. Errors are listed in an `error enum`:

```rust
error enum ParseError { Empty, NotANumber, TooLarge }

fn parseInt(text: *i8): i64 | ParseError {
  if (text[0] == '\0') {
    return ParseError.Empty;     // fail by returning an error
  }
  ...
  return value;                  // succeed by returning the value
}
```

An error is a value like any other -- no exceptions, no unwinding -- and a
union is not its value, so an error cannot be ignored: `let n: i64 =
parseInt(text);` is a type mismatch. Where the call is, you say what happens
to an error:

| You want | Write |
|---|---|
| To pass it on | `let n: i64 = try parseInt(text);` |
| A fallback in its place | `let n: i64 = parseInt(text) ?? 0;` |
| To handle it, and leave | `let n: i64 = parseInt(text) catch (e) { log(e); return 1; };` |
| To look at it | `if (result is ParseError) { ... }` |

`try` returns the error from the function it is in, which must say it can
return that error too: `fn load(path: *i8): Config | IoError | ParseError`.
`??` only works its fallback out when it needs it, and works the same way on
a pointer that may be `null`. A `catch` block must end in `return`, `break`
or `continue`; `e` in it is the error.

`is` narrows a variable, as a type guard does in TypeScript:

```rust
let result: i64 | ParseError = parseInt(text);
if (result is ParseError) {
  printf("%s\n", nameOf(result));   // here, result is a ParseError
  return 1;
}
printf("%lld\n", result);           // and here, an i64
```

A function that only fails returns `void | IoError`, and succeeds with a bare
`return;`. Errors from different error enums can share a union, and are
always told apart: every error in the program has a number of its own.

## Strings

A string literal has type `*i8` and points at a NUL-terminated constant; a
character literal has type `i8`. Escapes are `\n`, `\t`, `\r`, `\0`, `\\`,
`\"`, `\'`, and `\x` with two hex digits for any byte.

```rust
extern fn strlen(text: *i8): i64;

let GREETING: *i8 = "Ode";

fn isDigit(c: i8): bool {
  return c >= '0' && c <= '9';
}
```

`printf("%s", text)` writes one as text. Indexing a string yields its bytes, so `GREETING[0]` is `'O'`. Comments are
recognised by the lexer, so a `//` inside a literal is just text.

A string in backticks is written as it is: across lines if need be, with no
escapes. When the opening backtick ends its line, the string is a block --
the indentation its lines share is dropped -- so it can sit indented with the
code around it:

```rust
let program: *i8 = `
  fn main(): i32 {
    return 0;
  }
`;   // "fn main(): i32 {\n  return 0;\n}\n"
```

Ode has no interpolation, so `${` in a backtick string is an error rather
than text that looks like it means something.

## Arrays

An array is a pointer plus indexing. `values[i]` is `*(values + i)`, and
works on either side of an assignment:

```rust
let values: *i32 = malloc(sizeof(i32) * 8) as *i32;
values[0] = 41;
printf("%d\n", values[0]);
```

## Globals

A `let` at program level is a global, visible to every function regardless of
declaration order. Initialisers must be constant, because they are worked
out at compile time. An integer global may be any arithmetic on literals,
`sizeof`, enum members and the globals declared before it; a global of any
other type may be a literal or an earlier global:

```rust
let WIDTH: i32 = 80;
let CELLS: i32 = WIDTH * 25;
let BUFFER: i64 = sizeof(Cell) * CELLS;
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
  printf("%d\n", v.y);
  return 0;
}
```

`fn`, `extern fn`, `struct` and `let` can all be exported. A path is relative
to the file that imports it, and `.ode` may be left off. An import that is
not a path, such as `"std/list"`, names a module of the
[standard library](std.md). Every file is loaded
once, so imports may be cyclic. Compile the entry file as usual (`ode
main.ode`) and the files it imports come along. Two files may each have a
private declaration of the same name without colliding.
[`examples/modules.ode`](../examples/modules.ode) and the files under
`examples/modules/` show all of it.

## Tests

Tests live in the file they test, as in Zig and Rust. A `test` block at the
top level is a test: a name, then a body like a `void` function's.

```rust
fn add(a: i32, b: i32): i32 {
  return a + b;
}

test "add sums two numbers" {
  assertEq(add(2, 2), 4);
  assert(add(-1, 1) == 0, "opposites cancel");
}
```

`ode test file.ode` runs every test in the file and in the files it imports,
and `ode test dir/` every test in every `.ode` file under a directory; a
second argument runs only the tests whose name contains it. Tests can live
in files of their own, named `*.test.ode`, which no build includes. A plain build
leaves tests out entirely, unchecked, so they cost the program nothing. A
file of tests needs no `main`, and a test may call the file's private
functions, `main` included.

```
$ ode test math.ode
test add sums two numbers ... ok
math.ode:12:3: assertEq failed
  actual:   4
  expected: 5
test a broken one ... FAILED

1 passed; 1 failed
```

Two checks are built in, and work in any code, not only in tests:

- `assert(cond)` and `assert(cond, message)` stop when `cond` is false.
- `assertEq(actual, expected)` stops when the two differ, and shows both --
  an enum value by its name, `Color.Red`.
  They compare as `==` does — a literal takes the other side's type — except
  that two strings compare by their text.

A failed check reports where it was, on stderr, and exits with status 1.
Each test runs in a process of its own, so that ends one test, and so does a
crash: the tests after it still run. `test` is only a keyword where a string
follows it, and `assert` and `assertEq` are only built in while the program
declares no function of that name.

