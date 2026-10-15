/**
 * Tree-sitter grammar for the Ode language.
 *
 * Mirrors docs/grammar.md in the repository. Precedence numbers follow the
 * "Operator Precedence" table there, lowest binding first.
 */

const PREC = {
  logic_or: 1,
  logic_and: 2,
  bit_or: 3,
  bit_xor: 4,
  bit_and: 5,
  equality: 6,
  comparison: 7,
  shift: 8,
  term: 9,
  factor: 10,
  cast: 11,
  unary: 12,
  postfix: 13,
  call: 14,
};

module.exports = grammar({
  name: 'ode',

  extras: $ => [/\s/, $.comment],

  word: $ => $.identifier,

  rules: {
    source_file: $ => repeat($._top_level),

    _top_level: $ => choice(
      $.import_declaration,
      $.export_declaration,
      $.function_declaration,
      $.extern_declaration,
      $.struct_declaration,
      $.enum_declaration,
      $._statement,
    ),

    // -----------------------------------------------------------------------
    // Declarations
    // -----------------------------------------------------------------------

    // `from` is only a keyword here; elsewhere it is an ordinary identifier.
    import_declaration: $ => seq(
      'import',
      '{',
      optional(seq(
        $.import_specifier,
        repeat(seq(',', $.import_specifier)),
        optional(','),
      )),
      '}',
      'from',
      field('source', $.string_literal),
      ';',
    ),

    import_specifier: $ => seq(
      field('name', $.identifier),
      optional(seq('as', field('alias', $.identifier))),
    ),

    export_declaration: $ => seq(
      'export',
      field('declaration', choice(
        $.function_declaration,
        $.extern_declaration,
        $.struct_declaration,
        $.enum_declaration,
        $.variable_declaration,
      )),
    ),

    function_declaration: $ => seq(
      'fn',
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      ':',
      field('return_type', $.type),
      field('body', $.block),
    ),

    extern_declaration: $ => seq(
      'extern',
      'fn',
      field('name', $.identifier),
      field('parameters', $.parameter_list),
      ':',
      field('return_type', $.type),
      ';',
    ),

    parameter_list: $ => seq(
      '(',
      optional(seq($.parameter, repeat(seq(',', $.parameter)), optional(','))),
      ')',
    ),

    parameter: $ => seq(
      field('name', $.identifier),
      ':',
      field('type', $.type),
    ),

    enum_declaration: $ => seq(
      'enum',
      field('name', $._type_identifier),
      '{',
      optional(seq(
        $.enum_member,
        repeat(seq(',', $.enum_member)),
        optional(','),
      )),
      '}',
    ),

    enum_member: $ => seq(
      field('name', $.identifier),
      optional(seq('=', field('value', $._expression))),
    ),

    struct_declaration: $ => seq(
      'struct',
      field('name', $._type_identifier),
      field('body', $.field_declaration_list),
    ),

    // Fields and methods, in any order.
    field_declaration_list: $ => seq(
      '{',
      repeat(choice($.field_declaration, $.function_declaration)),
      '}',
    ),

    field_declaration: $ => seq(
      field('name', $._field_identifier),
      ':',
      field('type', $.type),
      optional(','),
    ),

    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    type: $ => choice(
      $.pointer_type,
      $.primitive_type,
      $._type_identifier,
    ),

    pointer_type: $ => prec.right(seq('*', $.type)),

    primitive_type: $ => choice(
      'i8', 'u8', 'i16', 'u16', 'i32', 'u32', 'i64', 'u64',
      'usize', 'f32', 'f64', 'bool', 'void',
    ),

    // -----------------------------------------------------------------------
    // Statements
    // -----------------------------------------------------------------------

    _statement: $ => choice(
      $.variable_declaration,
      $.assignment_statement,
      $.if_statement,
      $.while_statement,
      $.match_statement,
      $.break_statement,
      $.continue_statement,
      $.return_statement,
      $.print_statement,
      $.expression_statement,
      $.block,
    ),

    block: $ => seq('{', repeat($._statement), '}'),

    match_statement: $ => seq(
      'match',
      '(',
      field('value', $._expression),
      ')',
      '{',
      repeat($.match_arm),
      '}',
    ),

    match_arm: $ => seq(
      choice(
        field('else', 'else'),
        seq($._expression, repeat(seq(',', $._expression))),
      ),
      '=>',
      field('body', $.block),
    ),

    variable_declaration: $ => seq(
      'let',
      field('name', $.identifier),
      ':',
      field('type', $.type),
      '=',
      field('value', $._expression),
      ';',
    ),

    assignment_statement: $ => seq(
      field('left', $._expression),
      field('operator', choice('=', '+=', '-=', '*=', '/=', '%=')),
      field('right', $._expression),
      ';',
    ),

    if_statement: $ => seq(
      'if',
      '(', field('condition', $._expression), ')',
      field('consequence', $.block),
      optional(seq('else', field('alternative', choice($.block, $.if_statement)))),
    ),

    while_statement: $ => seq(
      'while',
      '(', field('condition', $._expression), ')',
      field('body', $.block),
    ),

    break_statement: _ => seq('break', ';'),
    continue_statement: _ => seq('continue', ';'),

    return_statement: $ => seq('return', optional($._expression), ';'),

    print_statement: $ => seq('print', '(', $._expression, ')', ';'),

    expression_statement: $ => seq($._expression, ';'),

    // -----------------------------------------------------------------------
    // Expressions
    // -----------------------------------------------------------------------

    _expression: $ => choice(
      $.binary_expression,
      $.unary_expression,
      $.cast_expression,
      $.field_expression,
      $.index_expression,
      $.call_expression,
      $.method_call_expression,
      $.struct_literal,
      $.sizeof_expression,
      $.parenthesized_expression,
      $.identifier,
      $.number_literal,
      $.string_literal,
      $.char_literal,
      $.boolean_literal,
      $.null_literal,
    ),

    binary_expression: $ => {
      const table = [
        [PREC.logic_or, '||'],
        [PREC.logic_and, '&&'],
        [PREC.bit_or, '|'],
        [PREC.bit_xor, '^'],
        [PREC.bit_and, '&'],
        [PREC.equality, choice('==', '!=')],
        [PREC.comparison, choice('<', '<=', '>', '>=')],
        [PREC.shift, choice('<<', '>>')],
        [PREC.term, choice('+', '-')],
        [PREC.factor, choice('*', '/', '%')],
      ];

      return choice(...table.map(([precedence, operator]) => prec.left(precedence, seq(
        field('left', $._expression),
        field('operator', operator),
        field('right', $._expression),
      ))));
    },

    unary_expression: $ => prec.right(PREC.unary, seq(
      field('operator', choice('-', '+', '!', '*', '&')),
      field('operand', $._expression),
    )),

    cast_expression: $ => prec.left(PREC.cast, seq(
      field('value', $._expression),
      'as',
      field('type', $.type),
    )),

    field_expression: $ => prec.left(PREC.postfix, seq(
      field('object', $._expression),
      '.',
      field('field', $._field_identifier),
    )),

    index_expression: $ => prec.left(PREC.postfix, seq(
      field('object', $._expression),
      '[',
      field('index', $._expression),
      ']',
    )),

    call_expression: $ => prec.left(PREC.call, seq(
      field('function', $.identifier),
      field('arguments', $.argument_list),
    )),

    // `value.method(...)`, or `Struct.function(...)`: which one it is depends
    // on what the name in front means, which only the compiler knows.
    method_call_expression: $ => prec.left(PREC.call, seq(
      field('object', $._expression),
      '.',
      field('method', $._field_identifier),
      field('arguments', $.argument_list),
    )),

    argument_list: $ => seq(
      '(',
      optional(seq($._expression, repeat(seq(',', $._expression)), optional(','))),
      ')',
    ),

    struct_literal: $ => prec(PREC.call, seq(
      field('name', $._type_identifier),
      field('body', $.field_initializer_list),
    )),

    field_initializer_list: $ => seq('{', repeat($.field_initializer), '}'),

    field_initializer: $ => seq(
      field('name', $._field_identifier),
      ':',
      field('value', $._expression),
      optional(','),
    ),

    sizeof_expression: $ => seq('sizeof', '(', field('type', $.type), ')'),

    parenthesized_expression: $ => seq('(', $._expression, ')'),

    // -----------------------------------------------------------------------
    // Lexical elements
    // -----------------------------------------------------------------------

    identifier: _ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    // Aliases of `identifier`, so that a highlight query can tell a type name
    // and a field name apart from an ordinary variable reference.
    _type_identifier: $ => alias($.identifier, $.type_identifier),
    _field_identifier: $ => alias($.identifier, $.field_identifier),

    number_literal: _ => /[0-9]+(\.[0-9]+)?/,

    boolean_literal: _ => choice('true', 'false'),

    null_literal: _ => 'null',

    string_literal: $ => seq(
      '"',
      repeat(choice($.escape_sequence, token.immediate(/[^"\\\n]+/))),
      '"',
    ),

    char_literal: $ => seq(
      "'",
      choice($.escape_sequence, token.immediate(/[^'\\\n]/)),
      "'",
    ),

    escape_sequence: _ => token.immediate(/\\[ntr0\\"']/),

    comment: _ => token(seq('//', /[^\n]*/)),
  },
});
