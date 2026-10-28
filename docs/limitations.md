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
`i64`/`u64`, plus `f32` and `f64`, and `isize`/`usize`, as wide as a pointer.


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
arithmetic overflows there before the cast: a debug build stops, and a
release one wraps. Widen first: `2147483647 as i64 + 1`.

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

### 6.2 Enums carry no data; unions do that

An enum member is only a name for an integer. Data that is one of several
shapes is a union of structs instead -- `type Shape = Circle | Rect` -- told
apart with `is` or `match`. Both narrow a variable or a field path
(`node.kind is Call`), through `!` as well, but not an element (`list.at(0)`, `items[i]`) or a
call's result -- copy it into a variable first. A write through another
pointer to the same field is not seen, so a narrowed field changed by a
function it is passed to keeps its narrowing. And an arm names whole members:
one error of an error enum is told apart by a match on the enum inside it.

### 6.3 Structs cross `extern` by value only one way

A struct passes to and comes back from an `extern` by value as C passes it
on the target -- arm64's float aggregates and 16-byte rule, x86-64's 8-byte
parts, wasm32's `byval` and `sret` (`compiler/codegen/abi.ode`). What is
left out:

- **C calling Ode.** A function value handed to C, as a callback, is called
  by C's rules, but an Ode function taking or returning a struct by value
  keeps Ode's own; nothing checks the two agree. A callback takes pointers.
- **A struct holding a union**, whose layout C does not share, and a struct
  through a variadic extern's `...`, for which C has no rule:

  ```
  error: extern 'f' takes a struct C cannot take by value
  ```
- **Running out of registers.** A struct is lowered alone, as if it had the
  registers to itself; when earlier arguments have used them up, C's rule
  for where it then goes is LLVM's, which agrees for the cases tested
  (`tests/abi/`) but is not checked against clang argument by argument.

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

`std/` has memory, a list, a map, text, terminal I/O, whole files and an HTTP/1.1
server -- what the examples, the tests and the first programs needed. There
is no set, no time, no HTTP client,
and no processes beyond `exit` (the server forks, but keeps that to itself). A function that
can fail returns an error -- `parseInt` a `ParseError`, the file functions a
`FileError` -- and one that must not -- an index out of range, running out
of memory -- stops the program. A test cannot say that it expects to stop; such a test lives in
`tests/runner/`, where its recorded failure is what is checked.

### 6.9 Errors: what the first version leaves out

- `catch (e)` takes a union of one error enum; with several, keep the value
  and tell them apart with `is`.
- `is` narrows in the branches of the `if` it is the condition of -- through
  `!`, `&&` and `||` too -- and after that `if` when its first branch always
  leaves. It does not narrow across a loop's condition, `while (x is A)`.
- An error carries no data: it says what went wrong, not with what. A union
  can return a struct alongside the errors -- `Config | ParseFailure |
  IoError` -- when the details matter.

### 6.10 Lambdas capture nothing

A lambda may use its parameters, globals and functions, not the locals of
the function it is written in. Its value stays one pointer to code -- no
allocation, nothing to free, and C can call it -- and what it needs is
passed in. State that has to travel with a function goes in a parameter:
`each(list, context, (context, item) => ...)`.

## 7. Codegen and runtime

### 7.1 Runtime checks, without --release only

A build without `--release` stops at a division by zero, an overflow of a
signed integer's `+`, `-` or `*`, and a null pointer read or written
through -- `p.field`, `*p`, `p[i]` -- saying where:

```
main.ode:12:14: integer overflow
```

What it does not check:

- **Bounds.** A pointer has no length to check an index against; `List`
  checks its own, and a string read past its NUL reads on.
- **Unsigned arithmetic** wraps, as in C and Go, and so does `-x` of a
  signed integer's smallest value.
- **A release build** checks none of it: a signed overflow wraps there and a
  division by zero is whatever the machine does.

The checks cost: the compiler, built without `--release`, takes about half
as long again to compile itself with them as without.

### 7.2 Identical string literals are not shared

Every string literal creates its own private global, so the same text written
twice is stored twice. Irrelevant at current scale.

### 7.3 Two optimisation levels

A build is unoptimised, or with `--release` -- on `ode`, `ode test` and `ode
build`, and as an artifact's `.release` -- optimised by clang at `-O2`.
There is nothing between or beyond: no `-O1`, `-O3` or size-first `-Os`, no
LTO across what a program links, and no LLVM pass pipeline of its own. A
release build also leaves out the checks at run time (7.1).

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
`ODE_CC` names, must be on `PATH`. Both runs go through `fork` and `execvp`
rather than a shell, so a path holding a space or a metacharacter needs no
quoting and cannot be re-split or executed. What is left is that the compiler
has no backend of its own: it depends on `clang` to turn IR into a binary,
and on LLVM's tools for the targets below -- `ld.lld` and `llvm-ar` for
Linux, `wasm-ld` for wasm32.

### 8.3 Targets

`--target` takes 64-bit x86 and ARM on macOS and Linux, and freestanding
wasm32. Each is spelled out, with its triple and its pointer size, in
`compiler/codegen/target.ode`; anything else is rejected rather than handed
to clang to guess at.

- **No Windows**, and no 32-bit target but wasm32. Windows would need its
  own linking and its own C library, and `ode test` needs `fork` (6.7).
- **Linux means musl, linked statically.** Ode bundles musl and builds it the
  first time a program is built for a target, which takes about twenty
  seconds and needs `sh`, `make`, `tar`, `llvm-ar` and `ld.lld`. A static
  program cannot load shared libraries, so `-l` on a musl target links only
  `.a` archives. glibc is not bundled: a `-gnu` target needs the target's
  own `--sysroot`, and without one stops at `--emit-object`.
- **The cache is never cleaned.** Each musl build stays in
  `~/.cache/ode/libc/` (or `$ODE_CACHE`) until it is deleted by hand; a new
  musl version builds beside the old one.
- **Tests for another machine need something to run them.** wasm32's run in
  Node, which must be on `PATH`. Any other target's need `--runner` -- an
  emulator such as `qemu-aarch64`, or a script that runs the program in a
  container -- which Ode does not provide or find by itself, as Zig's
  `-fqemu` does. `ode build run` has no runner at all: a foreign executable
  fails to start.
- **A wasm32 test is told less.** An `assertEq` that fails says where, not
  its two values, and a test that calls into the host -- `std/io`, `std/fs`
  -- fails, since the runner provides only the panic handler.
- **Only code differs per target, not declarations.** A `match` on
  `std/target` picks code while compiling, but a struct, a global or an
  `extern` cannot be declared differently per target, so a C struct whose
  layout differs -- `termios`, `stat` -- is still written for one target.
  And `isize` is a name for `i64` on 64-bit targets rather than a type of
  its own, so mixing the two is caught only by building for wasm32.
- **The compiler itself cannot branch on the OS.** `bootstrap/ode.ll` is one
  file for every 64-bit machine, so the compiler's own sources, and the parts
  of std they use, must not `match (OS)`: the seed would bake in the OS it
  was written on. They ask at run time instead, as the toolchain does with
  `xcrun`. Telling wasm32 from the rest, as `std/heap` does, is safe, since
  the seed is never wasm32.

### 8.4 WebAssembly

`--target wasm32` builds a module for a host to instantiate, not a program
to run:

- **No C library and no WASI.** A module reaches the world only through the
  imports its host provides, one per `extern`. `std/mem`, `std/list` and
  `std/text` need nothing from it, being Ode's own on wasm32; `std/io`,
  `std/fs` and `std/c` are C's, and a module that uses them needs the host
  to provide those functions, with C's wasm32 signatures.
- **The wasm32 heap is simple.** Blocks are powers of two, so up to half of
  one is unused; freed blocks are reused but memory is never handed back to
  the host; and nothing is safe across threads, which a module does not
  have.
- **No entry point.** A `main` is exported like any other function, but
  nothing calls it.
- **What crosses to the host is numbers.** A string is an address in the
  exported `memory`, read out by the host; an `i64` reaches JavaScript as a
  `BigInt`; a struct crosses only into and out of an `extern` (6.3).
- **A failed check says little.** It traps, and the host gets a
  `RuntimeError` from the call. A program that declares `extern fn
  panic(where: *i8, message: *i8): void` is handed where it failed and an
  `assert`'s message first; an `assertEq`'s two values are not shown, as
  there is nothing on wasm32 to format them with.
- **It needs a clang with the WebAssembly backend**, which Apple's does not
  have: on macOS, Homebrew's LLVM, with `wasm-ld` from its lld.

### 8.5 `build.ode`

A build file records what to build, and the compiler carries it out (see
[Building a project](build.md)). The first version leaves out:

- **Parallelism.** Artifacts are built one after another, and so are a
  step's commands.
- **Dependencies between steps.** A step runs its own commands only; it
  cannot ask for another step first. A command's program, and any artifact
  whose output it is handed, are built before it, which covers most of it.
- **The compiler in the up-to-date check.** An executable is rebuilt when
  its sources, flags or C toolchain change, not when the `ode` building it
  does, so after changing compilers `--force` rebuilds what was built by the
  old one.
- **Typed options.** `-D` values are text, read with `b.option` and
  `b.flag`; there is no list of the options a build file takes, and `ode
  build --help` lists its steps but not those.
- **Installing, and packages.** There is no install step or prefix, and no
  way to depend on another project's `build.ode`: a library is used by its
  path, or by `-L` and `-l`.

### 8.6 Intermediates pass through the filesystem

`ode file.ode` leaves only the executable, `<stem>`, or `<path>` with `-o`;
for wasm32 the module is `<stem>.wasm`. `--keep-intermediates` keeps the
`<path>.ll` and `<path>.o` it was built from beside it. Either way the two are
written to disk on the way, because clang is handed files, so a build always
touches the filesystem beyond its output. `--emit-llvm` prints the IR without
building anything, and `--emit-object` stops at `<path>.o`.

### 8.7 The language server

`ode lsp` checks a file the way `ode test` would, each time it changes, and
answers from that. What it leaves out:

- **Whole files.** The editor sends all of a file on each change, and every
  answer checks the file again, with what it imports -- about half a second
  for a file that pulls in most of the compiler, and less for most.
- **A file at a time.** It shows the problems in the file being edited, and
  a problem in a file it imports on the import; it does not check the rest of
  a project.
- **A file that does not parse** gets its syntax errors, but a hover, a
  definition or member completion needs it to parse first, since the checker
  does not run on a tree with holes in it. Completing a name still offers
  the file's declarations and the keywords.
- **Four answers.** Problems, hovers, definitions and completion; no
  references, renaming, formatting, signature help or symbols.
