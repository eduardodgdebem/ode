#!/usr/bin/env bash
# Build the Ode tree-sitter parser and install it, with its queries, into the
# Neovim site directory. Re-run after any change to grammar.js or queries/.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
site="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"

cd "$here"

if [ ! -f src/parser.c ] || [ grammar.js -nt src/parser.c ]; then
  echo "generating parser..."
  npx --yes tree-sitter-cli@0.25.10 generate
fi

mkdir -p "$site/parser" "$site/queries/ode"

echo "compiling $site/parser/ode.so"
cc -O2 -fPIC -shared -Isrc -o "$site/parser/ode.so" src/parser.c

echo "installing queries into $site/queries/ode"
cp queries/*.scm "$site/queries/ode/"

echo "done. open a .ode file in nvim; :InspectTree shows the parse tree."
