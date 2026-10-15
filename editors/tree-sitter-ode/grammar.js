/**
 * Tree-sitter grammar for the Ode language.
 *
 * Mirrors docs/grammar.md in the repository. Precedence numbers follow the
 * "Operator Precedence" table there, lowest binding first.
 */

const PREC = {
  catch: -1,
  coalesce: 0,
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

  // `Name<` starts type arguments or a comparison; the parser keeps both
  // readings until one of them fails, as the compiler's lookahead does.
  conflicts: $ => [
    [$._expression, $.generic_expression],
  ],

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
      $.test_declaration,
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

    type_parameters: $ => seq('<', $.identifier, repeat(seq(',', $.identifier)), '>'),

    type_arguments: $ => prec.dynamic(1, seq('<', $.type, repeat(seq(',', $.type)), '>')),

    function_declaration: $ => seq(
      'fn',
      field('name', $.identifier),
      optional(field('type_parameters', $.type_parameters)),
      field('parameters', $.parameter_list),
      ':',
      field('return_type', $._declared_type),
      field('body', $.block),
    ),

    // `test` is only a keyword when a string follows it.
    test_declaration: $ => seq(
      'test',
      field('name', $.string_literal),
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
      optional(choice(
        seq($.parameter, repeat(seq(',', $.parameter)),
            optional(seq(',', $.variadic))),
        $.variadic,
      )),
      ')',
    ),

    variadic: _ => '...',

    parameter: $ => seq(
      field('name', $.identifier),
      ':',
      field('type', $._declared_type),
    ),

    enum_declaration: $ => seq(
      optional(alias('error', 'error')),
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
      optional(field('type_parameters', $.type_parameters)),
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
      field('type', $._declared_type),
      optional(','),
    ),

    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    // Where a value is declared, its type may be a union: the value, then
    // the errors it may be instead.
    _declared_type: $ => choice($.type, $.union_type),

    union_type: $ => seq($.type, repeat1(seq('|', $.type))),

    type: $ => choice(
      $.pointer_type,
      $.function_type,
      $.primitive_type,
      $.generic_type,
      $._type_identifier,
    ),

    generic_type: $ => prec(1, seq(
      field('name', $._type_identifier),
      field('arguments', $.type_arguments),
    )),

    function_type: $ => seq(
      'fn',
      '(',
      optional(seq($.type, repeat(seq(',', $.type)))),
      ')',
      ':',
      field('result', $.type),
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
      $.for_statement,
      $.match_statement,
      $.break_statement,
      $.continue_statement,
      $.return_statement,
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
      field('type', $._declared_type),
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

    // `in` is only a keyword here, so it is matched as a word.
    for_statement: $ => seq(
      'for',
      '(',
      field('variable', $.identifier),
      'in',
      field('start', $._expression),
      '..',
      field('end', $._expression),
      ')',
      field('body', $.block),
    ),

    break_statement: _ => seq('break', ';'),
    continue_statement: _ => seq('continue', ';'),

    return_statement: $ => seq('return', optional($._expression), ';'),


    expression_statement: $ => seq($._expression, ';'),

    // -----------------------------------------------------------------------
    // Expressions
    // -----------------------------------------------------------------------

    _expression: $ => choice(
      $.binary_expression,
      $.unary_expression,
      $.try_expression,
      $.catch_expression,
      $.is_expression,
      $.cast_expression,
      $.field_expression,
      $.index_expression,
      $.call_expression,
      $.method_call_expression,
      $.generic_expression,
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
        [PREC.coalesce, '??'],
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

    // `try value`: the value, or its error passed on.
    try_expression: $ => prec.right(PREC.unary, seq('try', field('value', $._expression))),

    // `value catch (e) { ... }`: the value, or the block run with its error.
    catch_expression: $ => prec.left(PREC.catch, seq(
      field('value', $._expression),
      'catch',
      '(',
      field('error', $.identifier),
      ')',
      field('handler', $.block),
    )),

    // `value is SomeError`; `is` is only a keyword here.
    is_expression: $ => prec.left(PREC.comparison, seq(
      field('value', $._expression),
      'is',
      field('type', $.type),
    )),

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
      field('function', choice($.identifier, $.generic_expression,
                               $.index_expression, $.call_expression,
                               $.parenthesized_expression)),
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

    // `List<i32>` in an expression: before `.new()`, `(...)` or `{ ... }`.
    generic_expression: $ => prec.dynamic(1, seq(
      field('name', $.identifier),
      field('arguments', $.type_arguments),
    )),

    argument_list: $ => seq(
      '(',
      optional(seq($._expression, repeat(seq(',', $._expression)), optional(','))),
      ')',
    ),

    struct_literal: $ => prec(PREC.call, seq(
      field('name', choice($._type_identifier, $.generic_expression)),
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

    string_literal: $ => choice(
      seq(
        '"',
        repeat(choice($.escape_sequence, token.immediate(/[^"\\\n]+/))),
        '"',
      ),
      // Backticks: as written, across lines, with no escapes.
      seq('`', optional(token.immediate(/[^`]+/)), token.immediate('`')),
    ),

    char_literal: $ => seq(
      "'",
      choice($.escape_sequence, token.immediate(/[^'\\\n]/)),
      "'",
    ),

    escape_sequence: _ => token.immediate(/\\([ntr0\\"']|x[0-9a-fA-F]{2})/),

    comment: _ => token(seq('//', /[^\n]*/)),
  },
});
