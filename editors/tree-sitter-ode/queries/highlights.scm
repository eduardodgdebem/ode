; Tree-sitter highlight queries for Ode.
; Capture names follow the Neovim standard groups (:h treesitter-highlight).

; ---------------------------------------------------------------------------
; Identifiers
; ---------------------------------------------------------------------------

(identifier) @variable

(parameter name: (identifier) @variable.parameter)

(variable_declaration name: (identifier) @variable)

(field_identifier) @variable.member

(type_identifier) @type

(primitive_type) @type.builtin

; ---------------------------------------------------------------------------
; Functions
; ---------------------------------------------------------------------------

(function_declaration name: (identifier) @function)

(extern_declaration name: (identifier) @function)

(call_expression function: (identifier) @function.call)

; ---------------------------------------------------------------------------
; Literals
; ---------------------------------------------------------------------------

(number_literal) @number

((number_literal) @number.float
  (#match? @number.float "\\."))

(boolean_literal) @boolean

(string_literal) @string

(char_literal) @character

(escape_sequence) @string.escape

(comment) @comment @spell

; ---------------------------------------------------------------------------
; Keywords
; ---------------------------------------------------------------------------

[
  "fn"
  "extern"
  "struct"
  "let"
] @keyword

"as" @keyword.operator

[
  "if"
  "else"
] @keyword.conditional

"while" @keyword.repeat

[
  "break"
  "continue"
] @keyword.repeat

"return" @keyword.return

[
  "print"
  "sizeof"
] @function.builtin

; ---------------------------------------------------------------------------
; Operators and punctuation
; ---------------------------------------------------------------------------

[
  "+"
  "-"
  "*"
  "/"
  "%"
  "&"
  "|"
  "^"
  "!"
  "<"
  ">"
  "="
  "=="
  "!="
  "<="
  ">="
  "&&"
  "||"
  "<<"
  ">>"
  "+="
  "-="
  "*="
  "/="
  "%="
] @operator

(pointer_type "*" @punctuation.special)

[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ","
  ":"
  ";"
  "."
] @punctuation.delimiter
