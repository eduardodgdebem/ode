# tree-sitter-ode

A [tree-sitter](https://tree-sitter.github.io) grammar for Ode, kept in step
with `docs/grammar.md` in the repository. It exists so editors can highlight,
fold and navigate `.ode` sources without the compiler being involved.

## Layout

- `grammar.js` — the grammar. Precedence constants mirror the "Operator
  Precedence" table in `docs/grammar.md`, lowest binding first.
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

## The language server

`ode lsp` is a language server: it underlines the problems in a file as it
is edited, shows a name's declaration and the comment above it on hover,
goes to where a name is declared, in whatever file, and completes names in
scope and, after a `.`, fields, methods and enum members. It speaks the
Language Server Protocol over standard input and output, so any editor with
an LSP client can run it.

In Neovim (0.11 or later), add to `after/ftplugin/ode.lua`:

```lua
if vim.fn.executable("ode") == 1 then
  vim.lsp.start({
    name = "ode",
    cmd = { "ode", "lsp" },
    root_dir = vim.fs.root(0, { "build.ode", ".git" }),
  })
end
```

`K` then hovers, `<C-]>` goes to a definition, `<C-x><C-o>`
completes, and `vim.diagnostic` shows the problems. It needs `ode` on the
`PATH`, built with the server -- `build/ode` in the repository -- and finds
the standard library as `ode` always does.

## Working on the grammar

```sh
npx tree-sitter-cli@0.25.10 generate                 # rebuild src/ from grammar.js
npx tree-sitter-cli@0.25.10 parse ../../examples/*.ode --stat
npx tree-sitter-cli@0.25.10 query queries/highlights.scm ../../examples/structs.ode
```

Inside Neovim, `:InspectTree` shows the parse tree for the current buffer and
`:Inspect` reports the capture under the cursor.

Every file under `examples/`, `compiler/` and `tests/` parses with no error
nodes, apart from the rejection cases that are malformed on purpose; keep it
that way when the language grows.
