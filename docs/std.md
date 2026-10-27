# The standard library

`std/` holds the library every Ode program can import by name:

```rust
import { println } from "std/io";
import { List } from "std/list";
import { alloc, release } from "std/mem";
```

An import that is not a path (`./x`, `../x` or `/x`) names a library module,
and `std/<name>` is `std/<name>.ode`. The compiler looks for the library in
`$ODE_STD`, then beside where it is installed: `../std` or `../lib/ode/std`
from the directory holding `ode`, so `build/ode` finds the repository's
`std/`.

Each module carries its own tests, written beside the code they test, and
`ode build test` runs them. `ode test std/list.ode` runs one module's. A
program's own `ode test` runs its tests, not the library's.

## `std/c`

The C library's functions, declared once, with C's types spelled in Ode: a
`char *` is `*i8`, a `size_t` is `isize`, a `FILE *` is `*i8`.

| Group | Functions |
|---|---|
| Memory | `malloc` `calloc` `realloc` `free` `memcpy` `memmove` `memset` `memcmp` |
| Strings | `strlen` `strcmp` `strncmp` `strstr` `strtol` `strtod` |
| Output | `printf` `dprintf` `snprintf` `putchar` `getchar` `puts` |
| Streams | `fopen` `fdopen` `fclose` `fread` `fwrite` `fgetc` `fputs` `fflush` |
| Descriptors | `read` `write` |
| Process | `exit` `abort` `getenv` |

The modules below are the friendlier way in; `std/c` is what they are built
on, and what a program reaches for when they do not cover something.

## `std/mem`

Memory by element rather than by byte, so no call needs `sizeof` or a cast.
Running out of memory ends the program.

| Function | Does |
|---|---|
| `alloc<T>(count: i64): *T` | room for `count` values, uninitialised |
| `allocZeroed<T>(count: i64): *T` | the same, every byte zero |
| `grow<T>(values: *T, count: i64): *T` | moves `values` to room for `count`, keeping what fits |
| `release<T>(values: *T): void` | frees them |
| `copy<T>(to: *T, from: *T, count: i64): void` | copies values that do not overlap |
| `move<T>(to: *T, from: *T, count: i64): void` | copies values that may |

```rust
let nodes: *Node = alloc<Node>(16);
nodes = grow<Node>(nodes, 32);
release<Node>(nodes);
```

## `std/list`

`List<T>`, a growable list kept behind a pointer. Reading or writing past the
end stops the program.

| Method | Does |
|---|---|
| `List<T>.new()`, `List<T>.withCapacity(n)` | an empty list |
| `push(item)` | adds to the end |
| `at(index)`, `set(index, item)` | reads, writes |
| `last()`, `pop()` | the last item; `pop` also removes it |
| `truncate(count)`, `clear()` | drops items from the end |
| `isEmpty()` | whether `count` is 0 |
| `copy()` | a new list with the same items |
| `release()` | frees the list |
| `each(visit)` | calls `visit` on every item, in order |
| `filter(keep)` | a new list of the items `keep` says yes to |
| `find(matches)`, `findIndex(matches)` | the first match, or where it is; `ListError.NotFound` when none does |
| `any(matches)`, `all(matches)` | whether some item, or every item, matches; `false` and `true` for an empty list |
| `sort(compare)` | puts the items in order in place; stable, n log n |

`count` is a field, so `for (index in 0..list.count)` walks it.

The functions given to these are usually lambdas, written on the spot:

```rust
let names: *List<*i8> = List<*i8>.new();
names.sort(strcmp);                                   // any function of the right type
let long: *List<*i8> = names.filter((name) => length(name) > 8);
let first: *i8 = names.find((name) => name[0] == 'a') ?? "nobody";
let lengths: *List<i64> = map<*i8, i64>(names, (name) => length(name));
let total: i64 = reduce<i64, i64>(lengths, 0, (sum, n) => sum + n);
```

`compare(a, b)` for `sort` is below zero when `a` goes first, above zero when
`b` does, and zero when either may, as for C's `qsort` and TypeScript's
`sort`: `(a, b) => a - b` is ascending. Items that compare equal keep their
order.

Two helpers make a list of another type, so they are functions with their
type arguments written out rather than methods:

| Function | Does |
|---|---|
| `map<T, U>(list, f)` | a new list of `f(item)` for each item |
| `reduce<T, U>(list, start, step)` | folds the items into one value: `step(step(start, first), second)`... |

A lambda captures nothing, so one that needs a value from around it -- the
name being searched for, say -- cannot get it; that search is still a loop.

## `std/text`

Strings are NUL-terminated `*i8`. A function that makes one returns a new
string the caller owns.

| Function | Does |
|---|---|
| `length(text)` | bytes before the NUL |
| `equals(a, b)` | same text |
| `startsWith(text, prefix)`, `endsWith(text, suffix)`, `contains(text, part)` | |
| `indexOf(text, part)` | where `part` starts, or -1 |
| `slice(text, start, count)`, `copy(text)` | new strings |
| `fromInt(value)` | decimal text |
| `parseInt(text)` | the decimal in `text`: `i64 \| ParseError` -- `Empty`, `NotANumber` or `OutOfRange` |

`Builder` puts a string together: `Builder.new()`, then `add(text)`,
`push(byte)`, `addInt(value)` and `addBytes(bytes, count)`, and `take()`
hands over the string and frees the builder.

## `std/io`

| Function | Does |
|---|---|
| `print(text)`, `println(text)` | to standard output, through printf's buffer |
| `eprint(text)`, `eprintln(text)` | to standard error |
| `flush()` | writes out anything still buffered |
| `readLine()` | the next line of input without its newline, or null at the end |

## `std/fs`

Each function that can fail returns a `FileError`: `NotFound` when nothing is
at the path, `CannotRead` when something is but cannot be read as a file (a
directory, say), and `CannotWrite` when it cannot be written.

| Function | Does |
|---|---|
| `readFile(path)` | the whole file as a string: `*i8 \| FileError` |
| `writeFile(path, text)`, `appendFile(path, text)` | `void \| FileError` |
| `removeFile(path)` | `void \| FileError` |
| `exists(path)` | whether anything is there |

```rust
let source: *i8 = readFile("config.txt") catch (e) {
  eprintln("cannot read config.txt");
  return 1;
};
let port: i64 = parseInt(field(source, "port")) ?? 8080;
```

## `std/heap`

Memory and bytes on every target, which `std/mem` and `std/text` are built
on: `heapAlloc`, `heapResize` and `heapFree`; `copyBytes` and `fillBytes`;
`textLength`, `textLengthUpTo`, `compareText` and `findText`. Elsewhere they
are the C library's `malloc`, `memmove`, `strcmp` and the rest. On wasm32,
which has no C library, they are written in Ode: a heap of power-of-two
blocks with a free list per size, cut from the end of the module's memory
and grown with `wasmMemoryGrow`. That is what lets a wasm module use lists
and text with nothing from its host.

## `std/target`

What the program is being built for, as constants a `match` picks its arm
from while compiling: `OS`, `ARCH`, `ABI` and `POINTER_BYTES`. The compiler
writes this module for each build rather than reading it from a file; see
[What a program is built for](language.md#what-a-program-is-built-for).

## `std/build`

What a project's `build.ode` is written against: `Build`, with
`executable`, `tool`, `tests`, `step`, `option` and `flag`; `Artifact`, with
`linkLibrary`, `libraryPath`, `linkFramework` and `linkLike`; and `Step`,
whose `run` gives a `Command` taking `arg` and `argOutput`. It describes a
build and does not run one; see [Building a project](build.md).
