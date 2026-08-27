#!/usr/bin/env bash
# Runs the bootstrap to its fixed point.
#
#   selfhost/bootstrap.sh
#
#   bootstrap/ode.ll --clang--> stage0
#   stage0           compiles the sources -> ode1
#   ode1             compiles the sources -> ode2
#   ode2             compiles the sources -> ode3
#
# ode2 and ode3 must be byte-identical. ode1 need not match them: it was built
# by whatever compiler the checked-in seed happens to be, which may predate
# the current sources. Once a generation reproduces itself the compiler is a
# fixed point, and that is what makes it self-hosting rather than merely
# self-compiling.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK="$ROOT_DIR/build/bootstrap"
SOURCE="$ROOT_DIR/build/ode.ode"

rm -rf "$WORK"
mkdir -p "$WORK"

echo "stage 0: bootstrap/ode.ll -> ode1"
"$ROOT_DIR/selfhost/build.sh" >/dev/null

# Each generation writes to the same file name in a directory of its own, so
# that the output path clang embeds is identical and cannot account for a
# difference between them.
from="$ROOT_DIR/build/ode"
for stage in 1 2; do
  echo "stage $stage: ode$stage -> ode$((stage + 1))"
  mkdir -p "$WORK/$stage"
  "$from" -o "$WORK/$stage/ode" "$SOURCE"
  from="$WORK/$stage/ode"
done

echo
if cmp -s "$WORK/1/ode" "$WORK/2/ode"; then
  echo "fixed point reached: ode2 and ode3 are byte-identical"
  echo "  $(wc -c <"$WORK/1/ode" | tr -d ' ') bytes"
  exit 0
fi

echo "NOT a fixed point: ode2 and ode3 differ" >&2
cmp -l "$WORK/1/ode" "$WORK/2/ode" | head -5 >&2
exit 1
