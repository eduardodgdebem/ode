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
`char *` is `*i8`, a `size_t` is `i64`, a `FILE *` is `*i8`.

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
| `release()` | frees the list |

`count` is a field, so `for (index in 0..list.count)` walks it.

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
| `parseInt(text, fallback)` | the decimal in `text`, or `fallback` if it holds anything else |

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

| Function | Does |
|---|---|
| `readFile(path)` | the whole file as a string, or null |
| `writeFile(path, text)`, `appendFile(path, text)` | false when it cannot |
| `exists(path)`, `removeFile(path)` | |
