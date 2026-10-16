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

None known.

Four were recorded here and have since been fixed: a nested block overwriting
the outer variable of the same name, `==` and `<` on two structs tripping an
LLVM assertion, a function declared inside another emitting invalid IR, and a
missing input file reported as a missing `main`. Each is now pinned by the
regression suite, so a recurrence fails a check rather than reaching a user.

Two further latent bugs turned up while fixing those and are also closed: a
`let` bound its name before its initialiser was generated, so `let x = x + 1;`
in an inner block would have read its own uninitialised slot once scoping
existed; and the old `print` statement promoted anything whose kind was `i8` — including `*i8` —
through `ptrtoint`, truncating every printed string to 32 bits. That one only
worked because the constants sat below 4GB.

## 2. Missing operators

Remainder, the bitwise operators, the shifts, compound assignment and unary
plus were added and are exercised by `examples/operators.ode`. What is left:

| Missing | Example | Notes |
|---|---|---|

Two notes on what did land. There is no `&=`, `|=`, `^=`, `<<=` or `>>=`: the
lexer only ever tries two characters when matching an operator, so a
three-character one needs a change there first. And compound assignment
desugars in the parser to `a = a op b`, which puts the target into the tree
twice, so a side effect in the target — `a[next()] += 1` — runs twice.

## 3. Missing types

| Missing | Notes |
|---|---|
| Fixed-size arrays (`[i8; 256]`) | Deliberate — see 6.1 |
| Tagged unions (enums with data) | Deliberate — see 6.2 |

The numeric set itself is complete: `i8`/`u8`, `i16`/`u16`, `i32`/`u32` and
`i64`/`u64` (spelled `usize` too), plus `f32` and `f64`.


## 4. Type system

Four entries here were closed: a literal now takes the type its context
expects, `.` follows any number of pointers, globals can be built from
earlier globals and constant arithmetic, and a function that returns a value
must return on every path. That last was once deliberate — falling off the
end yielded a zero — until errors as values made the zero of `i32 | SomeError`
read as success; it is now a compile error. What is left:

### 4.1 No implicit conversions between variables

**Deliberate.** A literal, a character or a `sizeof` takes whatever numeric
type is expected of it — the declared type, the parameter, the field, the
return type, or the other operand — so none of these needs a cast:

```rust
let small: i16 = -12;
let total: i64 = count64 * 2 + 1;
let digit: i32 = '0' + offset;
let bytes: *i8 = malloc(sizeof(Node) * 4);
```

A value that already has a type never changes it silently, though: an `i32`
variable used where an `i64` is wanted still needs `as i64`. With nothing to
go by — `(2147483647 + 1) as i64`, say — a literal is `i32`, and the
arithmetic wraps there before the cast.

### 4.2 A constant global folds integers only

```rust
let RATE: f64 = 2.5;
let DOUBLE: f64 = RATE * 2.0;   // error: initialiser of global 'DOUBLE' is
                                // not constant
```

An integer global may be any arithmetic on literals, `sizeof`, enum members
and globals declared before it, worked out at compile time. A global of any
other type may only be a literal or an earlier global. And a global is never
made from one declared after it, which also rules out two made of each other.

## 5. Diagnostics

### 5.1 Errors are batched within a phase, but not across phases

Both the parser and the analyzer recover and keep going, so a file with three
type errors reports all three in one run:

```
main.ode:4:3: error: type mismatch in declaration of 'a': declared as 'bool' but assigned 'i32'
main.ode:11:3: error: if condition must be boolean: got 'i32'
main.ode:15:3: error: while condition must be boolean: got 'i32'
3 errors generated.
```

Recovery is per statement. The parser discards tokens up to the next `;` or the
start of the next statement, stepping over a whole `{ ... }` body rather than
descending into one, so a malformed function header costs its body instead of
producing a second round of errors from inside it. The analyzer catches at the
same granularity, putting back any scope the abandoned statement left open. A
`let` whose initialiser failed still binds its name to the declared type, so
the statements below it do not report an invented "undefined variable".

Past 20 errors the list stops being useful, so it is truncated and the summary
says so: `47 errors generated, showing the first 20.`

What is left:

- **Syntax and type errors do not appear together.** A tree with a hole in it
  says nothing trustworthy about types, so when the parser reports anything the
  compiler stops before the analyzer runs. Fixing the syntax and recompiling is
  what surfaces the type errors.
- **The lexer does not recover.** An unterminated string or a bad character
  literal is still reported on its own.
- **Codegen does not recover**, but by then everything user-facing has already
  been checked.

### 5.2 Some diagnostics have no position

- Errors raised by the IR generator. They are internal invariants, with
  nothing in the source to point at.
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

### 6.1 No fixed-size array types

An array is a pointer plus indexing: `malloc` for the storage, `a[i]` to reach
it. A real array type would add a second axis to `Type` for one bootstrap
convenience.

### 6.2 Enums carry no data

`enum` and `match` exist, but an enum member is only a name for an integer:
there are no Rust-style variants carrying fields. A kind tag -- now an enum --
plus one struct holding every variant's fields stands in, as
`examples/expr_tree.ode` shows. Wasteful in memory, and exactly what a C
bootstrap compiler does.

### 6.3 Structs cannot cross `extern` by value

```
error: extern 'f' takes a struct by value: take a pointer instead
```

Passing an aggregate across the C ABI needs target-specific lowering — `sret`,
`byval`, register pairs — that this compiler does not implement. Emitting a
plain LLVM aggregate would produce calls that disagree with the C side.
Struct-by-value between two Ode functions is fine.

### 6.4 Modules are named imports only

`import { a, b as c } from "./path";` and `export` on a declaration are all
there is. Missing, compared with TypeScript:

- no namespace import (`import * as m`) and so no qualified `m.name`;
- no re-export (`export { a } from "./b"`) and no default export;
- no bare specifiers or search path: every import is a file path, relative to
  the importing file unless it starts with `/`.

When two files declare the same name, the later one's IR name is qualified
with its file's stem. That name can surface in a diagnostic about types, where
a private `struct Pair` in `counter.ode` prints as `counter.Pair`. A private
function is still an ordinary external symbol in the object file rather than
`internal`.

The lexer stops the compile at its first error, so a lexical error in an
imported file ends the run there, before any other file's diagnostics.

### 6.5 Methods are only for structs, and have no interfaces

A method is a function written inside a struct, and that is all a method can
be:

- methods cannot be added to a struct from outside its declaration (Rust's
  separate `impl`, or Go declaring them anywhere in the package), nor to a
  type that is not a struct;
- there are no interfaces or traits, so a generic cannot require "anything
  with a `len()`" -- it is checked per instance instead, and an instance whose
  type lacks one fails there;
- every method is visible wherever its struct is: there is no `pub`, and no
  private helper method.

### 6.6 Generics are written out and checked per instance

- Type arguments are always written: `max<i64>(a, b)`, never `max(a, b)`.
- There are no constraints on a type parameter, so a generic's body is only
  checked once it has arguments, and an error in it is reported for each
  instance it shows up in.
- A method cannot take type parameters of its own, beyond its struct's.
- A function type cannot be a type argument yet, and a type parameter cannot
  be used as a struct's name in an expression (`T.new()`).
- Each instance is compiled separately, so a generic used with many types
  makes the binary bigger accordingly.

### 6.7 Tests are plain, and need a POSIX system

A test has a name and a body, and nothing else: no setup or teardown, no
parameters, no skipping, and no matchers beyond `assert` and `assertEq`.
Each test runs in a child made with `fork`, so `ode test` runs on macOS and
Linux but not Windows.

### 6.8 The standard library is small

`std/` has memory, a list, text, terminal I/O and whole files -- what the
examples and tests needed first. There is no map or set, no formatting
beyond `printf`, no time, and no processes beyond `exit`. A function that
can fail returns an error -- `parseInt` a `ParseError`, the file functions a
`FileError` -- and one that must not -- an index out of range, running out
of memory -- stops the program. A test cannot say that it expects to stop; such a test lives in
`tests/runner/`, where its recorded failure is what is checked.

### 6.9 Errors: what the first version leaves out

- `catch (e)` takes a union of one error enum; with several, keep the value
  and tell them apart with `is`.
- `is` narrows a local variable, in the branches of the `if` it is the
  condition of, and after that `if` when its first branch always leaves; it
  does not narrow a field, a global, or through `&&`.
- A function type cannot return a union yet, so a function that can fail is
  not a value of any `fn(...)` type.
- An error carries no data: it says what went wrong, not with what. Enums
  with data would be the way to add it.

## 7. Codegen and runtime

### 7.1 No runtime checks

Division by zero produces garbage rather than a diagnostic or a trap:

```rust
let z: i32 = 0;
printf("%d\n", 10 / z);  // prints an arbitrary value
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

### 7.5 No unicode escapes

Strings and characters take `\n`, `\t`, `\r`, `\0`, `\\`, `\"`, `\'` and
`\xNN`, and a backtick string spans lines with no escapes at all. There is no
`\u{...}`: text is bytes, and a character outside ASCII is written as the
bytes that encode it.

## 8. Tooling

### 8.1 A test cannot expect to fail

Tests are written beside the code they test and run in-process, and a check
reports a Problem rather than a sentence, so tests do not depend on how
anything is worded. What a test cannot say is that the code under it should
stop the program -- an index out of range, a failed assert -- since that
ends the test; such cases live in `tests/runner/`, where a recorded failure
is what is checked.

The compiler is self-hosting, so `ode build bootstrap` is the other half of
the check: a compiler that miscompiles itself stops reproducing itself, and
the fixed-point comparison catches that even when every test still passes.

### 8.2 Assembling and linking shell out to `clang`

The compiler emits textual LLVM IR and then runs `clang` twice -- once to
assemble the `.ll` into a `.o`, once to link it -- so `clang`, or the compiler
`ODE_CC` names, must be on `PATH`. Both runs go through `fork` and `execvp` rather than a shell, so a
path holding a space or a metacharacter needs no quoting and cannot be
re-split or executed. What is left is that the compiler has no backend of its
own: it depends on `clang` to turn IR into a binary.

### 8.3 Intermediates pass through the filesystem

`ode file.ode` leaves only the executable, `<stem>`, or `<path>` with `-o`;
`--keep-intermediates` keeps the `<path>.ll` and `<path>.o` it was built from
beside it. Either way the two are written to disk on the way, because clang
is handed files, so a build always touches the filesystem beyond its output.
`--emit-llvm` prints the IR without building anything.
