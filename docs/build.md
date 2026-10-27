# Building a project

A project describes its build in Ode, in a `build.ode` at its root, against
`std/build`. `ode build` finds the nearest `build.ode` at or above the
current directory and does what it says.

```rust
import { Build, Artifact } from "std/build";

export fn build(b: *Build): void {
  let game: *Artifact = b.executable("game", "src/main.ode");
  game.libraryPath("vendor/raylib/lib").linkLibrary("raylib");
  game.linkFramework("Cocoa").linkFramework("IOKit");

  if (b.flag("intel")) {
    b.executable("game-intel", "src/main.ode").linkLike(game).target = "x86_64-macos";
  }

  // The tests link what the game links, so code that calls raylib can be
  // tested too.
  b.tests("src").linkLike(game);
}
```

```bash
ode build                    # build every executable, into build/
ode build test               # run every test build.ode declares
ode build test --filter ui   # only the tests whose name holds "ui"
ode build run -- --level 2   # build the only executable and run it
ode build run game           # the one named, when there are several
ode build -Dintel            # options build.ode reads with b.flag / b.option
ode build --target aarch64-linux --sysroot ~/sysroots/arm64-linux
ode build plan               # print what build.ode declared
ode build --help             # the steps, with those build.ode adds
```

Paths are relative to the directory `build.ode` is in, wherever `ode build`
is run from.

## What `build` is given

| On `Build` | Does |
|---|---|
| `b.executable(name, root)` | a program built from `root`, by default into `build/<name>` |
| `b.tests(root)` | the tests in `root`, a file or a directory, for `ode build test` |
| `b.option(name)` | the value of `-Dname=value`, `""` for a bare `-Dname`, `null` when not given |
| `b.flag(name)` | whether `-Dname` or `-Dname=true` was given |
| `b.target`, `b.sysroot` | `--target` and `--sysroot`, which every executable starts with |

| On `Artifact` | Does |
|---|---|
| `.linkLibrary(name)` | links `lib<name>`: `-l` |
| `.libraryPath(dir)` | looks for libraries in `dir`: `-L` |
| `.linkFramework(name)` | links a macOS framework: `-framework` |
| `.linkLike(other)` | links everything `other` links so far |
| `.output` | where an executable goes |
| `.target`, `.sysroot` | what it is built for: `arch-os[-abi]`, as `ode --target` takes it |

Each method returns the artifact, so calls chain. A test artifact's target is
never used, because tests run on the machine running them.

## Steps

`ode build <step>` runs a step. `build` builds every executable and `test`
runs every test; a build file adds steps of its own, or adds to those two,
by naming the programs they run:

```rust
let gen: *Artifact = b.tool("gen", "tools/gen.ode");
b.step("tables", "regenerate the tables")
    .run(gen).arg("--out").arg("src/tables.ode");
```

| | Does |
|---|---|
| `b.tool(name, root)` | an executable built only when a step runs it or is handed its output |
| `b.step(name, description)` | the step `ode build <name>` runs; `build` and `test` exist already |
| `step.run(program)` | runs `program`, after what the step did before |
| `command.arg(text)` | an argument |
| `command.argOutput(artifact)` | the path `artifact` is built to, building it first |

A command runs in the directory `build.ode` is in, with the arguments given
after `--` on the command line last. A command in the `test` step is handed
`--filter` too.

The compiler builds itself this way: its [`build.ode`](../build.ode) builds
`build/ode`, and its `test`, `bootstrap` and `seed` steps run `tools/dev.ode`
on it.

## Up to date

An executable is built again only when something it depends on has changed:
the files it is made of, found by following its imports, the flags it is
built with, and the C compiler and SDK. Their hash is kept in
`<output>.stamp`. `--force` builds anyway. An executable whose output is the
compiler doing the building is written beside it first and then moved into
place, so a compiler can rebuild itself.

## How it works

`ode build` compiles `build.ode` with a small runner whose `main` calls
`build`, and runs it. `build` only records what it wants, and the runner
prints that as a plan, one fact per line (`ode build plan` shows it). The
compiler reads the plan back and carries it out by running itself on each
artifact with the flags `ode` takes on the command line, so a build file can
do nothing that the command line cannot.

Recording rather than doing suits the language: a lambda captures nothing,
so a build is a description, not a graph of closures as in Zig's
`build.zig`. It keeps linking in the compiler's hands too, which is how
`ode test` links what the executables link.

## Targets

`--target` and an artifact's `.target` take `arch-os[-abi]`: `x86_64` or
`aarch64` (also `arm64`), `macos` or `linux`, and on Linux `musl`, the
default, or `gnu`. A Linux executable links statically against the musl Ode
bundles, so `ode build --target aarch64-linux` works from a Mac with nothing
else installed but LLVM's tools; see the [README](../README.md#quick-start).
