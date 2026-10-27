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

A function that returns a value — `main` included — must return on every
path; reaching its closing brace is a compile error. A path ends in a
`return`, an `if` / `else` or `match` whose every branch does, or a
`while (true)` that no `break` gets out of. A loop that may run no times, or
a `catch` that only returns on an error, does not count, and neither does a
call to `exit`: write the `return` after it. A `void` function may fall off its
end, and so may a `void | SomeError` one, which then succeeds.

`&&` and `||` short-circuit, so a guard reads naturally:

```rust
while (i < length && text[i] != '\0') {
  i = i + 1;
}
```

## Types

Integers in every width and signedness — `i8`, `u8`, `i16`, `u16`, `i32`,
`u32`, `i64`, `u64` — the floats `f32` and `f64`, plus `bool`, `void`, and
pointers to any of them (`*i8`, `**i8`).

`isize` and `usize` are as wide as a pointer on the target: `i64` and `u64`
on every target but wasm32, where they are `i32` and `u32`. They are other
names for those, not types of their own, so an `isize` passes for an `i64`
on a 64-bit target and fails to on wasm32 -- which is what a cast at the
boundary, `n as isize`, is for. C's `size_t` is one.

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

### Type aliases

`type` gives a type a second name:

```rust
type Count = i64;
type Reader = (*i8) => i64 | ParseError;
type Where = Point;

fn total(read: Reader, texts: **i8, count: i32): Count | ParseError { ... }
let origin: Where = Where { x: 0, y: 0 };
```

The name means exactly that type, not a new one: a `Count` is an `i64`, and
the two mix freely. Aliases are declared at the top level, exported and
imported like structs, and may name a type declared further down.

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
written `(parameter types) => result type`:

```rust
fn square(x: i32): i32 { return x * x; }

fn apply(f: (i32) => i32, x: i32): i32 {
  return f(x);
}

let op: (i32) => i32 = square;
printf("%d\n", apply(op, 7));  // 49
```

A function value can be kept in a struct and called like a method, kept in a
table and called by index (`table[i](x)`), returned, compared with `==`, and
set to `null` for "no function". It is a pointer to code, so C can call it:
`extern fn qsort(base: *i8, count: i64, size: i64, compare: (*i8, *i8) => i32): void;`
takes a comparison written in Ode.

The result runs to the end of the type, so a function that can fail is
written the way it is declared:

```rust
fn parseAll(texts: **i8, count: i32, parse: (*i8) => i64 | ParseError): i64 | ParseError {
  let total: i64 = 0;
  for (index in 0..count) {
    total = total + try parse(texts[index]);
  }
  return total;
}
```

Parentheses around a function type keep it whole where something else
would be read into it: a pointer to one is `*((i32) => i32)`, and a union
holding one is `((i32) => i32) | E`.

## Lambdas

A function can be written where it is used, without a name:

```rust
apply((x) => x + 1, 41);                          // 42
let double: (i32) => i32 = (x) => x * 2;
each(numbers, count, (n) => printf("%d\n", n));
qsort(values as *i8, count, 4, (a, b) => *(a as *i32) - *(b as *i32));
```

The types it leaves out come from where it is used: given where a
`(i32) => i32` is expected, `x` is an `i32` and so is the result. With
nothing to go by -- called on the spot, say -- it writes them out:
`((x: i32): i32 => x * 10)(4)`.

A body after `=>` that is an expression is what the lambda returns; a lambda
returning `void` just runs it. A block is a function body like any other,
with `return`, its own locals and loops, and `try` when the lambda can fail:

```rust
let percent: (*i8) => i64 | ParseError | RangeError = (text) => {
  let value: i64 = try parseInt(text);
  if (value > 100) {
    return RangeError.TooLarge;
  }
  return value;
};
```

A lambda captures nothing. It may use its parameters, globals and other
functions, but not a local of the function it is written in:

```rust
let base: i32 = 10;
apply((x) => x + base, 1);   // error: a lambda cannot use 'base'
```

That is what keeps it cheap: its value is a pointer to its code, the same as
a named function's, so there is nothing to allocate or free, and C can call
it. What it needs is passed in as a parameter.

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
extern fn malloc(size: isize): *i8;
extern fn free(block: *i8): void;
extern fn putchar(character: i32): i32;
```

C's `size_t`, `ssize_t` and `long` are `isize`, which is what
[`std/c`](std.md#stdc) declares them as; an `i64` there would be right on
64-bit targets only.

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

Structs pass and return by value between Ode functions, and to and from C
through `extern`, as C passes them on the target -- so a C API built on
small structs, a `Color` or a `Vector2`, is declared as it is:

```rust
struct Color { r: u8, g: u8, b: u8, a: u8 }
struct Vector2 { x: f32, y: f32 }

extern fn DrawCircleV(center: Vector2, radius: f32, color: Color): void;
extern fn GetMousePosition(): Vector2;
```

A struct holding a union cannot cross, and neither can one through `...`.

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

Members are written `Shape.Circle` -- or just `.Circle` wherever a `Shape`
is expected: a variable's type, a parameter, a return, the other side of
`==`, a match on one. An enum is not an integer: it compares with `==` and
`!=`, and becomes one only through `as` (`Status.Gone as i32`).

`match` runs the arm whose pattern equals the value. On an enum it has to
handle every member, so adding one is a compile error everywhere it was
forgotten -- unless the match has an `else` arm. A match is also a value,
and an arm can be a single expression, ended by a comma:

```rust
fn sides(shape: Shape): i32 {
  return match (shape) {
    .Circle => 0,
    .Square => 4,
    .Triangle => 3,
  };
}
```

An arm can still run a block. In a match used as a value, a block arm has to
leave -- `return`, `break` or `continue` -- since it gives no value; in a
match used as a statement, an expression arm is simply run:

```rust
match (command) {
  .Quit => { return 0; }
  .Help => printUsage(),
  else => run(command),
}
```

It works on integers and characters too, with literal patterns and a
required `else`:

```rust
let kind: *i8 = match (c) {
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' => "digit",
  ' ', '\t', '\n' => "space",
  else => "other",
};
```

A member named alone is found among a union's error enums too, when exactly
one has it: `return .Empty;` in a function returning `i64 | ParseError`.

`nameOf(value)` gives the name of the member an enum value is, as a string:
`nameOf(Color.Red)` is `"Red"`, and a value that is no member's is `"?"`.

## Unions

A value that may be one of several types has a union type, written with
`|`, and `is` asks which it holds -- narrowing the variable, as a type guard
does in TypeScript:

```rust
struct Circle { radius: f64 }
struct Rect { width: f64, height: f64 }
type Shape = Circle | Rect;

fn area(shape: Shape): f64 {
  if (shape is Circle) {
    return 3.14159 * shape.radius * shape.radius;   // here, a Circle
  }
  return shape.width * shape.height;                 // and here, a Rect
}

area(Circle { radius: 2.0 });
```

Any type can be a member: `i64 | *i8`, `Circle | Rect | Line`. A union is
given any of its members, or a union of some of them -- a `Shape` goes where
a `Shape | Line` is expected -- but not the other way round until `is` has
narrowed it. A union of unions is one union of all their members, in no
particular order: `Shape | Line` is `Circle | Line | Rect`.

`match` takes a union too, one arm per member, and narrows the variable in
each arm the way `is` does. Without an `else`, every member has to have an
arm -- so a member added to the union later is an error at every `match`
that does not handle it:

```rust
fn area(shape: Shape): f64 {
  match (shape) {
    Circle => { return 3.14159 * shape.radius * shape.radius; }
    Rect => { return shape.width * shape.height; }
  }
}

fn describe(value: i64 | *i8 | ParseError): void {
  match (value) {
    i64 => { printf("%ld\n", value); }
    *i8 => { printf("%s\n", value); }
    ParseError => { printf("%s\n", nameOf(value)); }   // every ParseError
  }
}
```

An arm may name several members, `Circle, Rect => { ... }`, and the
variable there is the union of them; in `else` it is whatever no arm named.

A field narrows the same way, read along the same path -- through pointers
and nested fields alike:

```rust
fn measure(holder: *Holder): f64 {
  if (holder.shape is Circle) {
    return holder.shape.radius;
  }
  return holder.shape.width * holder.shape.height;
}
```

`!` swaps what the two branches learn, so the early return reads the way it
does in TypeScript:

```rust
if (!(shape is Circle)) {
  return 0;
}
return shape.radius;      // here, a Circle
```

`&&` and `||` carry it through too: the right side of `&&` runs only where
the left held, so `shape is Circle && shape.radius > 1` reads a Circle's
radius, and an `if` on `a && b` knows both in its first branch.

Assigning a narrowed variable or field -- or anything it is part of, such as
the whole `holder` -- forgets what was found out about it, from there on: it
may hold any member again until it is asked once more.

A union is as big as its largest member and a code saying which member it
holds; nothing is allocated, and `is` compares that code. Two unions are not
compared with `==` -- ask with `is`, and compare what it holds.

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
`return;`. Calling one for what it does still has to say what happens to its
error -- `touch(path);` alone is an error -- and there, a `catch` block may
fall through, there being no value to give: `removeFile(path) catch (e) {};`
ignores the error on purpose, where anyone reading can see it. Errors from different error enums can share a union, and are
always told apart: every error in the program has a number of its own.

Errors are union members like any other, so the two mix: a
`fn validate(shape: Shape): Shape | ShapeError` returns either shape, or an
error, and `try validate(shape)` is a `Shape`.

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

## What a program is built for

`std/target` says what the program is being compiled for -- the
`--target`, or the machine compiling it -- as enums, in constants:

```rust
import { OS, ARCH, Os, Arch } from "std/target";

extern fn ioctl(fd: i32, request: u64, ...): i32;

fn windowSizeRequest(): u64 {
  return match (OS) {
    .Linux => 21523,        // TIOCGWINSZ
    .Macos => 1074295912,   // TIOCGWINSZ
    .Freestanding => 0,
  };
}
```

| Constant | Type | Members |
|---|---|---|
| `OS` | `Os` | `Macos`, `Linux`, `Freestanding` (no OS: a wasm32 module) |
| `ARCH` | `Arch` | `X86_64`, `Aarch64`, `Wasm32` |
| `ABI` | `Abi` | `None`, `Gnu`, `Musl` -- which C library, on Linux |
| `POINTER_BYTES` | `i32` | 8, or 4 on wasm32 |

A `match` on one of them is decided while compiling: only the arm it picks
is compiled into the program, so the others may call what exists only on
their target -- an `extern` that only Linux's C library has links on macOS,
because nothing calls it there. Every arm is still checked, on every target,
so a program that builds for one has been type-checked for all. The match
must handle every member, or say `else`, as any match on an enum must.

They are constants: nothing may assign to them or take their address. Read
anywhere else -- `if (ABI == Abi.Musl)` -- one is an ordinary value, and both
branches are compiled.

Two builtins reach wasm32's memory, for an allocator to be built on, as
`std/heap`'s is: `wasmMemorySize()`, its size in 64 KiB pages, and
`wasmMemoryGrow(pages)`, which adds pages and returns how many there were,
or -1. On any other target there is no such memory, so the size is 0 and
growing fails -- they belong in an arm of `match (ARCH)` that wasm32 picks.

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

