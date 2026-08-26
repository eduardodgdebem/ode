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

These produce a crash, invalid IR, or a silently wrong result. They are bugs
rather than missing features.

### 1.1 A variable in a nested block overwrites the outer one

**Severity: high — silently wrong output, no diagnostic.**

```rust
fn main(): i32 {
  let x: i32 = 1;
  {
    let x: i32 = 99;
    print(x);
  }
  print(x);      // prints 99, should print 1
  return 0;
}
```

Prints `99 99`.

The semantic analyzer scopes correctly — `SymbolTable` pushes and pops a scope
per block — but `IRGenerator::allocaMap_` is a flat `name -> alloca` map reset
only per function. The inner `let` overwrites the outer entry and never
restores it, so every later read of `x` finds the inner slot.

Parameters are affected too, and there the corruption outlives the block that
caused it:

```rust
fn f(x: i32): i32 {
  {
    let x: i32 = 99;
  }
  return x;      // returns 99, should return 1
}
```

This is the most dangerous entry in this document, because nothing reports it
and the wrong value looks entirely plausible.

*Fix:* scope `allocaMap_` the way `SymbolTable` is scoped, or rename to unique
slots during analysis.

### 1.2 Comparing structs with `==` crashes the compiler

**Severity: high — assertion failure, not a diagnostic.**

```rust
struct P { x: i32, }

fn main(): i32 {
  let a: P = P { x: 1 };
  let b: P = P { x: 1 };
  print(a == b);
  return 0;
}
```

```
Assertion failed: (... && "Invalid operand types for ICmp instruction"),
function AssertOK, file Instructions.h, line 1187.
```

`checkBinaryOp` allows `==` and `!=` whenever both sides have the same type,
which includes structs, and codegen then hands an aggregate to `CreateICmpEQ`.

*Fix:* reject struct operands in the equality case in `checkBinaryOp`. Deep
comparison would be a separate feature.

### 1.3 A function declared inside another function emits invalid IR

**Severity: medium — caught by the verifier, so it fails loudly.**

```rust
fn main(): i32 {
  fn helper(): i32 { return 7; }
  print(helper());
  return 0;
}
```

```
Basic Block in function 'main' does not have terminator!
```

`parseStatement` accepts `fn` anywhere a statement is allowed, and the analyzer
handles it, but codegen emits the nested function's body while the builder is
still positioned inside the enclosing function.

Nested functions are not needed for self-hosting. The honest fix is to reject
`fn` outside the top level in the parser rather than to make it work.

### 1.4 A missing input file reports the wrong error

**Severity: low — misleading message.**

```
$ ode /tmp/does-not-exist.ode
/tmp/does-not-exist.ode: error: No main function found
```

`Reader::readAll` returns an empty string when the file could not be opened,
so the pipeline compiles an empty program and fails much later. It should fail
in the reader.

---

## 2. Missing operators

None of these parse. Each is a plain parser and codegen addition.

| Missing | Example | Notes |
|---|---|---|
| Remainder | `a % b` | Needed for hashing and base conversion; `srem` / `urem` in LLVM |
| Bitwise and/or/xor | `a & b`, `a \| b`, `a ^ b` | `&` is address-of and `&&` is logical, so the single-character forms are free |
| Shifts | `a << b`, `a >> b` | |
| Compound assignment | `a += 1` | Pure sugar over `a = a + 1` |
| Unary plus | `+5` | Sugar |
| `for` loops | `for (...) { }` | `while` covers it |

Of these, **remainder and the bitwise operators are the ones a self-hosted
compiler will actually miss** — a keyword hash table wants both.

## 3. Missing types

| Missing | Notes |
|---|---|
| `f64` | Only `f32` exists |
| `u32`, `i16`, `u16` | The integer set is `i8`, `u8`, `i32`, `i64`, `u64`/`usize` |
| Function pointers | No function type exists, so dispatch tables have to be `if`/`else if` chains |
| Fixed-size arrays (`[i8; 256]`) | Deliberate — see 6.2 |
| Tagged unions | Deliberate — see 6.3 |

Function pointers are the significant one. Without them, a table-driven parser
is not expressible and dispatch stays as chained conditionals.

## 4. Type system

### 4.1 Integer literals are always `i32`, checked before any cast

```rust
let big: i64 = 3000000000 as i64;
```

```
error: number is out of range for i32: use an explicit cast such as `... as i64`
```

`checkNumberLiteral` rejects the literal before `checkCast` ever sees the
target type, so a value that only fits in `i64` cannot be written at all. The
workaround is arithmetic: `1500000000 as i64 * 2 as i64`.

*Fix:* give the literal the cast's target type when it is immediately cast, or
type literals from context generally.

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
