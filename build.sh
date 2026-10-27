#!/usr/bin/env bash
# Gets a machine with no Ode compiler to its first one, then hands over.
#
#   ./build.sh [build | test | bootstrap | seed] [options]   (./build.sh --help)
#
# Building, testing and bootstrapping are `ode build`, which does what
# build.ode says, as for any Ode project. This script is the one step that
# cannot be: turning the checked-in seed, bootstrap/ode.ll, into a working
# compiler with clang. Once build/ode exists it does nothing but run
# `build/ode build "$@"`.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ODE="$ROOT_DIR/build/ode"

if [ ! -x "$ODE" ]; then
  STAGE0="$ROOT_DIR/build/ode-stage0"
  mkdir -p "$ROOT_DIR/build"

  # Tell clang which SDK to link against on macOS, as the compiler itself
  # does: a clang that is not Apple's may not know, and ignores SDKROOT.
  sysroot=()
  if [ -n "${SDKROOT:-}" ]; then
    sysroot=(-isysroot "$SDKROOT")
  elif command -v xcrun >/dev/null 2>&1; then
    sysroot=(-isysroot "$(xcrun --show-sdk-path)")
  fi

  echo "no compiler yet: seeding from bootstrap/ode.ll"
  "${ODE_CC:-clang}" "$ROOT_DIR/bootstrap/ode.ll" -o "$STAGE0" \
    -Wno-override-module ${sysroot[@]+"${sysroot[@]}"}
  # The seed compiles the sources directly rather than through its own `ode
  # build`, so the script keeps working with a seed that predates the layout.
  # The compiler imports the standard library, which must be this checkout's.
  ODE_STD="$ROOT_DIR/std" "$STAGE0" -o "$ODE" "$ROOT_DIR/compiler/main.ode"
fi

exec "$ODE" build "$@"
