# Field report: porting vimdo to Ode

A real program written in Ode, and what got in its way. The program is
odedo, in `~/Projects/swift/odedo` (outside this repository); file
references below such as `core/app.ode:271` are under its `src/`. The
entries complement [limitations.md](limitations.md): some repeat what is
listed there as deliberate, and say what it cost in practice.

odedo is about 4,000 lines of Ode (tests included), ported from vimdo's
1,700 lines of Rust. It covers a vim state machine, a JSON parser and
writer, a native window drawn through raylib, a terminal front end, process
spawning, and 23 tests, among them every one of vimdo's key-sequence tests.
Everything below was hit while writing it, and each claim was checked
against `build/ode` at commit `b7a0efc`.

They are ordered by how much they cost in this program, most first.

---

## 0. Calling a C GUI library

vimdo is an egui window, so odedo's window goes through raylib, a C library.
This cost more than everything else below put together.

### 0.1 Structs cannot cross `extern`, and GUI APIs are made of them

raylib passes `Color`, `Vector2`, `Rectangle`, `Font`, `Image` and `Texture`
by value nearly everywhere. Ode refuses all of them (*"extern 'f' takes a
struct by value"*), so `gui/raylib.ode` declares every binding the way
Apple's arm64 ABI happens to pass it:

| C | Declared in Ode as | Why it works |
|---|---|---|
| `Color` (4 bytes) | `u32`, red in the low byte | a small struct goes in one integer register |
| `Vector2`, `Rectangle` | 2 or 4 separate `f32` | all-float structs go in float registers, one each |
| `Font`, `Image` argument | `*Font`, `*Image` | anything over 16 bytes is passed as a pointer to a copy |
| `Vector2` result | `f32` | its x half comes back in the first float register |

This holds only on arm64. On x86-64 every row is different, and the
compiler cannot check any of it.

**Returning** a big struct is impossible. The caller has to pass a hidden
result pointer in a register (`x8`) that Ode code cannot set. That rules
out `LoadFontEx`, `GenImageFontAtlas`, `LoadTextureFromImage`,
`MeasureTextEx` and `GetFontDefault`. So `gui/raylib.ode` `loadFont`
rebuilds font loading by hand in about 90 lines: rasterize with
`LoadFontData` (which returns a pointer), pack the atlas itself, upload it
with `rlLoadTexture` (which returns a `u32`), and fill in raylib's `Font`
struct in Ode memory. Text measuring became "the font is monospaced, count
the characters".

**Suggestion:** lower structs across `extern` for arm64 and x86-64 SysV.
Classifying a struct (all-float, small integer, or memory) is about a
hundred lines per target, and it opens up every C library written since
the 90s. It is worth doing before anything else on this list for anyone
writing GUI or game code. Until then, an error that names the workaround
(*"pass a pointer; a 4-byte struct can be declared as u32 on arm64"*) would
save real time.

### 0.2 `ode` cannot link a library

There is no `-l`, `-L` or `-framework` option, and no way to say it in the
source. `build.sh` asks for `--emit-llvm` and runs clang itself with
`libraylib.a` and six frameworks.

Tests have the same problem, worse: `ode test` builds and links each file, so
a file that imports the raylib bindings cannot be tested at all. The window
code lives in `src/gui/` for that reason alone, and `./build.sh test` skips
that directory.

**Suggestion:** a `link` declaration beside the externs that need it, which
both the build and the test runner honour:
`link "raylib"; link framework "Cocoa";`. Zig's `linkSystemLibrary` and
Rust's `#[link]` work the same way. A `--link` flag would be the cheap first
step.

### 0.3 Smaller costs of drawing code

- **A global cannot call a function**, so the color table cannot be
  `let BG: u32 = rgb(26, 27, 38);`. Each color is a function instead
  (`gui/draw.ode`).
- **`as f32` everywhere.** Positions are `f32` and counts are `i64`, so every
  "n characters times cell width" needs a cast.
- **No allocator to hand a Builder, and no `defer`**, so 60 frames a second
  would leak. Drawing uses a scratch buffer reset each frame and formats
  into it with `snprintf` (`Painter.take`).
- **No array literal.** `posix_spawn`'s `argv` is filled in one element at a
  time (`core/notify.ode`).
- **Strings carry no length.** One of my tests passed 14 for a 12-byte literal,
  and `decode` read past it into whatever constant came next. The test
  passed alone and failed only when built with the whole program. A string
  type with a length (a slice) would make that impossible; until then,
  nothing catches it.

## 1. Friction that showed up everywhere

### 1.1 A union with no error in it is treated as one that may fail

Two separate checks treat *any* union as if it held an error:

```rust
fn update(self: *Pomodoro, at: f64, running: bool): PomoEvent | Nothing { ... }

pomo.update(0.0, false);
// error: an error from this is ignored: 'Nothing | PomoEvent'
// note: pass it on with try, give a fallback with ??, or handle it with catch
```

None of the three suggestions works: `try` and `catch` reject a union with no
error enum (`catch takes one kind of error, not 'Nothing | i32'`), and `??`
is a type mismatch. The only way to call it for its effect is to bind the
result to a variable that is never used (`core/pomodoro.ode:147`).

`==` has the same problem: `a == b` on two `i64 | Nothing` says *"a value that
may be an error cannot be compared"* (`tui/main.ode:14`, `sameMoment`).

**Suggestion:** only require handling when the union really contains an
`error enum` member. Separately, add an explicit discard (`_ = expr;`).

### 1.2 No conditional expression, and `match` refuses `bool`

`let x = cond ? a : b` takes five lines every time. `tui/view.ode` alone does it
about a dozen times (colors, labels, `" (paused)"`). `match (flag) { true => ..., false => ... }`
is rejected with *"cannot match on 'bool'"*, so `core/storage.ode:107` has a
`boolText` helper just to print JSON.

**Suggestion:** allow `match` on `bool` (it is an enum of two, and exhaustive
checking already exists). An `if` expression would help more, but costs
more grammar.

### 1.3 No hex, octal or binary literals

| Where | Written as | Meant |
|---|---|---|
| `tui/view.ode:12` (14 colors) | `26 * 65536 + 27 * 256 + 38` | `0x1a1b26` |
| `core/editor.ode:11` | `& 192) == 128` | `& 0xC0) == 0x80` |
| `tui/term.ode:31` | `1074295912` | `0x40087468` (TIOCGWINSZ) |
| `core/storage.ode:42` | `493` | `0o755` |

The language has `&`, `|`, `<<` and `>>`, but no way to write the masks they
need. This is cheap (lexer only) and the most visible gap for systems code.

### 1.4 Bytes are signed

String bytes are `i8`, so `byte & 192` is *"number is out of range for 'i8'"*,
and spotting UTF-8 means testing `byte < 0` (`tui/term.ode:149`,
`core/editor.ode:96`). Every byte-level test needs a cast to `i32` and `& 255`
first (`tui/view.ode`, `cellsOf`).

**Suggestion:** either let a literal in a bitwise operation be read as a bit
pattern of the other side's width, or move strings to `*u8`, which would be
bigger.

### 1.5 Formatting means `alloc` + `snprintf`, by hand, every time

Ode functions cannot be variadic, so `snprintf` cannot be wrapped. Every
message in `core/app.ode` (deleted / yanked / pomodoro on / save failed) and every
clock in `tui/view.ode` is:

```rust
let text: *i8 = alloc<i8>(512);
snprintf(text, 512, "%lld task%s deleted", count, plural(count));
```

`Builder` covers strings and integers, but not floats or padding (`%02lld`).

**Suggestion, cheapest first:** `Builder.addFloat(value, digits)` and
`addPadded(value, width)`; or a compiler-known `format(...)` that lowers to
`snprintf` with a computed size; or interpolation in backtick strings, where
`${` is already reserved as an error.

## 2. Gaps that shaped the design

### 2.1 Option is a union with a home-made `Nothing`, and `??` does not work on it

`f64 | Nothing` works well as vimdo's `Option<f64>`, narrowing through
fields included (`self.startedAt is f64` and then arithmetic on it). But:

- every program declares its own `struct Nothing {}` and writes `Nothing {}`
  at each use;
- `c ?? 1` on an `i64 | Nothing` is a type mismatch, while it works for
  errors and pointers;
- two of them cannot be compared (1.1).

**Suggestion:** a built-in `none` (type and value). `??` would then mean "the
value, or this when it is `none` or an error".

### 2.2 No `match` on strings

`:w`, `:q`, `:add`, `:pomo on|off|skip|reset` become a 40-line `if`/`equals`
chain (`core/app.ode:565`). `assertEq` already compares strings by text, so the
rule exists in the compiler.

**Suggestion:** string-literal patterns in `match` on `*i8`, compared by text,
with `else` required.

### 2.3 Methods taking `*self` cannot be called on a temporary

```rust
loaded.store.tasks.at(1).isRunning();
// error: cannot call 'Task.isRunning' on a temporary value
```

There are two workarounds, and odedo uses both. Read-only methods take
`self: Task` and copy the struct (`core/model.ode:58`). For writes,
`App.task(i)` returns `items + index` (`core/app.ode:210`), because `List.at` hands
back a copy and `List` has no way to point at an element.

**Suggestion:** materialize the temporary in a hidden local for `*self`
calls (Go does this for addressable values; C++ binds temporaries to const
refs). And add `List.ref(index): *T` to std.

### 2.4 Lambdas capture nothing, and methods are not values

These are deliberate and documented, but they cost in practice. Every
"find by a value" is a loop: `restore` matches tasks by id (`core/app.ode:271`),
and so do `runningIndex` and search. `List.findIndex(Task.isRunning)` would
cover the simplest case without needing captures, but `Task.isRunning` is
*"undefined variable 'Task'"*.

**Suggestion:** allow `Struct.method` as a function value when the method takes
`self` by value or pointer. It is a plain function pointer, so it fits the
no-allocation rule.

### 2.5 No `defer`, and so everything leaks

Each `snprintf` buffer, every undo snapshot (`List.copy()` of the whole task
list) and every `Builder.take()` string is leaked. Freeing them by hand on
every early return would double the length of `core/app.ode`. In a TUI that runs
for hours that adds up: the 200-entry undo cap drops old snapshots from the
list, but nothing frees them.

**Suggestion:** `defer stmt;`. It needs no GC, fits Zig/Go users, and lowers
to code at each exit.

### 2.6 Pattern matching on data

A vim key is "kind + char". vimdo writes `Key::Char('j') | Key::Down =>`.
Ode has unions of structs, but no patterns inside them, so `core/app.ode`
uses `isChar('j') || key.kind == .Down` about 30 times, and the main dispatch is
`if` chains plus a `match` on `key.ch` for plain chars only.

**Suggestion:** literal patterns on a field (`Char { ch: 'j' } , Down =>`),
or arm guards (`.Char if key.ch == 'j' =>`).

## 3. Standard library

These came up, and each was written by hand in odedo:

| Missing | Written in |
|---|---|
| `List.insert(at, item)`, `List.removeAt(at)` | `core/model.ode:121` (twice more inside `core/editor.ode`, `core/app.ode`) |
| text: `trim`, `split` on whitespace, `toLower`, case-folded `indexOf` | `core/app.ode` (`trimmed`, `words`, `indexFolded`) |
| `parseFloat` (like `parseInt`, with an error) | `core/app.ode` (`positive`, via `strtod` + end pointer) |
| time: `now()` as `f64`, `sleep` | `core/model.ode` (`clock_gettime` with a hand-laid `timespec`) |
| fs: `makeDirs`, `rename` | `core/storage.ode` (`mkdir` with a guessed `mode_t` width) |
| `std/c`: `signal`, `fork`, `poll`, `isatty`, `system`, `_exit` | declared locally in `tui/term.ode` and again in `core/notify.ode` |
| a terminal module: raw mode, size, key decoding | `tui/term.ode`, with `termios` kept as 256 opaque bytes |

The last two rows contain platform guesses (`TIOCGWINSZ`, the `mode_t` width,
the `termios` size) that only hold on macOS. A `std/os` that owns them would
keep programs portable.

## 4. A bug found along the way (mine, but worth a doc line)

The first notifier forked a child that slept until the pomodoro deadline,
and killed it with `SIGTERM` when the deadline moved. The child inherited
the terminal front end's own `SIGTERM` handler. That handler put the shared
terminal back into cooked mode, so the *parent* stopped receiving keys.
Resetting the handler in the child fixed it. The window front end then
ruled out `fork` without `exec` anyway (Cocoa is not fork-safe), so
`core/notify.ode` now spawns `sh -c "sleep N && osascript ..."` with
`posix_spawn` and kills that.

It is worth noting that a capture-free lambda worked as a C signal handler,
and `null` as a function value worked as `SIG_DFL`. Both are good proof of
the "lambdas are C function pointers" design.

## 5. What worked well

Worth keeping exactly as it is:

- **Unions as data.** `type Json = JNull | bool | f64 | *i8 | *JArray | *JObject`,
  recursive through `List<Json>`, compiled and passed its tests on the first
  try.
- **Narrowing on fields:** `if (self.count is i64) { self.count = self.count * 10 + digit; }`.
- **Errors as values:** `try`, `catch (e) { return ...; }`, and `nameOf(e)` in
  a user-facing message (`core/storage.ode`, `loadStore`).
- **Tests beside code.** `ode test src/` ran all 23 in under a second, and
  porting vimdo's `feed(app, "gg2dd")` tests 1:1 is what made the port safe.
- **Diagnostics.** *"type 'ParseError' is declared in 'std/text.ode' but not
  imported here"* and *"it takes 'self' by pointer, so store the value first"*
  each said exactly what to do.
- **`extern` to C.** `poll`, `ioctl` through `...`, `tcgetattr`,
  `clock_gettime` with Ode structs passed by pointer all worked first time.
- **Compile speed.** The whole program builds in about 0.2s.
- **Ode memory laid out as C expects.** `Font`, `GlyphInfo`, `Image` and
  `Texture` written as Ode structs matched raylib's layout byte for byte,
  so a font assembled in Ode drew correctly the first time.

## Suggested order

0. Structs across `extern` (0.1), and a way to link a library (0.2), for
   anyone writing against a C library with a struct-heavy API.
1. Hex/binary/octal literals (1.3). Lexer only.
2. Unions without errors: no "ignored error", and allow `==` (1.1).
3. `match` on `bool` and on strings (1.2, 2.2).
4. A built-in `none` with `??` (2.1).
5. `defer` (2.5).
6. `Builder.addFloat` / padding, then a `format` (1.5).
7. std: `List.insert/removeAt/ref`, text `trim/split/toLower`, `parseFloat`,
   `std/time`, `std/os` (3).
8. `*self` on temporaries, `Struct.method` as a value (2.3, 2.4).
