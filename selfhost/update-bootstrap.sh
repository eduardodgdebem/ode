#!/usr/bin/env bash
# Refreshes bootstrap/ode.ll from the compiler as it stands now.
#
#   selfhost/update-bootstrap.sh
#
# The seed is what a machine with no Ode compiler starts from, so it has to be
# able to compile the current sources. Run this whenever the compiler starts
# using a language feature the committed seed predates -- and commit the
# result, because a stale seed breaks the build for anyone starting fresh.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ODE="$ROOT_DIR/build/ode"
SEED_IR="$ROOT_DIR/bootstrap/ode.ll"

if [ ! -x "$ODE" ]; then
  echo "update-bootstrap.sh: build the compiler first (selfhost/build.sh)" >&2
  exit 1
fi

"$ROOT_DIR/selfhost/build.sh" >/dev/null
mkdir -p "$(dirname "$SEED_IR")"
"$ODE" --emit-llvm "$ROOT_DIR/selfhost/main.ode" >"$SEED_IR"

echo "wrote $SEED_IR ($(wc -c <"$SEED_IR" | tr -d ' ') bytes)"
echo "commit it: a fresh checkout has nothing else to start from."
