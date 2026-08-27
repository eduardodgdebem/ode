#!/usr/bin/env bash
# Runs the bootstrap to its fixed point.
#
#   selfhost/bootstrap.sh
#
#   ode   (C++)  compiles the Ode sources -> ode1
#   ode1         compiles the same sources -> ode2
#   ode2         compiles the same sources -> ode3
#
# ode2 and ode3 must be byte-identical. ode1 is not expected to match them:
# it was produced by a different compiler, through the LLVM API rather than
# from this compiler's own textual IR, so it differs in layout while meaning
# the same thing. Once ode2 reproduces itself, the compiler is a fixed point.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/build/bootstrap"
SOURCE="$ROOT_DIR/build/ode1.ode"

if [ ! -x "$ROOT_DIR/build/ode" ]; then
  echo "bootstrap: no C++ compiler at build/ode (run: cmake --build ./build)" >&2
  exit 1
fi

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "stage 0: ode (C++) -> ode1"
"$ROOT_DIR/selfhost/build.sh" > /dev/null

# Each generation writes to the same file name in a directory of its own, so
# that the output path clang embeds is identical and cannot account for a
# difference between them.
for stage in 1 2; do
  from="$ROOT_DIR/build/ode1"
  [ $stage -eq 2 ] && from="$BUILD_DIR/1/ode"

  echo "stage $stage: $(basename "$(dirname "$from")")/$(basename "$from") -> ode$((stage + 1))"
  mkdir -p "$BUILD_DIR/$stage"
  "$from" -o "$BUILD_DIR/$stage/ode" "$SOURCE"
done

echo
if cmp -s "$BUILD_DIR/1/ode" "$BUILD_DIR/2/ode"; then
  echo "fixed point reached: ode2 and ode3 are byte-identical"
  echo "  $(wc -c < "$BUILD_DIR/1/ode" | tr -d ' ') bytes"
  exit 0
fi

echo "NOT a fixed point: ode2 and ode3 differ" >&2
cmp -l "$BUILD_DIR/1/ode" "$BUILD_DIR/2/ode" | head -5 >&2
exit 1
