#!/usr/bin/env bash
# Compares the self-hosted compiler against the C++ one, phase by phase, over
# every Ode source in the repository plus the self-hosted compiler's own
# source. Any difference is a porting bug.
#
#   selfhost/difftest.sh
#
# The C++ compiler is the reference. Only the phases the port has reached are
# compared; the rest are added here as they land.
set -uo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ODE="$ROOT_DIR/build/ode"
ODE1="$ROOT_DIR/build/ode1"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

passed=0
failed=0

for binary in "$ODE" "$ODE1"; do
  if [ ! -x "$binary" ]; then
    echo "difftest: no compiler at $binary" >&2
    echo "  build both with: cmake --build ./build && ./selfhost/build.sh" >&2
    exit 1
  fi
done

compare_tokens() {
  local source="$1" name
  name="$(basename "$source")"

  "$ODE" --dump-tokens "$source" > "$WORK_DIR/cpp.tokens" 2>"$WORK_DIR/cpp.err"
  local cpp_status=$?
  "$ODE1" "$source" > "$WORK_DIR/ode.tokens" 2>"$WORK_DIR/ode.err"
  local ode_status=$?

  # A source the C++ lexer rejects only has to be rejected by both.
  if [ $cpp_status -ne 0 ]; then
    if [ $ode_status -ne 0 ]; then
      printf '  tokens   %-40s ok (both reject)\n' "$name"
      passed=$((passed + 1))
    else
      printf '  tokens   %-40s FAIL (C++ rejects, self-hosted accepts)\n' "$name"
      failed=$((failed + 1))
    fi
    return
  fi

  if [ $ode_status -ne 0 ]; then
    printf '  tokens   %-40s FAIL (self-hosted rejects)\n' "$name"
    sed 's/^/      /' < "$WORK_DIR/ode.err"
    failed=$((failed + 1))
    return
  fi

  if cmp -s "$WORK_DIR/cpp.tokens" "$WORK_DIR/ode.tokens"; then
    printf '  tokens   %-40s ok\n' "$name"
    passed=$((passed + 1))
  else
    printf '  tokens   %-40s FAIL (token streams differ)\n' "$name"
    diff -u --label c++ "$WORK_DIR/cpp.tokens" \
            --label self-hosted "$WORK_DIR/ode.tokens" |
      head -20 | sed 's/^/      /'
    failed=$((failed + 1))
  fi
}

echo "comparing the self-hosted lexer against the C++ one"

for source in "$ROOT_DIR"/examples/*.ode "$ROOT_DIR"/tests/invalid/*.ode; do
  compare_tokens "$source"
done

# The compiler's own source is the case that has to work.
if [ -f "$ROOT_DIR/build/ode1.ode" ]; then
  compare_tokens "$ROOT_DIR/build/ode1.ode"
fi

echo
if [ $failed -eq 0 ]; then
  echo "all $passed comparisons matched"
  exit 0
fi

echo "$failed of $((passed + failed)) comparisons differed"
exit 1
