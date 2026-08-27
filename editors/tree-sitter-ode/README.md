# tree-sitter-ode

A [tree-sitter](https://tree-sitter.github.io) grammar for Ode, kept in step
with `gramma.md` at the repository root. It exists so editors can highlight,
fold and navigate `.ode` sources without the compiler being involved.

## Layout

- `grammar.js` — the grammar. Precedence constants mirror the "Operator
  Precedence" table in `gramma.md`, lowest binding first.
- `queries/` — `highlights.scm`, `indents.scm`, `folds.scm` and `locals.scm`,
  written against the Neovim standard capture names.
- `src/` — the generated parser. Regenerated from `grammar.js`, not edited.
- `install-nvim.sh` — builds the parser and installs it plus the queries into
  the Neovim site directory.

## Neovim

```sh
./install-nvim.sh
```

That compiles `src/parser.c` into `~/.local/share/nvim/site/parser/ode.so` and
copies `queries/*.scm` to `~/.local/share/nvim/site/queries/ode/`, both of
which are on Neovim's runtimepath. Two files in the Neovim config supply the
rest:

- `ftdetect/ode.lua` maps the `.ode` extension to the `ode` filetype.
- `after/ftplugin/ode.lua` calls `vim.treesitter.start()` and sets the comment
  string, indent width and fold expression.

Re-run the script after editing `grammar.js` or any query; it regenerates the
parser when `grammar.js` is the newer file.

## Working on the grammar

```sh
npx tree-sitter-cli@0.25.10 generate                 # rebuild src/ from grammar.js
npx tree-sitter-cli@0.25.10 parse ../../examples/*.ode --stat
npx tree-sitter-cli@0.25.10 query queries/highlights.scm ../../examples/structs.ode
```

Inside Neovim, `:InspectTree` shows the parse tree for the current buffer and
`:Inspect` reports the capture under the cursor.

Every file under `examples/`, `selfhost/` and `tests/` parses with no error
nodes; keep it that way when the language grows.
