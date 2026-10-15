#!/usr/bin/env bash
# Gets a machine with no Ode compiler to its first one, then hands over.
#
#   selfhost/build.sh [build | test | bootstrap | seed] [options]
#
# Building, testing and bootstrapping are `ode build`, written in Ode in
# selfhost/buildtool.ode. This script is the one step that cannot be: turning
# the checked-in seed, bootstrap/ode.ll, into a working compiler with clang.
# Once build/ode exists it does nothing but run `build/ode build "$@"`.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
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
  "$STAGE0" build
fi

exec "$ODE" build "$@"
