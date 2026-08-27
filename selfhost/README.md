# The self-hosted compiler

Ode's reason to exist is compiling itself. This directory holds the compiler
written in Ode; `build/ode` (the C++ one) compiles it.

## Building and testing

```bash
cmake --build ./build      # the C++ compiler, which compiles the Ode one
./selfhost/build.sh        # concatenate and compile -> build/ode1
./selfhost/difftest.sh     # compare ode1 against ode, phase by phase
```

## Why the sources are concatenated

Ode has no modules, so the compiler has to be one file. Keeping it as one file
to *edit* would be miserable, so the sources are split here and `build.sh`
concatenates them in name order into `build/ode1.ode`, which is what actually
gets compiled.

Order does not affect meaning: function signatures, globals and struct names
are all hoisted before any body is checked, so a function in `00_prelude.ode`
may call one in `90_main.ode`. The numbering exists to keep the generated file
stable and diffable, not to satisfy the compiler.

| File | Holds |
|---|---|
| `00_prelude.ode` | libc externs, growable text, failure, file I/O |
| `10_token.ode` | token kinds, `Token`, `TokenList` |
| `20_lexer.ode` | the lexer |
| `90_main.ode` | the driver |

## How correctness is checked

`difftest.sh` runs both compilers over every `examples/*.ode`, every
`tests/invalid/*.ode`, and the self-hosted compiler's own source, and compares
their output byte for byte. The C++ compiler is the reference; any difference
is a porting bug.

Right now that means the token stream, via `ode --dump-tokens` and the dump
`ode1` prints. Later phases get compared the same way as they land. This is
the answer to the gap `LIMITATIONS.md` section 8.1 describes: two compilers
that have to agree need something better than bisecting a failing program.

Three real defects came out of it already, none of which a by-eye reading
would have caught:

- Type names lex as their own kind, not as identifiers.
- A leading `-` folds into a number literal, but only where the previous token
  cannot end an expression. `print(-17 % 5)` is one negative literal; `x = 5 - 3`
  is a subtraction; and because `=` is not in that set, `let c: i32 = --5;` is a
  negation of `-5`.
- A token cannot hold its text as a NUL-terminated string, because `'\0'` is a
  token whose text is one NUL byte. Tokens carry an explicit length instead.

## What the port has to stay inside

The self-hosted compiler is compiled by the C++ one, so it can only use what
the C++ compiler already supports. A feature added to the Ode-written compiler
is usable by the compiler's own source only one generation later. In practice:

- No function pointers, so dispatch is `if`/`else if` chains.
- No implicit conversions, so widths change through `as`.
- No variadic `extern`, so decimal formatting is written out by hand.
- Globals are initialised from constants and assigned at start-up.
- One `.` follows one pointer level.

## Where it is going

Lexer, then parser, then analyzer, then a textual LLVM IR emitter that shells
out to `clang` -- the backend plan, verified end to end before any of this was
written. Bootstrap finishes when `ode1` compiling its own source produces a
compiler byte-identical to itself.
