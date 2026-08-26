#!/usr/bin/env bash
#
# Regression suite for the Ode compiler.
#
#   tests/run_tests.sh [--ode <path>] [--update] [--filter <substring>]
#
# Valid cases are every examples/*.ode: each is compiled, linked, run, and its
# stdout compared against tests/valid/<name>.out.
#
# Invalid cases are every tests/invalid/*.ode: each must fail to compile, and
# the diagnostic is compared against tests/invalid/<name>.expected.
#
# --update rewrites the expected files from what the compiler does now, which
# is how the suite is re-baselined after a deliberate language change. Read the
# diff before committing it.

set -uo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$TESTS_DIR")"

ODE="${ODE:-$ROOT_DIR/build/ode}"
UPDATE=0
FILTER=""

while [ $# -gt 0 ]; do
  case "$1" in
    --ode)
      ODE="$2"
      shift 2
      ;;
    --update)
      UPDATE=1
      shift
      ;;
    --filter)
      FILTER="$2"
      shift 2
      ;;
    -h|--help)
      sed -n '2,16p' "${BASH_SOURCE[0]}" | cut -c3-
      exit 0
      ;;
    *)
      echo "run_tests.sh: unknown argument '$1'" >&2
      exit 2
      ;;
  esac
done

if [ ! -x "$ODE" ]; then
  echo "run_tests.sh: no ode compiler at '$ODE'" >&2
  echo "build it with 'cmake --build ./build', or pass --ode <path>" >&2
  exit 2
fi

if [ -t 1 ]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; DIM=$'\033[2m'; OFF=$'\033[0m'
else
  RED=""; GREEN=""; DIM=""; OFF=""
fi

WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ode-tests.XXXXXX")"
# Every artifact lands in the temp directory so the repository stays clean.
trap 'rm -rf "$WORK_DIR"' EXIT

passed=0
failed=0
updated=0
valid_count=0
invalid_count=0
failures=()

report_pass() {
  passed=$((passed + 1))
  printf '%s  %-10s %-34s %sok%s\n' "$DIM" "$1" "$2" "$GREEN" "$OFF"
}

report_fail() {
  failed=$((failed + 1))
  failures+=("$1/$2: $3")
  printf '  %-10s %-34s %sFAIL%s  %s\n' "$1" "$2" "$RED" "$OFF" "$3"
}

show_diff() {
  diff -u --label expected "$1" --label actual "$2" | sed 's/^/    /'
}

selected() {
  [ -z "$FILTER" ] || [[ "$1" == *"$FILTER"* ]]
}

run_valid() {
  local source="$1"
  local name expected actual status
  name="$(basename "$source" .ode)"
  selected "$name" || return 0
  valid_count=$((valid_count + 1))

  expected="$TESTS_DIR/valid/$name.out"
  actual="$WORK_DIR/$name.actual"

  # Compiled with no flags and from inside the work directory, which is also
  # what pins down the default output paths.
  if ! (cd "$WORK_DIR" && "$ODE" "$source") > "$WORK_DIR/$name.compile" 2>&1; then
    report_fail valid "$name" "compilation failed"
    sed 's/^/    /' "$WORK_DIR/$name.compile"
    return 0
  fi

  "$WORK_DIR/$name" > "$actual" 2> "$WORK_DIR/$name.stderr"
  status=$?
  if [ $status -ne 0 ]; then
    report_fail valid "$name" "program exited with status $status"
    return 0
  fi

  if [ $UPDATE -eq 1 ]; then
    if [ ! -f "$expected" ] || ! cmp -s "$expected" "$actual"; then
      cp "$actual" "$expected"
      updated=$((updated + 1))
    fi
    report_pass valid "$name"
    return 0
  fi

  if [ ! -f "$expected" ]; then
    report_fail valid "$name" "no expected output recorded (run with --update)"
    return 0
  fi

  if cmp -s "$expected" "$actual"; then
    report_pass valid "$name"
  else
    report_fail valid "$name" "stdout differs"
    show_diff "$expected" "$actual"
  fi
}

run_invalid() {
  local source="$1"
  local name expected actual
  name="$(basename "$source" .ode)"
  selected "$name" || return 0
  invalid_count=$((invalid_count + 1))

  expected="$TESTS_DIR/invalid/$name.expected"
  actual="$WORK_DIR/$name.actual"

  # The case is copied in and compiled by its bare name so that the recorded
  # diagnostic does not carry the absolute path it was run from.
  cp "$source" "$WORK_DIR/$name.ode"
  if (cd "$WORK_DIR" && "$ODE" "$name.ode") > "$actual" 2>&1; then
    report_fail invalid "$name" "compiled successfully but should have failed"
    return 0
  fi

  if [ $UPDATE -eq 1 ]; then
    if [ ! -f "$expected" ] || ! cmp -s "$expected" "$actual"; then
      cp "$actual" "$expected"
      updated=$((updated + 1))
    fi
    report_pass invalid "$name"
    return 0
  fi

  if [ ! -f "$expected" ]; then
    report_fail invalid "$name" "no expected diagnostic recorded (run with --update)"
    return 0
  fi

  if cmp -s "$expected" "$actual"; then
    report_pass invalid "$name"
  else
    report_fail invalid "$name" "diagnostic differs"
    show_diff "$expected" "$actual"
  fi
}

# The driver flags have no expected-output file to record; they are checked
# against the files they are supposed to produce.
run_cli() {
  local name="$1"
  shift
  selected "$name" || return 0

  if "$@"; then
    report_pass cli "$name"
  else
    report_fail cli "$name" "check failed"
  fi
}

check_output_flag() {
  local out="$WORK_DIR/cli/nested/renamed"
  mkdir -p "$(dirname "$out")"
  "$ODE" -o "$out" "$ROOT_DIR/examples/example1.ode" > /dev/null 2>&1 || return 1
  [ -x "$out" ] && [ -f "$out.ll" ] && [ -f "$out.o" ] && [ "$("$out")" = "0" ]
}

check_no_intermediates_flag() {
  local out="$WORK_DIR/cli/dropped"
  mkdir -p "$(dirname "$out")"
  "$ODE" --no-intermediates -o "$out" "$ROOT_DIR/examples/example1.ode" > /dev/null 2>&1 || return 1
  [ -x "$out" ] && [ ! -e "$out.ll" ] && [ ! -e "$out.o" ]
}

# A path holding a space and a shell metacharacter must survive the linker,
# which builds a command string for /bin/sh.
check_hostile_output_path() {
  local out="$WORK_DIR/cli/a b \$(touch pwned);/prog"
  mkdir -p "$(dirname "$out")"
  "$ODE" -o "$out" "$ROOT_DIR/examples/example1.ode" > /dev/null 2>&1 || return 1
  [ -x "$out" ] && [ ! -e "$WORK_DIR/pwned" ] && [ "$("$out")" = "0" ]
}

check_no_input_file() {
  ! "$ODE" > /dev/null 2>&1
}

mkdir -p "$TESTS_DIR/valid"

for source in "$ROOT_DIR"/examples/*.ode; do
  run_valid "$source"
done

for source in "$TESTS_DIR"/invalid/*.ode; do
  run_invalid "$source"
done

run_cli output-flag check_output_flag
run_cli no-intermediates-flag check_no_intermediates_flag
run_cli hostile-output-path check_hostile_output_path
run_cli no-input-file check_no_input_file

echo
if [ $UPDATE -eq 1 ]; then
  echo "$valid_count valid, $invalid_count invalid: $updated expectation(s) rewritten"
fi

if [ $failed -eq 0 ]; then
  echo "${GREEN}all $passed checks passed${OFF} ($valid_count valid, $invalid_count invalid)"
  exit 0
fi

echo "${RED}$failed of $((passed + failed)) checks failed${OFF}"
for failure in "${failures[@]}"; do
  echo "  $failure"
done
exit 1
