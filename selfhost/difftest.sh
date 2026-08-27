#!/usr/bin/env bash
# Compares the self-hosted compiler against the C++ one, phase by phase, over
# every Ode source in the repository plus the self-hosted compiler's own
# source. Any difference is a porting bug.
#
#   selfhost/difftest.sh [--filter <substring>]
#
# The C++ compiler is the reference. Only the phases the port has reached are
# compared; the rest are added here as they land.
set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ODE="$ROOT_DIR/build/ode"
ODE1="$ROOT_DIR/build/ode1"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

FILTER=""
while [ $# -gt 0 ]; do
  case "$1" in
    --filter) FILTER="$2"; shift 2 ;;
    *) echo "difftest.sh: unknown option '$1'" >&2; exit 2 ;;
  esac
done

passed=0
failed=0

for binary in "$ODE" "$ODE1"; do
  if [ ! -x "$binary" ]; then
    echo "difftest: no compiler at $binary" >&2
    echo "  build both with: cmake --build ./build && ./selfhost/build.sh" >&2
    exit 1
  fi
done

# Compares one phase's output for one source. A source the C++ compiler
# rejects only has to be rejected by the self-hosted one too: the diagnostics
# themselves are not compared, because the self-hosted compiler does not
# recover from errors yet and so reports only the first.
compare() {
  local phase="$1" flag="$2" source="$3" name
  name="$(basename "$source")"

  if [ -n "$FILTER" ] && [[ "$name" != *"$FILTER"* ]]; then
    return
  fi

  "$ODE" "$flag" "$source" > "$WORK_DIR/cpp.out" 2>"$WORK_DIR/cpp.err"
  local cpp_status=$?
  "$ODE1" "$flag" "$source" > "$WORK_DIR/ode.out" 2>"$WORK_DIR/ode.err"
  local ode_status=$?

  if [ $cpp_status -ne 0 ]; then
    if [ $ode_status -ne 0 ]; then
      printf '  %-7s %-40s ok (both reject)\n' "$phase" "$name"
      passed=$((passed + 1))
    else
      printf '  %-7s %-40s FAIL (C++ rejects, self-hosted accepts)\n' \
        "$phase" "$name"
      sed 's/^/      /' < "$WORK_DIR/cpp.err"
      failed=$((failed + 1))
    fi
    return
  fi

  if [ $ode_status -ne 0 ]; then
    printf '  %-7s %-40s FAIL (self-hosted rejects)\n' "$phase" "$name"
    sed 's/^/      /' < "$WORK_DIR/ode.err"
    failed=$((failed + 1))
    return
  fi

  if cmp -s "$WORK_DIR/cpp.out" "$WORK_DIR/ode.out"; then
    printf '  %-7s %-40s ok\n' "$phase" "$name"
    passed=$((passed + 1))
  else
    printf '  %-7s %-40s FAIL (output differs)\n' "$phase" "$name"
    diff -u --label c++ "$WORK_DIR/cpp.out" \
            --label self-hosted "$WORK_DIR/ode.out" |
      head -20 | sed 's/^/      /'
    failed=$((failed + 1))
  fi
}

sources() {
  ls "$ROOT_DIR"/examples/*.ode "$ROOT_DIR"/tests/invalid/*.ode
  # The compiler's own source is the case that has to work.
  if [ -f "$ROOT_DIR/build/ode1.ode" ]; then
    echo "$ROOT_DIR/build/ode1.ode"
  fi
}

echo "comparing the self-hosted compiler against the C++ one"
echo

for source in $(sources); do
  compare tokens --dump-tokens "$source"
done

echo

for source in $(sources); do
  compare ast --dump-ast "$source"
done

echo
if [ $failed -eq 0 ]; then
  echo "all $passed comparisons matched"
  exit 0
fi

echo "$failed of $((passed + failed)) comparisons differed"
exit 1
