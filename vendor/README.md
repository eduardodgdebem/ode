# Bundled sources

What Ode needs to build programs for Linux from any machine, kept here so
that building never needs the network. The compiler builds them once per
target, the first time a program is built for it, into `~/.cache/ode/libc/`
(see [`compiler/codegen/libc.ode`](../compiler/codegen/libc.ode)).

| File | What | From | Licence |
|---|---|---|---|
| `musl-1.2.5.tar.gz` | musl, the C library Linux programs link against, statically | the release tarball from <https://musl.libc.org/releases/>, unchanged; sha256 `a9a118bbe84d8764da0ea0d28b3ab3fae8477fc7e4085d90102b8596fc7c75e4` | MIT, in its `COPYRIGHT` |
| `compiler-rt-builtins-23.1.3.tar.gz` | compiler-rt's builtins: the helpers clang calls for what the CPU has no instruction for, such as aarch64's 128-bit `long double` | the top-level `.c`, `.h` and `.inc` files of `compiler-rt/lib/builtins` at LLVM's `llvmorg-23.1.3` tag (`0d261d1c`), unchanged, with `compiler-rt/LICENSE.TXT` | Apache 2.0 with LLVM exceptions, in its `LICENSE.TXT` |

## Updating

A new musl release replaces its tarball as published, and `MUSL` in
`compiler/codegen/libc.ode` names it. The cache is keyed by that name, so a
new version is built afresh.

The builtins are taken from a sparse checkout:

```bash
git clone --depth 1 --filter=blob:none --sparse --branch llvmorg-<version> \
  https://github.com/llvm/llvm-project.git
cd llvm-project && git sparse-checkout set compiler-rt/lib/builtins
mkdir -p ../compiler-rt-builtins-<version>
find compiler-rt/lib/builtins -maxdepth 1 -type f \
  \( -name '*.c' -o -name '*.h' -o -name '*.inc' \) \
  -exec cp {} ../compiler-rt-builtins-<version>/ \;
git show HEAD:compiler-rt/LICENSE.TXT > ../compiler-rt-builtins-<version>/LICENSE.TXT
tar -czf compiler-rt-builtins-<version>.tar.gz -C .. compiler-rt-builtins-<version>
```

and `BUILTINS` in `libc.ode` names it.
