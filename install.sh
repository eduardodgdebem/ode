#!/usr/bin/env bash
# Installs Ode from this checkout, on macOS or Linux -- and on Windows,
# through WSL (see install.ps1).
#
#   ./install.sh                     build the compiler and install it under ~/.local
#   ./install.sh --prefix /usr/local install it there instead
#   ./install.sh --debug             install one that checks as it runs, as a build without --release does
#   ./install.sh uninstall           take an installed Ode out again
#   ./install.sh --check             say what this machine has and lacks, and stop
#
# Or with no checkout at all, which fetches one to build from and removes it
# afterwards -- ODE_REF=<branch or tag> picks which:
#
#   curl -fsSL https://raw.githubusercontent.com/eduardodgdebem/ode/main/install.sh | bash
#   curl -fsSL .../install.sh | bash -s -- --prefix /usr/local
#
# For working on Ode itself, the steps build.ode declares, run with the
# compiler in build/ -- seeded from bootstrap/ode.ll the first time:
#
#   ./install.sh build [options]     build build/ode
#   ./install.sh test | bootstrap | seed | plan ...
#
# An installed Ode is <prefix>/bin/ode, with what it reads beside it in
# <prefix>/lib/ode: std/, the standard library; vendor/, musl's and
# compiler-rt's sources, which Linux programs are linked against; and
# runners/, which runs wasm32 tests in Node.
set -euo pipefail

say() { printf '%s\n' "$*"; }
warn() { printf 'install: %s\n' "$*" >&2; }
die() { warn "$*"; exit 1; }

REPOSITORY="${ODE_REPO:-https://github.com/eduardodgdebem/ode}"

# Piped into bash, as `curl ... | bash`, this script is no file in a
# checkout: there is no seed or source beside it to build. One is fetched
# instead -- cloned with git, or the archive GitHub serves when there is no
# git -- and the copy of this script in it runs, and removes it when done.
SCRIPT="${BASH_SOURCE[0]:-}"
if [ -z "$SCRIPT" ] || [ ! -f "$(dirname "$SCRIPT")/bootstrap/ode.ll" ]; then
  ref="${ODE_REF:-main}"
  fetched="$(mktemp -d "${TMPDIR:-/tmp}/ode-source.XXXXXX")"
  say "fetching Ode ($ref) from $REPOSITORY"
  if command -v git >/dev/null 2>&1; then
    git clone --quiet --depth 1 --branch "$ref" "$REPOSITORY" "$fetched/ode" ||
      die "cannot clone $REPOSITORY at $ref"
  elif command -v curl >/dev/null 2>&1; then
    mkdir -p "$fetched/ode"
    curl -fsSL "$REPOSITORY/archive/$ref.tar.gz" | tar -xz -C "$fetched/ode" --strip-components 1 ||
      die "cannot download $REPOSITORY/archive/$ref.tar.gz"
  else
    die "fetching Ode needs git or curl"
  fi
  ODE_FETCHED="$fetched" exec bash "$fetched/ode/install.sh" "$@"
fi

ROOT_DIR="$(cd "$(dirname "$SCRIPT")" && pwd)"
BUILD_DIR="$ROOT_DIR/build"
ODE="$BUILD_DIR/ode"

# A checkout fetched for this install is not kept.
if [ -n "${ODE_FETCHED:-}" ]; then
  trap 'rm -rf "$ODE_FETCHED"' EXIT
fi

usage() {
  sed -n '2,28p' "$SCRIPT" | sed 's/^# \{0,1\}//'
}

# ---------------------------------------------------------------------------
# The machine.
# ---------------------------------------------------------------------------

OS=""
ARCH="$(uname -m)"
case "$(uname -s)" in
  Darwin) OS=macos ;;
  Linux)
    OS=linux
    if grep -qi microsoft /proc/version 2>/dev/null; then
      OS_NOTE=" (WSL)"
    fi
    ;;
  MINGW* | MSYS* | CYGWIN*)
    die "Ode runs on Windows through WSL, a Linux it can build for and run on:
  wsl --install              once, from PowerShell, if WSL is not there yet
  .\\install.ps1              from PowerShell in this checkout, which runs this script in WSL"
    ;;
  *) die "no support for $(uname -s): Ode runs on macOS and Linux, and on Windows through WSL" ;;
esac
case "$ARCH" in
  arm64 | aarch64) ARCH=aarch64 ;;
  x86_64 | amd64) ARCH=x86_64 ;;
  *) die "no support for $ARCH: Ode builds for aarch64 and x86_64" ;;
esac

CC="${ODE_CC:-clang}"

# What package installs a missing tool, for the advice that goes with it.
install_hint() {
  local what="$1"
  if [ "$OS" = macos ]; then
    case "$what" in
      clang) say "xcode-select --install" ;;
      *) say "brew install llvm lld" ;;
    esac
    return
  fi
  if command -v apt-get >/dev/null 2>&1; then
    say "sudo apt-get install clang lld llvm"
  elif command -v dnf >/dev/null 2>&1; then
    say "sudo dnf install clang lld llvm"
  elif command -v pacman >/dev/null 2>&1; then
    say "sudo pacman -S clang lld llvm"
  elif command -v apk >/dev/null 2>&1; then
    say "apk add clang lld llvm"
  else
    say "install clang, lld and llvm with your package manager"
  fi
}

# A tool clang's own directory or the PATH has, as the compiler looks for
# one; the first of the names that is there.
find_tool() {
  local dir
  dir="$(dirname "$(command -v "$CC" 2>/dev/null || echo /nonexistent)")"
  for name in "$@"; do
    if [ -x "$dir/$name" ]; then
      say "$dir/$name"
      return 0
    fi
    if command -v "$name" >/dev/null 2>&1; then
      command -v "$name"
      return 0
    fi
  done
  # Homebrew keeps LLVM's tools off the PATH.
  if [ "$OS" = macos ] && command -v brew >/dev/null 2>&1; then
    for prefix in "$(brew --prefix llvm 2>/dev/null)" "$(brew --prefix lld 2>/dev/null)"; do
      for name in "$@"; do
        if [ -n "$prefix" ] && [ -x "$prefix/bin/$name" ]; then
          say "$prefix/bin/$name"
          return 0
        fi
      done
    done
  fi
  return 1
}

# Says what this machine has, and fails when it lacks what building Ode
# needs. Linux programs are linked with lld against musl, which llvm-ar
# archives; on Linux that is every program, and on macOS only those built
# for Linux, so there it is advice rather than a failure.
check_machine() {
  local missing=0
  say "machine:   $OS$(printf '%s' "${OS_NOTE:-}") $ARCH"

  if ! command -v "$CC" >/dev/null 2>&1; then
    warn "no $CC: Ode emits LLVM IR and builds it with clang -- $(install_hint clang)"
    return 1
  fi
  say "clang:     $(command -v "$CC") ($("$CC" --version | head -n 1))"

  if [ "$OS" = macos ]; then
    if ! xcrun --show-sdk-path >/dev/null 2>&1 && [ -z "${SDKROOT:-}" ]; then
      warn "no macOS SDK: programs cannot be linked without one -- $(install_hint clang)"
      missing=1
    fi
  fi

  local linker archiver
  linker="$(find_tool ld.lld || true)"
  archiver="$(find_tool llvm-ar ar || true)"
  if [ -n "$linker" ] && [ -n "$archiver" ]; then
    say "for Linux: $linker, $archiver"
  elif [ "$OS" = linux ]; then
    warn "no ld.lld or llvm-ar: every Linux program links with them -- $(install_hint lld)"
    missing=1
  else
    say "for Linux: missing ld.lld or llvm-ar, so --target *-linux will not link -- $(install_hint lld)"
  fi

  if command -v node >/dev/null 2>&1; then
    say "for wasm:  node $(node --version), to run wasm32 tests"
  else
    say "for wasm:  no node, so ode test --target wasm32 cannot run its tests"
  fi
  return "$missing"
}

# ---------------------------------------------------------------------------
# The compiler.
# ---------------------------------------------------------------------------

# build/ode, made from the checked-in seed when there is none yet: clang
# turns bootstrap/ode.ll into a first compiler, which compiles the sources.
seed_compiler() {
  if [ -x "$ODE" ]; then
    return
  fi
  mkdir -p "$BUILD_DIR"
  local stage0="$BUILD_DIR/ode-stage0"

  # Tell clang which SDK to link against on macOS, as the compiler itself
  # does: a clang that is not Apple's may not know, and ignores SDKROOT.
  local sysroot=()
  if [ -n "${SDKROOT:-}" ]; then
    sysroot=(-isysroot "$SDKROOT")
  elif [ "$OS" = macos ]; then
    sysroot=(-isysroot "$(xcrun --show-sdk-path)")
  fi

  say "no compiler yet: seeding from bootstrap/ode.ll"
  "$CC" "$ROOT_DIR/bootstrap/ode.ll" -o "$stage0" -Wno-override-module \
    ${sysroot[@]+"${sysroot[@]}"}
  # The seed compiles the sources directly rather than through its own `ode
  # build`, so this keeps working with a seed that predates the layout. The
  # compiler imports the standard library, which must be this checkout's.
  ODE_STD="$ROOT_DIR/std" "$stage0" -o "$ODE" "$ROOT_DIR/compiler/main.ode"
}

# ---------------------------------------------------------------------------
# Installing.
# ---------------------------------------------------------------------------

default_prefix() {
  if [ "$(id -u)" = 0 ]; then
    say /usr/local
  else
    say "$HOME/.local"
  fi
}

install_ode() {
  local prefix="$1" debug="$2"
  check_machine || die "fix the above, then run this again (./install.sh --check says what is there)"
  seed_compiler

  local staging="$BUILD_DIR/install"
  rm -rf "$staging"
  mkdir -p "$staging"
  # Optimised, and without the checks a build makes as it runs, unless
  # --debug: an installed compiler is used, not worked on.
  local release=(--release) kind="optimised"
  if [ "$debug" = 1 ]; then
    release=()
    kind="checking as it runs"
  fi
  say "building the compiler, $kind"
  ODE_STD="$ROOT_DIR/std" "$ODE" ${release[@]+"${release[@]}"} -o "$staging/ode" \
    "$ROOT_DIR/compiler/main.ode"

  local lib="$prefix/lib/ode"
  say "installing into $prefix"
  mkdir -p "$prefix/bin" "$lib" || die "cannot write to $prefix; choose another with --prefix, or run as root"
  # What is installed is replaced whole, so a file std no longer has does
  # not linger from an older one.
  rm -rf "$lib/std" "$lib/vendor" "$lib/runners"
  cp -R "$ROOT_DIR/std" "$lib/std"
  cp -R "$ROOT_DIR/vendor" "$lib/vendor"
  cp -R "$ROOT_DIR/runners" "$lib/runners"
  cp "$staging/ode" "$prefix/bin/ode.new"
  mv -f "$prefix/bin/ode.new" "$prefix/bin/ode"
  rm -rf "$staging"

  verify_install "$prefix"
}

# Builds and runs a program with the installed compiler, as a user would:
# from somewhere else, finding its library by where it is.
verify_install() {
  local prefix="$1"
  local scratch
  scratch="$(mktemp -d "${TMPDIR:-/tmp}/ode-install.XXXXXX")"
  cat > "$scratch/hello.ode" <<'EOF'
import { println } from "std/io";
import { Map, textMap } from "std/map";

fn main(): i32 {
  let greetings: *Map<*i8, *i8> = textMap<*i8>();
  greetings.set("ode", "hello from an installed ode");
  println(greetings.get("ode") ?? "missing");
  return 0;
}
EOF
  local said
  if ! said="$(cd "$scratch" && env -u ODE_STD "$prefix/bin/ode" hello.ode -o hello 2>&1 && ./hello)"; then
    rm -rf "$scratch"
    die "the installed ode could not build and run a program:
$said"
  fi
  rm -rf "$scratch"
  say "checked:   $said"

  local version
  version="$(git -C "$ROOT_DIR" describe --always --dirty 2>/dev/null || echo unknown)"
  say "installed Ode ($version) as $prefix/bin/ode"
  case ":$PATH:" in
    *":$prefix/bin:"*) ;;
    *)
      say ""
      say "$prefix/bin is not on your PATH; add it, e.g. in ~/.zshrc or ~/.bashrc:"
      say "  export PATH=\"$prefix/bin:\$PATH\""
      ;;
  esac
}

uninstall_ode() {
  local prefix="$1"
  if [ ! -e "$prefix/bin/ode" ] && [ ! -d "$prefix/lib/ode" ]; then
    die "no Ode is installed under $prefix"
  fi
  rm -f "$prefix/bin/ode"
  rm -rf "$prefix/lib/ode"
  say "removed Ode from $prefix (musl built for it stays in ~/.cache/ode)"
}

# ---------------------------------------------------------------------------

prefix=""
debug=0
command=""
rest=()
while [ $# -gt 0 ]; do
  case "$1" in
    -h | --help) usage; exit 0 ;;
    --check) check_machine; exit $? ;;
    --prefix)
      [ $# -ge 2 ] || die "--prefix takes a directory"
      prefix="$2"
      shift
      ;;
    --prefix=*) prefix="${1#--prefix=}" ;;
    --debug) debug=1 ;;
    install | uninstall)
      if [ -z "$command" ]; then command="$1"; else rest+=("$1"); fi
      ;;
    *)
      # Anything else is a step of build.ode, with its own options.
      if [ -z "$command" ]; then
        command=build-step
      fi
      rest+=("$1")
      ;;
  esac
  shift
done
command="${command:-install}"
prefix="${prefix:-$(default_prefix)}"
case "$prefix" in
  /*) ;;
  *) prefix="$(pwd)/$prefix" ;;
esac

case "$command" in
  install) install_ode "$prefix" "$debug" ;;
  uninstall) uninstall_ode "$prefix" ;;
  build-step)
    seed_compiler
    exec "$ODE" build ${rest[@]+"${rest[@]}"}
    ;;
esac
