(function_declaration) @local.scope
(block) @local.scope

(parameter name: (identifier) @local.definition.parameter)
(variable_declaration name: (identifier) @local.definition.var)
(function_declaration name: (identifier) @local.definition.function)
(extern_declaration name: (identifier) @local.definition.function)
(struct_declaration name: (type_identifier) @local.definition.type)

(import_specifier alias: (identifier) @local.definition.import)
(import_specifier !alias name: (identifier) @local.definition.import)

(identifier) @local.reference
