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
(null_literal) @constant.builtin

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
  "enum"
  "let"
] @keyword

"match" @keyword.conditional
"=>" @punctuation.delimiter

(enum_member name: (identifier) @constant)

"as" @keyword.operator

[
  "import"
  "export"
  "from"
] @keyword.import

(import_declaration source: (string_literal) @string.special.path)

[
  "if"
  "else"
] @keyword.conditional

"while" @keyword.repeat
"for" @keyword.repeat
"in" @keyword.repeat
".." @operator

[
  "break"
  "continue"
] @keyword.repeat

"return" @keyword.return

"sizeof" @function.builtin

(test_declaration "test" @keyword)

((call_expression
  function: (identifier) @function.builtin)
 (#any-of? @function.builtin "assert" "assertEq"))

(variadic) @punctuation.special

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

; Methods

(field_declaration_list
  (function_declaration name: (identifier) @function.method))

(method_call_expression method: (field_identifier) @function.method.call)

((identifier) @variable.builtin
  (#eq? @variable.builtin "self"))
