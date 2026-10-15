#!/usr/bin/env bash
# Builds the compiler from the sources in this directory.
#
#   selfhost/build.sh [--ode <path>] [--out <path>]
#
# The compiler is a set of modules entered at selfhost/main.ode, which imports
# the rest, so building it is compiling that one file.
#
# The compiler is written in Ode, so something has to compile it first. With
# no compiler present that is bootstrap/ode.ll, a checked-in copy of the
# compiler's own output that clang can turn into a working binary.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SELFHOST_DIR="$ROOT_DIR/selfhost"
ENTRY="$SELFHOST_DIR/main.ode"
SEED_IR="$ROOT_DIR/bootstrap/ode.ll"
STAGE0="$ROOT_DIR/build/ode-stage0"
ODE=""
OUT="$ROOT_DIR/build/ode"

while [ $# -gt 0 ]; do
  case "$1" in
  --ode)
    ODE="$2"
    shift 2
    ;;
  --out)
    OUT="$2"
    shift 2
    ;;
  *)
    echo "build.sh: unknown option '$1'" >&2
    exit 2
    ;;
  esac
done

mkdir -p "$ROOT_DIR/build"

# Nothing was named, so use the compiler already built if there is one and
# seed from the checked-in IR if there is not.
if [ -z "$ODE" ]; then
  if [ -x "$OUT" ]; then
    ODE="$OUT"
  else
    if [ ! -f "$SEED_IR" ]; then
      echo "build.sh: no compiler at $OUT and no seed at $SEED_IR" >&2
      exit 1
    fi
    echo "no compiler yet: seeding from $(basename "$SEED_IR")"
    clang "$SEED_IR" -o "$STAGE0" -Wno-override-module
    ODE="$STAGE0"
  fi
fi

if [ ! -x "$ODE" ]; then
  echo "build.sh: no compiler at $ODE" >&2
  exit 1
fi

# The compiler cannot overwrite itself while it is running, so a build that
# would land on the compiler in use goes to a temporary first.
if [ "$ODE" = "$OUT" ]; then
  "$ODE" -o "$OUT.new" "$ENTRY"
  mv "$OUT.new" "$OUT"
  mv "$OUT.new.ll" "$OUT.ll"
  mv "$OUT.new.o" "$OUT.o"
else
  "$ODE" -o "$OUT" "$ENTRY"
fi

echo "built $OUT from $(cat "$SELFHOST_DIR"/*.ode | wc -l | tr -d ' ') lines in $(ls "$SELFHOST_DIR"/*.ode | wc -l | tr -d ' ') modules"
