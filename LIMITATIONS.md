# Known limitations

Everything here was reproduced against the compiler at the time of writing.
Each entry says how to trigger it and what happens.

The list is ordered by how much it hurts, not by how hard it is to fix.
Section 1 holds outright defects — a crash or a wrong answer. Everything after
it is a feature that does not exist yet, or a deliberate decision.

**Not limitations**, though they are easy to assume: `main` can take
`(argc: i32, argv: **i8)` and read them, and file I/O works through `extern`
declarations of `fopen` / `fgetc` / `fclose`. Both are verified.

---

## 1. Defects

None known. The four that were recorded here — a nested block overwriting the
outer variable of the same name, `==` on two structs tripping an LLVM
assertion, a function declared inside another emitting invalid IR, and a
missing input file reported as a missing `main` — have been fixed. What
follows is what they turned into.

### 1.1 Shadowing works (fixed)

A `let` in a nested block declares a new variable and leaves the outer one of
the same name alone, including when the outer one is a parameter:

```rust
fn main(): i32 {
  let x: i32 = 1;
  {
    let x: i32 = 99;
    print(x);    // 99
  }
  print(x);      // 1
  return 0;
}
```

`IRGenerator` now keeps a stack of `name -> alloca` maps, pushed and popped
per block, mirroring the analyzer's `SymbolTable`. The allocas themselves are
still created in the function's entry block; only the binding is scoped. A
declaration binds its name after its initialiser is generated, so
`let x: i32 = x + 1;` in an inner block reads the outer `x`, which is what the
analyzer type-checked it against. `examples/shadowing.ode` covers it.

### 1.2 Comparing structs is rejected (fixed)

```rust
print(a == b);   // error: cannot compare struct 'P' values: compare their fields instead
print(a < b);    // error: cannot order struct 'P' values: compare their fields instead
```

`checkBinaryOp` rejects struct operands in both the equality and the
relational case rather than handing an aggregate to `CreateICmpEQ`. Field-wise
comparison remains a separate feature that does not exist; compare the fields
by hand.

### 1.3 `fn`, `extern` and `struct` are top-level only (fixed)

```rust
fn main(): i32 {
  fn helper(): i32 { return 7; }   // error: 'fn' declarations are only allowed
  return 0;                        //        at the top level of the program
}
```

The parser rejects all three anywhere but the top level of the program, which
is honest about what codegen can emit. Nested functions are still not a
feature and are not planned.

### 1.4 A missing input file is reported by the reader (fixed)

```
$ ode /tmp/does-not-exist.ode
/tmp/does-not-exist.ode: error: cannot open file
```

`Reader::readAll` throws instead of returning an empty string, so the failure
is reported where it happens rather than as a missing `main` much later.

---

## 2. Missing operators

Remainder, the bitwise operators, the shifts, compound assignment and unary
plus were added and are exercised by `examples/operators.ode`. What is left:

| Missing | Example | Notes |
|---|---|---|
| `for` loops | `for (...) { }` | `while` covers it |

Two notes on what did land. There is no `&=`, `|=`, `^=`, `<<=` or `>>=`: the
lexer only ever tries two characters when matching an operator, so a
three-character one needs a change there first. And compound assignment
desugars in the parser to `a = a op b`, which puts the target into the tree
twice, so a side effect in the target — `a[next()] += 1` — runs twice.

## 3. Missing types

| Missing | Notes |
|---|---|
| Function pointers | No function type exists, so dispatch tables have to be `if`/`else if` chains |
| Fixed-size arrays (`[i8; 256]`) | Deliberate — see 6.2 |
| Tagged unions | Deliberate — see 6.3 |

The numeric set itself is complete: `i8`/`u8`, `i16`/`u16`, `i32`/`u32` and
`i64`/`u64` (spelled `usize` too), plus `f32` and `f64`.

Function pointers are the significant one. Without them, a table-driven parser
is not expressible and dispatch stays as chained conditionals.

## 4. Type system

### 4.1 A literal takes a wider type only from a cast written directly on it

Literals are `i32`, or `f32` when they contain a `.`. A literal written as the
direct operand of a cast takes the target's type when `i32` cannot hold the
value, so a wide constant can be written as itself:

```rust
let big: i64 = 3000000000 as i64;
let all: u64 = 18446744073709551615 as u64;
```

A value that does fit `i32` keeps it, so a narrowing cast still truncates:
`300 as i8` is 44, not an out-of-range literal.

Two shapes are still rejected, because in neither is the literal the cast's
operand:

```rust
let big: i64 = -3000000000 as i64;  // `as` binds looser than unary minus, so
                                    // the operand is the negation, not the 3e9
let f: f64 = 3000000000 as f64;     // the target is not an integer type, so
                                    // the literal falls back to i32
```

Both have a direct workaround — `-(3000000000 as i64)` and
`3000000000 as i64 as f64` — so this is a wart rather than a wall.

*Fix:* look through a negation in `checkCastOperand`, and type literals from
context generally rather than only under a cast.

### 4.2 No implicit conversions

**Deliberate.** Every width change needs `as`, so `let n: i64 = 0;` is an
error and `let n: i64 = 0 as i64;` is required. Explicit, but verbose in
arithmetic-heavy code.

### 4.3 `.` follows exactly one level of pointer

`node.field` works when `node` is a struct or a `*Struct`. A `**Struct`
requires `(*node).field`:

```
error: cannot read field 'x': '**P' is not a struct
```

### 4.4 Globals must be initialised from constants

```rust
let A: i32 = 1;
let B: i32 = A;   // error: initialiser of global 'B' is not constant
```

Only literals, `sizeof`, and casts or negations of those. Global initialisers
become LLVM constant initialisers, so anything computed has to be assigned from
an `init()` function at start-up.

### 4.5 No all-paths-return analysis

**Deliberate.** Falling off the end of a non-void function is allowed and
yields a zero value. Several examples rely on it, including `main` in
`example2` through `example5`.

### 4.6 `print` does not accept structs

```
error: unsupported type for print statement
```

`print` handles integers, floats, booleans and pointers only. This diagnostic
also carries no line or column — see 5.2.

## 5. Diagnostics

### 5.1 Only the first error is reported

There is no error recovery. The compiler stops at the first problem, so a file
with three type errors requires three compile-and-fix cycles.

This is the biggest ergonomic gap for self-hosting work, and the largest change
on this page: it needs synchronising recovery points in the parser and
non-fatal diagnostics through the analyzer.

### 5.2 Some diagnostics have no position

- Errors raised by the IR generator, including `print` of an unsupported type.
  Most are internal invariants with nothing in the source to point at, but
  `print` is user-facing.
- `rejectStructCycles`, which works over collected layouts rather than
  declarations.
- `validateType` reports at the enclosing declaration rather than at the type
  name, so `let b: Missing = 2;` points at the `let` rather than at `Missing`.
  The line is right; the column is off.

### 5.3 No warnings

There is no diagnostic short of a hard error — no unused variable, no
unreachable code, no implicit truncation notice.

## 6. Deliberate omissions

Choices, not oversights. Each has a reason and a workaround.

### 6.1 No variadic `extern`

`extern fn printf(fmt: *i8, ...): i32;` cannot be written; every declaration is
fixed-arity. Nothing self-hosting needs is variadic — `malloc`, `fopen`,
`fread`, `write`, `strlen`, `exit` are all fixed — and the built-in `print`
covers debugging output.

### 6.2 No fixed-size array types

An array is a pointer plus indexing: `malloc` for the storage, `a[i]` to reach
it. A real array type would add a second axis to `Type` for one bootstrap
convenience.

### 6.3 No sum types

A kind tag plus one struct holding every variant's fields stands in, as
`examples/expr_tree.ode` shows. Wasteful in memory, and exactly what a C
bootstrap compiler does.

### 6.4 Structs cannot cross `extern` by value

```
error: extern 'f' takes a struct by value: take a pointer instead
```

Passing an aggregate across the C ABI needs target-specific lowering — `sret`,
`byval`, register pairs — that this compiler does not implement. Emitting a
plain LLVM aggregate would produce calls that disagree with the C side.
Struct-by-value between two Ode functions is fine.

### 6.5 No modules

The whole program is one file. The self-hosted compiler is expected to be a
single file of roughly 4,000–5,000 lines, which is unpleasant but workable.

## 7. Codegen and runtime

### 7.1 No runtime checks

Division by zero produces garbage rather than a diagnostic or a trap:

```rust
let z: i32 = 0;
print(10 / z);     // prints an arbitrary value
```

There are also no bounds checks on indexing, no null checks on dereference,
and no integer overflow detection. `example6` relies on the last of these —
`fib(47)` overflows `i32` and prints a negative number.

### 7.2 Identical string literals are not shared

Every string literal creates its own private global, so the same text written
twice is stored twice. Irrelevant at current scale.

### 7.3 No optimisation control

The target machine is always built at `CodeGenOptLevel::Default` and there is
no flag to change it, no `-O` equivalent, and no LLVM pass pipeline beyond what
that implies.

### 7.4 Only `//` comments

No block comments, no nesting.

### 7.5 Limited string escapes

`\n`, `\t`, `\r`, `\0`, `\\`, `\"` and `\'`. No `\xNN`, no unicode escapes, and
no multi-line string literals — a string may not cross a newline.

## 8. Tooling

### 8.1 No test suite

`examples/` is checked by running it and reading the output. There is no
harness, no expected-output files, and no `ctest` target, so a regression is
only caught if someone looks.

This is the gap most likely to hurt during the self-hosting port, where the
compilers need to be diffed against each other continuously.

### 8.2 Linking shells out to `clang++`

`Linker::link` builds a `clang++` command and calls `std::system`, so `clang++`
must be on `PATH`, and the object path is interpolated into a shell command
without quoting.

### 8.3 Output paths are not configurable

The compiler always writes `<stem>.ll`, `<stem>.o` and `<stem>` next to the
working directory. There is no `-o`, and the `.ll` and `.o` files are always
left behind.
