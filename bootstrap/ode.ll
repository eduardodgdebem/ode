%Buf = type { ptr, i64, i64 }
%Diagnostic = type { ptr, ptr, i32, i32 }
%Diagnostics = type { ptr, i32, i32, i32 }
%Token = type { i32, ptr, i64, i32, i32 }
%TokenList = type { ptr, i32, i32 }
%Lexer = type { ptr, i64, i64, i32, i32 }
%Node = type { i32, i32, i32, ptr, i64, i32, i32, i32, i32, ptr, i32, i32, i32, i1 }
%Ast = type { ptr, i32, i32, i32 }
%Parser = type { ptr, ptr, i32, i1 }
%Type = type { i32, i32, ptr }
%FieldDef = type { ptr, %Type }
%StructLayout = type { ptr, ptr, i32, i32 }
%StructTable = type { ptr, i32, i32 }
%Symbol = type { ptr, i32, %Type, ptr, i32, ptr }
%SymbolTable = type { ptr, i32, i32, ptr, i32, i32 }
%Module = type { ptr, ptr }
%NameSet = type { ptr, i32, i32 }
%SymbolList = type { ptr, i32 }
%Analyzer = type { ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i1, %Type }
%Local = type { ptr, ptr, %Type }
%Emitter = type { ptr, ptr, ptr, ptr, i32, i32, i32, i1, ptr, i32, i32, ptr, i32, i32, ptr, ptr, i32, i32 }
declare i32 @printf(ptr, ...)
declare ptr @malloc(i64)
declare ptr @realloc(ptr, i64)
declare void @free(ptr)
declare ptr @memcpy(ptr, ptr, i64)
declare i64 @strlen(ptr)
declare i32 @strcmp(ptr, ptr)
declare i64 @write(i32, ptr, i64)
declare void @exit(i32)
declare ptr @fopen(ptr, ptr)
declare i32 @fclose(ptr)
declare i64 @fread(ptr, i64, i64, ptr)
declare i64 @fwrite(ptr, i64, i64, ptr)
declare i32 @fseek(ptr, i64, i32)
declare i64 @ftell(ptr)
declare i32 @remove(ptr)
declare i32 @fork()
declare i32 @execvp(ptr, ptr)
declare i32 @waitpid(i32, ptr, i32)
declare void @_exit(i32)
declare ptr @realpath(ptr, ptr)
@STDOUT = global i32 1
@STDERR = global i32 2
@SEEK_SET = global i32 0
@SEEK_END = global i32 2
@DIAG_LIMIT = global i32 20
@DIAGS = global ptr null
@FAILED = global i1 false
@TK_NONE = global i32 -1
@TK_END = global i32 0
@TK_IDENT = global i32 1
@TK_NUMBER = global i32 2
@TK_STRING = global i32 3
@TK_CHAR = global i32 4
@TK_BOOL = global i32 5
@TK_TYPE = global i32 6
@TK_LET = global i32 10
@TK_IF = global i32 11
@TK_ELSE = global i32 12
@TK_FN = global i32 13
@TK_EXTERN = global i32 14
@TK_STRUCT = global i32 15
@TK_SIZEOF = global i32 16
@TK_RETURN = global i32 17
@TK_WHILE = global i32 18
@TK_BREAK = global i32 19
@TK_CONTINUE = global i32 20
@TK_PRINT = global i32 21
@TK_AS = global i32 22
@TK_IMPORT = global i32 23
@TK_EXPORT = global i32 24
@TK_ASSIGN = global i32 30
@TK_PLUS = global i32 31
@TK_MINUS = global i32 32
@TK_STAR = global i32 33
@TK_SLASH = global i32 34
@TK_PERCENT = global i32 35
@TK_NOT = global i32 36
@TK_AMP = global i32 37
@TK_PIPE = global i32 38
@TK_CARET = global i32 39
@TK_SHL = global i32 40
@TK_SHR = global i32 41
@TK_ANDAND = global i32 42
@TK_OROR = global i32 43
@TK_EQ = global i32 44
@TK_NE = global i32 45
@TK_LT = global i32 46
@TK_LE = global i32 47
@TK_GT = global i32 48
@TK_GE = global i32 49
@TK_PLUS_ASSIGN = global i32 50
@TK_MINUS_ASSIGN = global i32 51
@TK_STAR_ASSIGN = global i32 52
@TK_SLASH_ASSIGN = global i32 53
@TK_PERCENT_ASSIGN = global i32 54
@TK_LPAREN = global i32 60
@TK_RPAREN = global i32 61
@TK_LBRACE = global i32 62
@TK_RBRACE = global i32 63
@TK_LBRACKET = global i32 64
@TK_RBRACKET = global i32 65
@TK_DOT = global i32 66
@TK_SEMICOLON = global i32 67
@TK_COMMA = global i32 68
@TK_COLON = global i32 69
@NO_NODE = global i32 -1
@NK_PROGRAM = global i32 1
@NK_BLOCK = global i32 2
@NK_VARDECL = global i32 3
@NK_ASSIGN = global i32 4
@NK_IF = global i32 5
@NK_WHILE = global i32 6
@NK_BREAK = global i32 7
@NK_CONTINUE = global i32 8
@NK_FN = global i32 9
@NK_EXTERN = global i32 10
@NK_STRUCT = global i32 11
@NK_FIELD = global i32 12
@NK_CALL = global i32 13
@NK_RETURN = global i32 14
@NK_PRINT = global i32 15
@NK_EXPRSTMT = global i32 16
@NK_BINARY = global i32 17
@NK_UNARY = global i32 18
@NK_CAST = global i32 19
@NK_FIELDACCESS = global i32 20
@NK_INDEX = global i32 21
@NK_STRUCTLIT = global i32 22
@NK_FINIT = global i32 23
@NK_SIZEOF = global i32 24
@NK_NUMBER = global i32 25
@NK_STRING = global i32 26
@NK_CHAR = global i32 27
@NK_BOOL = global i32 28
@NK_IDENT = global i32 29
@NK_TYPE = global i32 30
@NK_PARAMS = global i32 31
@NK_PARAM = global i32 32
@NK_ARGS = global i32 33
@NK_ERROR = global i32 34
@NK_IMPORT = global i32 35
@NK_IMPORTNAME = global i32 36
@TY_NONE = global i32 0
@TY_I8 = global i32 1
@TY_U8 = global i32 2
@TY_I16 = global i32 3
@TY_U16 = global i32 4
@TY_I32 = global i32 5
@TY_U32 = global i32 6
@TY_I64 = global i32 7
@TY_U64 = global i32 8
@TY_F32 = global i32 9
@TY_F64 = global i32 10
@TY_BOOL = global i32 11
@TY_VOID = global i32 12
@TY_STRUCT = global i32 13
@MAX_U64 = global i64 18446744073709551615
@SYM_VAR = global i32 1
@SYM_FN = global i32 2
@MODULES = global ptr null
@MODULE_COUNT = global i32 0
@MODULE_CAPACITY = global i32 0
@.str.0 = private unnamed_addr constant [7 x i8] c"<none>\00"
@SOURCE_PATH = global ptr @.str.0
@.str.1 = private unnamed_addr constant [115 x i8] c"usage: ode [-o <path>] [--no-intermediates] [--emit-llvm] [--dump-tokens | --dump-ast | --dump-types] <input.ode>\0A\00"
@USAGE = global ptr @.str.1
@.str.2 = private unnamed_addr constant [10 x i8] c": error: \00"
@.str.3 = private unnamed_addr constant [38 x i8] c" errors generated, showing the first \00"
@.str.4 = private unnamed_addr constant [3 x i8] c".\0A\00"
@.str.5 = private unnamed_addr constant [20 x i8] c" errors generated.\0A\00"
@.str.6 = private unnamed_addr constant [10 x i8] c": error: \00"
@.str.7 = private unnamed_addr constant [10 x i8] c": error: \00"
@.str.8 = private unnamed_addr constant [2 x i8] c"r\00"
@.str.9 = private unnamed_addr constant [2 x i8] c"w\00"
@.str.10 = private unnamed_addr constant [4 x i8] c"end\00"
@.str.11 = private unnamed_addr constant [6 x i8] c"ident\00"
@.str.12 = private unnamed_addr constant [7 x i8] c"number\00"
@.str.13 = private unnamed_addr constant [7 x i8] c"string\00"
@.str.14 = private unnamed_addr constant [5 x i8] c"char\00"
@.str.15 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.16 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.17 = private unnamed_addr constant [4 x i8] c"let\00"
@.str.18 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.19 = private unnamed_addr constant [5 x i8] c"else\00"
@.str.20 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.21 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str.22 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.23 = private unnamed_addr constant [7 x i8] c"sizeof\00"
@.str.24 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.25 = private unnamed_addr constant [6 x i8] c"while\00"
@.str.26 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.27 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.28 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.29 = private unnamed_addr constant [3 x i8] c"as\00"
@.str.30 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.31 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.32 = private unnamed_addr constant [2 x i8] c"=\00"
@.str.33 = private unnamed_addr constant [2 x i8] c"+\00"
@.str.34 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.35 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.36 = private unnamed_addr constant [2 x i8] c"/\00"
@.str.37 = private unnamed_addr constant [2 x i8] c"%\00"
@.str.38 = private unnamed_addr constant [2 x i8] c"!\00"
@.str.39 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.40 = private unnamed_addr constant [2 x i8] c"|\00"
@.str.41 = private unnamed_addr constant [2 x i8] c"^\00"
@.str.42 = private unnamed_addr constant [3 x i8] c"<<\00"
@.str.43 = private unnamed_addr constant [3 x i8] c">>\00"
@.str.44 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.45 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.46 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.47 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.48 = private unnamed_addr constant [2 x i8] c"<\00"
@.str.49 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.50 = private unnamed_addr constant [2 x i8] c">\00"
@.str.51 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.52 = private unnamed_addr constant [3 x i8] c"+=\00"
@.str.53 = private unnamed_addr constant [3 x i8] c"-=\00"
@.str.54 = private unnamed_addr constant [3 x i8] c"*=\00"
@.str.55 = private unnamed_addr constant [3 x i8] c"/=\00"
@.str.56 = private unnamed_addr constant [3 x i8] c"%=\00"
@.str.57 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.58 = private unnamed_addr constant [2 x i8] c")\00"
@.str.59 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.60 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.61 = private unnamed_addr constant [2 x i8] c"[\00"
@.str.62 = private unnamed_addr constant [2 x i8] c"]\00"
@.str.63 = private unnamed_addr constant [2 x i8] c".\00"
@.str.64 = private unnamed_addr constant [2 x i8] c";\00"
@.str.65 = private unnamed_addr constant [2 x i8] c",\00"
@.str.66 = private unnamed_addr constant [2 x i8] c":\00"
@.str.67 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.68 = private unnamed_addr constant [4 x i8] c"let\00"
@.str.69 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.70 = private unnamed_addr constant [5 x i8] c"else\00"
@.str.71 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.72 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str.73 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.74 = private unnamed_addr constant [7 x i8] c"sizeof\00"
@.str.75 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.76 = private unnamed_addr constant [6 x i8] c"while\00"
@.str.77 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.78 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.79 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.80 = private unnamed_addr constant [3 x i8] c"as\00"
@.str.81 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.82 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.83 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.84 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.85 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str.86 = private unnamed_addr constant [3 x i8] c"u8\00"
@.str.87 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str.88 = private unnamed_addr constant [4 x i8] c"u16\00"
@.str.89 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.90 = private unnamed_addr constant [4 x i8] c"u32\00"
@.str.91 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.92 = private unnamed_addr constant [4 x i8] c"u64\00"
@.str.93 = private unnamed_addr constant [6 x i8] c"usize\00"
@.str.94 = private unnamed_addr constant [4 x i8] c"f32\00"
@.str.95 = private unnamed_addr constant [4 x i8] c"f64\00"
@.str.96 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.97 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.98 = private unnamed_addr constant [24 x i8] c"unknown escape sequence\00"
@.str.99 = private unnamed_addr constant [28 x i8] c"unterminated string literal\00"
@.str.100 = private unnamed_addr constant [39 x i8] c"string literal may not cross a newline\00"
@.str.101 = private unnamed_addr constant [50 x i8] c"character literal must hold exactly one character\00"
@.str.102 = private unnamed_addr constant [21 x i8] c"unexpected character\00"
@.str.103 = private unnamed_addr constant [1 x i8] c"\00"
@.str.104 = private unnamed_addr constant [8 x i8] c"program\00"
@.str.105 = private unnamed_addr constant [6 x i8] c"block\00"
@.str.106 = private unnamed_addr constant [8 x i8] c"vardecl\00"
@.str.107 = private unnamed_addr constant [7 x i8] c"assign\00"
@.str.108 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.109 = private unnamed_addr constant [6 x i8] c"while\00"
@.str.110 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.111 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.112 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.113 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str.114 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.115 = private unnamed_addr constant [6 x i8] c"field\00"
@.str.116 = private unnamed_addr constant [5 x i8] c"call\00"
@.str.117 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.118 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.119 = private unnamed_addr constant [9 x i8] c"exprstmt\00"
@.str.120 = private unnamed_addr constant [7 x i8] c"binary\00"
@.str.121 = private unnamed_addr constant [6 x i8] c"unary\00"
@.str.122 = private unnamed_addr constant [5 x i8] c"cast\00"
@.str.123 = private unnamed_addr constant [12 x i8] c"fieldaccess\00"
@.str.124 = private unnamed_addr constant [6 x i8] c"index\00"
@.str.125 = private unnamed_addr constant [10 x i8] c"structlit\00"
@.str.126 = private unnamed_addr constant [6 x i8] c"finit\00"
@.str.127 = private unnamed_addr constant [7 x i8] c"sizeof\00"
@.str.128 = private unnamed_addr constant [7 x i8] c"number\00"
@.str.129 = private unnamed_addr constant [7 x i8] c"string\00"
@.str.130 = private unnamed_addr constant [5 x i8] c"char\00"
@.str.131 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.132 = private unnamed_addr constant [6 x i8] c"ident\00"
@.str.133 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.134 = private unnamed_addr constant [7 x i8] c"params\00"
@.str.135 = private unnamed_addr constant [6 x i8] c"param\00"
@.str.136 = private unnamed_addr constant [5 x i8] c"args\00"
@.str.137 = private unnamed_addr constant [6 x i8] c"error\00"
@.str.138 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.139 = private unnamed_addr constant [11 x i8] c"importname\00"
@.str.140 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.141 = private unnamed_addr constant [11 x i8] c"expected '\00"
@.str.142 = private unnamed_addr constant [12 x i8] c"' but got '\00"
@.str.143 = private unnamed_addr constant [12 x i8] c"end of file\00"
@.str.144 = private unnamed_addr constant [5 x i8] c"type\00"
@.str.145 = private unnamed_addr constant [11 x i8] c"field name\00"
@.str.146 = private unnamed_addr constant [2 x i8] c"]\00"
@.str.147 = private unnamed_addr constant [2 x i8] c")\00"
@.str.148 = private unnamed_addr constant [55 x i8] c"number, string, character, boolean, identifier, or '('\00"
@.str.149 = private unnamed_addr constant [7 x i8] c"sizeof\00"
@.str.150 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.151 = private unnamed_addr constant [2 x i8] c")\00"
@.str.152 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.153 = private unnamed_addr constant [2 x i8] c")\00"
@.str.154 = private unnamed_addr constant [12 x i8] c"struct name\00"
@.str.155 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.156 = private unnamed_addr constant [11 x i8] c"field name\00"
@.str.157 = private unnamed_addr constant [2 x i8] c":\00"
@.str.158 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.159 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.160 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str.161 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.162 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.163 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.164 = private unnamed_addr constant [57 x i8] c"' declarations are only allowed at the top level of the \00"
@.str.165 = private unnamed_addr constant [8 x i8] c"program\00"
@.str.166 = private unnamed_addr constant [4 x i8] c"let\00"
@.str.167 = private unnamed_addr constant [11 x i8] c"identifier\00"
@.str.168 = private unnamed_addr constant [2 x i8] c":\00"
@.str.169 = private unnamed_addr constant [2 x i8] c"=\00"
@.str.170 = private unnamed_addr constant [2 x i8] c";\00"
@.str.171 = private unnamed_addr constant [2 x i8] c";\00"
@.str.172 = private unnamed_addr constant [2 x i8] c";\00"
@.str.173 = private unnamed_addr constant [2 x i8] c";\00"
@.str.174 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.175 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.176 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.177 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.178 = private unnamed_addr constant [2 x i8] c")\00"
@.str.179 = private unnamed_addr constant [6 x i8] c"while\00"
@.str.180 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.181 = private unnamed_addr constant [2 x i8] c")\00"
@.str.182 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.183 = private unnamed_addr constant [2 x i8] c";\00"
@.str.184 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.185 = private unnamed_addr constant [2 x i8] c";\00"
@.str.186 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.187 = private unnamed_addr constant [2 x i8] c";\00"
@.str.188 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.189 = private unnamed_addr constant [2 x i8] c";\00"
@.str.190 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.191 = private unnamed_addr constant [15 x i8] c"parameter name\00"
@.str.192 = private unnamed_addr constant [2 x i8] c":\00"
@.str.193 = private unnamed_addr constant [2 x i8] c")\00"
@.str.194 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.195 = private unnamed_addr constant [11 x i8] c"identifier\00"
@.str.196 = private unnamed_addr constant [2 x i8] c":\00"
@.str.197 = private unnamed_addr constant [7 x i8] c"extern\00"
@.str.198 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.199 = private unnamed_addr constant [11 x i8] c"identifier\00"
@.str.200 = private unnamed_addr constant [2 x i8] c":\00"
@.str.201 = private unnamed_addr constant [2 x i8] c";\00"
@.str.202 = private unnamed_addr constant [7 x i8] c"struct\00"
@.str.203 = private unnamed_addr constant [12 x i8] c"struct name\00"
@.str.204 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.205 = private unnamed_addr constant [11 x i8] c"field name\00"
@.str.206 = private unnamed_addr constant [2 x i8] c":\00"
@.str.207 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.208 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.209 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.210 = private unnamed_addr constant [14 x i8] c"imported name\00"
@.str.211 = private unnamed_addr constant [6 x i8] c"alias\00"
@.str.212 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.213 = private unnamed_addr constant [5 x i8] c"from\00"
@.str.214 = private unnamed_addr constant [5 x i8] c"from\00"
@.str.215 = private unnamed_addr constant [12 x i8] c"module path\00"
@.str.216 = private unnamed_addr constant [2 x i8] c";\00"
@.str.217 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.218 = private unnamed_addr constant [12 x i8] c"declaration\00"
@.str.219 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str.220 = private unnamed_addr constant [3 x i8] c"u8\00"
@.str.221 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str.222 = private unnamed_addr constant [4 x i8] c"u16\00"
@.str.223 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.224 = private unnamed_addr constant [4 x i8] c"u32\00"
@.str.225 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.226 = private unnamed_addr constant [4 x i8] c"u64\00"
@.str.227 = private unnamed_addr constant [4 x i8] c"f32\00"
@.str.228 = private unnamed_addr constant [4 x i8] c"f64\00"
@.str.229 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.230 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.231 = private unnamed_addr constant [8 x i8] c"unknown\00"
@.str.232 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str.233 = private unnamed_addr constant [3 x i8] c"u8\00"
@.str.234 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str.235 = private unnamed_addr constant [4 x i8] c"u16\00"
@.str.236 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.237 = private unnamed_addr constant [4 x i8] c"u32\00"
@.str.238 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.239 = private unnamed_addr constant [4 x i8] c"u64\00"
@.str.240 = private unnamed_addr constant [6 x i8] c"usize\00"
@.str.241 = private unnamed_addr constant [4 x i8] c"f32\00"
@.str.242 = private unnamed_addr constant [4 x i8] c"f64\00"
@.str.243 = private unnamed_addr constant [5 x i8] c"bool\00"
@.str.244 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.245 = private unnamed_addr constant [9 x i8] c"symbol '\00"
@.str.246 = private unnamed_addr constant [33 x i8] c"' already declared in this scope\00"
@.str.247 = private unnamed_addr constant [5 x i8] c".ode\00"
@.str.248 = private unnamed_addr constant [5 x i8] c".ode\00"
@.str.249 = private unnamed_addr constant [9 x i8] c"module '\00"
@.str.250 = private unnamed_addr constant [24 x i8] c"' has no export named '\00"
@.str.251 = private unnamed_addr constant [25 x i8] c"' is not exported from '\00"
@.str.252 = private unnamed_addr constant [7 x i8] c"type '\00"
@.str.253 = private unnamed_addr constant [19 x i8] c"' is declared in '\00"
@.str.254 = private unnamed_addr constant [24 x i8] c"' but not imported here\00"
@.str.255 = private unnamed_addr constant [3 x i8] c": \00"
@.str.256 = private unnamed_addr constant [11 x i8] c"expected '\00"
@.str.257 = private unnamed_addr constant [12 x i8] c"' but got '\00"
@.str.258 = private unnamed_addr constant [6 x i8] c"got '\00"
@.str.259 = private unnamed_addr constant [6 x i8] c"got '\00"
@.str.260 = private unnamed_addr constant [8 x i8] c"' and '\00"
@.str.261 = private unnamed_addr constant [25 x i8] c"expected type annotation\00"
@.str.262 = private unnamed_addr constant [14 x i8] c"unknown type \00"
@.str.263 = private unnamed_addr constant [1 x i8] c"\00"
@.str.264 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.265 = private unnamed_addr constant [10 x i8] c"in sizeof\00"
@.str.266 = private unnamed_addr constant [28 x i8] c"sizeof(void) is not allowed\00"
@.str.267 = private unnamed_addr constant [20 x i8] c"undefined variable \00"
@.str.268 = private unnamed_addr constant [1 x i8] c"\00"
@.str.269 = private unnamed_addr constant [1 x i8] c"\00"
@.str.270 = private unnamed_addr constant [31 x i8] c" is a function, not a variable\00"
@.str.271 = private unnamed_addr constant [29 x i8] c"unknown expression node type\00"
@.str.272 = private unnamed_addr constant [47 x i8] c"left-hand side of assignment is not assignable\00"
@.str.273 = private unnamed_addr constant [20 x i8] c"undefined function \00"
@.str.274 = private unnamed_addr constant [1 x i8] c"\00"
@.str.275 = private unnamed_addr constant [1 x i8] c"\00"
@.str.276 = private unnamed_addr constant [19 x i8] c" is not a function\00"
@.str.277 = private unnamed_addr constant [10 x i8] c"expected \00"
@.str.278 = private unnamed_addr constant [10 x i8] c" but got \00"
@.str.279 = private unnamed_addr constant [30 x i8] c"wrong number of arguments to \00"
@.str.280 = private unnamed_addr constant [1 x i8] c"\00"
@.str.281 = private unnamed_addr constant [10 x i8] c"argument \00"
@.str.282 = private unnamed_addr constant [6 x i8] c" of '\00"
@.str.283 = private unnamed_addr constant [21 x i8] c"' has the wrong type\00"
@.str.284 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.285 = private unnamed_addr constant [45 x i8] c"cannot take the address of a temporary value\00"
@.str.286 = private unnamed_addr constant [40 x i8] c"cannot take the address of a void value\00"
@.str.287 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.288 = private unnamed_addr constant [39 x i8] c"unary minus requires a numeric operand\00"
@.str.289 = private unnamed_addr constant [2 x i8] c"+\00"
@.str.290 = private unnamed_addr constant [38 x i8] c"unary plus requires a numeric operand\00"
@.str.291 = private unnamed_addr constant [2 x i8] c"!\00"
@.str.292 = private unnamed_addr constant [37 x i8] c"logical NOT requires boolean operand\00"
@.str.293 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.294 = private unnamed_addr constant [39 x i8] c"cannot dereference a non-pointer value\00"
@.str.295 = private unnamed_addr constant [27 x i8] c"cannot dereference '*void'\00"
@.str.296 = private unnamed_addr constant [41 x i8] c"cast it to a concrete pointer type first\00"
@.str.297 = private unnamed_addr constant [24 x i8] c"unknown unary operator \00"
@.str.298 = private unnamed_addr constant [1 x i8] c"\00"
@.str.299 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.300 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.301 = private unnamed_addr constant [43 x i8] c"logical operators require boolean operands\00"
@.str.302 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.303 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.304 = private unnamed_addr constant [46 x i8] c"equality operators require same type operands\00"
@.str.305 = private unnamed_addr constant [27 x i8] c"cannot compare void values\00"
@.str.306 = private unnamed_addr constant [23 x i8] c"cannot compare struct \00"
@.str.307 = private unnamed_addr constant [8 x i8] c" values\00"
@.str.308 = private unnamed_addr constant [29 x i8] c"compare their fields instead\00"
@.str.309 = private unnamed_addr constant [2 x i8] c">\00"
@.str.310 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.311 = private unnamed_addr constant [2 x i8] c"<\00"
@.str.312 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.313 = private unnamed_addr constant [48 x i8] c"comparison operators require same type operands\00"
@.str.314 = private unnamed_addr constant [38 x i8] c"cannot compare boolean or void values\00"
@.str.315 = private unnamed_addr constant [21 x i8] c"cannot order struct \00"
@.str.316 = private unnamed_addr constant [8 x i8] c" values\00"
@.str.317 = private unnamed_addr constant [29 x i8] c"compare their fields instead\00"
@.str.318 = private unnamed_addr constant [2 x i8] c"+\00"
@.str.319 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.320 = private unnamed_addr constant [24 x i8] c"cannot add two pointers\00"
@.str.321 = private unnamed_addr constant [52 x i8] c"pointer difference requires identical pointer types\00"
@.str.322 = private unnamed_addr constant [47 x i8] c"cannot take the difference of '*void' pointers\00"
@.str.323 = private unnamed_addr constant [42 x i8] c"cannot subtract a pointer from an integer\00"
@.str.324 = private unnamed_addr constant [46 x i8] c"pointer arithmetic requires an integer offset\00"
@.str.325 = private unnamed_addr constant [32 x i8] c"cannot do arithmetic on '*void'\00"
@.str.326 = private unnamed_addr constant [41 x i8] c"cast it to a concrete pointer type first\00"
@.str.327 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.328 = private unnamed_addr constant [2 x i8] c"/\00"
@.str.329 = private unnamed_addr constant [38 x i8] c"pointers do not support this operator\00"
@.str.330 = private unnamed_addr constant [48 x i8] c"arithmetic operators require same type operands\00"
@.str.331 = private unnamed_addr constant [37 x i8] c"arithmetic requires numeric operands\00"
@.str.332 = private unnamed_addr constant [2 x i8] c"%\00"
@.str.333 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.334 = private unnamed_addr constant [2 x i8] c"|\00"
@.str.335 = private unnamed_addr constant [2 x i8] c"^\00"
@.str.336 = private unnamed_addr constant [3 x i8] c"<<\00"
@.str.337 = private unnamed_addr constant [3 x i8] c">>\00"
@.str.338 = private unnamed_addr constant [1 x i8] c"\00"
@.str.339 = private unnamed_addr constant [29 x i8] c" requires same type operands\00"
@.str.340 = private unnamed_addr constant [1 x i8] c"\00"
@.str.341 = private unnamed_addr constant [27 x i8] c" requires integer operands\00"
@.str.342 = private unnamed_addr constant [24 x i8] c"unknown binary operator\00"
@.str.343 = private unnamed_addr constant [14 x i8] c"cannot cast '\00"
@.str.344 = private unnamed_addr constant [7 x i8] c"' to '\00"
@.str.345 = private unnamed_addr constant [25 x i8] c"void is not a value type\00"
@.str.346 = private unnamed_addr constant [60 x i8] c"pointers only convert to a 64-bit integer (i64, u64, usize)\00"
@.str.347 = private unnamed_addr constant [62 x i8] c"only a 64-bit integer (i64, u64, usize) converts to a pointer\00"
@.str.348 = private unnamed_addr constant [19 x i8] c"no such conversion\00"
@.str.349 = private unnamed_addr constant [28 x i8] c"number is out of range for \00"
@.str.350 = private unnamed_addr constant [1 x i8] c"\00"
@.str.351 = private unnamed_addr constant [46 x i8] c"the value does not fit the type it is cast to\00"
@.str.352 = private unnamed_addr constant [42 x i8] c"use an explicit cast such as `... as i64`\00"
@.str.353 = private unnamed_addr constant [28 x i8] c"number is out of range for \00"
@.str.354 = private unnamed_addr constant [1 x i8] c"\00"
@.str.355 = private unnamed_addr constant [19 x i8] c"cannot read field \00"
@.str.356 = private unnamed_addr constant [1 x i8] c"\00"
@.str.357 = private unnamed_addr constant [1 x i8] c"\00"
@.str.358 = private unnamed_addr constant [17 x i8] c" is not a struct\00"
@.str.359 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.360 = private unnamed_addr constant [1 x i8] c"\00"
@.str.361 = private unnamed_addr constant [14 x i8] c"unknown type \00"
@.str.362 = private unnamed_addr constant [1 x i8] c"\00"
@.str.363 = private unnamed_addr constant [9 x i8] c"struct '\00"
@.str.364 = private unnamed_addr constant [17 x i8] c"' has no field '\00"
@.str.365 = private unnamed_addr constant [33 x i8] c"cannot index a non-pointer value\00"
@.str.366 = private unnamed_addr constant [21 x i8] c"cannot index '*void'\00"
@.str.367 = private unnamed_addr constant [41 x i8] c"cast it to a concrete pointer type first\00"
@.str.368 = private unnamed_addr constant [25 x i8] c"index must be an integer\00"
@.str.369 = private unnamed_addr constant [16 x i8] c"in literal for \00"
@.str.370 = private unnamed_addr constant [1 x i8] c"\00"
@.str.371 = private unnamed_addr constant [14 x i8] c"unknown type \00"
@.str.372 = private unnamed_addr constant [1 x i8] c"\00"
@.str.373 = private unnamed_addr constant [9 x i8] c"struct '\00"
@.str.374 = private unnamed_addr constant [17 x i8] c"' has no field '\00"
@.str.375 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.376 = private unnamed_addr constant [22 x i8] c" is initialised twice\00"
@.str.377 = private unnamed_addr constant [8 x i8] c"field '\00"
@.str.378 = private unnamed_addr constant [7 x i8] c"' of '\00"
@.str.379 = private unnamed_addr constant [21 x i8] c"' has the wrong type\00"
@.str.380 = private unnamed_addr constant [8 x i8] c"field '\00"
@.str.381 = private unnamed_addr constant [7 x i8] c"' of '\00"
@.str.382 = private unnamed_addr constant [13 x i8] c"' is missing\00"
@.str.383 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.384 = private unnamed_addr constant [29 x i8] c"break used outside of a loop\00"
@.str.385 = private unnamed_addr constant [32 x i8] c"continue used outside of a loop\00"
@.str.386 = private unnamed_addr constant [28 x i8] c"unknown statement node type\00"
@.str.387 = private unnamed_addr constant [19 x i8] c"in declaration of \00"
@.str.388 = private unnamed_addr constant [1 x i8] c"\00"
@.str.389 = private unnamed_addr constant [10 x i8] c"variable \00"
@.str.390 = private unnamed_addr constant [16 x i8] c" cannot be void\00"
@.str.391 = private unnamed_addr constant [34 x i8] c"type mismatch in declaration of '\00"
@.str.392 = private unnamed_addr constant [14 x i8] c"declared as '\00"
@.str.393 = private unnamed_addr constant [17 x i8] c"' but assigned '\00"
@.str.394 = private unnamed_addr constant [23 x i8] c"initialiser of global \00"
@.str.395 = private unnamed_addr constant [17 x i8] c" is not constant\00"
@.str.396 = private unnamed_addr constant [46 x i8] c"globals may only be initialised from literals\00"
@.str.397 = private unnamed_addr constant [28 x i8] c"type mismatch in assignment\00"
@.str.398 = private unnamed_addr constant [29 x i8] c"if condition must be boolean\00"
@.str.399 = private unnamed_addr constant [32 x i8] c"while condition must be boolean\00"
@.str.400 = private unnamed_addr constant [34 x i8] c"return used outside of a function\00"
@.str.401 = private unnamed_addr constant [23 x i8] c"return without a value\00"
@.str.402 = private unnamed_addr constant [23 x i8] c"this function returns \00"
@.str.403 = private unnamed_addr constant [1 x i8] c"\00"
@.str.404 = private unnamed_addr constant [39 x i8] c"returning a value from a void function\00"
@.str.405 = private unnamed_addr constant [18 x i8] c"wrong return type\00"
@.str.406 = private unnamed_addr constant [26 x i8] c"cannot print a void value\00"
@.str.407 = private unnamed_addr constant [8 x i8] c"extern \00"
@.str.408 = private unnamed_addr constant [22 x i8] c" has a void parameter\00"
@.str.409 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.410 = private unnamed_addr constant [28 x i8] c" is declared more than once\00"
@.str.411 = private unnamed_addr constant [9 x i8] c"struct '\00"
@.str.412 = private unnamed_addr constant [19 x i8] c"' declares field '\00"
@.str.413 = private unnamed_addr constant [8 x i8] c"' twice\00"
@.str.414 = private unnamed_addr constant [8 x i8] c"field '\00"
@.str.415 = private unnamed_addr constant [14 x i8] c"' of struct '\00"
@.str.416 = private unnamed_addr constant [8 x i8] c"field '\00"
@.str.417 = private unnamed_addr constant [14 x i8] c"' of struct '\00"
@.str.418 = private unnamed_addr constant [17 x i8] c"' cannot be void\00"
@.str.419 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.420 = private unnamed_addr constant [17 x i8] c" contains itself\00"
@.str.421 = private unnamed_addr constant [33 x i8] c"use a pointer to break the cycle\00"
@.str.422 = private unnamed_addr constant [19 x i8] c"in declaration of \00"
@.str.423 = private unnamed_addr constant [1 x i8] c"\00"
@.str.424 = private unnamed_addr constant [10 x i8] c"variable \00"
@.str.425 = private unnamed_addr constant [16 x i8] c" cannot be void\00"
@.str.426 = private unnamed_addr constant [17 x i8] c"return type of '\00"
@.str.427 = private unnamed_addr constant [24 x i8] c"return type of extern '\00"
@.str.428 = private unnamed_addr constant [22 x i8] c"parameter of extern '\00"
@.str.429 = private unnamed_addr constant [15 x i8] c"parameter of '\00"
@.str.430 = private unnamed_addr constant [8 x i8] c"extern \00"
@.str.431 = private unnamed_addr constant [27 x i8] c" returns a struct by value\00"
@.str.432 = private unnamed_addr constant [25 x i8] c"return a pointer instead\00"
@.str.433 = private unnamed_addr constant [8 x i8] c"extern \00"
@.str.434 = private unnamed_addr constant [25 x i8] c" takes a struct by value\00"
@.str.435 = private unnamed_addr constant [23 x i8] c"take a pointer instead\00"
@.str.436 = private unnamed_addr constant [5 x i8] c"main\00"
@.str.437 = private unnamed_addr constant [23 x i8] c"No main function found\00"
@.str.438 = private unnamed_addr constant [3 x i8] c"%t\00"
@.str.439 = private unnamed_addr constant [2 x i8] c"L\00"
@.str.440 = private unnamed_addr constant [3 x i8] c"  \00"
@.str.441 = private unnamed_addr constant [3 x i8] c":\0A\00"
@.str.442 = private unnamed_addr constant [11 x i8] c"br label %\00"
@.str.443 = private unnamed_addr constant [7 x i8] c"br i1 \00"
@.str.444 = private unnamed_addr constant [10 x i8] c", label %\00"
@.str.445 = private unnamed_addr constant [10 x i8] c", label %\00"
@.str.446 = private unnamed_addr constant [4 x i8] c"ptr\00"
@.str.447 = private unnamed_addr constant [3 x i8] c"i8\00"
@.str.448 = private unnamed_addr constant [4 x i8] c"i16\00"
@.str.449 = private unnamed_addr constant [4 x i8] c"i32\00"
@.str.450 = private unnamed_addr constant [4 x i8] c"i64\00"
@.str.451 = private unnamed_addr constant [6 x i8] c"float\00"
@.str.452 = private unnamed_addr constant [7 x i8] c"double\00"
@.str.453 = private unnamed_addr constant [3 x i8] c"i1\00"
@.str.454 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.455 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.456 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.457 = private unnamed_addr constant [16 x i8] c"zeroinitializer\00"
@.str.458 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.459 = private unnamed_addr constant [4 x i8] c"0.0\00"
@.str.460 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.461 = private unnamed_addr constant [7 x i8] c"@.str.\00"
@.str.462 = private unnamed_addr constant [35 x i8] c" = private unnamed_addr constant [\00"
@.str.463 = private unnamed_addr constant [10 x i8] c" x i8] c\22\00"
@.str.464 = private unnamed_addr constant [6 x i8] c"\5C00\22\0A\00"
@.str.465 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.466 = private unnamed_addr constant [6 x i8] c"load \00"
@.str.467 = private unnamed_addr constant [7 x i8] c", ptr \00"
@.str.468 = private unnamed_addr constant [7 x i8] c"store \00"
@.str.469 = private unnamed_addr constant [7 x i8] c", ptr \00"
@.str.470 = private unnamed_addr constant [9 x i8] c"ptrtoint\00"
@.str.471 = private unnamed_addr constant [9 x i8] c"inttoptr\00"
@.str.472 = private unnamed_addr constant [5 x i8] c"zext\00"
@.str.473 = private unnamed_addr constant [9 x i8] c"icmp ne \00"
@.str.474 = private unnamed_addr constant [3 x i8] c", \00"
@.str.475 = private unnamed_addr constant [6 x i8] c"trunc\00"
@.str.476 = private unnamed_addr constant [5 x i8] c"sext\00"
@.str.477 = private unnamed_addr constant [5 x i8] c"zext\00"
@.str.478 = private unnamed_addr constant [7 x i8] c"sitofp\00"
@.str.479 = private unnamed_addr constant [7 x i8] c"uitofp\00"
@.str.480 = private unnamed_addr constant [7 x i8] c"fptosi\00"
@.str.481 = private unnamed_addr constant [7 x i8] c"fptoui\00"
@.str.482 = private unnamed_addr constant [6 x i8] c"fpext\00"
@.str.483 = private unnamed_addr constant [8 x i8] c"fptrunc\00"
@.str.484 = private unnamed_addr constant [23 x i8] c"cannot cast in codegen\00"
@.str.485 = private unnamed_addr constant [5 x i8] c" to \00"
@.str.486 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.487 = private unnamed_addr constant [24 x i8] c"getelementptr inbounds \00"
@.str.488 = private unnamed_addr constant [7 x i8] c", ptr \00"
@.str.489 = private unnamed_addr constant [14 x i8] c", i32 0, i32 \00"
@.str.490 = private unnamed_addr constant [24 x i8] c"getelementptr inbounds \00"
@.str.491 = private unnamed_addr constant [7 x i8] c", ptr \00"
@.str.492 = private unnamed_addr constant [7 x i8] c", i64 \00"
@.str.493 = private unnamed_addr constant [51 x i8] c"expression does not denote an addressable location\00"
@.str.494 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.495 = private unnamed_addr constant [10 x i8] c"alloca i1\00"
@.str.496 = private unnamed_addr constant [9 x i8] c"sub i64 \00"
@.str.497 = private unnamed_addr constant [3 x i8] c", \00"
@.str.498 = private unnamed_addr constant [10 x i8] c"sdiv i64 \00"
@.str.499 = private unnamed_addr constant [3 x i8] c", \00"
@.str.500 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.501 = private unnamed_addr constant [12 x i8] c"sub i64 0, \00"
@.str.502 = private unnamed_addr constant [24 x i8] c"getelementptr inbounds \00"
@.str.503 = private unnamed_addr constant [7 x i8] c", ptr \00"
@.str.504 = private unnamed_addr constant [7 x i8] c", i64 \00"
@.str.505 = private unnamed_addr constant [2 x i8] c"+\00"
@.str.506 = private unnamed_addr constant [5 x i8] c"fadd\00"
@.str.507 = private unnamed_addr constant [4 x i8] c"add\00"
@.str.508 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.509 = private unnamed_addr constant [5 x i8] c"fsub\00"
@.str.510 = private unnamed_addr constant [4 x i8] c"sub\00"
@.str.511 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.512 = private unnamed_addr constant [5 x i8] c"fmul\00"
@.str.513 = private unnamed_addr constant [4 x i8] c"mul\00"
@.str.514 = private unnamed_addr constant [2 x i8] c"/\00"
@.str.515 = private unnamed_addr constant [5 x i8] c"fdiv\00"
@.str.516 = private unnamed_addr constant [5 x i8] c"sdiv\00"
@.str.517 = private unnamed_addr constant [5 x i8] c"udiv\00"
@.str.518 = private unnamed_addr constant [2 x i8] c"%\00"
@.str.519 = private unnamed_addr constant [5 x i8] c"srem\00"
@.str.520 = private unnamed_addr constant [5 x i8] c"urem\00"
@.str.521 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.522 = private unnamed_addr constant [4 x i8] c"and\00"
@.str.523 = private unnamed_addr constant [2 x i8] c"|\00"
@.str.524 = private unnamed_addr constant [3 x i8] c"or\00"
@.str.525 = private unnamed_addr constant [2 x i8] c"^\00"
@.str.526 = private unnamed_addr constant [4 x i8] c"xor\00"
@.str.527 = private unnamed_addr constant [3 x i8] c"<<\00"
@.str.528 = private unnamed_addr constant [4 x i8] c"shl\00"
@.str.529 = private unnamed_addr constant [3 x i8] c">>\00"
@.str.530 = private unnamed_addr constant [5 x i8] c"ashr\00"
@.str.531 = private unnamed_addr constant [5 x i8] c"lshr\00"
@.str.532 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.533 = private unnamed_addr constant [9 x i8] c"fcmp oeq\00"
@.str.534 = private unnamed_addr constant [8 x i8] c"icmp eq\00"
@.str.535 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.536 = private unnamed_addr constant [9 x i8] c"fcmp one\00"
@.str.537 = private unnamed_addr constant [8 x i8] c"icmp ne\00"
@.str.538 = private unnamed_addr constant [2 x i8] c"<\00"
@.str.539 = private unnamed_addr constant [9 x i8] c"fcmp olt\00"
@.str.540 = private unnamed_addr constant [9 x i8] c"icmp slt\00"
@.str.541 = private unnamed_addr constant [9 x i8] c"icmp ult\00"
@.str.542 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.543 = private unnamed_addr constant [9 x i8] c"fcmp ole\00"
@.str.544 = private unnamed_addr constant [9 x i8] c"icmp sle\00"
@.str.545 = private unnamed_addr constant [9 x i8] c"icmp ule\00"
@.str.546 = private unnamed_addr constant [2 x i8] c">\00"
@.str.547 = private unnamed_addr constant [9 x i8] c"fcmp ogt\00"
@.str.548 = private unnamed_addr constant [9 x i8] c"icmp sgt\00"
@.str.549 = private unnamed_addr constant [9 x i8] c"icmp ugt\00"
@.str.550 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.551 = private unnamed_addr constant [9 x i8] c"fcmp oge\00"
@.str.552 = private unnamed_addr constant [9 x i8] c"icmp sge\00"
@.str.553 = private unnamed_addr constant [9 x i8] c"icmp uge\00"
@.str.554 = private unnamed_addr constant [4 x i8] c"add\00"
@.str.555 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.556 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.557 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.558 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.559 = private unnamed_addr constant [2 x i8] c"<\00"
@.str.560 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.561 = private unnamed_addr constant [2 x i8] c">\00"
@.str.562 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.563 = private unnamed_addr constant [3 x i8] c", \00"
@.str.564 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.565 = private unnamed_addr constant [2 x i8] c"*\00"
@.str.566 = private unnamed_addr constant [2 x i8] c"+\00"
@.str.567 = private unnamed_addr constant [2 x i8] c"-\00"
@.str.568 = private unnamed_addr constant [6 x i8] c"fneg \00"
@.str.569 = private unnamed_addr constant [5 x i8] c"sub \00"
@.str.570 = private unnamed_addr constant [5 x i8] c" 0, \00"
@.str.571 = private unnamed_addr constant [8 x i8] c"xor i1 \00"
@.str.572 = private unnamed_addr constant [7 x i8] c", true\00"
@.str.573 = private unnamed_addr constant [6 x i8] c"call \00"
@.str.574 = private unnamed_addr constant [3 x i8] c" @\00"
@.str.575 = private unnamed_addr constant [3 x i8] c", \00"
@.str.576 = private unnamed_addr constant [1 x i8] c"\00"
@.str.577 = private unnamed_addr constant [6 x i8] c"undef\00"
@.str.578 = private unnamed_addr constant [13 x i8] c"insertvalue \00"
@.str.579 = private unnamed_addr constant [3 x i8] c", \00"
@.str.580 = private unnamed_addr constant [3 x i8] c", \00"
@.str.581 = private unnamed_addr constant [3 x i8] c".0\00"
@.str.582 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.583 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.584 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.585 = private unnamed_addr constant [14 x i8] c"extractvalue \00"
@.str.586 = private unnamed_addr constant [3 x i8] c", \00"
@.str.587 = private unnamed_addr constant [42 x i8] c"unsupported expression in code generation\00"
@.str.588 = private unnamed_addr constant [4 x i8] c"%s\0A\00"
@.str.589 = private unnamed_addr constant [4 x i8] c"%p\0A\00"
@.str.590 = private unnamed_addr constant [4 x i8] c"%d\0A\00"
@.str.591 = private unnamed_addr constant [4 x i8] c"%u\0A\00"
@.str.592 = private unnamed_addr constant [6 x i8] c"%lld\0A\00"
@.str.593 = private unnamed_addr constant [6 x i8] c"%llu\0A\00"
@.str.594 = private unnamed_addr constant [4 x i8] c"%f\0A\00"
@.str.595 = private unnamed_addr constant [37 x i8] c"unsupported type for print statement\00"
@.str.596 = private unnamed_addr constant [1 x i8] c"\00"
@.str.597 = private unnamed_addr constant [33 x i8] c"call i32 (ptr, ...) @printf(ptr \00"
@.str.598 = private unnamed_addr constant [3 x i8] c", \00"
@.str.599 = private unnamed_addr constant [8 x i8] c"alloca \00"
@.str.600 = private unnamed_addr constant [9 x i8] c"ret void\00"
@.str.601 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.602 = private unnamed_addr constant [41 x i8] c"unsupported statement in code generation\00"
@.str.603 = private unnamed_addr constant [3 x i8] c" @\00"
@.str.604 = private unnamed_addr constant [3 x i8] c", \00"
@.str.605 = private unnamed_addr constant [7 x i8] c"define\00"
@.str.606 = private unnamed_addr constant [4 x i8] c" %p\00"
@.str.607 = private unnamed_addr constant [7 x i8] c"define\00"
@.str.608 = private unnamed_addr constant [11 x i8] c" {\0Aentry:\0A\00"
@.str.609 = private unnamed_addr constant [8 x i8] c"alloca \00"
@.str.610 = private unnamed_addr constant [3 x i8] c"%p\00"
@.str.611 = private unnamed_addr constant [9 x i8] c"ret void\00"
@.str.612 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.613 = private unnamed_addr constant [4 x i8] c"}\0A\0A\00"
@.str.614 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.615 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.616 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.617 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.618 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.619 = private unnamed_addr constant [15 x i8] c"inttoptr (i64 \00"
@.str.620 = private unnamed_addr constant [9 x i8] c" to ptr)\00"
@.str.621 = private unnamed_addr constant [11 x i8] c" = global \00"
@.str.622 = private unnamed_addr constant [11 x i8] c" = type { \00"
@.str.623 = private unnamed_addr constant [3 x i8] c", \00"
@.str.624 = private unnamed_addr constant [4 x i8] c" }\0A\00"
@.str.625 = private unnamed_addr constant [31 x i8] c"declare i32 @printf(ptr, ...)\0A\00"
@.str.626 = private unnamed_addr constant [8 x i8] c"declare\00"
@.str.627 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.628 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.629 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.630 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.631 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.632 = private unnamed_addr constant [3 x i8] c"\5C0\00"
@.str.633 = private unnamed_addr constant [3 x i8] c" '\00"
@.str.634 = private unnamed_addr constant [3 x i8] c"  \00"
@.str.635 = private unnamed_addr constant [3 x i8] c" '\00"
@.str.636 = private unnamed_addr constant [8 x i8] c" export\00"
@.str.637 = private unnamed_addr constant [8 x i8] c" depth=\00"
@.str.638 = private unnamed_addr constant [4 x i8] c" : \00"
@.str.639 = private unnamed_addr constant [21 x i8] c"cannot find module '\00"
@.str.640 = private unnamed_addr constant [14 x i8] c"--dump-tokens\00"
@.str.641 = private unnamed_addr constant [11 x i8] c"--dump-ast\00"
@.str.642 = private unnamed_addr constant [13 x i8] c"--dump-types\00"
@.str.643 = private unnamed_addr constant [12 x i8] c"--emit-llvm\00"
@.str.644 = private unnamed_addr constant [19 x i8] c"--no-intermediates\00"
@.str.645 = private unnamed_addr constant [3 x i8] c"-o\00"
@.str.646 = private unnamed_addr constant [23 x i8] c"cannot open input file\00"
@.str.647 = private unnamed_addr constant [4 x i8] c".ll\00"
@.str.648 = private unnamed_addr constant [25 x i8] c"cannot write the LLVM IR\00"
@.str.649 = private unnamed_addr constant [3 x i8] c".o\00"
@.str.650 = private unnamed_addr constant [6 x i8] c"clang\00"
@.str.651 = private unnamed_addr constant [3 x i8] c"-c\00"
@.str.652 = private unnamed_addr constant [3 x i8] c"-o\00"
@.str.653 = private unnamed_addr constant [21 x i8] c"-Wno-override-module\00"
@.str.654 = private unnamed_addr constant [18 x i8] c"assembling failed\00"
@.str.655 = private unnamed_addr constant [6 x i8] c"clang\00"
@.str.656 = private unnamed_addr constant [3 x i8] c"-o\00"
@.str.657 = private unnamed_addr constant [15 x i8] c"linking failed\00"

define ptr @nullText() {
entry:
  %t0 = sext i32 0 to i64
  %t1 = inttoptr i64 %t0 to ptr
  ret ptr %t1
}

define i1 @isNullText(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @nullText()
  %t3 = icmp eq ptr %t1, %t2
  ret i1 %t3
}

define void @writeText(i32 %p0, ptr %p1) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load i32, ptr %t0
  %t3 = load ptr, ptr %t1
  %t4 = load ptr, ptr %t1
  %t5 = call i64 @strlen(ptr %t4)
  %t6 = call i64 @write(i32 %t2, ptr %t3, i64 %t5)
  ret void
}

define void @writeBuf(i32 %p0, ptr %p1) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load i32, ptr %t0
  %t3 = load ptr, ptr %t1
  %t4 = getelementptr inbounds %Buf, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %Buf, ptr %t6, i32 0, i32 1
  %t8 = load i64, ptr %t7
  %t9 = call i64 @write(i32 %t2, ptr %t5, i64 %t8)
  ret void
}

define void @print2(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load i32, ptr @STDOUT
  %t3 = load ptr, ptr %t0
  call void @writeText(i32 %t2, ptr %t3)
  %t4 = load i32, ptr @STDOUT
  %t5 = load ptr, ptr %t1
  call void @writeText(i32 %t4, ptr %t5)
  ret void
}

define ptr @nullBuf() {
entry:
  %t0 = sext i32 0 to i64
  %t1 = inttoptr i64 %t0 to ptr
  ret ptr %t1
}

define ptr @bufNew() {
entry:
  %t0 = call ptr @malloc(i64 24)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = sext i32 64 to i64
  %t3 = load ptr, ptr %t1
  %t4 = getelementptr inbounds %Buf, ptr %t3, i32 0, i32 2
  store i64 %t2, ptr %t4
  %t5 = sext i32 0 to i64
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %Buf, ptr %t6, i32 0, i32 1
  store i64 %t5, ptr %t7
  %t8 = load ptr, ptr %t1
  %t9 = getelementptr inbounds %Buf, ptr %t8, i32 0, i32 2
  %t10 = load i64, ptr %t9
  %t11 = call ptr @malloc(i64 %t10)
  %t12 = load ptr, ptr %t1
  %t13 = getelementptr inbounds %Buf, ptr %t12, i32 0, i32 0
  store ptr %t11, ptr %t13
  %t14 = trunc i32 0 to i8
  %t15 = load ptr, ptr %t1
  %t16 = getelementptr inbounds %Buf, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = sext i32 0 to i64
  %t19 = getelementptr inbounds i8, ptr %t17, i64 %t18
  store i8 %t14, ptr %t19
  %t20 = load ptr, ptr %t1
  ret ptr %t20
}

define void @bufReserve(ptr %p0, i64 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i64
  store i64 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Buf, ptr %t2, i32 0, i32 1
  %t4 = load i64, ptr %t3
  %t5 = load i64, ptr %t1
  %t6 = add i64 %t4, %t5
  %t7 = sext i32 1 to i64
  %t8 = add i64 %t6, %t7
  %t9 = alloca i64
  store i64 %t8, ptr %t9
  %t10 = load i64, ptr %t9
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Buf, ptr %t11, i32 0, i32 2
  %t13 = load i64, ptr %t12
  %t14 = icmp sle i64 %t10, %t13
  br i1 %t14, label %L0, label %L2
L0:
  ret void
L2:
  br label %L3
L3:
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Buf, ptr %t15, i32 0, i32 2
  %t17 = load i64, ptr %t16
  %t18 = load i64, ptr %t9
  %t19 = icmp slt i64 %t17, %t18
  br i1 %t19, label %L4, label %L5
L4:
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Buf, ptr %t20, i32 0, i32 2
  %t22 = load i64, ptr %t21
  %t23 = sext i32 2 to i64
  %t24 = mul i64 %t22, %t23
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %Buf, ptr %t25, i32 0, i32 2
  store i64 %t24, ptr %t26
  br label %L3
L5:
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Buf, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Buf, ptr %t30, i32 0, i32 2
  %t32 = load i64, ptr %t31
  %t33 = call ptr @realloc(ptr %t29, i64 %t32)
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Buf, ptr %t34, i32 0, i32 0
  store ptr %t33, ptr %t35
  ret void
}

define void @bufPush(ptr %p0, i8 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i8
  store i8 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = sext i32 1 to i64
  call void @bufReserve(ptr %t2, i64 %t3)
  %t4 = load i8, ptr %t1
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Buf, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Buf, ptr %t8, i32 0, i32 1
  %t10 = load i64, ptr %t9
  %t11 = getelementptr inbounds i8, ptr %t7, i64 %t10
  store i8 %t4, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %Buf, ptr %t12, i32 0, i32 1
  %t14 = load i64, ptr %t13
  %t15 = sext i32 1 to i64
  %t16 = add i64 %t14, %t15
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Buf, ptr %t17, i32 0, i32 1
  store i64 %t16, ptr %t18
  %t19 = trunc i32 0 to i8
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Buf, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Buf, ptr %t23, i32 0, i32 1
  %t25 = load i64, ptr %t24
  %t26 = getelementptr inbounds i8, ptr %t22, i64 %t25
  store i8 %t19, ptr %t26
  ret void
}

define void @bufAddBytes(ptr %p0, ptr %p1, i64 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i64
  store i64 %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = load i64, ptr %t2
  call void @bufReserve(ptr %t3, i64 %t4)
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Buf, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Buf, ptr %t8, i32 0, i32 1
  %t10 = load i64, ptr %t9
  %t11 = getelementptr inbounds i8, ptr %t7, i64 %t10
  %t12 = load ptr, ptr %t1
  %t13 = load i64, ptr %t2
  %t14 = call ptr @memcpy(ptr %t11, ptr %t12, i64 %t13)
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Buf, ptr %t15, i32 0, i32 1
  %t17 = load i64, ptr %t16
  %t18 = load i64, ptr %t2
  %t19 = add i64 %t17, %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Buf, ptr %t20, i32 0, i32 1
  store i64 %t19, ptr %t21
  %t22 = trunc i32 0 to i8
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Buf, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Buf, ptr %t26, i32 0, i32 1
  %t28 = load i64, ptr %t27
  %t29 = getelementptr inbounds i8, ptr %t25, i64 %t28
  store i8 %t22, ptr %t29
  ret void
}

define void @bufAdd(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t1
  %t4 = load ptr, ptr %t1
  %t5 = call i64 @strlen(ptr %t4)
  call void @bufAddBytes(ptr %t2, ptr %t3, i64 %t5)
  ret void
}

define void @bufAddInt(ptr %p0, i64 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i64
  store i64 %p1, ptr %t1
  %t2 = load i64, ptr %t1
  %t3 = sext i32 0 to i64
  %t4 = icmp eq i64 %t2, %t3
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = load ptr, ptr %t0
  call void @bufPush(ptr %t5, i8 48)
  ret void
L2:
  %t6 = load i64, ptr %t1
  %t7 = alloca i64
  store i64 %t6, ptr %t7
  %t8 = load i64, ptr %t7
  %t9 = sext i32 0 to i64
  %t10 = icmp slt i64 %t8, %t9
  br i1 %t10, label %L3, label %L5
L3:
  %t11 = load ptr, ptr %t0
  call void @bufPush(ptr %t11, i8 45)
  %t12 = sext i32 0 to i64
  %t13 = load i64, ptr %t7
  %t14 = sub i64 %t12, %t13
  store i64 %t14, ptr %t7
  br label %L5
L5:
  %t15 = sext i32 24 to i64
  %t16 = call ptr @malloc(i64 %t15)
  %t17 = alloca ptr
  store ptr %t16, ptr %t17
  %t18 = alloca i32
  store i32 0, ptr %t18
  br label %L6
L6:
  %t19 = load i64, ptr %t7
  %t20 = sext i32 0 to i64
  %t21 = icmp sgt i64 %t19, %t20
  br i1 %t21, label %L7, label %L8
L7:
  %t22 = sext i8 48 to i64
  %t23 = load i64, ptr %t7
  %t24 = sext i32 10 to i64
  %t25 = srem i64 %t23, %t24
  %t26 = add i64 %t22, %t25
  %t27 = trunc i64 %t26 to i8
  %t28 = load ptr, ptr %t17
  %t29 = load i32, ptr %t18
  %t30 = sext i32 %t29 to i64
  %t31 = getelementptr inbounds i8, ptr %t28, i64 %t30
  store i8 %t27, ptr %t31
  %t32 = load i64, ptr %t7
  %t33 = sext i32 10 to i64
  %t34 = sdiv i64 %t32, %t33
  store i64 %t34, ptr %t7
  %t35 = load i32, ptr %t18
  %t36 = add i32 %t35, 1
  store i32 %t36, ptr %t18
  br label %L6
L8:
  br label %L9
L9:
  %t37 = load i32, ptr %t18
  %t38 = icmp sgt i32 %t37, 0
  br i1 %t38, label %L10, label %L11
L10:
  %t39 = load i32, ptr %t18
  %t40 = sub i32 %t39, 1
  store i32 %t40, ptr %t18
  %t41 = load ptr, ptr %t0
  %t42 = load ptr, ptr %t17
  %t43 = load i32, ptr %t18
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds i8, ptr %t42, i64 %t44
  %t46 = load i8, ptr %t45
  call void @bufPush(ptr %t41, i8 %t46)
  br label %L9
L11:
  %t47 = load ptr, ptr %t17
  call void @free(ptr %t47)
  ret void
}

define void @bufFree(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Buf, ptr %t1, i32 0, i32 0
  %t3 = load ptr, ptr %t2
  call void @free(ptr %t3)
  %t4 = load ptr, ptr %t0
  call void @free(ptr %t4)
  ret void
}

define ptr @bufTake(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Buf, ptr %t1, i32 0, i32 0
  %t3 = load ptr, ptr %t2
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  call void @free(ptr %t5)
  %t6 = load ptr, ptr %t4
  ret ptr %t6
}

define i1 @textEquals(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t1
  %t4 = call i32 @strcmp(ptr %t2, ptr %t3)
  %t5 = icmp eq i32 %t4, 0
  ret i1 %t5
}

define ptr @textCopy(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i64 @strlen(ptr %t1)
  %t3 = alloca i64
  store i64 %t2, ptr %t3
  %t4 = load i64, ptr %t3
  %t5 = sext i32 1 to i64
  %t6 = add i64 %t4, %t5
  %t7 = call ptr @malloc(i64 %t6)
  %t8 = alloca ptr
  store ptr %t7, ptr %t8
  %t9 = load ptr, ptr %t8
  %t10 = load ptr, ptr %t0
  %t11 = load i64, ptr %t3
  %t12 = call ptr @memcpy(ptr %t9, ptr %t10, i64 %t11)
  %t13 = trunc i32 0 to i8
  %t14 = load ptr, ptr %t8
  %t15 = load i64, ptr %t3
  %t16 = getelementptr inbounds i8, ptr %t14, i64 %t15
  store i8 %t13, ptr %t16
  %t17 = load ptr, ptr %t8
  ret ptr %t17
}

define ptr @textSlice(ptr %p0, i64 %p1, i64 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i64
  store i64 %p1, ptr %t1
  %t2 = alloca i64
  store i64 %p2, ptr %t2
  %t3 = load i64, ptr %t2
  %t4 = sext i32 1 to i64
  %t5 = add i64 %t3, %t4
  %t6 = call ptr @malloc(i64 %t5)
  %t7 = alloca ptr
  store ptr %t6, ptr %t7
  %t8 = load ptr, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = load i64, ptr %t1
  %t11 = getelementptr inbounds i8, ptr %t9, i64 %t10
  %t12 = load i64, ptr %t2
  %t13 = call ptr @memcpy(ptr %t8, ptr %t11, i64 %t12)
  %t14 = trunc i32 0 to i8
  %t15 = load ptr, ptr %t7
  %t16 = load i64, ptr %t2
  %t17 = getelementptr inbounds i8, ptr %t15, i64 %t16
  store i8 %t14, ptr %t17
  %t18 = load ptr, ptr %t7
  ret ptr %t18
}

define ptr @intToText(i64 %p0) {
entry:
  %t0 = alloca i64
  store i64 %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t2
  %t4 = load i64, ptr %t0
  call void @bufAddInt(ptr %t3, i64 %t4)
  %t5 = load ptr, ptr %t2
  %t6 = call ptr @bufTake(ptr %t5)
  ret ptr %t6
}

define ptr @diagnosticsNew() {
entry:
  %t0 = call ptr @malloc(i64 24)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load i32, ptr @DIAG_LIMIT
  %t3 = load ptr, ptr %t1
  %t4 = getelementptr inbounds %Diagnostics, ptr %t3, i32 0, i32 2
  store i32 %t2, ptr %t4
  %t5 = load ptr, ptr %t1
  %t6 = getelementptr inbounds %Diagnostics, ptr %t5, i32 0, i32 1
  store i32 0, ptr %t6
  %t7 = load ptr, ptr %t1
  %t8 = getelementptr inbounds %Diagnostics, ptr %t7, i32 0, i32 3
  store i32 0, ptr %t8
  %t9 = load ptr, ptr %t1
  %t10 = getelementptr inbounds %Diagnostics, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = sext i32 %t11 to i64
  %t13 = mul i64 24, %t12
  %t14 = call ptr @malloc(i64 %t13)
  %t15 = load ptr, ptr %t1
  %t16 = getelementptr inbounds %Diagnostics, ptr %t15, i32 0, i32 0
  store ptr %t14, ptr %t16
  %t17 = load ptr, ptr %t1
  ret ptr %t17
}

define void @report(i32 %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load i1, ptr @FAILED
  br i1 %t3, label %L0, label %L2
L0:
  ret void
L2:
  store i1 true, ptr @FAILED
  %t4 = load ptr, ptr @DIAGS
  %t5 = getelementptr inbounds %Diagnostics, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = add i32 %t6, 1
  %t8 = load ptr, ptr @DIAGS
  %t9 = getelementptr inbounds %Diagnostics, ptr %t8, i32 0, i32 3
  store i32 %t7, ptr %t9
  %t10 = load ptr, ptr @DIAGS
  %t11 = getelementptr inbounds %Diagnostics, ptr %t10, i32 0, i32 1
  %t12 = load i32, ptr %t11
  %t13 = load ptr, ptr @DIAGS
  %t14 = getelementptr inbounds %Diagnostics, ptr %t13, i32 0, i32 2
  %t15 = load i32, ptr %t14
  %t16 = icmp sge i32 %t12, %t15
  br i1 %t16, label %L3, label %L5
L3:
  ret void
L5:
  %t17 = load ptr, ptr @SOURCE_PATH
  %t18 = load ptr, ptr @DIAGS
  %t19 = getelementptr inbounds %Diagnostics, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load ptr, ptr @DIAGS
  %t22 = getelementptr inbounds %Diagnostics, ptr %t21, i32 0, i32 1
  %t23 = load i32, ptr %t22
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Diagnostic, ptr %t20, i64 %t24
  %t26 = getelementptr inbounds %Diagnostic, ptr %t25, i32 0, i32 0
  store ptr %t17, ptr %t26
  %t27 = load ptr, ptr %t2
  %t28 = load ptr, ptr @DIAGS
  %t29 = getelementptr inbounds %Diagnostics, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = load ptr, ptr @DIAGS
  %t32 = getelementptr inbounds %Diagnostics, ptr %t31, i32 0, i32 1
  %t33 = load i32, ptr %t32
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %Diagnostic, ptr %t30, i64 %t34
  %t36 = getelementptr inbounds %Diagnostic, ptr %t35, i32 0, i32 1
  store ptr %t27, ptr %t36
  %t37 = load i32, ptr %t0
  %t38 = load ptr, ptr @DIAGS
  %t39 = getelementptr inbounds %Diagnostics, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load ptr, ptr @DIAGS
  %t42 = getelementptr inbounds %Diagnostics, ptr %t41, i32 0, i32 1
  %t43 = load i32, ptr %t42
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds %Diagnostic, ptr %t40, i64 %t44
  %t46 = getelementptr inbounds %Diagnostic, ptr %t45, i32 0, i32 2
  store i32 %t37, ptr %t46
  %t47 = load i32, ptr %t1
  %t48 = load ptr, ptr @DIAGS
  %t49 = getelementptr inbounds %Diagnostics, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = load ptr, ptr @DIAGS
  %t52 = getelementptr inbounds %Diagnostics, ptr %t51, i32 0, i32 1
  %t53 = load i32, ptr %t52
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Diagnostic, ptr %t50, i64 %t54
  %t56 = getelementptr inbounds %Diagnostic, ptr %t55, i32 0, i32 3
  store i32 %t47, ptr %t56
  %t57 = load ptr, ptr @DIAGS
  %t58 = getelementptr inbounds %Diagnostics, ptr %t57, i32 0, i32 1
  %t59 = load i32, ptr %t58
  %t60 = add i32 %t59, 1
  %t61 = load ptr, ptr @DIAGS
  %t62 = getelementptr inbounds %Diagnostics, ptr %t61, i32 0, i32 1
  store i32 %t60, ptr %t62
  ret void
}

define i1 @hasErrors() {
entry:
  %t0 = load ptr, ptr @DIAGS
  %t1 = getelementptr inbounds %Diagnostics, ptr %t0, i32 0, i32 3
  %t2 = load i32, ptr %t1
  %t3 = icmp sgt i32 %t2, 0
  ret i1 %t3
}

define void @printDiagnostics() {
entry:
  %t0 = call ptr @bufNew()
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr @DIAGS
  %t5 = getelementptr inbounds %Diagnostics, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = icmp slt i32 %t3, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t1
  %t9 = load ptr, ptr @DIAGS
  %t10 = getelementptr inbounds %Diagnostics, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t2
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Diagnostic, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Diagnostic, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  call void @bufAdd(ptr %t8, ptr %t16)
  %t17 = load ptr, ptr @DIAGS
  %t18 = getelementptr inbounds %Diagnostics, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  %t20 = load i32, ptr %t2
  %t21 = sext i32 %t20 to i64
  %t22 = getelementptr inbounds %Diagnostic, ptr %t19, i64 %t21
  %t23 = getelementptr inbounds %Diagnostic, ptr %t22, i32 0, i32 2
  %t24 = load i32, ptr %t23
  %t25 = icmp sgt i32 %t24, 0
  br i1 %t25, label %L3, label %L5
L3:
  %t26 = load ptr, ptr %t1
  call void @bufPush(ptr %t26, i8 58)
  %t27 = load ptr, ptr %t1
  %t28 = load ptr, ptr @DIAGS
  %t29 = getelementptr inbounds %Diagnostics, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = load i32, ptr %t2
  %t32 = sext i32 %t31 to i64
  %t33 = getelementptr inbounds %Diagnostic, ptr %t30, i64 %t32
  %t34 = getelementptr inbounds %Diagnostic, ptr %t33, i32 0, i32 2
  %t35 = load i32, ptr %t34
  %t36 = sext i32 %t35 to i64
  call void @bufAddInt(ptr %t27, i64 %t36)
  %t37 = load ptr, ptr %t1
  call void @bufPush(ptr %t37, i8 58)
  %t38 = load ptr, ptr %t1
  %t39 = load ptr, ptr @DIAGS
  %t40 = getelementptr inbounds %Diagnostics, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t2
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds %Diagnostic, ptr %t41, i64 %t43
  %t45 = getelementptr inbounds %Diagnostic, ptr %t44, i32 0, i32 3
  %t46 = load i32, ptr %t45
  %t47 = sext i32 %t46 to i64
  call void @bufAddInt(ptr %t38, i64 %t47)
  br label %L5
L5:
  %t48 = load ptr, ptr %t1
  call void @bufAdd(ptr %t48, ptr @.str.2)
  %t49 = load ptr, ptr %t1
  %t50 = load ptr, ptr @DIAGS
  %t51 = getelementptr inbounds %Diagnostics, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t2
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Diagnostic, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Diagnostic, ptr %t55, i32 0, i32 1
  %t57 = load ptr, ptr %t56
  call void @bufAdd(ptr %t49, ptr %t57)
  %t58 = load ptr, ptr %t1
  call void @bufPush(ptr %t58, i8 10)
  %t59 = load i32, ptr %t2
  %t60 = add i32 %t59, 1
  store i32 %t60, ptr %t2
  br label %L0
L2:
  %t61 = load ptr, ptr @DIAGS
  %t62 = getelementptr inbounds %Diagnostics, ptr %t61, i32 0, i32 3
  %t63 = load i32, ptr %t62
  %t64 = load ptr, ptr @DIAGS
  %t65 = getelementptr inbounds %Diagnostics, ptr %t64, i32 0, i32 1
  %t66 = load i32, ptr %t65
  %t67 = icmp sgt i32 %t63, %t66
  br i1 %t67, label %L6, label %L7
L6:
  %t68 = load ptr, ptr %t1
  %t69 = load ptr, ptr @DIAGS
  %t70 = getelementptr inbounds %Diagnostics, ptr %t69, i32 0, i32 3
  %t71 = load i32, ptr %t70
  %t72 = sext i32 %t71 to i64
  call void @bufAddInt(ptr %t68, i64 %t72)
  %t73 = load ptr, ptr %t1
  call void @bufAdd(ptr %t73, ptr @.str.3)
  %t74 = load ptr, ptr %t1
  %t75 = load ptr, ptr @DIAGS
  %t76 = getelementptr inbounds %Diagnostics, ptr %t75, i32 0, i32 1
  %t77 = load i32, ptr %t76
  %t78 = sext i32 %t77 to i64
  call void @bufAddInt(ptr %t74, i64 %t78)
  %t79 = load ptr, ptr %t1
  call void @bufAdd(ptr %t79, ptr @.str.4)
  br label %L8
L7:
  %t80 = load ptr, ptr @DIAGS
  %t81 = getelementptr inbounds %Diagnostics, ptr %t80, i32 0, i32 3
  %t82 = load i32, ptr %t81
  %t83 = icmp sgt i32 %t82, 1
  br i1 %t83, label %L9, label %L11
L9:
  %t84 = load ptr, ptr %t1
  %t85 = load ptr, ptr @DIAGS
  %t86 = getelementptr inbounds %Diagnostics, ptr %t85, i32 0, i32 3
  %t87 = load i32, ptr %t86
  %t88 = sext i32 %t87 to i64
  call void @bufAddInt(ptr %t84, i64 %t88)
  %t89 = load ptr, ptr %t1
  call void @bufAdd(ptr %t89, ptr @.str.5)
  br label %L11
L11:
  br label %L8
L8:
  %t90 = load i32, ptr @STDERR
  %t91 = load ptr, ptr %t1
  call void @writeBuf(i32 %t90, ptr %t91)
  ret void
}

define void @failAt(i32 %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load i32, ptr %t0
  %t4 = icmp sle i32 %t3, 0
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = load ptr, ptr %t2
  call void @fail(ptr %t5)
  ret void
L2:
  %t6 = call ptr @bufNew()
  %t7 = alloca ptr
  store ptr %t6, ptr %t7
  %t8 = load ptr, ptr %t7
  %t9 = load ptr, ptr @SOURCE_PATH
  call void @bufAdd(ptr %t8, ptr %t9)
  %t10 = load ptr, ptr %t7
  call void @bufPush(ptr %t10, i8 58)
  %t11 = load ptr, ptr %t7
  %t12 = load i32, ptr %t0
  %t13 = sext i32 %t12 to i64
  call void @bufAddInt(ptr %t11, i64 %t13)
  %t14 = load ptr, ptr %t7
  call void @bufPush(ptr %t14, i8 58)
  %t15 = load ptr, ptr %t7
  %t16 = load i32, ptr %t1
  %t17 = sext i32 %t16 to i64
  call void @bufAddInt(ptr %t15, i64 %t17)
  %t18 = load ptr, ptr %t7
  call void @bufAdd(ptr %t18, ptr @.str.6)
  %t19 = load ptr, ptr %t7
  %t20 = load ptr, ptr %t2
  call void @bufAdd(ptr %t19, ptr %t20)
  %t21 = load ptr, ptr %t7
  call void @bufPush(ptr %t21, i8 10)
  %t22 = load i32, ptr @STDERR
  %t23 = load ptr, ptr %t7
  %t24 = getelementptr inbounds %Buf, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  call void @writeText(i32 %t22, ptr %t25)
  call void @exit(i32 1)
  ret void
}

define void @fail(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t2
  %t4 = load ptr, ptr @SOURCE_PATH
  call void @bufAdd(ptr %t3, ptr %t4)
  %t5 = load ptr, ptr %t2
  call void @bufAdd(ptr %t5, ptr @.str.7)
  %t6 = load ptr, ptr %t2
  %t7 = load ptr, ptr %t0
  call void @bufAdd(ptr %t6, ptr %t7)
  %t8 = load ptr, ptr %t2
  call void @bufPush(ptr %t8, i8 10)
  %t9 = load i32, ptr @STDERR
  %t10 = load ptr, ptr %t2
  %t11 = getelementptr inbounds %Buf, ptr %t10, i32 0, i32 0
  %t12 = load ptr, ptr %t11
  call void @writeText(i32 %t9, ptr %t12)
  call void @exit(i32 1)
  ret void
}

define i32 @runProgram(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call i32 @fork()
  %t2 = alloca i32
  store i32 %t1, ptr %t2
  %t3 = load i32, ptr %t2
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = load ptr, ptr %t0
  %t6 = sext i32 0 to i64
  %t7 = getelementptr inbounds ptr, ptr %t5, i64 %t6
  %t8 = load ptr, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = call i32 @execvp(ptr %t8, ptr %t9)
  call void @_exit(i32 127)
  br label %L2
L2:
  %t11 = load i32, ptr %t2
  %t12 = icmp slt i32 %t11, 0
  br i1 %t12, label %L3, label %L5
L3:
  ret i32 -1
L5:
  %t13 = call ptr @malloc(i64 4)
  %t14 = alloca ptr
  store ptr %t13, ptr %t14
  %t15 = load i32, ptr %t2
  %t16 = load ptr, ptr %t14
  %t17 = call i32 @waitpid(i32 %t15, ptr %t16, i32 0)
  %t18 = load ptr, ptr %t14
  %t19 = load i32, ptr %t18
  %t20 = and i32 %t19, 127
  %t21 = icmp ne i32 %t20, 0
  br i1 %t21, label %L6, label %L8
L6:
  ret i32 -1
L8:
  %t22 = load ptr, ptr %t14
  %t23 = load i32, ptr %t22
  %t24 = ashr i32 %t23, 8
  %t25 = and i32 %t24, 255
  ret i32 %t25
}

define ptr @readFile(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @fopen(ptr %t1, ptr @.str.8)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = call i1 @isNullText(ptr %t4)
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = call ptr @nullText()
  ret ptr %t6
L2:
  %t7 = load ptr, ptr %t3
  %t8 = sext i32 0 to i64
  %t9 = load i32, ptr @SEEK_END
  %t10 = call i32 @fseek(ptr %t7, i64 %t8, i32 %t9)
  %t11 = load ptr, ptr %t3
  %t12 = call i64 @ftell(ptr %t11)
  %t13 = alloca i64
  store i64 %t12, ptr %t13
  %t14 = load ptr, ptr %t3
  %t15 = sext i32 0 to i64
  %t16 = load i32, ptr @SEEK_SET
  %t17 = call i32 @fseek(ptr %t14, i64 %t15, i32 %t16)
  %t18 = load i64, ptr %t13
  %t19 = sext i32 1 to i64
  %t20 = add i64 %t18, %t19
  %t21 = call ptr @malloc(i64 %t20)
  %t22 = alloca ptr
  store ptr %t21, ptr %t22
  %t23 = load ptr, ptr %t22
  %t24 = sext i32 1 to i64
  %t25 = load i64, ptr %t13
  %t26 = load ptr, ptr %t3
  %t27 = call i64 @fread(ptr %t23, i64 %t24, i64 %t25, ptr %t26)
  %t28 = alloca i64
  store i64 %t27, ptr %t28
  %t29 = load ptr, ptr %t3
  %t30 = call i32 @fclose(ptr %t29)
  %t31 = trunc i32 0 to i8
  %t32 = load ptr, ptr %t22
  %t33 = load i64, ptr %t28
  %t34 = getelementptr inbounds i8, ptr %t32, i64 %t33
  store i8 %t31, ptr %t34
  %t35 = load ptr, ptr %t22
  ret ptr %t35
}

define i1 @writeFile(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call ptr @fopen(ptr %t2, ptr @.str.9)
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t4
  %t6 = call i1 @isNullText(ptr %t5)
  br i1 %t6, label %L0, label %L2
L0:
  ret i1 false
L2:
  %t7 = load ptr, ptr %t1
  %t8 = call i64 @strlen(ptr %t7)
  %t9 = alloca i64
  store i64 %t8, ptr %t9
  %t10 = load ptr, ptr %t1
  %t11 = sext i32 1 to i64
  %t12 = load i64, ptr %t9
  %t13 = load ptr, ptr %t4
  %t14 = call i64 @fwrite(ptr %t10, i64 %t11, i64 %t12, ptr %t13)
  %t15 = alloca i64
  store i64 %t14, ptr %t15
  %t16 = load ptr, ptr %t4
  %t17 = call i32 @fclose(ptr %t16)
  %t18 = load i64, ptr %t15
  %t19 = load i64, ptr %t9
  %t20 = icmp eq i64 %t18, %t19
  ret i1 %t20
}

define ptr @nullTokenList() {
entry:
  %t0 = sext i32 0 to i64
  %t1 = inttoptr i64 %t0 to ptr
  ret ptr %t1
}

define ptr @tokenListNew() {
entry:
  %t0 = call ptr @malloc(i64 16)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  %t3 = getelementptr inbounds %TokenList, ptr %t2, i32 0, i32 2
  store i32 256, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = getelementptr inbounds %TokenList, ptr %t4, i32 0, i32 1
  store i32 0, ptr %t5
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %TokenList, ptr %t6, i32 0, i32 2
  %t8 = load i32, ptr %t7
  %t9 = sext i32 %t8 to i64
  %t10 = mul i64 32, %t9
  %t11 = call ptr @malloc(i64 %t10)
  %t12 = load ptr, ptr %t1
  %t13 = getelementptr inbounds %TokenList, ptr %t12, i32 0, i32 0
  store ptr %t11, ptr %t13
  %t14 = load ptr, ptr %t1
  ret ptr %t14
}

define void @tokenListAdd(ptr %p0, i32 %p1, ptr %p2, i64 %p3, i32 %p4, i32 %p5) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i64
  store i64 %p3, ptr %t3
  %t4 = alloca i32
  store i32 %p4, ptr %t4
  %t5 = alloca i32
  store i32 %p5, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %TokenList, ptr %t6, i32 0, i32 1
  %t8 = load i32, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %TokenList, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = icmp eq i32 %t8, %t11
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %TokenList, ptr %t13, i32 0, i32 2
  %t15 = load i32, ptr %t14
  %t16 = mul i32 %t15, 2
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %TokenList, ptr %t17, i32 0, i32 2
  store i32 %t16, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %TokenList, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %TokenList, ptr %t22, i32 0, i32 2
  %t24 = load i32, ptr %t23
  %t25 = sext i32 %t24 to i64
  %t26 = mul i64 32, %t25
  %t27 = call ptr @realloc(ptr %t21, i64 %t26)
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %TokenList, ptr %t28, i32 0, i32 0
  store ptr %t27, ptr %t29
  br label %L2
L2:
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %TokenList, ptr %t30, i32 0, i32 1
  %t32 = load i32, ptr %t31
  %t33 = alloca i32
  store i32 %t32, ptr %t33
  %t34 = load i32, ptr %t1
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %TokenList, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t33
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Token, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Token, ptr %t40, i32 0, i32 0
  store i32 %t34, ptr %t41
  %t42 = load ptr, ptr %t2
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr inbounds %TokenList, ptr %t43, i32 0, i32 0
  %t45 = load ptr, ptr %t44
  %t46 = load i32, ptr %t33
  %t47 = sext i32 %t46 to i64
  %t48 = getelementptr inbounds %Token, ptr %t45, i64 %t47
  %t49 = getelementptr inbounds %Token, ptr %t48, i32 0, i32 1
  store ptr %t42, ptr %t49
  %t50 = load i64, ptr %t3
  %t51 = load ptr, ptr %t0
  %t52 = getelementptr inbounds %TokenList, ptr %t51, i32 0, i32 0
  %t53 = load ptr, ptr %t52
  %t54 = load i32, ptr %t33
  %t55 = sext i32 %t54 to i64
  %t56 = getelementptr inbounds %Token, ptr %t53, i64 %t55
  %t57 = getelementptr inbounds %Token, ptr %t56, i32 0, i32 2
  store i64 %t50, ptr %t57
  %t58 = load i32, ptr %t4
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %TokenList, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = load i32, ptr %t33
  %t63 = sext i32 %t62 to i64
  %t64 = getelementptr inbounds %Token, ptr %t61, i64 %t63
  %t65 = getelementptr inbounds %Token, ptr %t64, i32 0, i32 3
  store i32 %t58, ptr %t65
  %t66 = load i32, ptr %t5
  %t67 = load ptr, ptr %t0
  %t68 = getelementptr inbounds %TokenList, ptr %t67, i32 0, i32 0
  %t69 = load ptr, ptr %t68
  %t70 = load i32, ptr %t33
  %t71 = sext i32 %t70 to i64
  %t72 = getelementptr inbounds %Token, ptr %t69, i64 %t71
  %t73 = getelementptr inbounds %Token, ptr %t72, i32 0, i32 4
  store i32 %t66, ptr %t73
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %TokenList, ptr %t74, i32 0, i32 1
  %t76 = load i32, ptr %t75
  %t77 = add i32 %t76, 1
  %t78 = load ptr, ptr %t0
  %t79 = getelementptr inbounds %TokenList, ptr %t78, i32 0, i32 1
  store i32 %t77, ptr %t79
  ret void
}

define ptr @tokenAt(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i32, ptr %t1
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %TokenList, ptr %t3, i32 0, i32 1
  %t5 = load i32, ptr %t4
  %t6 = icmp sge i32 %t2, %t5
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %TokenList, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %TokenList, ptr %t10, i32 0, i32 1
  %t12 = load i32, ptr %t11
  %t13 = sub i32 %t12, 1
  %t14 = sext i32 %t13 to i64
  %t15 = getelementptr inbounds %Token, ptr %t9, i64 %t14
  ret ptr %t15
L2:
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %TokenList, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Token, ptr %t18, i64 %t20
  ret ptr %t21
}

define ptr @kindName(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = load i32, ptr @TK_END
  %t3 = icmp eq i32 %t1, %t2
  br i1 %t3, label %L0, label %L2
L0:
  ret ptr @.str.10
L2:
  %t4 = load i32, ptr %t0
  %t5 = load i32, ptr @TK_IDENT
  %t6 = icmp eq i32 %t4, %t5
  br i1 %t6, label %L3, label %L5
L3:
  ret ptr @.str.11
L5:
  %t7 = load i32, ptr %t0
  %t8 = load i32, ptr @TK_NUMBER
  %t9 = icmp eq i32 %t7, %t8
  br i1 %t9, label %L6, label %L8
L6:
  ret ptr @.str.12
L8:
  %t10 = load i32, ptr %t0
  %t11 = load i32, ptr @TK_STRING
  %t12 = icmp eq i32 %t10, %t11
  br i1 %t12, label %L9, label %L11
L9:
  ret ptr @.str.13
L11:
  %t13 = load i32, ptr %t0
  %t14 = load i32, ptr @TK_CHAR
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L12, label %L14
L12:
  ret ptr @.str.14
L14:
  %t16 = load i32, ptr %t0
  %t17 = load i32, ptr @TK_BOOL
  %t18 = icmp eq i32 %t16, %t17
  br i1 %t18, label %L15, label %L17
L15:
  ret ptr @.str.15
L17:
  %t19 = load i32, ptr %t0
  %t20 = load i32, ptr @TK_TYPE
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L18, label %L20
L18:
  ret ptr @.str.16
L20:
  %t22 = load i32, ptr %t0
  %t23 = load i32, ptr @TK_LET
  %t24 = icmp eq i32 %t22, %t23
  br i1 %t24, label %L21, label %L23
L21:
  ret ptr @.str.17
L23:
  %t25 = load i32, ptr %t0
  %t26 = load i32, ptr @TK_IF
  %t27 = icmp eq i32 %t25, %t26
  br i1 %t27, label %L24, label %L26
L24:
  ret ptr @.str.18
L26:
  %t28 = load i32, ptr %t0
  %t29 = load i32, ptr @TK_ELSE
  %t30 = icmp eq i32 %t28, %t29
  br i1 %t30, label %L27, label %L29
L27:
  ret ptr @.str.19
L29:
  %t31 = load i32, ptr %t0
  %t32 = load i32, ptr @TK_FN
  %t33 = icmp eq i32 %t31, %t32
  br i1 %t33, label %L30, label %L32
L30:
  ret ptr @.str.20
L32:
  %t34 = load i32, ptr %t0
  %t35 = load i32, ptr @TK_EXTERN
  %t36 = icmp eq i32 %t34, %t35
  br i1 %t36, label %L33, label %L35
L33:
  ret ptr @.str.21
L35:
  %t37 = load i32, ptr %t0
  %t38 = load i32, ptr @TK_STRUCT
  %t39 = icmp eq i32 %t37, %t38
  br i1 %t39, label %L36, label %L38
L36:
  ret ptr @.str.22
L38:
  %t40 = load i32, ptr %t0
  %t41 = load i32, ptr @TK_SIZEOF
  %t42 = icmp eq i32 %t40, %t41
  br i1 %t42, label %L39, label %L41
L39:
  ret ptr @.str.23
L41:
  %t43 = load i32, ptr %t0
  %t44 = load i32, ptr @TK_RETURN
  %t45 = icmp eq i32 %t43, %t44
  br i1 %t45, label %L42, label %L44
L42:
  ret ptr @.str.24
L44:
  %t46 = load i32, ptr %t0
  %t47 = load i32, ptr @TK_WHILE
  %t48 = icmp eq i32 %t46, %t47
  br i1 %t48, label %L45, label %L47
L45:
  ret ptr @.str.25
L47:
  %t49 = load i32, ptr %t0
  %t50 = load i32, ptr @TK_BREAK
  %t51 = icmp eq i32 %t49, %t50
  br i1 %t51, label %L48, label %L50
L48:
  ret ptr @.str.26
L50:
  %t52 = load i32, ptr %t0
  %t53 = load i32, ptr @TK_CONTINUE
  %t54 = icmp eq i32 %t52, %t53
  br i1 %t54, label %L51, label %L53
L51:
  ret ptr @.str.27
L53:
  %t55 = load i32, ptr %t0
  %t56 = load i32, ptr @TK_PRINT
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L54, label %L56
L54:
  ret ptr @.str.28
L56:
  %t58 = load i32, ptr %t0
  %t59 = load i32, ptr @TK_AS
  %t60 = icmp eq i32 %t58, %t59
  br i1 %t60, label %L57, label %L59
L57:
  ret ptr @.str.29
L59:
  %t61 = load i32, ptr %t0
  %t62 = load i32, ptr @TK_IMPORT
  %t63 = icmp eq i32 %t61, %t62
  br i1 %t63, label %L60, label %L62
L60:
  ret ptr @.str.30
L62:
  %t64 = load i32, ptr %t0
  %t65 = load i32, ptr @TK_EXPORT
  %t66 = icmp eq i32 %t64, %t65
  br i1 %t66, label %L63, label %L65
L63:
  ret ptr @.str.31
L65:
  %t67 = load i32, ptr %t0
  %t68 = load i32, ptr @TK_ASSIGN
  %t69 = icmp eq i32 %t67, %t68
  br i1 %t69, label %L66, label %L68
L66:
  ret ptr @.str.32
L68:
  %t70 = load i32, ptr %t0
  %t71 = load i32, ptr @TK_PLUS
  %t72 = icmp eq i32 %t70, %t71
  br i1 %t72, label %L69, label %L71
L69:
  ret ptr @.str.33
L71:
  %t73 = load i32, ptr %t0
  %t74 = load i32, ptr @TK_MINUS
  %t75 = icmp eq i32 %t73, %t74
  br i1 %t75, label %L72, label %L74
L72:
  ret ptr @.str.34
L74:
  %t76 = load i32, ptr %t0
  %t77 = load i32, ptr @TK_STAR
  %t78 = icmp eq i32 %t76, %t77
  br i1 %t78, label %L75, label %L77
L75:
  ret ptr @.str.35
L77:
  %t79 = load i32, ptr %t0
  %t80 = load i32, ptr @TK_SLASH
  %t81 = icmp eq i32 %t79, %t80
  br i1 %t81, label %L78, label %L80
L78:
  ret ptr @.str.36
L80:
  %t82 = load i32, ptr %t0
  %t83 = load i32, ptr @TK_PERCENT
  %t84 = icmp eq i32 %t82, %t83
  br i1 %t84, label %L81, label %L83
L81:
  ret ptr @.str.37
L83:
  %t85 = load i32, ptr %t0
  %t86 = load i32, ptr @TK_NOT
  %t87 = icmp eq i32 %t85, %t86
  br i1 %t87, label %L84, label %L86
L84:
  ret ptr @.str.38
L86:
  %t88 = load i32, ptr %t0
  %t89 = load i32, ptr @TK_AMP
  %t90 = icmp eq i32 %t88, %t89
  br i1 %t90, label %L87, label %L89
L87:
  ret ptr @.str.39
L89:
  %t91 = load i32, ptr %t0
  %t92 = load i32, ptr @TK_PIPE
  %t93 = icmp eq i32 %t91, %t92
  br i1 %t93, label %L90, label %L92
L90:
  ret ptr @.str.40
L92:
  %t94 = load i32, ptr %t0
  %t95 = load i32, ptr @TK_CARET
  %t96 = icmp eq i32 %t94, %t95
  br i1 %t96, label %L93, label %L95
L93:
  ret ptr @.str.41
L95:
  %t97 = load i32, ptr %t0
  %t98 = load i32, ptr @TK_SHL
  %t99 = icmp eq i32 %t97, %t98
  br i1 %t99, label %L96, label %L98
L96:
  ret ptr @.str.42
L98:
  %t100 = load i32, ptr %t0
  %t101 = load i32, ptr @TK_SHR
  %t102 = icmp eq i32 %t100, %t101
  br i1 %t102, label %L99, label %L101
L99:
  ret ptr @.str.43
L101:
  %t103 = load i32, ptr %t0
  %t104 = load i32, ptr @TK_ANDAND
  %t105 = icmp eq i32 %t103, %t104
  br i1 %t105, label %L102, label %L104
L102:
  ret ptr @.str.44
L104:
  %t106 = load i32, ptr %t0
  %t107 = load i32, ptr @TK_OROR
  %t108 = icmp eq i32 %t106, %t107
  br i1 %t108, label %L105, label %L107
L105:
  ret ptr @.str.45
L107:
  %t109 = load i32, ptr %t0
  %t110 = load i32, ptr @TK_EQ
  %t111 = icmp eq i32 %t109, %t110
  br i1 %t111, label %L108, label %L110
L108:
  ret ptr @.str.46
L110:
  %t112 = load i32, ptr %t0
  %t113 = load i32, ptr @TK_NE
  %t114 = icmp eq i32 %t112, %t113
  br i1 %t114, label %L111, label %L113
L111:
  ret ptr @.str.47
L113:
  %t115 = load i32, ptr %t0
  %t116 = load i32, ptr @TK_LT
  %t117 = icmp eq i32 %t115, %t116
  br i1 %t117, label %L114, label %L116
L114:
  ret ptr @.str.48
L116:
  %t118 = load i32, ptr %t0
  %t119 = load i32, ptr @TK_LE
  %t120 = icmp eq i32 %t118, %t119
  br i1 %t120, label %L117, label %L119
L117:
  ret ptr @.str.49
L119:
  %t121 = load i32, ptr %t0
  %t122 = load i32, ptr @TK_GT
  %t123 = icmp eq i32 %t121, %t122
  br i1 %t123, label %L120, label %L122
L120:
  ret ptr @.str.50
L122:
  %t124 = load i32, ptr %t0
  %t125 = load i32, ptr @TK_GE
  %t126 = icmp eq i32 %t124, %t125
  br i1 %t126, label %L123, label %L125
L123:
  ret ptr @.str.51
L125:
  %t127 = load i32, ptr %t0
  %t128 = load i32, ptr @TK_PLUS_ASSIGN
  %t129 = icmp eq i32 %t127, %t128
  br i1 %t129, label %L126, label %L128
L126:
  ret ptr @.str.52
L128:
  %t130 = load i32, ptr %t0
  %t131 = load i32, ptr @TK_MINUS_ASSIGN
  %t132 = icmp eq i32 %t130, %t131
  br i1 %t132, label %L129, label %L131
L129:
  ret ptr @.str.53
L131:
  %t133 = load i32, ptr %t0
  %t134 = load i32, ptr @TK_STAR_ASSIGN
  %t135 = icmp eq i32 %t133, %t134
  br i1 %t135, label %L132, label %L134
L132:
  ret ptr @.str.54
L134:
  %t136 = load i32, ptr %t0
  %t137 = load i32, ptr @TK_SLASH_ASSIGN
  %t138 = icmp eq i32 %t136, %t137
  br i1 %t138, label %L135, label %L137
L135:
  ret ptr @.str.55
L137:
  %t139 = load i32, ptr %t0
  %t140 = load i32, ptr @TK_PERCENT_ASSIGN
  %t141 = icmp eq i32 %t139, %t140
  br i1 %t141, label %L138, label %L140
L138:
  ret ptr @.str.56
L140:
  %t142 = load i32, ptr %t0
  %t143 = load i32, ptr @TK_LPAREN
  %t144 = icmp eq i32 %t142, %t143
  br i1 %t144, label %L141, label %L143
L141:
  ret ptr @.str.57
L143:
  %t145 = load i32, ptr %t0
  %t146 = load i32, ptr @TK_RPAREN
  %t147 = icmp eq i32 %t145, %t146
  br i1 %t147, label %L144, label %L146
L144:
  ret ptr @.str.58
L146:
  %t148 = load i32, ptr %t0
  %t149 = load i32, ptr @TK_LBRACE
  %t150 = icmp eq i32 %t148, %t149
  br i1 %t150, label %L147, label %L149
L147:
  ret ptr @.str.59
L149:
  %t151 = load i32, ptr %t0
  %t152 = load i32, ptr @TK_RBRACE
  %t153 = icmp eq i32 %t151, %t152
  br i1 %t153, label %L150, label %L152
L150:
  ret ptr @.str.60
L152:
  %t154 = load i32, ptr %t0
  %t155 = load i32, ptr @TK_LBRACKET
  %t156 = icmp eq i32 %t154, %t155
  br i1 %t156, label %L153, label %L155
L153:
  ret ptr @.str.61
L155:
  %t157 = load i32, ptr %t0
  %t158 = load i32, ptr @TK_RBRACKET
  %t159 = icmp eq i32 %t157, %t158
  br i1 %t159, label %L156, label %L158
L156:
  ret ptr @.str.62
L158:
  %t160 = load i32, ptr %t0
  %t161 = load i32, ptr @TK_DOT
  %t162 = icmp eq i32 %t160, %t161
  br i1 %t162, label %L159, label %L161
L159:
  ret ptr @.str.63
L161:
  %t163 = load i32, ptr %t0
  %t164 = load i32, ptr @TK_SEMICOLON
  %t165 = icmp eq i32 %t163, %t164
  br i1 %t165, label %L162, label %L164
L162:
  ret ptr @.str.64
L164:
  %t166 = load i32, ptr %t0
  %t167 = load i32, ptr @TK_COMMA
  %t168 = icmp eq i32 %t166, %t167
  br i1 %t168, label %L165, label %L167
L165:
  ret ptr @.str.65
L167:
  %t169 = load i32, ptr %t0
  %t170 = load i32, ptr @TK_COLON
  %t171 = icmp eq i32 %t169, %t170
  br i1 %t171, label %L168, label %L170
L168:
  ret ptr @.str.66
L170:
  ret ptr @.str.67
}

define ptr @lexerNew(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call ptr @malloc(i64 32)
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = load ptr, ptr %t2
  %t5 = getelementptr inbounds %Lexer, ptr %t4, i32 0, i32 0
  store ptr %t3, ptr %t5
  %t6 = sext i32 0 to i64
  %t7 = load ptr, ptr %t2
  %t8 = getelementptr inbounds %Lexer, ptr %t7, i32 0, i32 1
  store i64 %t6, ptr %t8
  %t9 = load ptr, ptr %t0
  %t10 = call i64 @strlen(ptr %t9)
  %t11 = load ptr, ptr %t2
  %t12 = getelementptr inbounds %Lexer, ptr %t11, i32 0, i32 2
  store i64 %t10, ptr %t12
  %t13 = load ptr, ptr %t2
  %t14 = getelementptr inbounds %Lexer, ptr %t13, i32 0, i32 3
  store i32 1, ptr %t14
  %t15 = load ptr, ptr %t2
  %t16 = getelementptr inbounds %Lexer, ptr %t15, i32 0, i32 4
  store i32 1, ptr %t16
  %t17 = load ptr, ptr %t2
  ret ptr %t17
}

define i1 @lexerAtEnd(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Lexer, ptr %t1, i32 0, i32 1
  %t3 = load i64, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Lexer, ptr %t4, i32 0, i32 2
  %t6 = load i64, ptr %t5
  %t7 = icmp sge i64 %t3, %t6
  ret i1 %t7
}

define i8 @lexerPeek(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i1 @lexerAtEnd(ptr %t1)
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = trunc i32 0 to i8
  ret i8 %t3
L2:
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Lexer, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Lexer, ptr %t7, i32 0, i32 1
  %t9 = load i64, ptr %t8
  %t10 = getelementptr inbounds i8, ptr %t6, i64 %t9
  %t11 = load i8, ptr %t10
  ret i8 %t11
}

define i8 @lexerPeekNext(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Lexer, ptr %t1, i32 0, i32 1
  %t3 = load i64, ptr %t2
  %t4 = sext i32 1 to i64
  %t5 = add i64 %t3, %t4
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 2
  %t8 = load i64, ptr %t7
  %t9 = icmp sge i64 %t5, %t8
  br i1 %t9, label %L0, label %L2
L0:
  %t10 = trunc i32 0 to i8
  ret i8 %t10
L2:
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Lexer, ptr %t11, i32 0, i32 0
  %t13 = load ptr, ptr %t12
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Lexer, ptr %t14, i32 0, i32 1
  %t16 = load i64, ptr %t15
  %t17 = sext i32 1 to i64
  %t18 = add i64 %t16, %t17
  %t19 = getelementptr inbounds i8, ptr %t13, i64 %t18
  %t20 = load i8, ptr %t19
  ret i8 %t20
}

define i8 @lexerAdvance(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i8 @lexerPeek(ptr %t1)
  %t3 = alloca i8
  store i8 %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Lexer, ptr %t4, i32 0, i32 1
  %t6 = load i64, ptr %t5
  %t7 = sext i32 1 to i64
  %t8 = add i64 %t6, %t7
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Lexer, ptr %t9, i32 0, i32 1
  store i64 %t8, ptr %t10
  %t11 = load i8, ptr %t3
  %t12 = icmp eq i8 %t11, 10
  br i1 %t12, label %L0, label %L1
L0:
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Lexer, ptr %t13, i32 0, i32 3
  %t15 = load i32, ptr %t14
  %t16 = add i32 %t15, 1
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Lexer, ptr %t17, i32 0, i32 3
  store i32 %t16, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Lexer, ptr %t19, i32 0, i32 4
  store i32 1, ptr %t20
  br label %L2
L1:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Lexer, ptr %t21, i32 0, i32 4
  %t23 = load i32, ptr %t22
  %t24 = add i32 %t23, 1
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %Lexer, ptr %t25, i32 0, i32 4
  store i32 %t24, ptr %t26
  br label %L2
L2:
  %t27 = load i8, ptr %t3
  ret i8 %t27
}

define i1 @isDigit(i8 %p0) {
entry:
  %t0 = alloca i8
  store i8 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load i8, ptr %t0
  %t3 = icmp sge i8 %t2, 48
  store i1 %t3, ptr %t1
  br i1 %t3, label %L0, label %L1
L0:
  %t4 = load i8, ptr %t0
  %t5 = icmp sle i8 %t4, 57
  store i1 %t5, ptr %t1
  br label %L1
L1:
  %t6 = load i1, ptr %t1
  ret i1 %t6
}

define i1 @isAlpha(i8 %p0) {
entry:
  %t0 = alloca i8
  store i8 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load i8, ptr %t0
  %t3 = icmp sge i8 %t2, 97
  store i1 %t3, ptr %t1
  br i1 %t3, label %L0, label %L1
L0:
  %t4 = load i8, ptr %t0
  %t5 = icmp sle i8 %t4, 122
  store i1 %t5, ptr %t1
  br label %L1
L1:
  %t6 = load i1, ptr %t1
  br i1 %t6, label %L2, label %L4
L2:
  ret i1 true
L4:
  %t7 = alloca i1
  %t8 = load i8, ptr %t0
  %t9 = icmp sge i8 %t8, 65
  store i1 %t9, ptr %t7
  br i1 %t9, label %L5, label %L6
L5:
  %t10 = load i8, ptr %t0
  %t11 = icmp sle i8 %t10, 90
  store i1 %t11, ptr %t7
  br label %L6
L6:
  %t12 = load i1, ptr %t7
  br i1 %t12, label %L7, label %L9
L7:
  ret i1 true
L9:
  %t13 = load i8, ptr %t0
  %t14 = icmp eq i8 %t13, 95
  ret i1 %t14
}

define i1 @isAlphaNumeric(i8 %p0) {
entry:
  %t0 = alloca i8
  store i8 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load i8, ptr %t0
  %t3 = call i1 @isAlpha(i8 %t2)
  store i1 %t3, ptr %t1
  br i1 %t3, label %L1, label %L0
L0:
  %t4 = load i8, ptr %t0
  %t5 = call i1 @isDigit(i8 %t4)
  store i1 %t5, ptr %t1
  br label %L1
L1:
  %t6 = load i1, ptr %t1
  ret i1 %t6
}

define i1 @isSpace(i8 %p0) {
entry:
  %t0 = alloca i8
  store i8 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = alloca i1
  %t3 = alloca i1
  %t4 = load i8, ptr %t0
  %t5 = icmp eq i8 %t4, 32
  store i1 %t5, ptr %t3
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = load i8, ptr %t0
  %t7 = icmp eq i8 %t6, 9
  store i1 %t7, ptr %t3
  br label %L1
L1:
  %t8 = load i1, ptr %t3
  store i1 %t8, ptr %t2
  br i1 %t8, label %L3, label %L2
L2:
  %t9 = load i8, ptr %t0
  %t10 = icmp eq i8 %t9, 10
  store i1 %t10, ptr %t2
  br label %L3
L3:
  %t11 = load i1, ptr %t2
  store i1 %t11, ptr %t1
  br i1 %t11, label %L5, label %L4
L4:
  %t12 = load i8, ptr %t0
  %t13 = icmp eq i8 %t12, 13
  store i1 %t13, ptr %t1
  br label %L5
L5:
  %t14 = load i1, ptr %t1
  ret i1 %t14
}

define void @lexerSkipTrivia(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  br label %L0
L0:
  %t1 = load ptr, ptr %t0
  %t2 = call i1 @lexerAtEnd(ptr %t1)
  %t3 = xor i1 %t2, true
  br i1 %t3, label %L1, label %L2
L1:
  %t4 = load ptr, ptr %t0
  %t5 = call i8 @lexerPeek(ptr %t4)
  %t6 = alloca i8
  store i8 %t5, ptr %t6
  %t7 = load i8, ptr %t6
  %t8 = call i1 @isSpace(i8 %t7)
  br i1 %t8, label %L3, label %L5
L3:
  %t9 = load ptr, ptr %t0
  %t10 = call i8 @lexerAdvance(ptr %t9)
  br label %L0
L6:
  br label %L5
L5:
  %t11 = alloca i1
  %t12 = load i8, ptr %t6
  %t13 = icmp eq i8 %t12, 47
  store i1 %t13, ptr %t11
  br i1 %t13, label %L7, label %L8
L7:
  %t14 = load ptr, ptr %t0
  %t15 = call i8 @lexerPeekNext(ptr %t14)
  %t16 = icmp eq i8 %t15, 47
  store i1 %t16, ptr %t11
  br label %L8
L8:
  %t17 = load i1, ptr %t11
  br i1 %t17, label %L9, label %L11
L9:
  br label %L12
L12:
  %t18 = alloca i1
  %t19 = load ptr, ptr %t0
  %t20 = call i1 @lexerAtEnd(ptr %t19)
  %t21 = xor i1 %t20, true
  store i1 %t21, ptr %t18
  br i1 %t21, label %L15, label %L16
L15:
  %t22 = load ptr, ptr %t0
  %t23 = call i8 @lexerPeek(ptr %t22)
  %t24 = icmp ne i8 %t23, 10
  store i1 %t24, ptr %t18
  br label %L16
L16:
  %t25 = load i1, ptr %t18
  br i1 %t25, label %L13, label %L14
L13:
  %t26 = load ptr, ptr %t0
  %t27 = call i8 @lexerAdvance(ptr %t26)
  br label %L12
L14:
  br label %L0
L17:
  br label %L11
L11:
  ret void
L2:
  ret void
}

define i32 @keywordKind(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i1 @textEquals(ptr %t1, ptr @.str.68)
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load i32, ptr @TK_LET
  ret i32 %t3
L2:
  %t4 = load ptr, ptr %t0
  %t5 = call i1 @textEquals(ptr %t4, ptr @.str.69)
  br i1 %t5, label %L3, label %L5
L3:
  %t6 = load i32, ptr @TK_IF
  ret i32 %t6
L5:
  %t7 = load ptr, ptr %t0
  %t8 = call i1 @textEquals(ptr %t7, ptr @.str.70)
  br i1 %t8, label %L6, label %L8
L6:
  %t9 = load i32, ptr @TK_ELSE
  ret i32 %t9
L8:
  %t10 = load ptr, ptr %t0
  %t11 = call i1 @textEquals(ptr %t10, ptr @.str.71)
  br i1 %t11, label %L9, label %L11
L9:
  %t12 = load i32, ptr @TK_FN
  ret i32 %t12
L11:
  %t13 = load ptr, ptr %t0
  %t14 = call i1 @textEquals(ptr %t13, ptr @.str.72)
  br i1 %t14, label %L12, label %L14
L12:
  %t15 = load i32, ptr @TK_EXTERN
  ret i32 %t15
L14:
  %t16 = load ptr, ptr %t0
  %t17 = call i1 @textEquals(ptr %t16, ptr @.str.73)
  br i1 %t17, label %L15, label %L17
L15:
  %t18 = load i32, ptr @TK_STRUCT
  ret i32 %t18
L17:
  %t19 = load ptr, ptr %t0
  %t20 = call i1 @textEquals(ptr %t19, ptr @.str.74)
  br i1 %t20, label %L18, label %L20
L18:
  %t21 = load i32, ptr @TK_SIZEOF
  ret i32 %t21
L20:
  %t22 = load ptr, ptr %t0
  %t23 = call i1 @textEquals(ptr %t22, ptr @.str.75)
  br i1 %t23, label %L21, label %L23
L21:
  %t24 = load i32, ptr @TK_RETURN
  ret i32 %t24
L23:
  %t25 = load ptr, ptr %t0
  %t26 = call i1 @textEquals(ptr %t25, ptr @.str.76)
  br i1 %t26, label %L24, label %L26
L24:
  %t27 = load i32, ptr @TK_WHILE
  ret i32 %t27
L26:
  %t28 = load ptr, ptr %t0
  %t29 = call i1 @textEquals(ptr %t28, ptr @.str.77)
  br i1 %t29, label %L27, label %L29
L27:
  %t30 = load i32, ptr @TK_BREAK
  ret i32 %t30
L29:
  %t31 = load ptr, ptr %t0
  %t32 = call i1 @textEquals(ptr %t31, ptr @.str.78)
  br i1 %t32, label %L30, label %L32
L30:
  %t33 = load i32, ptr @TK_CONTINUE
  ret i32 %t33
L32:
  %t34 = load ptr, ptr %t0
  %t35 = call i1 @textEquals(ptr %t34, ptr @.str.79)
  br i1 %t35, label %L33, label %L35
L33:
  %t36 = load i32, ptr @TK_PRINT
  ret i32 %t36
L35:
  %t37 = load ptr, ptr %t0
  %t38 = call i1 @textEquals(ptr %t37, ptr @.str.80)
  br i1 %t38, label %L36, label %L38
L36:
  %t39 = load i32, ptr @TK_AS
  ret i32 %t39
L38:
  %t40 = load ptr, ptr %t0
  %t41 = call i1 @textEquals(ptr %t40, ptr @.str.81)
  br i1 %t41, label %L39, label %L41
L39:
  %t42 = load i32, ptr @TK_IMPORT
  ret i32 %t42
L41:
  %t43 = load ptr, ptr %t0
  %t44 = call i1 @textEquals(ptr %t43, ptr @.str.82)
  br i1 %t44, label %L42, label %L44
L42:
  %t45 = load i32, ptr @TK_EXPORT
  ret i32 %t45
L44:
  %t46 = load ptr, ptr %t0
  %t47 = call i1 @textEquals(ptr %t46, ptr @.str.83)
  br i1 %t47, label %L45, label %L47
L45:
  %t48 = load i32, ptr @TK_BOOL
  ret i32 %t48
L47:
  %t49 = load ptr, ptr %t0
  %t50 = call i1 @textEquals(ptr %t49, ptr @.str.84)
  br i1 %t50, label %L48, label %L50
L48:
  %t51 = load i32, ptr @TK_BOOL
  ret i32 %t51
L50:
  %t52 = load ptr, ptr %t0
  %t53 = call i1 @textEquals(ptr %t52, ptr @.str.85)
  br i1 %t53, label %L51, label %L53
L51:
  %t54 = load i32, ptr @TK_TYPE
  ret i32 %t54
L53:
  %t55 = load ptr, ptr %t0
  %t56 = call i1 @textEquals(ptr %t55, ptr @.str.86)
  br i1 %t56, label %L54, label %L56
L54:
  %t57 = load i32, ptr @TK_TYPE
  ret i32 %t57
L56:
  %t58 = load ptr, ptr %t0
  %t59 = call i1 @textEquals(ptr %t58, ptr @.str.87)
  br i1 %t59, label %L57, label %L59
L57:
  %t60 = load i32, ptr @TK_TYPE
  ret i32 %t60
L59:
  %t61 = load ptr, ptr %t0
  %t62 = call i1 @textEquals(ptr %t61, ptr @.str.88)
  br i1 %t62, label %L60, label %L62
L60:
  %t63 = load i32, ptr @TK_TYPE
  ret i32 %t63
L62:
  %t64 = load ptr, ptr %t0
  %t65 = call i1 @textEquals(ptr %t64, ptr @.str.89)
  br i1 %t65, label %L63, label %L65
L63:
  %t66 = load i32, ptr @TK_TYPE
  ret i32 %t66
L65:
  %t67 = load ptr, ptr %t0
  %t68 = call i1 @textEquals(ptr %t67, ptr @.str.90)
  br i1 %t68, label %L66, label %L68
L66:
  %t69 = load i32, ptr @TK_TYPE
  ret i32 %t69
L68:
  %t70 = load ptr, ptr %t0
  %t71 = call i1 @textEquals(ptr %t70, ptr @.str.91)
  br i1 %t71, label %L69, label %L71
L69:
  %t72 = load i32, ptr @TK_TYPE
  ret i32 %t72
L71:
  %t73 = load ptr, ptr %t0
  %t74 = call i1 @textEquals(ptr %t73, ptr @.str.92)
  br i1 %t74, label %L72, label %L74
L72:
  %t75 = load i32, ptr @TK_TYPE
  ret i32 %t75
L74:
  %t76 = load ptr, ptr %t0
  %t77 = call i1 @textEquals(ptr %t76, ptr @.str.93)
  br i1 %t77, label %L75, label %L77
L75:
  %t78 = load i32, ptr @TK_TYPE
  ret i32 %t78
L77:
  %t79 = load ptr, ptr %t0
  %t80 = call i1 @textEquals(ptr %t79, ptr @.str.94)
  br i1 %t80, label %L78, label %L80
L78:
  %t81 = load i32, ptr @TK_TYPE
  ret i32 %t81
L80:
  %t82 = load ptr, ptr %t0
  %t83 = call i1 @textEquals(ptr %t82, ptr @.str.95)
  br i1 %t83, label %L81, label %L83
L81:
  %t84 = load i32, ptr @TK_TYPE
  ret i32 %t84
L83:
  %t85 = load ptr, ptr %t0
  %t86 = call i1 @textEquals(ptr %t85, ptr @.str.96)
  br i1 %t86, label %L84, label %L86
L84:
  %t87 = load i32, ptr @TK_TYPE
  ret i32 %t87
L86:
  %t88 = load ptr, ptr %t0
  %t89 = call i1 @textEquals(ptr %t88, ptr @.str.97)
  br i1 %t89, label %L87, label %L89
L87:
  %t90 = load i32, ptr @TK_TYPE
  ret i32 %t90
L89:
  %t91 = load i32, ptr @TK_IDENT
  ret i32 %t91
}

define i8 @escapeValue(i8 %p0, i32 %p1, i32 %p2) {
entry:
  %t0 = alloca i8
  store i8 %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = load i8, ptr %t0
  %t4 = icmp eq i8 %t3, 110
  br i1 %t4, label %L0, label %L2
L0:
  ret i8 10
L2:
  %t5 = load i8, ptr %t0
  %t6 = icmp eq i8 %t5, 116
  br i1 %t6, label %L3, label %L5
L3:
  ret i8 9
L5:
  %t7 = load i8, ptr %t0
  %t8 = icmp eq i8 %t7, 114
  br i1 %t8, label %L6, label %L8
L6:
  ret i8 13
L8:
  %t9 = load i8, ptr %t0
  %t10 = icmp eq i8 %t9, 48
  br i1 %t10, label %L9, label %L11
L9:
  %t11 = trunc i32 0 to i8
  ret i8 %t11
L11:
  %t12 = load i8, ptr %t0
  %t13 = icmp eq i8 %t12, 92
  br i1 %t13, label %L12, label %L14
L12:
  ret i8 92
L14:
  %t14 = load i8, ptr %t0
  %t15 = icmp eq i8 %t14, 34
  br i1 %t15, label %L15, label %L17
L15:
  ret i8 34
L17:
  %t16 = load i8, ptr %t0
  %t17 = icmp eq i8 %t16, 39
  br i1 %t17, label %L18, label %L20
L18:
  ret i8 39
L20:
  %t18 = load i32, ptr %t1
  %t19 = load i32, ptr %t2
  call void @failAt(i32 %t18, i32 %t19, ptr @.str.98)
  %t20 = trunc i32 0 to i8
  ret i8 %t20
}

define void @lexerReadIdentifier(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Lexer, ptr %t2, i32 0, i32 3
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 4
  %t8 = load i32, ptr %t7
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Lexer, ptr %t10, i32 0, i32 1
  %t12 = load i64, ptr %t11
  %t13 = alloca i64
  store i64 %t12, ptr %t13
  br label %L0
L0:
  %t14 = alloca i1
  %t15 = load ptr, ptr %t0
  %t16 = call i1 @lexerAtEnd(ptr %t15)
  %t17 = xor i1 %t16, true
  store i1 %t17, ptr %t14
  br i1 %t17, label %L3, label %L4
L3:
  %t18 = load ptr, ptr %t0
  %t19 = call i8 @lexerPeek(ptr %t18)
  %t20 = call i1 @isAlphaNumeric(i8 %t19)
  store i1 %t20, ptr %t14
  br label %L4
L4:
  %t21 = load i1, ptr %t14
  br i1 %t21, label %L1, label %L2
L1:
  %t22 = load ptr, ptr %t0
  %t23 = call i8 @lexerAdvance(ptr %t22)
  br label %L0
L2:
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Lexer, ptr %t24, i32 0, i32 1
  %t26 = load i64, ptr %t25
  %t27 = load i64, ptr %t13
  %t28 = sub i64 %t26, %t27
  %t29 = alloca i64
  store i64 %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Lexer, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = load i64, ptr %t13
  %t34 = load i64, ptr %t29
  %t35 = call ptr @textSlice(ptr %t32, i64 %t33, i64 %t34)
  %t36 = alloca ptr
  store ptr %t35, ptr %t36
  %t37 = load ptr, ptr %t1
  %t38 = load ptr, ptr %t36
  %t39 = call i32 @keywordKind(ptr %t38)
  %t40 = load ptr, ptr %t36
  %t41 = load i64, ptr %t29
  %t42 = load i32, ptr %t5
  %t43 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t37, i32 %t39, ptr %t40, i64 %t41, i32 %t42, i32 %t43)
  ret void
}

define i1 @foldsNegative(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = load i32, ptr @TK_NONE
  %t3 = icmp eq i32 %t1, %t2
  br i1 %t3, label %L0, label %L2
L0:
  ret i1 true
L2:
  %t4 = alloca i1
  %t5 = load i32, ptr %t0
  %t6 = load i32, ptr @TK_EQ
  %t7 = icmp eq i32 %t5, %t6
  store i1 %t7, ptr %t4
  br i1 %t7, label %L4, label %L3
L3:
  %t8 = load i32, ptr %t0
  %t9 = load i32, ptr @TK_NE
  %t10 = icmp eq i32 %t8, %t9
  store i1 %t10, ptr %t4
  br label %L4
L4:
  %t11 = load i1, ptr %t4
  br i1 %t11, label %L5, label %L7
L5:
  ret i1 true
L7:
  %t12 = alloca i1
  %t13 = load i32, ptr %t0
  %t14 = load i32, ptr @TK_LT
  %t15 = icmp eq i32 %t13, %t14
  store i1 %t15, ptr %t12
  br i1 %t15, label %L9, label %L8
L8:
  %t16 = load i32, ptr %t0
  %t17 = load i32, ptr @TK_LE
  %t18 = icmp eq i32 %t16, %t17
  store i1 %t18, ptr %t12
  br label %L9
L9:
  %t19 = load i1, ptr %t12
  br i1 %t19, label %L10, label %L12
L10:
  ret i1 true
L12:
  %t20 = alloca i1
  %t21 = load i32, ptr %t0
  %t22 = load i32, ptr @TK_GT
  %t23 = icmp eq i32 %t21, %t22
  store i1 %t23, ptr %t20
  br i1 %t23, label %L14, label %L13
L13:
  %t24 = load i32, ptr %t0
  %t25 = load i32, ptr @TK_GE
  %t26 = icmp eq i32 %t24, %t25
  store i1 %t26, ptr %t20
  br label %L14
L14:
  %t27 = load i1, ptr %t20
  br i1 %t27, label %L15, label %L17
L15:
  ret i1 true
L17:
  %t28 = alloca i1
  %t29 = load i32, ptr %t0
  %t30 = load i32, ptr @TK_PLUS
  %t31 = icmp eq i32 %t29, %t30
  store i1 %t31, ptr %t28
  br i1 %t31, label %L19, label %L18
L18:
  %t32 = load i32, ptr %t0
  %t33 = load i32, ptr @TK_MINUS
  %t34 = icmp eq i32 %t32, %t33
  store i1 %t34, ptr %t28
  br label %L19
L19:
  %t35 = load i1, ptr %t28
  br i1 %t35, label %L20, label %L22
L20:
  ret i1 true
L22:
  %t36 = alloca i1
  %t37 = load i32, ptr %t0
  %t38 = load i32, ptr @TK_STAR
  %t39 = icmp eq i32 %t37, %t38
  store i1 %t39, ptr %t36
  br i1 %t39, label %L24, label %L23
L23:
  %t40 = load i32, ptr %t0
  %t41 = load i32, ptr @TK_SLASH
  %t42 = icmp eq i32 %t40, %t41
  store i1 %t42, ptr %t36
  br label %L24
L24:
  %t43 = load i1, ptr %t36
  br i1 %t43, label %L25, label %L27
L25:
  ret i1 true
L27:
  %t44 = alloca i1
  %t45 = load i32, ptr %t0
  %t46 = load i32, ptr @TK_ANDAND
  %t47 = icmp eq i32 %t45, %t46
  store i1 %t47, ptr %t44
  br i1 %t47, label %L29, label %L28
L28:
  %t48 = load i32, ptr %t0
  %t49 = load i32, ptr @TK_OROR
  %t50 = icmp eq i32 %t48, %t49
  store i1 %t50, ptr %t44
  br label %L29
L29:
  %t51 = load i1, ptr %t44
  br i1 %t51, label %L30, label %L32
L30:
  ret i1 true
L32:
  %t52 = alloca i1
  %t53 = load i32, ptr %t0
  %t54 = load i32, ptr @TK_LPAREN
  %t55 = icmp eq i32 %t53, %t54
  store i1 %t55, ptr %t52
  br i1 %t55, label %L34, label %L33
L33:
  %t56 = load i32, ptr %t0
  %t57 = load i32, ptr @TK_LBRACE
  %t58 = icmp eq i32 %t56, %t57
  store i1 %t58, ptr %t52
  br label %L34
L34:
  %t59 = load i1, ptr %t52
  br i1 %t59, label %L35, label %L37
L35:
  ret i1 true
L37:
  %t60 = alloca i1
  %t61 = load i32, ptr %t0
  %t62 = load i32, ptr @TK_COMMA
  %t63 = icmp eq i32 %t61, %t62
  store i1 %t63, ptr %t60
  br i1 %t63, label %L39, label %L38
L38:
  %t64 = load i32, ptr %t0
  %t65 = load i32, ptr @TK_COLON
  %t66 = icmp eq i32 %t64, %t65
  store i1 %t66, ptr %t60
  br label %L39
L39:
  %t67 = load i1, ptr %t60
  br i1 %t67, label %L40, label %L42
L40:
  ret i1 true
L42:
  %t68 = load i32, ptr %t0
  %t69 = load i32, ptr @TK_RETURN
  %t70 = icmp eq i32 %t68, %t69
  ret i1 %t70
}

define void @lexerReadNumber(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Lexer, ptr %t2, i32 0, i32 3
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 4
  %t8 = load i32, ptr %t7
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Lexer, ptr %t10, i32 0, i32 1
  %t12 = load i64, ptr %t11
  %t13 = alloca i64
  store i64 %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = call i8 @lexerPeek(ptr %t14)
  %t16 = icmp eq i8 %t15, 45
  br i1 %t16, label %L0, label %L2
L0:
  %t17 = load ptr, ptr %t0
  %t18 = call i8 @lexerAdvance(ptr %t17)
  br label %L2
L2:
  br label %L3
L3:
  %t19 = alloca i1
  %t20 = load ptr, ptr %t0
  %t21 = call i1 @lexerAtEnd(ptr %t20)
  %t22 = xor i1 %t21, true
  store i1 %t22, ptr %t19
  br i1 %t22, label %L6, label %L7
L6:
  %t23 = alloca i1
  %t24 = load ptr, ptr %t0
  %t25 = call i8 @lexerPeek(ptr %t24)
  %t26 = call i1 @isDigit(i8 %t25)
  store i1 %t26, ptr %t23
  br i1 %t26, label %L9, label %L8
L8:
  %t27 = load ptr, ptr %t0
  %t28 = call i8 @lexerPeek(ptr %t27)
  %t29 = icmp eq i8 %t28, 46
  store i1 %t29, ptr %t23
  br label %L9
L9:
  %t30 = load i1, ptr %t23
  store i1 %t30, ptr %t19
  br label %L7
L7:
  %t31 = load i1, ptr %t19
  br i1 %t31, label %L4, label %L5
L4:
  %t32 = load ptr, ptr %t0
  %t33 = call i8 @lexerAdvance(ptr %t32)
  br label %L3
L5:
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Lexer, ptr %t34, i32 0, i32 1
  %t36 = load i64, ptr %t35
  %t37 = load i64, ptr %t13
  %t38 = sub i64 %t36, %t37
  %t39 = alloca i64
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr inbounds %Lexer, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = load i64, ptr %t13
  %t44 = load i64, ptr %t39
  %t45 = call ptr @textSlice(ptr %t42, i64 %t43, i64 %t44)
  %t46 = alloca ptr
  store ptr %t45, ptr %t46
  %t47 = load ptr, ptr %t1
  %t48 = load i32, ptr @TK_NUMBER
  %t49 = load ptr, ptr %t46
  %t50 = load i64, ptr %t39
  %t51 = load i32, ptr %t5
  %t52 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t47, i32 %t48, ptr %t49, i64 %t50, i32 %t51, i32 %t52)
  ret void
}

define void @lexerReadString(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Lexer, ptr %t2, i32 0, i32 3
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 4
  %t8 = load i32, ptr %t7
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = call i8 @lexerAdvance(ptr %t10)
  %t12 = call ptr @bufNew()
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  br label %L0
L0:
  br i1 true, label %L1, label %L2
L1:
  %t14 = load ptr, ptr %t0
  %t15 = call i1 @lexerAtEnd(ptr %t14)
  br i1 %t15, label %L3, label %L5
L3:
  %t16 = load i32, ptr %t5
  %t17 = load i32, ptr %t9
  call void @failAt(i32 %t16, i32 %t17, ptr @.str.99)
  br label %L5
L5:
  %t18 = load ptr, ptr %t0
  %t19 = call i8 @lexerPeek(ptr %t18)
  %t20 = alloca i8
  store i8 %t19, ptr %t20
  %t21 = load i8, ptr %t20
  %t22 = icmp eq i8 %t21, 34
  br i1 %t22, label %L6, label %L8
L6:
  %t23 = load ptr, ptr %t0
  %t24 = call i8 @lexerAdvance(ptr %t23)
  br label %L2
L9:
  br label %L8
L8:
  %t25 = load i8, ptr %t20
  %t26 = icmp eq i8 %t25, 10
  br i1 %t26, label %L10, label %L12
L10:
  %t27 = load i32, ptr %t5
  %t28 = load i32, ptr %t9
  call void @failAt(i32 %t27, i32 %t28, ptr @.str.100)
  br label %L12
L12:
  %t29 = load i8, ptr %t20
  %t30 = icmp eq i8 %t29, 92
  br i1 %t30, label %L13, label %L15
L13:
  %t31 = load ptr, ptr %t0
  %t32 = call i8 @lexerAdvance(ptr %t31)
  %t33 = load ptr, ptr %t0
  %t34 = call i8 @lexerAdvance(ptr %t33)
  %t35 = alloca i8
  store i8 %t34, ptr %t35
  %t36 = load ptr, ptr %t13
  %t37 = load i8, ptr %t35
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %Lexer, ptr %t38, i32 0, i32 3
  %t40 = load i32, ptr %t39
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Lexer, ptr %t41, i32 0, i32 4
  %t43 = load i32, ptr %t42
  %t44 = call i8 @escapeValue(i8 %t37, i32 %t40, i32 %t43)
  call void @bufPush(ptr %t36, i8 %t44)
  br label %L0
L16:
  br label %L15
L15:
  %t45 = load ptr, ptr %t13
  %t46 = load ptr, ptr %t0
  %t47 = call i8 @lexerAdvance(ptr %t46)
  call void @bufPush(ptr %t45, i8 %t47)
  br label %L0
L2:
  %t48 = load ptr, ptr %t13
  %t49 = getelementptr inbounds %Buf, ptr %t48, i32 0, i32 1
  %t50 = load i64, ptr %t49
  %t51 = alloca i64
  store i64 %t50, ptr %t51
  %t52 = load ptr, ptr %t1
  %t53 = load i32, ptr @TK_STRING
  %t54 = load ptr, ptr %t13
  %t55 = call ptr @bufTake(ptr %t54)
  %t56 = load i64, ptr %t51
  %t57 = load i32, ptr %t5
  %t58 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t52, i32 %t53, ptr %t55, i64 %t56, i32 %t57, i32 %t58)
  ret void
}

define void @lexerReadChar(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Lexer, ptr %t2, i32 0, i32 3
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 4
  %t8 = load i32, ptr %t7
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = call i8 @lexerAdvance(ptr %t10)
  %t12 = call ptr @bufNew()
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = call i8 @lexerAdvance(ptr %t14)
  %t16 = alloca i8
  store i8 %t15, ptr %t16
  %t17 = load i8, ptr %t16
  %t18 = icmp eq i8 %t17, 92
  br i1 %t18, label %L0, label %L1
L0:
  %t19 = load ptr, ptr %t0
  %t20 = call i8 @lexerAdvance(ptr %t19)
  %t21 = alloca i8
  store i8 %t20, ptr %t21
  %t22 = load ptr, ptr %t13
  %t23 = load i8, ptr %t21
  %t24 = load i32, ptr %t5
  %t25 = load i32, ptr %t9
  %t26 = call i8 @escapeValue(i8 %t23, i32 %t24, i32 %t25)
  call void @bufPush(ptr %t22, i8 %t26)
  br label %L2
L1:
  %t27 = load ptr, ptr %t13
  %t28 = load i8, ptr %t16
  call void @bufPush(ptr %t27, i8 %t28)
  br label %L2
L2:
  %t29 = load ptr, ptr %t0
  %t30 = call i8 @lexerPeek(ptr %t29)
  %t31 = icmp ne i8 %t30, 39
  br i1 %t31, label %L3, label %L5
L3:
  %t32 = load i32, ptr %t5
  %t33 = load i32, ptr %t9
  call void @failAt(i32 %t32, i32 %t33, ptr @.str.101)
  br label %L5
L5:
  %t34 = load ptr, ptr %t0
  %t35 = call i8 @lexerAdvance(ptr %t34)
  %t36 = load ptr, ptr %t13
  %t37 = getelementptr inbounds %Buf, ptr %t36, i32 0, i32 1
  %t38 = load i64, ptr %t37
  %t39 = alloca i64
  store i64 %t38, ptr %t39
  %t40 = load ptr, ptr %t1
  %t41 = load i32, ptr @TK_CHAR
  %t42 = load ptr, ptr %t13
  %t43 = call ptr @bufTake(ptr %t42)
  %t44 = load i64, ptr %t39
  %t45 = load i32, ptr %t5
  %t46 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t40, i32 %t41, ptr %t43, i64 %t44, i32 %t45, i32 %t46)
  ret void
}

define void @lexerReadOperator(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Lexer, ptr %t2, i32 0, i32 3
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Lexer, ptr %t6, i32 0, i32 4
  %t8 = load i32, ptr %t7
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = call i8 @lexerPeek(ptr %t10)
  %t12 = alloca i8
  store i8 %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = call i8 @lexerPeekNext(ptr %t13)
  %t15 = alloca i8
  store i8 %t14, ptr %t15
  %t16 = sub i32 0, 1
  %t17 = alloca i32
  store i32 %t16, ptr %t17
  %t18 = alloca i1
  %t19 = load i8, ptr %t12
  %t20 = icmp eq i8 %t19, 61
  store i1 %t20, ptr %t18
  br i1 %t20, label %L0, label %L1
L0:
  %t21 = load i8, ptr %t15
  %t22 = icmp eq i8 %t21, 61
  store i1 %t22, ptr %t18
  br label %L1
L1:
  %t23 = load i1, ptr %t18
  br i1 %t23, label %L2, label %L3
L2:
  %t24 = load i32, ptr @TK_EQ
  store i32 %t24, ptr %t17
  br label %L4
L3:
  %t25 = alloca i1
  %t26 = load i8, ptr %t12
  %t27 = icmp eq i8 %t26, 33
  store i1 %t27, ptr %t25
  br i1 %t27, label %L5, label %L6
L5:
  %t28 = load i8, ptr %t15
  %t29 = icmp eq i8 %t28, 61
  store i1 %t29, ptr %t25
  br label %L6
L6:
  %t30 = load i1, ptr %t25
  br i1 %t30, label %L7, label %L8
L7:
  %t31 = load i32, ptr @TK_NE
  store i32 %t31, ptr %t17
  br label %L9
L8:
  %t32 = alloca i1
  %t33 = load i8, ptr %t12
  %t34 = icmp eq i8 %t33, 60
  store i1 %t34, ptr %t32
  br i1 %t34, label %L10, label %L11
L10:
  %t35 = load i8, ptr %t15
  %t36 = icmp eq i8 %t35, 61
  store i1 %t36, ptr %t32
  br label %L11
L11:
  %t37 = load i1, ptr %t32
  br i1 %t37, label %L12, label %L13
L12:
  %t38 = load i32, ptr @TK_LE
  store i32 %t38, ptr %t17
  br label %L14
L13:
  %t39 = alloca i1
  %t40 = load i8, ptr %t12
  %t41 = icmp eq i8 %t40, 62
  store i1 %t41, ptr %t39
  br i1 %t41, label %L15, label %L16
L15:
  %t42 = load i8, ptr %t15
  %t43 = icmp eq i8 %t42, 61
  store i1 %t43, ptr %t39
  br label %L16
L16:
  %t44 = load i1, ptr %t39
  br i1 %t44, label %L17, label %L18
L17:
  %t45 = load i32, ptr @TK_GE
  store i32 %t45, ptr %t17
  br label %L19
L18:
  %t46 = alloca i1
  %t47 = load i8, ptr %t12
  %t48 = icmp eq i8 %t47, 38
  store i1 %t48, ptr %t46
  br i1 %t48, label %L20, label %L21
L20:
  %t49 = load i8, ptr %t15
  %t50 = icmp eq i8 %t49, 38
  store i1 %t50, ptr %t46
  br label %L21
L21:
  %t51 = load i1, ptr %t46
  br i1 %t51, label %L22, label %L23
L22:
  %t52 = load i32, ptr @TK_ANDAND
  store i32 %t52, ptr %t17
  br label %L24
L23:
  %t53 = alloca i1
  %t54 = load i8, ptr %t12
  %t55 = icmp eq i8 %t54, 124
  store i1 %t55, ptr %t53
  br i1 %t55, label %L25, label %L26
L25:
  %t56 = load i8, ptr %t15
  %t57 = icmp eq i8 %t56, 124
  store i1 %t57, ptr %t53
  br label %L26
L26:
  %t58 = load i1, ptr %t53
  br i1 %t58, label %L27, label %L28
L27:
  %t59 = load i32, ptr @TK_OROR
  store i32 %t59, ptr %t17
  br label %L29
L28:
  %t60 = alloca i1
  %t61 = load i8, ptr %t12
  %t62 = icmp eq i8 %t61, 60
  store i1 %t62, ptr %t60
  br i1 %t62, label %L30, label %L31
L30:
  %t63 = load i8, ptr %t15
  %t64 = icmp eq i8 %t63, 60
  store i1 %t64, ptr %t60
  br label %L31
L31:
  %t65 = load i1, ptr %t60
  br i1 %t65, label %L32, label %L33
L32:
  %t66 = load i32, ptr @TK_SHL
  store i32 %t66, ptr %t17
  br label %L34
L33:
  %t67 = alloca i1
  %t68 = load i8, ptr %t12
  %t69 = icmp eq i8 %t68, 62
  store i1 %t69, ptr %t67
  br i1 %t69, label %L35, label %L36
L35:
  %t70 = load i8, ptr %t15
  %t71 = icmp eq i8 %t70, 62
  store i1 %t71, ptr %t67
  br label %L36
L36:
  %t72 = load i1, ptr %t67
  br i1 %t72, label %L37, label %L38
L37:
  %t73 = load i32, ptr @TK_SHR
  store i32 %t73, ptr %t17
  br label %L39
L38:
  %t74 = alloca i1
  %t75 = load i8, ptr %t12
  %t76 = icmp eq i8 %t75, 43
  store i1 %t76, ptr %t74
  br i1 %t76, label %L40, label %L41
L40:
  %t77 = load i8, ptr %t15
  %t78 = icmp eq i8 %t77, 61
  store i1 %t78, ptr %t74
  br label %L41
L41:
  %t79 = load i1, ptr %t74
  br i1 %t79, label %L42, label %L43
L42:
  %t80 = load i32, ptr @TK_PLUS_ASSIGN
  store i32 %t80, ptr %t17
  br label %L44
L43:
  %t81 = alloca i1
  %t82 = load i8, ptr %t12
  %t83 = icmp eq i8 %t82, 45
  store i1 %t83, ptr %t81
  br i1 %t83, label %L45, label %L46
L45:
  %t84 = load i8, ptr %t15
  %t85 = icmp eq i8 %t84, 61
  store i1 %t85, ptr %t81
  br label %L46
L46:
  %t86 = load i1, ptr %t81
  br i1 %t86, label %L47, label %L48
L47:
  %t87 = load i32, ptr @TK_MINUS_ASSIGN
  store i32 %t87, ptr %t17
  br label %L49
L48:
  %t88 = alloca i1
  %t89 = load i8, ptr %t12
  %t90 = icmp eq i8 %t89, 42
  store i1 %t90, ptr %t88
  br i1 %t90, label %L50, label %L51
L50:
  %t91 = load i8, ptr %t15
  %t92 = icmp eq i8 %t91, 61
  store i1 %t92, ptr %t88
  br label %L51
L51:
  %t93 = load i1, ptr %t88
  br i1 %t93, label %L52, label %L53
L52:
  %t94 = load i32, ptr @TK_STAR_ASSIGN
  store i32 %t94, ptr %t17
  br label %L54
L53:
  %t95 = alloca i1
  %t96 = load i8, ptr %t12
  %t97 = icmp eq i8 %t96, 47
  store i1 %t97, ptr %t95
  br i1 %t97, label %L55, label %L56
L55:
  %t98 = load i8, ptr %t15
  %t99 = icmp eq i8 %t98, 61
  store i1 %t99, ptr %t95
  br label %L56
L56:
  %t100 = load i1, ptr %t95
  br i1 %t100, label %L57, label %L58
L57:
  %t101 = load i32, ptr @TK_SLASH_ASSIGN
  store i32 %t101, ptr %t17
  br label %L59
L58:
  %t102 = alloca i1
  %t103 = load i8, ptr %t12
  %t104 = icmp eq i8 %t103, 37
  store i1 %t104, ptr %t102
  br i1 %t104, label %L60, label %L61
L60:
  %t105 = load i8, ptr %t15
  %t106 = icmp eq i8 %t105, 61
  store i1 %t106, ptr %t102
  br label %L61
L61:
  %t107 = load i1, ptr %t102
  br i1 %t107, label %L62, label %L64
L62:
  %t108 = load i32, ptr @TK_PERCENT_ASSIGN
  store i32 %t108, ptr %t17
  br label %L64
L64:
  br label %L59
L59:
  br label %L54
L54:
  br label %L49
L49:
  br label %L44
L44:
  br label %L39
L39:
  br label %L34
L34:
  br label %L29
L29:
  br label %L24
L24:
  br label %L19
L19:
  br label %L14
L14:
  br label %L9
L9:
  br label %L4
L4:
  %t109 = load i32, ptr %t17
  %t110 = icmp sge i32 %t109, 0
  br i1 %t110, label %L65, label %L67
L65:
  %t111 = load ptr, ptr %t0
  %t112 = call i8 @lexerAdvance(ptr %t111)
  %t113 = load ptr, ptr %t0
  %t114 = call i8 @lexerAdvance(ptr %t113)
  %t115 = load ptr, ptr %t1
  %t116 = load i32, ptr %t17
  %t117 = load i32, ptr %t17
  %t118 = call ptr @kindName(i32 %t117)
  %t119 = call ptr @textCopy(ptr %t118)
  %t120 = load i32, ptr %t17
  %t121 = call ptr @kindName(i32 %t120)
  %t122 = call i64 @strlen(ptr %t121)
  %t123 = load i32, ptr %t5
  %t124 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t115, i32 %t116, ptr %t119, i64 %t122, i32 %t123, i32 %t124)
  ret void
L67:
  %t125 = load i8, ptr %t12
  %t126 = icmp eq i8 %t125, 61
  br i1 %t126, label %L68, label %L69
L68:
  %t127 = load i32, ptr @TK_ASSIGN
  store i32 %t127, ptr %t17
  br label %L70
L69:
  %t128 = load i8, ptr %t12
  %t129 = icmp eq i8 %t128, 43
  br i1 %t129, label %L71, label %L72
L71:
  %t130 = load i32, ptr @TK_PLUS
  store i32 %t130, ptr %t17
  br label %L73
L72:
  %t131 = load i8, ptr %t12
  %t132 = icmp eq i8 %t131, 45
  br i1 %t132, label %L74, label %L75
L74:
  %t133 = load i32, ptr @TK_MINUS
  store i32 %t133, ptr %t17
  br label %L76
L75:
  %t134 = load i8, ptr %t12
  %t135 = icmp eq i8 %t134, 42
  br i1 %t135, label %L77, label %L78
L77:
  %t136 = load i32, ptr @TK_STAR
  store i32 %t136, ptr %t17
  br label %L79
L78:
  %t137 = load i8, ptr %t12
  %t138 = icmp eq i8 %t137, 47
  br i1 %t138, label %L80, label %L81
L80:
  %t139 = load i32, ptr @TK_SLASH
  store i32 %t139, ptr %t17
  br label %L82
L81:
  %t140 = load i8, ptr %t12
  %t141 = icmp eq i8 %t140, 37
  br i1 %t141, label %L83, label %L84
L83:
  %t142 = load i32, ptr @TK_PERCENT
  store i32 %t142, ptr %t17
  br label %L85
L84:
  %t143 = load i8, ptr %t12
  %t144 = icmp eq i8 %t143, 33
  br i1 %t144, label %L86, label %L87
L86:
  %t145 = load i32, ptr @TK_NOT
  store i32 %t145, ptr %t17
  br label %L88
L87:
  %t146 = load i8, ptr %t12
  %t147 = icmp eq i8 %t146, 38
  br i1 %t147, label %L89, label %L90
L89:
  %t148 = load i32, ptr @TK_AMP
  store i32 %t148, ptr %t17
  br label %L91
L90:
  %t149 = load i8, ptr %t12
  %t150 = icmp eq i8 %t149, 124
  br i1 %t150, label %L92, label %L93
L92:
  %t151 = load i32, ptr @TK_PIPE
  store i32 %t151, ptr %t17
  br label %L94
L93:
  %t152 = load i8, ptr %t12
  %t153 = icmp eq i8 %t152, 94
  br i1 %t153, label %L95, label %L96
L95:
  %t154 = load i32, ptr @TK_CARET
  store i32 %t154, ptr %t17
  br label %L97
L96:
  %t155 = load i8, ptr %t12
  %t156 = icmp eq i8 %t155, 60
  br i1 %t156, label %L98, label %L99
L98:
  %t157 = load i32, ptr @TK_LT
  store i32 %t157, ptr %t17
  br label %L100
L99:
  %t158 = load i8, ptr %t12
  %t159 = icmp eq i8 %t158, 62
  br i1 %t159, label %L101, label %L102
L101:
  %t160 = load i32, ptr @TK_GT
  store i32 %t160, ptr %t17
  br label %L103
L102:
  %t161 = load i8, ptr %t12
  %t162 = icmp eq i8 %t161, 40
  br i1 %t162, label %L104, label %L105
L104:
  %t163 = load i32, ptr @TK_LPAREN
  store i32 %t163, ptr %t17
  br label %L106
L105:
  %t164 = load i8, ptr %t12
  %t165 = icmp eq i8 %t164, 41
  br i1 %t165, label %L107, label %L108
L107:
  %t166 = load i32, ptr @TK_RPAREN
  store i32 %t166, ptr %t17
  br label %L109
L108:
  %t167 = load i8, ptr %t12
  %t168 = icmp eq i8 %t167, 123
  br i1 %t168, label %L110, label %L111
L110:
  %t169 = load i32, ptr @TK_LBRACE
  store i32 %t169, ptr %t17
  br label %L112
L111:
  %t170 = load i8, ptr %t12
  %t171 = icmp eq i8 %t170, 125
  br i1 %t171, label %L113, label %L114
L113:
  %t172 = load i32, ptr @TK_RBRACE
  store i32 %t172, ptr %t17
  br label %L115
L114:
  %t173 = load i8, ptr %t12
  %t174 = icmp eq i8 %t173, 91
  br i1 %t174, label %L116, label %L117
L116:
  %t175 = load i32, ptr @TK_LBRACKET
  store i32 %t175, ptr %t17
  br label %L118
L117:
  %t176 = load i8, ptr %t12
  %t177 = icmp eq i8 %t176, 93
  br i1 %t177, label %L119, label %L120
L119:
  %t178 = load i32, ptr @TK_RBRACKET
  store i32 %t178, ptr %t17
  br label %L121
L120:
  %t179 = load i8, ptr %t12
  %t180 = icmp eq i8 %t179, 46
  br i1 %t180, label %L122, label %L123
L122:
  %t181 = load i32, ptr @TK_DOT
  store i32 %t181, ptr %t17
  br label %L124
L123:
  %t182 = load i8, ptr %t12
  %t183 = icmp eq i8 %t182, 59
  br i1 %t183, label %L125, label %L126
L125:
  %t184 = load i32, ptr @TK_SEMICOLON
  store i32 %t184, ptr %t17
  br label %L127
L126:
  %t185 = load i8, ptr %t12
  %t186 = icmp eq i8 %t185, 44
  br i1 %t186, label %L128, label %L129
L128:
  %t187 = load i32, ptr @TK_COMMA
  store i32 %t187, ptr %t17
  br label %L130
L129:
  %t188 = load i8, ptr %t12
  %t189 = icmp eq i8 %t188, 58
  br i1 %t189, label %L131, label %L132
L131:
  %t190 = load i32, ptr @TK_COLON
  store i32 %t190, ptr %t17
  br label %L133
L132:
  %t191 = load i32, ptr %t5
  %t192 = load i32, ptr %t9
  call void @failAt(i32 %t191, i32 %t192, ptr @.str.102)
  br label %L133
L133:
  br label %L130
L130:
  br label %L127
L127:
  br label %L124
L124:
  br label %L121
L121:
  br label %L118
L118:
  br label %L115
L115:
  br label %L112
L112:
  br label %L109
L109:
  br label %L106
L106:
  br label %L103
L103:
  br label %L100
L100:
  br label %L97
L97:
  br label %L94
L94:
  br label %L91
L91:
  br label %L88
L88:
  br label %L85
L85:
  br label %L82
L82:
  br label %L79
L79:
  br label %L76
L76:
  br label %L73
L73:
  br label %L70
L70:
  %t193 = load ptr, ptr %t0
  %t194 = call i8 @lexerAdvance(ptr %t193)
  %t195 = load ptr, ptr %t1
  %t196 = load i32, ptr %t17
  %t197 = load i32, ptr %t17
  %t198 = call ptr @kindName(i32 %t197)
  %t199 = call ptr @textCopy(ptr %t198)
  %t200 = load i32, ptr %t17
  %t201 = call ptr @kindName(i32 %t200)
  %t202 = call i64 @strlen(ptr %t201)
  %t203 = load i32, ptr %t5
  %t204 = load i32, ptr %t9
  call void @tokenListAdd(ptr %t195, i32 %t196, ptr %t199, i64 %t202, i32 %t203, i32 %t204)
  ret void
}

define ptr @tokenize(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @lexerNew(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = call ptr @tokenListNew()
  %t5 = alloca ptr
  store ptr %t4, ptr %t5
  %t6 = load i32, ptr @TK_NONE
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  br label %L0
L0:
  br i1 true, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t3
  call void @lexerSkipTrivia(ptr %t8)
  %t9 = load ptr, ptr %t3
  %t10 = call i1 @lexerAtEnd(ptr %t9)
  br i1 %t10, label %L3, label %L5
L3:
  br label %L2
L6:
  br label %L5
L5:
  %t11 = load ptr, ptr %t3
  %t12 = call i8 @lexerPeek(ptr %t11)
  %t13 = alloca i8
  store i8 %t12, ptr %t13
  %t14 = load i8, ptr %t13
  %t15 = call i1 @isAlpha(i8 %t14)
  br i1 %t15, label %L7, label %L8
L7:
  %t16 = load ptr, ptr %t3
  %t17 = load ptr, ptr %t5
  call void @lexerReadIdentifier(ptr %t16, ptr %t17)
  br label %L9
L8:
  %t18 = load i8, ptr %t13
  %t19 = call i1 @isDigit(i8 %t18)
  br i1 %t19, label %L10, label %L11
L10:
  %t20 = load ptr, ptr %t3
  %t21 = load ptr, ptr %t5
  call void @lexerReadNumber(ptr %t20, ptr %t21)
  br label %L12
L11:
  %t22 = alloca i1
  %t23 = alloca i1
  %t24 = load i8, ptr %t13
  %t25 = icmp eq i8 %t24, 45
  store i1 %t25, ptr %t23
  br i1 %t25, label %L13, label %L14
L13:
  %t26 = load ptr, ptr %t3
  %t27 = call i8 @lexerPeekNext(ptr %t26)
  %t28 = call i1 @isDigit(i8 %t27)
  store i1 %t28, ptr %t23
  br label %L14
L14:
  %t29 = load i1, ptr %t23
  store i1 %t29, ptr %t22
  br i1 %t29, label %L15, label %L16
L15:
  %t30 = load i32, ptr %t7
  %t31 = call i1 @foldsNegative(i32 %t30)
  store i1 %t31, ptr %t22
  br label %L16
L16:
  %t32 = load i1, ptr %t22
  br i1 %t32, label %L17, label %L18
L17:
  %t33 = load ptr, ptr %t3
  %t34 = load ptr, ptr %t5
  call void @lexerReadNumber(ptr %t33, ptr %t34)
  br label %L19
L18:
  %t35 = load i8, ptr %t13
  %t36 = icmp eq i8 %t35, 34
  br i1 %t36, label %L20, label %L21
L20:
  %t37 = load ptr, ptr %t3
  %t38 = load ptr, ptr %t5
  call void @lexerReadString(ptr %t37, ptr %t38)
  br label %L22
L21:
  %t39 = load i8, ptr %t13
  %t40 = icmp eq i8 %t39, 39
  br i1 %t40, label %L23, label %L24
L23:
  %t41 = load ptr, ptr %t3
  %t42 = load ptr, ptr %t5
  call void @lexerReadChar(ptr %t41, ptr %t42)
  br label %L25
L24:
  %t43 = load ptr, ptr %t3
  %t44 = load ptr, ptr %t5
  call void @lexerReadOperator(ptr %t43, ptr %t44)
  br label %L25
L25:
  br label %L22
L22:
  br label %L19
L19:
  br label %L12
L12:
  br label %L9
L9:
  %t45 = load ptr, ptr %t5
  %t46 = load ptr, ptr %t5
  %t47 = getelementptr inbounds %TokenList, ptr %t46, i32 0, i32 1
  %t48 = load i32, ptr %t47
  %t49 = sub i32 %t48, 1
  %t50 = call ptr @tokenAt(ptr %t45, i32 %t49)
  %t51 = getelementptr inbounds %Token, ptr %t50, i32 0, i32 0
  %t52 = load i32, ptr %t51
  store i32 %t52, ptr %t7
  br label %L0
L2:
  %t53 = load ptr, ptr %t5
  %t54 = load i32, ptr @TK_END
  %t55 = call ptr @textCopy(ptr @.str.103)
  %t56 = sext i32 0 to i64
  call void @tokenListAdd(ptr %t53, i32 %t54, ptr %t55, i64 %t56, i32 0, i32 0)
  %t57 = load ptr, ptr %t5
  ret ptr %t57
}

define ptr @astNew() {
entry:
  %t0 = call ptr @malloc(i64 24)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  %t3 = getelementptr inbounds %Ast, ptr %t2, i32 0, i32 2
  store i32 256, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 1
  store i32 0, ptr %t5
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 3
  store i32 0, ptr %t7
  %t8 = load ptr, ptr %t1
  %t9 = getelementptr inbounds %Ast, ptr %t8, i32 0, i32 2
  %t10 = load i32, ptr %t9
  %t11 = sext i32 %t10 to i64
  %t12 = mul i64 72, %t11
  %t13 = call ptr @malloc(i64 %t12)
  %t14 = load ptr, ptr %t1
  %t15 = getelementptr inbounds %Ast, ptr %t14, i32 0, i32 0
  store ptr %t13, ptr %t15
  %t16 = load ptr, ptr %t1
  ret ptr %t16
}

define i32 @astAdd(ptr %p0, i32 %p1, i32 %p2, i32 %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca i32
  store i32 %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Ast, ptr %t7, i32 0, i32 2
  %t9 = load i32, ptr %t8
  %t10 = icmp eq i32 %t6, %t9
  br i1 %t10, label %L0, label %L2
L0:
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Ast, ptr %t11, i32 0, i32 2
  %t13 = load i32, ptr %t12
  %t14 = mul i32 %t13, 2
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Ast, ptr %t15, i32 0, i32 2
  store i32 %t14, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Ast, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 2
  %t22 = load i32, ptr %t21
  %t23 = sext i32 %t22 to i64
  %t24 = mul i64 72, %t23
  %t25 = call ptr @realloc(ptr %t19, i64 %t24)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Ast, ptr %t26, i32 0, i32 0
  store ptr %t25, ptr %t27
  br label %L2
L2:
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Ast, ptr %t28, i32 0, i32 1
  %t30 = load i32, ptr %t29
  %t31 = alloca i32
  store i32 %t30, ptr %t31
  %t32 = load i32, ptr %t1
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Ast, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = load i32, ptr %t31
  %t37 = sext i32 %t36 to i64
  %t38 = getelementptr inbounds %Node, ptr %t35, i64 %t37
  %t39 = getelementptr inbounds %Node, ptr %t38, i32 0, i32 0
  store i32 %t32, ptr %t39
  %t40 = load i32, ptr %t2
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Ast, ptr %t41, i32 0, i32 0
  %t43 = load ptr, ptr %t42
  %t44 = load i32, ptr %t31
  %t45 = sext i32 %t44 to i64
  %t46 = getelementptr inbounds %Node, ptr %t43, i64 %t45
  %t47 = getelementptr inbounds %Node, ptr %t46, i32 0, i32 1
  store i32 %t40, ptr %t47
  %t48 = load i32, ptr %t3
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr inbounds %Ast, ptr %t49, i32 0, i32 0
  %t51 = load ptr, ptr %t50
  %t52 = load i32, ptr %t31
  %t53 = sext i32 %t52 to i64
  %t54 = getelementptr inbounds %Node, ptr %t51, i64 %t53
  %t55 = getelementptr inbounds %Node, ptr %t54, i32 0, i32 2
  store i32 %t48, ptr %t55
  %t56 = call ptr @nullText()
  %t57 = load ptr, ptr %t0
  %t58 = getelementptr inbounds %Ast, ptr %t57, i32 0, i32 0
  %t59 = load ptr, ptr %t58
  %t60 = load i32, ptr %t31
  %t61 = sext i32 %t60 to i64
  %t62 = getelementptr inbounds %Node, ptr %t59, i64 %t61
  %t63 = getelementptr inbounds %Node, ptr %t62, i32 0, i32 3
  store ptr %t56, ptr %t63
  %t64 = sext i32 0 to i64
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr inbounds %Ast, ptr %t65, i32 0, i32 0
  %t67 = load ptr, ptr %t66
  %t68 = load i32, ptr %t31
  %t69 = sext i32 %t68 to i64
  %t70 = getelementptr inbounds %Node, ptr %t67, i64 %t69
  %t71 = getelementptr inbounds %Node, ptr %t70, i32 0, i32 4
  store i64 %t64, ptr %t71
  %t72 = load i32, ptr @NO_NODE
  %t73 = load ptr, ptr %t0
  %t74 = getelementptr inbounds %Ast, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr %t31
  %t77 = sext i32 %t76 to i64
  %t78 = getelementptr inbounds %Node, ptr %t75, i64 %t77
  %t79 = getelementptr inbounds %Node, ptr %t78, i32 0, i32 5
  store i32 %t72, ptr %t79
  %t80 = load i32, ptr @NO_NODE
  %t81 = load ptr, ptr %t0
  %t82 = getelementptr inbounds %Ast, ptr %t81, i32 0, i32 0
  %t83 = load ptr, ptr %t82
  %t84 = load i32, ptr %t31
  %t85 = sext i32 %t84 to i64
  %t86 = getelementptr inbounds %Node, ptr %t83, i64 %t85
  %t87 = getelementptr inbounds %Node, ptr %t86, i32 0, i32 6
  store i32 %t80, ptr %t87
  %t88 = load i32, ptr @NO_NODE
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr inbounds %Ast, ptr %t89, i32 0, i32 0
  %t91 = load ptr, ptr %t90
  %t92 = load i32, ptr %t31
  %t93 = sext i32 %t92 to i64
  %t94 = getelementptr inbounds %Node, ptr %t91, i64 %t93
  %t95 = getelementptr inbounds %Node, ptr %t94, i32 0, i32 7
  store i32 %t88, ptr %t95
  %t96 = load ptr, ptr %t0
  %t97 = getelementptr inbounds %Ast, ptr %t96, i32 0, i32 0
  %t98 = load ptr, ptr %t97
  %t99 = load i32, ptr %t31
  %t100 = sext i32 %t99 to i64
  %t101 = getelementptr inbounds %Node, ptr %t98, i64 %t100
  %t102 = getelementptr inbounds %Node, ptr %t101, i32 0, i32 8
  store i32 0, ptr %t102
  %t103 = sext i32 0 to i64
  %t104 = inttoptr i64 %t103 to ptr
  %t105 = load ptr, ptr %t0
  %t106 = getelementptr inbounds %Ast, ptr %t105, i32 0, i32 0
  %t107 = load ptr, ptr %t106
  %t108 = load i32, ptr %t31
  %t109 = sext i32 %t108 to i64
  %t110 = getelementptr inbounds %Node, ptr %t107, i64 %t109
  %t111 = getelementptr inbounds %Node, ptr %t110, i32 0, i32 9
  store ptr %t104, ptr %t111
  %t112 = load ptr, ptr %t0
  %t113 = getelementptr inbounds %Ast, ptr %t112, i32 0, i32 0
  %t114 = load ptr, ptr %t113
  %t115 = load i32, ptr %t31
  %t116 = sext i32 %t115 to i64
  %t117 = getelementptr inbounds %Node, ptr %t114, i64 %t116
  %t118 = getelementptr inbounds %Node, ptr %t117, i32 0, i32 10
  store i32 0, ptr %t118
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr inbounds %Ast, ptr %t119, i32 0, i32 0
  %t121 = load ptr, ptr %t120
  %t122 = load i32, ptr %t31
  %t123 = sext i32 %t122 to i64
  %t124 = getelementptr inbounds %Node, ptr %t121, i64 %t123
  %t125 = getelementptr inbounds %Node, ptr %t124, i32 0, i32 11
  store i32 0, ptr %t125
  %t126 = load ptr, ptr %t0
  %t127 = getelementptr inbounds %Ast, ptr %t126, i32 0, i32 3
  %t128 = load i32, ptr %t127
  %t129 = load ptr, ptr %t0
  %t130 = getelementptr inbounds %Ast, ptr %t129, i32 0, i32 0
  %t131 = load ptr, ptr %t130
  %t132 = load i32, ptr %t31
  %t133 = sext i32 %t132 to i64
  %t134 = getelementptr inbounds %Node, ptr %t131, i64 %t133
  %t135 = getelementptr inbounds %Node, ptr %t134, i32 0, i32 12
  store i32 %t128, ptr %t135
  %t136 = load ptr, ptr %t0
  %t137 = getelementptr inbounds %Ast, ptr %t136, i32 0, i32 0
  %t138 = load ptr, ptr %t137
  %t139 = load i32, ptr %t31
  %t140 = sext i32 %t139 to i64
  %t141 = getelementptr inbounds %Node, ptr %t138, i64 %t140
  %t142 = getelementptr inbounds %Node, ptr %t141, i32 0, i32 13
  store i1 false, ptr %t142
  %t143 = load ptr, ptr %t0
  %t144 = getelementptr inbounds %Ast, ptr %t143, i32 0, i32 1
  %t145 = load i32, ptr %t144
  %t146 = add i32 %t145, 1
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Ast, ptr %t147, i32 0, i32 1
  store i32 %t146, ptr %t148
  %t149 = load i32, ptr %t31
  ret i32 %t149
}

define void @astSetText(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t2
  %t4 = getelementptr inbounds %Token, ptr %t3, i32 0, i32 1
  %t5 = load ptr, ptr %t4
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = load i32, ptr %t1
  %t10 = sext i32 %t9 to i64
  %t11 = getelementptr inbounds %Node, ptr %t8, i64 %t10
  %t12 = getelementptr inbounds %Node, ptr %t11, i32 0, i32 3
  store ptr %t5, ptr %t12
  %t13 = load ptr, ptr %t2
  %t14 = getelementptr inbounds %Token, ptr %t13, i32 0, i32 2
  %t15 = load i64, ptr %t14
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 4
  store i64 %t15, ptr %t22
  ret void
}

define void @astAddItem(ptr %p0, i32 %p1, i32 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Ast, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = load i32, ptr %t1
  %t7 = sext i32 %t6 to i64
  %t8 = getelementptr inbounds %Node, ptr %t5, i64 %t7
  %t9 = getelementptr inbounds %Node, ptr %t8, i32 0, i32 10
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Ast, ptr %t11, i32 0, i32 0
  %t13 = load ptr, ptr %t12
  %t14 = load i32, ptr %t1
  %t15 = sext i32 %t14 to i64
  %t16 = getelementptr inbounds %Node, ptr %t13, i64 %t15
  %t17 = getelementptr inbounds %Node, ptr %t16, i32 0, i32 11
  %t18 = load i32, ptr %t17
  %t19 = icmp eq i32 %t10, %t18
  br i1 %t19, label %L0, label %L2
L0:
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t1
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 11
  %t27 = load i32, ptr %t26
  %t28 = icmp eq i32 %t27, 0
  br i1 %t28, label %L3, label %L4
L3:
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Ast, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t1
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Node, ptr %t31, i64 %t33
  %t35 = getelementptr inbounds %Node, ptr %t34, i32 0, i32 11
  store i32 4, ptr %t35
  %t36 = sext i32 4 to i64
  %t37 = mul i64 4, %t36
  %t38 = call ptr @malloc(i64 %t37)
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Ast, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t1
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds %Node, ptr %t41, i64 %t43
  %t45 = getelementptr inbounds %Node, ptr %t44, i32 0, i32 9
  store ptr %t38, ptr %t45
  br label %L5
L4:
  %t46 = load ptr, ptr %t0
  %t47 = getelementptr inbounds %Ast, ptr %t46, i32 0, i32 0
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t1
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds %Node, ptr %t48, i64 %t50
  %t52 = getelementptr inbounds %Node, ptr %t51, i32 0, i32 11
  %t53 = load i32, ptr %t52
  %t54 = mul i32 %t53, 2
  %t55 = load ptr, ptr %t0
  %t56 = getelementptr inbounds %Ast, ptr %t55, i32 0, i32 0
  %t57 = load ptr, ptr %t56
  %t58 = load i32, ptr %t1
  %t59 = sext i32 %t58 to i64
  %t60 = getelementptr inbounds %Node, ptr %t57, i64 %t59
  %t61 = getelementptr inbounds %Node, ptr %t60, i32 0, i32 11
  store i32 %t54, ptr %t61
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Ast, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = load i32, ptr %t1
  %t66 = sext i32 %t65 to i64
  %t67 = getelementptr inbounds %Node, ptr %t64, i64 %t66
  %t68 = getelementptr inbounds %Node, ptr %t67, i32 0, i32 9
  %t69 = load ptr, ptr %t68
  %t70 = load ptr, ptr %t0
  %t71 = getelementptr inbounds %Ast, ptr %t70, i32 0, i32 0
  %t72 = load ptr, ptr %t71
  %t73 = load i32, ptr %t1
  %t74 = sext i32 %t73 to i64
  %t75 = getelementptr inbounds %Node, ptr %t72, i64 %t74
  %t76 = getelementptr inbounds %Node, ptr %t75, i32 0, i32 11
  %t77 = load i32, ptr %t76
  %t78 = sext i32 %t77 to i64
  %t79 = mul i64 4, %t78
  %t80 = call ptr @realloc(ptr %t69, i64 %t79)
  %t81 = load ptr, ptr %t0
  %t82 = getelementptr inbounds %Ast, ptr %t81, i32 0, i32 0
  %t83 = load ptr, ptr %t82
  %t84 = load i32, ptr %t1
  %t85 = sext i32 %t84 to i64
  %t86 = getelementptr inbounds %Node, ptr %t83, i64 %t85
  %t87 = getelementptr inbounds %Node, ptr %t86, i32 0, i32 9
  store ptr %t80, ptr %t87
  br label %L5
L5:
  br label %L2
L2:
  %t88 = load ptr, ptr %t0
  %t89 = getelementptr inbounds %Ast, ptr %t88, i32 0, i32 0
  %t90 = load ptr, ptr %t89
  %t91 = load i32, ptr %t1
  %t92 = sext i32 %t91 to i64
  %t93 = getelementptr inbounds %Node, ptr %t90, i64 %t92
  %t94 = getelementptr inbounds %Node, ptr %t93, i32 0, i32 10
  %t95 = load i32, ptr %t94
  %t96 = alloca i32
  store i32 %t95, ptr %t96
  %t97 = load i32, ptr %t2
  %t98 = load ptr, ptr %t0
  %t99 = getelementptr inbounds %Ast, ptr %t98, i32 0, i32 0
  %t100 = load ptr, ptr %t99
  %t101 = load i32, ptr %t1
  %t102 = sext i32 %t101 to i64
  %t103 = getelementptr inbounds %Node, ptr %t100, i64 %t102
  %t104 = getelementptr inbounds %Node, ptr %t103, i32 0, i32 9
  %t105 = load ptr, ptr %t104
  %t106 = load i32, ptr %t96
  %t107 = sext i32 %t106 to i64
  %t108 = getelementptr inbounds i32, ptr %t105, i64 %t107
  store i32 %t97, ptr %t108
  %t109 = load i32, ptr %t96
  %t110 = add i32 %t109, 1
  %t111 = load ptr, ptr %t0
  %t112 = getelementptr inbounds %Ast, ptr %t111, i32 0, i32 0
  %t113 = load ptr, ptr %t112
  %t114 = load i32, ptr %t1
  %t115 = sext i32 %t114 to i64
  %t116 = getelementptr inbounds %Node, ptr %t113, i64 %t115
  %t117 = getelementptr inbounds %Node, ptr %t116, i32 0, i32 10
  store i32 %t110, ptr %t117
  ret void
}

define ptr @nodeKindName(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = load i32, ptr @NK_PROGRAM
  %t3 = icmp eq i32 %t1, %t2
  br i1 %t3, label %L0, label %L2
L0:
  ret ptr @.str.104
L2:
  %t4 = load i32, ptr %t0
  %t5 = load i32, ptr @NK_BLOCK
  %t6 = icmp eq i32 %t4, %t5
  br i1 %t6, label %L3, label %L5
L3:
  ret ptr @.str.105
L5:
  %t7 = load i32, ptr %t0
  %t8 = load i32, ptr @NK_VARDECL
  %t9 = icmp eq i32 %t7, %t8
  br i1 %t9, label %L6, label %L8
L6:
  ret ptr @.str.106
L8:
  %t10 = load i32, ptr %t0
  %t11 = load i32, ptr @NK_ASSIGN
  %t12 = icmp eq i32 %t10, %t11
  br i1 %t12, label %L9, label %L11
L9:
  ret ptr @.str.107
L11:
  %t13 = load i32, ptr %t0
  %t14 = load i32, ptr @NK_IF
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L12, label %L14
L12:
  ret ptr @.str.108
L14:
  %t16 = load i32, ptr %t0
  %t17 = load i32, ptr @NK_WHILE
  %t18 = icmp eq i32 %t16, %t17
  br i1 %t18, label %L15, label %L17
L15:
  ret ptr @.str.109
L17:
  %t19 = load i32, ptr %t0
  %t20 = load i32, ptr @NK_BREAK
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L18, label %L20
L18:
  ret ptr @.str.110
L20:
  %t22 = load i32, ptr %t0
  %t23 = load i32, ptr @NK_CONTINUE
  %t24 = icmp eq i32 %t22, %t23
  br i1 %t24, label %L21, label %L23
L21:
  ret ptr @.str.111
L23:
  %t25 = load i32, ptr %t0
  %t26 = load i32, ptr @NK_FN
  %t27 = icmp eq i32 %t25, %t26
  br i1 %t27, label %L24, label %L26
L24:
  ret ptr @.str.112
L26:
  %t28 = load i32, ptr %t0
  %t29 = load i32, ptr @NK_EXTERN
  %t30 = icmp eq i32 %t28, %t29
  br i1 %t30, label %L27, label %L29
L27:
  ret ptr @.str.113
L29:
  %t31 = load i32, ptr %t0
  %t32 = load i32, ptr @NK_STRUCT
  %t33 = icmp eq i32 %t31, %t32
  br i1 %t33, label %L30, label %L32
L30:
  ret ptr @.str.114
L32:
  %t34 = load i32, ptr %t0
  %t35 = load i32, ptr @NK_FIELD
  %t36 = icmp eq i32 %t34, %t35
  br i1 %t36, label %L33, label %L35
L33:
  ret ptr @.str.115
L35:
  %t37 = load i32, ptr %t0
  %t38 = load i32, ptr @NK_CALL
  %t39 = icmp eq i32 %t37, %t38
  br i1 %t39, label %L36, label %L38
L36:
  ret ptr @.str.116
L38:
  %t40 = load i32, ptr %t0
  %t41 = load i32, ptr @NK_RETURN
  %t42 = icmp eq i32 %t40, %t41
  br i1 %t42, label %L39, label %L41
L39:
  ret ptr @.str.117
L41:
  %t43 = load i32, ptr %t0
  %t44 = load i32, ptr @NK_PRINT
  %t45 = icmp eq i32 %t43, %t44
  br i1 %t45, label %L42, label %L44
L42:
  ret ptr @.str.118
L44:
  %t46 = load i32, ptr %t0
  %t47 = load i32, ptr @NK_EXPRSTMT
  %t48 = icmp eq i32 %t46, %t47
  br i1 %t48, label %L45, label %L47
L45:
  ret ptr @.str.119
L47:
  %t49 = load i32, ptr %t0
  %t50 = load i32, ptr @NK_BINARY
  %t51 = icmp eq i32 %t49, %t50
  br i1 %t51, label %L48, label %L50
L48:
  ret ptr @.str.120
L50:
  %t52 = load i32, ptr %t0
  %t53 = load i32, ptr @NK_UNARY
  %t54 = icmp eq i32 %t52, %t53
  br i1 %t54, label %L51, label %L53
L51:
  ret ptr @.str.121
L53:
  %t55 = load i32, ptr %t0
  %t56 = load i32, ptr @NK_CAST
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L54, label %L56
L54:
  ret ptr @.str.122
L56:
  %t58 = load i32, ptr %t0
  %t59 = load i32, ptr @NK_FIELDACCESS
  %t60 = icmp eq i32 %t58, %t59
  br i1 %t60, label %L57, label %L59
L57:
  ret ptr @.str.123
L59:
  %t61 = load i32, ptr %t0
  %t62 = load i32, ptr @NK_INDEX
  %t63 = icmp eq i32 %t61, %t62
  br i1 %t63, label %L60, label %L62
L60:
  ret ptr @.str.124
L62:
  %t64 = load i32, ptr %t0
  %t65 = load i32, ptr @NK_STRUCTLIT
  %t66 = icmp eq i32 %t64, %t65
  br i1 %t66, label %L63, label %L65
L63:
  ret ptr @.str.125
L65:
  %t67 = load i32, ptr %t0
  %t68 = load i32, ptr @NK_FINIT
  %t69 = icmp eq i32 %t67, %t68
  br i1 %t69, label %L66, label %L68
L66:
  ret ptr @.str.126
L68:
  %t70 = load i32, ptr %t0
  %t71 = load i32, ptr @NK_SIZEOF
  %t72 = icmp eq i32 %t70, %t71
  br i1 %t72, label %L69, label %L71
L69:
  ret ptr @.str.127
L71:
  %t73 = load i32, ptr %t0
  %t74 = load i32, ptr @NK_NUMBER
  %t75 = icmp eq i32 %t73, %t74
  br i1 %t75, label %L72, label %L74
L72:
  ret ptr @.str.128
L74:
  %t76 = load i32, ptr %t0
  %t77 = load i32, ptr @NK_STRING
  %t78 = icmp eq i32 %t76, %t77
  br i1 %t78, label %L75, label %L77
L75:
  ret ptr @.str.129
L77:
  %t79 = load i32, ptr %t0
  %t80 = load i32, ptr @NK_CHAR
  %t81 = icmp eq i32 %t79, %t80
  br i1 %t81, label %L78, label %L80
L78:
  ret ptr @.str.130
L80:
  %t82 = load i32, ptr %t0
  %t83 = load i32, ptr @NK_BOOL
  %t84 = icmp eq i32 %t82, %t83
  br i1 %t84, label %L81, label %L83
L81:
  ret ptr @.str.131
L83:
  %t85 = load i32, ptr %t0
  %t86 = load i32, ptr @NK_IDENT
  %t87 = icmp eq i32 %t85, %t86
  br i1 %t87, label %L84, label %L86
L84:
  ret ptr @.str.132
L86:
  %t88 = load i32, ptr %t0
  %t89 = load i32, ptr @NK_TYPE
  %t90 = icmp eq i32 %t88, %t89
  br i1 %t90, label %L87, label %L89
L87:
  ret ptr @.str.133
L89:
  %t91 = load i32, ptr %t0
  %t92 = load i32, ptr @NK_PARAMS
  %t93 = icmp eq i32 %t91, %t92
  br i1 %t93, label %L90, label %L92
L90:
  ret ptr @.str.134
L92:
  %t94 = load i32, ptr %t0
  %t95 = load i32, ptr @NK_PARAM
  %t96 = icmp eq i32 %t94, %t95
  br i1 %t96, label %L93, label %L95
L93:
  ret ptr @.str.135
L95:
  %t97 = load i32, ptr %t0
  %t98 = load i32, ptr @NK_ARGS
  %t99 = icmp eq i32 %t97, %t98
  br i1 %t99, label %L96, label %L98
L96:
  ret ptr @.str.136
L98:
  %t100 = load i32, ptr %t0
  %t101 = load i32, ptr @NK_ERROR
  %t102 = icmp eq i32 %t100, %t101
  br i1 %t102, label %L99, label %L101
L99:
  ret ptr @.str.137
L101:
  %t103 = load i32, ptr %t0
  %t104 = load i32, ptr @NK_IMPORT
  %t105 = icmp eq i32 %t103, %t104
  br i1 %t105, label %L102, label %L104
L102:
  ret ptr @.str.138
L104:
  %t106 = load i32, ptr %t0
  %t107 = load i32, ptr @NK_IMPORTNAME
  %t108 = icmp eq i32 %t106, %t107
  br i1 %t108, label %L105, label %L107
L105:
  ret ptr @.str.139
L107:
  ret ptr @.str.140
}

define i1 @nodeCarriesText(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = alloca i1
  %t3 = load i32, ptr %t0
  %t4 = load i32, ptr @NK_VARDECL
  %t5 = icmp eq i32 %t3, %t4
  store i1 %t5, ptr %t2
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = load i32, ptr %t0
  %t7 = load i32, ptr @NK_FN
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t2
  br label %L1
L1:
  %t9 = load i1, ptr %t2
  store i1 %t9, ptr %t1
  br i1 %t9, label %L3, label %L2
L2:
  %t10 = load i32, ptr %t0
  %t11 = load i32, ptr @NK_EXTERN
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t1
  br label %L3
L3:
  %t13 = load i1, ptr %t1
  br i1 %t13, label %L4, label %L6
L4:
  ret i1 true
L6:
  %t14 = alloca i1
  %t15 = alloca i1
  %t16 = load i32, ptr %t0
  %t17 = load i32, ptr @NK_STRUCT
  %t18 = icmp eq i32 %t16, %t17
  store i1 %t18, ptr %t15
  br i1 %t18, label %L8, label %L7
L7:
  %t19 = load i32, ptr %t0
  %t20 = load i32, ptr @NK_FIELD
  %t21 = icmp eq i32 %t19, %t20
  store i1 %t21, ptr %t15
  br label %L8
L8:
  %t22 = load i1, ptr %t15
  store i1 %t22, ptr %t14
  br i1 %t22, label %L10, label %L9
L9:
  %t23 = load i32, ptr %t0
  %t24 = load i32, ptr @NK_CALL
  %t25 = icmp eq i32 %t23, %t24
  store i1 %t25, ptr %t14
  br label %L10
L10:
  %t26 = load i1, ptr %t14
  br i1 %t26, label %L11, label %L13
L11:
  ret i1 true
L13:
  %t27 = alloca i1
  %t28 = alloca i1
  %t29 = load i32, ptr %t0
  %t30 = load i32, ptr @NK_BINARY
  %t31 = icmp eq i32 %t29, %t30
  store i1 %t31, ptr %t28
  br i1 %t31, label %L15, label %L14
L14:
  %t32 = load i32, ptr %t0
  %t33 = load i32, ptr @NK_UNARY
  %t34 = icmp eq i32 %t32, %t33
  store i1 %t34, ptr %t28
  br label %L15
L15:
  %t35 = load i1, ptr %t28
  store i1 %t35, ptr %t27
  br i1 %t35, label %L17, label %L16
L16:
  %t36 = load i32, ptr %t0
  %t37 = load i32, ptr @NK_FIELDACCESS
  %t38 = icmp eq i32 %t36, %t37
  store i1 %t38, ptr %t27
  br label %L17
L17:
  %t39 = load i1, ptr %t27
  br i1 %t39, label %L18, label %L20
L18:
  ret i1 true
L20:
  %t40 = alloca i1
  %t41 = alloca i1
  %t42 = load i32, ptr %t0
  %t43 = load i32, ptr @NK_STRUCTLIT
  %t44 = icmp eq i32 %t42, %t43
  store i1 %t44, ptr %t41
  br i1 %t44, label %L22, label %L21
L21:
  %t45 = load i32, ptr %t0
  %t46 = load i32, ptr @NK_FINIT
  %t47 = icmp eq i32 %t45, %t46
  store i1 %t47, ptr %t41
  br label %L22
L22:
  %t48 = load i1, ptr %t41
  store i1 %t48, ptr %t40
  br i1 %t48, label %L24, label %L23
L23:
  %t49 = load i32, ptr %t0
  %t50 = load i32, ptr @NK_PARAM
  %t51 = icmp eq i32 %t49, %t50
  store i1 %t51, ptr %t40
  br label %L24
L24:
  %t52 = load i1, ptr %t40
  br i1 %t52, label %L25, label %L27
L25:
  ret i1 true
L27:
  %t53 = alloca i1
  %t54 = alloca i1
  %t55 = load i32, ptr %t0
  %t56 = load i32, ptr @NK_NUMBER
  %t57 = icmp eq i32 %t55, %t56
  store i1 %t57, ptr %t54
  br i1 %t57, label %L29, label %L28
L28:
  %t58 = load i32, ptr %t0
  %t59 = load i32, ptr @NK_STRING
  %t60 = icmp eq i32 %t58, %t59
  store i1 %t60, ptr %t54
  br label %L29
L29:
  %t61 = load i1, ptr %t54
  store i1 %t61, ptr %t53
  br i1 %t61, label %L31, label %L30
L30:
  %t62 = load i32, ptr %t0
  %t63 = load i32, ptr @NK_CHAR
  %t64 = icmp eq i32 %t62, %t63
  store i1 %t64, ptr %t53
  br label %L31
L31:
  %t65 = load i1, ptr %t53
  br i1 %t65, label %L32, label %L34
L32:
  ret i1 true
L34:
  %t66 = alloca i1
  %t67 = load i32, ptr %t0
  %t68 = load i32, ptr @NK_IMPORT
  %t69 = icmp eq i32 %t67, %t68
  store i1 %t69, ptr %t66
  br i1 %t69, label %L36, label %L35
L35:
  %t70 = load i32, ptr %t0
  %t71 = load i32, ptr @NK_IMPORTNAME
  %t72 = icmp eq i32 %t70, %t71
  store i1 %t72, ptr %t66
  br label %L36
L36:
  %t73 = load i1, ptr %t66
  br i1 %t73, label %L37, label %L39
L37:
  ret i1 true
L39:
  %t74 = alloca i1
  %t75 = alloca i1
  %t76 = load i32, ptr %t0
  %t77 = load i32, ptr @NK_BOOL
  %t78 = icmp eq i32 %t76, %t77
  store i1 %t78, ptr %t75
  br i1 %t78, label %L41, label %L40
L40:
  %t79 = load i32, ptr %t0
  %t80 = load i32, ptr @NK_IDENT
  %t81 = icmp eq i32 %t79, %t80
  store i1 %t81, ptr %t75
  br label %L41
L41:
  %t82 = load i1, ptr %t75
  store i1 %t82, ptr %t74
  br i1 %t82, label %L43, label %L42
L42:
  %t83 = load i32, ptr %t0
  %t84 = load i32, ptr @NK_TYPE
  %t85 = icmp eq i32 %t83, %t84
  store i1 %t85, ptr %t74
  br label %L43
L43:
  %t86 = load i1, ptr %t74
  ret i1 %t86
}

define ptr @parserNew(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = call ptr @malloc(i64 24)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = load ptr, ptr %t3
  %t6 = getelementptr inbounds %Parser, ptr %t5, i32 0, i32 0
  store ptr %t4, ptr %t6
  %t7 = load ptr, ptr %t1
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Parser, ptr %t8, i32 0, i32 1
  store ptr %t7, ptr %t9
  %t10 = load ptr, ptr %t3
  %t11 = getelementptr inbounds %Parser, ptr %t10, i32 0, i32 2
  store i32 0, ptr %t11
  %t12 = load ptr, ptr %t3
  %t13 = getelementptr inbounds %Parser, ptr %t12, i32 0, i32 3
  store i1 true, ptr %t13
  %t14 = load ptr, ptr %t3
  ret ptr %t14
}

define ptr @parserCurrent(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Parser, ptr %t1, i32 0, i32 0
  %t3 = load ptr, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 2
  %t6 = load i32, ptr %t5
  %t7 = call ptr @tokenAt(ptr %t3, i32 %t6)
  ret ptr %t7
}

define ptr @parserPeek(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Parser, ptr %t1, i32 0, i32 0
  %t3 = load ptr, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 2
  %t6 = load i32, ptr %t5
  %t7 = add i32 %t6, 1
  %t8 = call ptr @tokenAt(ptr %t3, i32 %t7)
  ret ptr %t8
}

define i32 @parserKind(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = getelementptr inbounds %Token, ptr %t2, i32 0, i32 0
  %t4 = load i32, ptr %t3
  ret i32 %t4
}

define void @parserAdvance(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Parser, ptr %t1, i32 0, i32 2
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = getelementptr inbounds %TokenList, ptr %t6, i32 0, i32 1
  %t8 = load i32, ptr %t7
  %t9 = sub i32 %t8, 1
  %t10 = icmp slt i32 %t3, %t9
  br i1 %t10, label %L0, label %L2
L0:
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Parser, ptr %t11, i32 0, i32 2
  %t13 = load i32, ptr %t12
  %t14 = add i32 %t13, 1
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Parser, ptr %t15, i32 0, i32 2
  store i32 %t14, ptr %t16
  br label %L2
L2:
  ret void
}

define void @parserFail(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call ptr @parserCurrent(ptr %t2)
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = call ptr @bufNew()
  %t6 = alloca ptr
  store ptr %t5, ptr %t6
  %t7 = load ptr, ptr %t6
  call void @bufAdd(ptr %t7, ptr @.str.141)
  %t8 = load ptr, ptr %t6
  %t9 = load ptr, ptr %t1
  call void @bufAdd(ptr %t8, ptr %t9)
  %t10 = load ptr, ptr %t6
  call void @bufAdd(ptr %t10, ptr @.str.142)
  %t11 = load ptr, ptr %t4
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 0
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @TK_END
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L0, label %L1
L0:
  %t16 = load ptr, ptr %t6
  call void @bufAdd(ptr %t16, ptr @.str.143)
  br label %L2
L1:
  %t17 = load ptr, ptr %t6
  %t18 = load ptr, ptr %t4
  %t19 = getelementptr inbounds %Token, ptr %t18, i32 0, i32 1
  %t20 = load ptr, ptr %t19
  %t21 = load ptr, ptr %t4
  %t22 = getelementptr inbounds %Token, ptr %t21, i32 0, i32 2
  %t23 = load i64, ptr %t22
  call void @bufAddBytes(ptr %t17, ptr %t20, i64 %t23)
  br label %L2
L2:
  %t24 = load ptr, ptr %t6
  call void @bufPush(ptr %t24, i8 39)
  %t25 = load ptr, ptr %t4
  %t26 = getelementptr inbounds %Token, ptr %t25, i32 0, i32 3
  %t27 = load i32, ptr %t26
  %t28 = load ptr, ptr %t4
  %t29 = getelementptr inbounds %Token, ptr %t28, i32 0, i32 4
  %t30 = load i32, ptr %t29
  %t31 = load ptr, ptr %t6
  %t32 = getelementptr inbounds %Buf, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  call void @report(i32 %t27, i32 %t30, ptr %t33)
  ret void
}

define i32 @parserErrorNode(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_ERROR
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  ret i32 %t14
}

define i1 @startsStatement(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = alloca i1
  %t3 = load i32, ptr %t0
  %t4 = load i32, ptr @TK_FN
  %t5 = icmp eq i32 %t3, %t4
  store i1 %t5, ptr %t2
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = load i32, ptr %t0
  %t7 = load i32, ptr @TK_EXTERN
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t2
  br label %L1
L1:
  %t9 = load i1, ptr %t2
  store i1 %t9, ptr %t1
  br i1 %t9, label %L3, label %L2
L2:
  %t10 = load i32, ptr %t0
  %t11 = load i32, ptr @TK_STRUCT
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t1
  br label %L3
L3:
  %t13 = load i1, ptr %t1
  br i1 %t13, label %L4, label %L6
L4:
  ret i1 true
L6:
  %t14 = alloca i1
  %t15 = load i32, ptr %t0
  %t16 = load i32, ptr @TK_IMPORT
  %t17 = icmp eq i32 %t15, %t16
  store i1 %t17, ptr %t14
  br i1 %t17, label %L8, label %L7
L7:
  %t18 = load i32, ptr %t0
  %t19 = load i32, ptr @TK_EXPORT
  %t20 = icmp eq i32 %t18, %t19
  store i1 %t20, ptr %t14
  br label %L8
L8:
  %t21 = load i1, ptr %t14
  br i1 %t21, label %L9, label %L11
L9:
  ret i1 true
L11:
  %t22 = alloca i1
  %t23 = alloca i1
  %t24 = load i32, ptr %t0
  %t25 = load i32, ptr @TK_LET
  %t26 = icmp eq i32 %t24, %t25
  store i1 %t26, ptr %t23
  br i1 %t26, label %L13, label %L12
L12:
  %t27 = load i32, ptr %t0
  %t28 = load i32, ptr @TK_IF
  %t29 = icmp eq i32 %t27, %t28
  store i1 %t29, ptr %t23
  br label %L13
L13:
  %t30 = load i1, ptr %t23
  store i1 %t30, ptr %t22
  br i1 %t30, label %L15, label %L14
L14:
  %t31 = load i32, ptr %t0
  %t32 = load i32, ptr @TK_WHILE
  %t33 = icmp eq i32 %t31, %t32
  store i1 %t33, ptr %t22
  br label %L15
L15:
  %t34 = load i1, ptr %t22
  br i1 %t34, label %L16, label %L18
L16:
  ret i1 true
L18:
  %t35 = alloca i1
  %t36 = load i32, ptr %t0
  %t37 = load i32, ptr @TK_RETURN
  %t38 = icmp eq i32 %t36, %t37
  store i1 %t38, ptr %t35
  br i1 %t38, label %L20, label %L19
L19:
  %t39 = load i32, ptr %t0
  %t40 = load i32, ptr @TK_PRINT
  %t41 = icmp eq i32 %t39, %t40
  store i1 %t41, ptr %t35
  br label %L20
L20:
  %t42 = load i1, ptr %t35
  br i1 %t42, label %L21, label %L23
L21:
  ret i1 true
L23:
  %t43 = alloca i1
  %t44 = load i32, ptr %t0
  %t45 = load i32, ptr @TK_BREAK
  %t46 = icmp eq i32 %t44, %t45
  store i1 %t46, ptr %t43
  br i1 %t46, label %L25, label %L24
L24:
  %t47 = load i32, ptr %t0
  %t48 = load i32, ptr @TK_CONTINUE
  %t49 = icmp eq i32 %t47, %t48
  store i1 %t49, ptr %t43
  br label %L25
L25:
  %t50 = load i1, ptr %t43
  ret i1 %t50
}

define void @parserSynchronize(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 0, ptr %t1
  br label %L0
L0:
  %t2 = load ptr, ptr %t0
  %t3 = call i32 @parserKind(ptr %t2)
  %t4 = load i32, ptr @TK_END
  %t5 = icmp ne i32 %t3, %t4
  br i1 %t5, label %L1, label %L2
L1:
  %t6 = load ptr, ptr %t0
  %t7 = call i32 @parserKind(ptr %t6)
  %t8 = alloca i32
  store i32 %t7, ptr %t8
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr @TK_LBRACE
  %t11 = icmp eq i32 %t9, %t10
  br i1 %t11, label %L3, label %L5
L3:
  %t12 = load i32, ptr %t1
  %t13 = add i32 %t12, 1
  store i32 %t13, ptr %t1
  %t14 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t14)
  br label %L0
L6:
  br label %L5
L5:
  %t15 = load i32, ptr %t8
  %t16 = load i32, ptr @TK_RBRACE
  %t17 = icmp eq i32 %t15, %t16
  br i1 %t17, label %L7, label %L9
L7:
  %t18 = load i32, ptr %t1
  %t19 = icmp eq i32 %t18, 0
  br i1 %t19, label %L10, label %L12
L10:
  ret void
L12:
  %t20 = load i32, ptr %t1
  %t21 = sub i32 %t20, 1
  store i32 %t21, ptr %t1
  %t22 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t22)
  %t23 = load i32, ptr %t1
  %t24 = icmp eq i32 %t23, 0
  br i1 %t24, label %L13, label %L15
L13:
  ret void
L15:
  br label %L0
L16:
  br label %L9
L9:
  %t25 = load i32, ptr %t1
  %t26 = icmp eq i32 %t25, 0
  br i1 %t26, label %L17, label %L19
L17:
  %t27 = load i32, ptr %t8
  %t28 = load i32, ptr @TK_SEMICOLON
  %t29 = icmp eq i32 %t27, %t28
  br i1 %t29, label %L20, label %L22
L20:
  %t30 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t30)
  ret void
L22:
  %t31 = load i32, ptr %t8
  %t32 = call i1 @startsStatement(i32 %t31)
  br i1 %t32, label %L23, label %L25
L23:
  ret void
L25:
  br label %L19
L19:
  %t33 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t33)
  br label %L0
L2:
  ret void
}

define ptr @parserExpect(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = call i32 @parserKind(ptr %t3)
  %t5 = load i32, ptr %t1
  %t6 = icmp ne i32 %t4, %t5
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t0
  %t8 = load ptr, ptr %t2
  call void @parserFail(ptr %t7, ptr %t8)
  %t9 = load ptr, ptr %t0
  %t10 = call ptr @parserCurrent(ptr %t9)
  ret ptr %t10
L2:
  %t11 = load ptr, ptr %t0
  %t12 = call ptr @parserCurrent(ptr %t11)
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t14)
  %t15 = load ptr, ptr %t13
  ret ptr %t15
}

define i32 @parseType(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = alloca i32
  store i32 0, ptr %t12
  br label %L0
L0:
  %t13 = load ptr, ptr %t0
  %t14 = call i32 @parserKind(ptr %t13)
  %t15 = load i32, ptr @TK_STAR
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L1, label %L2
L1:
  %t17 = load i32, ptr %t12
  %t18 = add i32 %t17, 1
  store i32 %t18, ptr %t12
  %t19 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t19)
  br label %L0
L2:
  %t20 = alloca i1
  %t21 = load ptr, ptr %t0
  %t22 = call i32 @parserKind(ptr %t21)
  %t23 = load i32, ptr @TK_TYPE
  %t24 = icmp ne i32 %t22, %t23
  store i1 %t24, ptr %t20
  br i1 %t24, label %L3, label %L4
L3:
  %t25 = load ptr, ptr %t0
  %t26 = call i32 @parserKind(ptr %t25)
  %t27 = load i32, ptr @TK_IDENT
  %t28 = icmp ne i32 %t26, %t27
  store i1 %t28, ptr %t20
  br label %L4
L4:
  %t29 = load i1, ptr %t20
  br i1 %t29, label %L5, label %L7
L5:
  %t30 = load ptr, ptr %t0
  call void @parserFail(ptr %t30, ptr @.str.144)
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Parser, ptr %t31, i32 0, i32 1
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr @NK_TYPE
  %t35 = load i32, ptr %t7
  %t36 = load i32, ptr %t11
  %t37 = call i32 @astAdd(ptr %t33, i32 %t34, i32 %t35, i32 %t36)
  ret i32 %t37
L7:
  %t38 = load ptr, ptr %t0
  %t39 = call ptr @parserCurrent(ptr %t38)
  %t40 = alloca ptr
  store ptr %t39, ptr %t40
  %t41 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t41)
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Parser, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr @NK_TYPE
  %t46 = load i32, ptr %t7
  %t47 = load i32, ptr %t11
  %t48 = call i32 @astAdd(ptr %t44, i32 %t45, i32 %t46, i32 %t47)
  %t49 = alloca i32
  store i32 %t48, ptr %t49
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr inbounds %Parser, ptr %t50, i32 0, i32 1
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t49
  %t54 = load ptr, ptr %t40
  call void @astSetText(ptr %t52, i32 %t53, ptr %t54)
  %t55 = load i32, ptr %t12
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %Parser, ptr %t56, i32 0, i32 1
  %t58 = load ptr, ptr %t57
  %t59 = getelementptr inbounds %Ast, ptr %t58, i32 0, i32 0
  %t60 = load ptr, ptr %t59
  %t61 = load i32, ptr %t49
  %t62 = sext i32 %t61 to i64
  %t63 = getelementptr inbounds %Node, ptr %t60, i64 %t62
  %t64 = getelementptr inbounds %Node, ptr %t63, i32 0, i32 8
  store i32 %t55, ptr %t64
  %t65 = load i32, ptr %t49
  ret i32 %t65
}

define i32 @parseExpr(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseLogicOr(ptr %t1)
  ret i32 %t2
}

define i32 @parseBinaryNode(ptr %p0, i32 %p1, i32 %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_BINARY
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Parser, ptr %t16, i32 0, i32 1
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t15
  %t20 = load ptr, ptr %t3
  call void @astSetText(ptr %t18, i32 %t19, ptr %t20)
  %t21 = load i32, ptr %t1
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Parser, ptr %t22, i32 0, i32 1
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %Ast, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t15
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Node, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Node, ptr %t29, i32 0, i32 5
  store i32 %t21, ptr %t30
  %t31 = load i32, ptr %t2
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Parser, ptr %t32, i32 0, i32 1
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr inbounds %Ast, ptr %t34, i32 0, i32 0
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t15
  %t38 = sext i32 %t37 to i64
  %t39 = getelementptr inbounds %Node, ptr %t36, i64 %t38
  %t40 = getelementptr inbounds %Node, ptr %t39, i32 0, i32 6
  store i32 %t31, ptr %t40
  %t41 = load i32, ptr %t15
  ret i32 %t41
}

define i32 @parseLogicOr(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseLogicAnd(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_OROR
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseLogicAnd(ptr %t12)
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t3
  %t17 = load i32, ptr %t14
  %t18 = load ptr, ptr %t10
  %t19 = call i32 @parseBinaryNode(ptr %t15, i32 %t16, i32 %t17, ptr %t18)
  store i32 %t19, ptr %t3
  br label %L0
L2:
  %t20 = load i32, ptr %t3
  ret i32 %t20
}

define i32 @parseLogicAnd(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseBitOr(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_ANDAND
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseBitOr(ptr %t12)
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t3
  %t17 = load i32, ptr %t14
  %t18 = load ptr, ptr %t10
  %t19 = call i32 @parseBinaryNode(ptr %t15, i32 %t16, i32 %t17, ptr %t18)
  store i32 %t19, ptr %t3
  br label %L0
L2:
  %t20 = load i32, ptr %t3
  ret i32 %t20
}

define i32 @parseBitOr(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseBitXor(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_PIPE
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseBitXor(ptr %t12)
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t3
  %t17 = load i32, ptr %t14
  %t18 = load ptr, ptr %t10
  %t19 = call i32 @parseBinaryNode(ptr %t15, i32 %t16, i32 %t17, ptr %t18)
  store i32 %t19, ptr %t3
  br label %L0
L2:
  %t20 = load i32, ptr %t3
  ret i32 %t20
}

define i32 @parseBitXor(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseBitAnd(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_CARET
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseBitAnd(ptr %t12)
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t3
  %t17 = load i32, ptr %t14
  %t18 = load ptr, ptr %t10
  %t19 = call i32 @parseBinaryNode(ptr %t15, i32 %t16, i32 %t17, ptr %t18)
  store i32 %t19, ptr %t3
  br label %L0
L2:
  %t20 = load i32, ptr %t3
  ret i32 %t20
}

define i32 @parseBitAnd(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseEquality(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_AMP
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseEquality(ptr %t12)
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t3
  %t17 = load i32, ptr %t14
  %t18 = load ptr, ptr %t10
  %t19 = call i32 @parseBinaryNode(ptr %t15, i32 %t16, i32 %t17, ptr %t18)
  store i32 %t19, ptr %t3
  br label %L0
L2:
  %t20 = load i32, ptr %t3
  ret i32 %t20
}

define i32 @parseEquality(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseComparison(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = alloca i1
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @parserKind(ptr %t5)
  %t7 = load i32, ptr @TK_EQ
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t4
  br i1 %t8, label %L4, label %L3
L3:
  %t9 = load ptr, ptr %t0
  %t10 = call i32 @parserKind(ptr %t9)
  %t11 = load i32, ptr @TK_NE
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t4
  br label %L4
L4:
  %t13 = load i1, ptr %t4
  br i1 %t13, label %L1, label %L2
L1:
  %t14 = load ptr, ptr %t0
  %t15 = call ptr @parserCurrent(ptr %t14)
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t17)
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parseComparison(ptr %t18)
  %t20 = alloca i32
  store i32 %t19, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr %t3
  %t23 = load i32, ptr %t20
  %t24 = load ptr, ptr %t16
  %t25 = call i32 @parseBinaryNode(ptr %t21, i32 %t22, i32 %t23, ptr %t24)
  store i32 %t25, ptr %t3
  br label %L0
L2:
  %t26 = load i32, ptr %t3
  ret i32 %t26
}

define i32 @parseComparison(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseShift(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = alloca i1
  %t5 = alloca i1
  %t6 = alloca i1
  %t7 = load ptr, ptr %t0
  %t8 = call i32 @parserKind(ptr %t7)
  %t9 = load i32, ptr @TK_GT
  %t10 = icmp eq i32 %t8, %t9
  store i1 %t10, ptr %t6
  br i1 %t10, label %L4, label %L3
L3:
  %t11 = load ptr, ptr %t0
  %t12 = call i32 @parserKind(ptr %t11)
  %t13 = load i32, ptr @TK_GE
  %t14 = icmp eq i32 %t12, %t13
  store i1 %t14, ptr %t6
  br label %L4
L4:
  %t15 = load i1, ptr %t6
  store i1 %t15, ptr %t5
  br i1 %t15, label %L6, label %L5
L5:
  %t16 = load ptr, ptr %t0
  %t17 = call i32 @parserKind(ptr %t16)
  %t18 = load i32, ptr @TK_LT
  %t19 = icmp eq i32 %t17, %t18
  store i1 %t19, ptr %t5
  br label %L6
L6:
  %t20 = load i1, ptr %t5
  store i1 %t20, ptr %t4
  br i1 %t20, label %L8, label %L7
L7:
  %t21 = load ptr, ptr %t0
  %t22 = call i32 @parserKind(ptr %t21)
  %t23 = load i32, ptr @TK_LE
  %t24 = icmp eq i32 %t22, %t23
  store i1 %t24, ptr %t4
  br label %L8
L8:
  %t25 = load i1, ptr %t4
  br i1 %t25, label %L1, label %L2
L1:
  %t26 = load ptr, ptr %t0
  %t27 = call ptr @parserCurrent(ptr %t26)
  %t28 = alloca ptr
  store ptr %t27, ptr %t28
  %t29 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t29)
  %t30 = load ptr, ptr %t0
  %t31 = call i32 @parseShift(ptr %t30)
  %t32 = alloca i32
  store i32 %t31, ptr %t32
  %t33 = load ptr, ptr %t0
  %t34 = load i32, ptr %t3
  %t35 = load i32, ptr %t32
  %t36 = load ptr, ptr %t28
  %t37 = call i32 @parseBinaryNode(ptr %t33, i32 %t34, i32 %t35, ptr %t36)
  store i32 %t37, ptr %t3
  br label %L0
L2:
  %t38 = load i32, ptr %t3
  ret i32 %t38
}

define i32 @parseShift(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseTerm(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = alloca i1
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @parserKind(ptr %t5)
  %t7 = load i32, ptr @TK_SHL
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t4
  br i1 %t8, label %L4, label %L3
L3:
  %t9 = load ptr, ptr %t0
  %t10 = call i32 @parserKind(ptr %t9)
  %t11 = load i32, ptr @TK_SHR
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t4
  br label %L4
L4:
  %t13 = load i1, ptr %t4
  br i1 %t13, label %L1, label %L2
L1:
  %t14 = load ptr, ptr %t0
  %t15 = call ptr @parserCurrent(ptr %t14)
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t17)
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parseTerm(ptr %t18)
  %t20 = alloca i32
  store i32 %t19, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr %t3
  %t23 = load i32, ptr %t20
  %t24 = load ptr, ptr %t16
  %t25 = call i32 @parseBinaryNode(ptr %t21, i32 %t22, i32 %t23, ptr %t24)
  store i32 %t25, ptr %t3
  br label %L0
L2:
  %t26 = load i32, ptr %t3
  ret i32 %t26
}

define i32 @parseTerm(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseFactor(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = alloca i1
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @parserKind(ptr %t5)
  %t7 = load i32, ptr @TK_PLUS
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t4
  br i1 %t8, label %L4, label %L3
L3:
  %t9 = load ptr, ptr %t0
  %t10 = call i32 @parserKind(ptr %t9)
  %t11 = load i32, ptr @TK_MINUS
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t4
  br label %L4
L4:
  %t13 = load i1, ptr %t4
  br i1 %t13, label %L1, label %L2
L1:
  %t14 = load ptr, ptr %t0
  %t15 = call ptr @parserCurrent(ptr %t14)
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t17)
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parseFactor(ptr %t18)
  %t20 = alloca i32
  store i32 %t19, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr %t3
  %t23 = load i32, ptr %t20
  %t24 = load ptr, ptr %t16
  %t25 = call i32 @parseBinaryNode(ptr %t21, i32 %t22, i32 %t23, ptr %t24)
  store i32 %t25, ptr %t3
  br label %L0
L2:
  %t26 = load i32, ptr %t3
  ret i32 %t26
}

define i32 @parseFactor(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseCast(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = alloca i1
  %t5 = alloca i1
  %t6 = load ptr, ptr %t0
  %t7 = call i32 @parserKind(ptr %t6)
  %t8 = load i32, ptr @TK_STAR
  %t9 = icmp eq i32 %t7, %t8
  store i1 %t9, ptr %t5
  br i1 %t9, label %L4, label %L3
L3:
  %t10 = load ptr, ptr %t0
  %t11 = call i32 @parserKind(ptr %t10)
  %t12 = load i32, ptr @TK_SLASH
  %t13 = icmp eq i32 %t11, %t12
  store i1 %t13, ptr %t5
  br label %L4
L4:
  %t14 = load i1, ptr %t5
  store i1 %t14, ptr %t4
  br i1 %t14, label %L6, label %L5
L5:
  %t15 = load ptr, ptr %t0
  %t16 = call i32 @parserKind(ptr %t15)
  %t17 = load i32, ptr @TK_PERCENT
  %t18 = icmp eq i32 %t16, %t17
  store i1 %t18, ptr %t4
  br label %L6
L6:
  %t19 = load i1, ptr %t4
  br i1 %t19, label %L1, label %L2
L1:
  %t20 = load ptr, ptr %t0
  %t21 = call ptr @parserCurrent(ptr %t20)
  %t22 = alloca ptr
  store ptr %t21, ptr %t22
  %t23 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t23)
  %t24 = load ptr, ptr %t0
  %t25 = call i32 @parseCast(ptr %t24)
  %t26 = alloca i32
  store i32 %t25, ptr %t26
  %t27 = load ptr, ptr %t0
  %t28 = load i32, ptr %t3
  %t29 = load i32, ptr %t26
  %t30 = load ptr, ptr %t22
  %t31 = call i32 @parseBinaryNode(ptr %t27, i32 %t28, i32 %t29, ptr %t30)
  store i32 %t31, ptr %t3
  br label %L0
L2:
  %t32 = load i32, ptr %t3
  ret i32 %t32
}

define i32 @parseCast(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parseUnary(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_AS
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t10
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 3
  %t13 = load i32, ptr %t12
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t10
  %t16 = getelementptr inbounds %Token, ptr %t15, i32 0, i32 4
  %t17 = load i32, ptr %t16
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t19)
  %t20 = load ptr, ptr %t0
  %t21 = call i32 @parseType(ptr %t20)
  %t22 = alloca i32
  store i32 %t21, ptr %t22
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Parser, ptr %t23, i32 0, i32 1
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr @NK_CAST
  %t27 = load i32, ptr %t14
  %t28 = load i32, ptr %t18
  %t29 = call i32 @astAdd(ptr %t25, i32 %t26, i32 %t27, i32 %t28)
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = load i32, ptr %t3
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Parser, ptr %t32, i32 0, i32 1
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr inbounds %Ast, ptr %t34, i32 0, i32 0
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t30
  %t38 = sext i32 %t37 to i64
  %t39 = getelementptr inbounds %Node, ptr %t36, i64 %t38
  %t40 = getelementptr inbounds %Node, ptr %t39, i32 0, i32 5
  store i32 %t31, ptr %t40
  %t41 = load i32, ptr %t22
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Parser, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = getelementptr inbounds %Ast, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = load i32, ptr %t30
  %t48 = sext i32 %t47 to i64
  %t49 = getelementptr inbounds %Node, ptr %t46, i64 %t48
  %t50 = getelementptr inbounds %Node, ptr %t49, i32 0, i32 6
  store i32 %t41, ptr %t50
  %t51 = load i32, ptr %t30
  store i32 %t51, ptr %t3
  br label %L0
L2:
  %t52 = load i32, ptr %t3
  ret i32 %t52
}

define i32 @parseUnary(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parserKind(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  %t4 = alloca i1
  %t5 = alloca i1
  %t6 = alloca i1
  %t7 = alloca i1
  %t8 = load i32, ptr %t3
  %t9 = load i32, ptr @TK_MINUS
  %t10 = icmp eq i32 %t8, %t9
  store i1 %t10, ptr %t7
  br i1 %t10, label %L1, label %L0
L0:
  %t11 = load i32, ptr %t3
  %t12 = load i32, ptr @TK_PLUS
  %t13 = icmp eq i32 %t11, %t12
  store i1 %t13, ptr %t7
  br label %L1
L1:
  %t14 = load i1, ptr %t7
  store i1 %t14, ptr %t6
  br i1 %t14, label %L3, label %L2
L2:
  %t15 = load i32, ptr %t3
  %t16 = load i32, ptr @TK_NOT
  %t17 = icmp eq i32 %t15, %t16
  store i1 %t17, ptr %t6
  br label %L3
L3:
  %t18 = load i1, ptr %t6
  store i1 %t18, ptr %t5
  br i1 %t18, label %L5, label %L4
L4:
  %t19 = load i32, ptr %t3
  %t20 = load i32, ptr @TK_STAR
  %t21 = icmp eq i32 %t19, %t20
  store i1 %t21, ptr %t5
  br label %L5
L5:
  %t22 = load i1, ptr %t5
  store i1 %t22, ptr %t4
  br i1 %t22, label %L7, label %L6
L6:
  %t23 = load i32, ptr %t3
  %t24 = load i32, ptr @TK_AMP
  %t25 = icmp eq i32 %t23, %t24
  store i1 %t25, ptr %t4
  br label %L7
L7:
  %t26 = load i1, ptr %t4
  br i1 %t26, label %L8, label %L10
L8:
  %t27 = load ptr, ptr %t0
  %t28 = call ptr @parserCurrent(ptr %t27)
  %t29 = alloca ptr
  store ptr %t28, ptr %t29
  %t30 = load ptr, ptr %t29
  %t31 = getelementptr inbounds %Token, ptr %t30, i32 0, i32 3
  %t32 = load i32, ptr %t31
  %t33 = alloca i32
  store i32 %t32, ptr %t33
  %t34 = load ptr, ptr %t29
  %t35 = getelementptr inbounds %Token, ptr %t34, i32 0, i32 4
  %t36 = load i32, ptr %t35
  %t37 = alloca i32
  store i32 %t36, ptr %t37
  %t38 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t38)
  %t39 = load ptr, ptr %t0
  %t40 = call i32 @parseUnary(ptr %t39)
  %t41 = alloca i32
  store i32 %t40, ptr %t41
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Parser, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr @NK_UNARY
  %t46 = load i32, ptr %t33
  %t47 = load i32, ptr %t37
  %t48 = call i32 @astAdd(ptr %t44, i32 %t45, i32 %t46, i32 %t47)
  %t49 = alloca i32
  store i32 %t48, ptr %t49
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr inbounds %Parser, ptr %t50, i32 0, i32 1
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t49
  %t54 = load ptr, ptr %t29
  call void @astSetText(ptr %t52, i32 %t53, ptr %t54)
  %t55 = load i32, ptr %t41
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %Parser, ptr %t56, i32 0, i32 1
  %t58 = load ptr, ptr %t57
  %t59 = getelementptr inbounds %Ast, ptr %t58, i32 0, i32 0
  %t60 = load ptr, ptr %t59
  %t61 = load i32, ptr %t49
  %t62 = sext i32 %t61 to i64
  %t63 = getelementptr inbounds %Node, ptr %t60, i64 %t62
  %t64 = getelementptr inbounds %Node, ptr %t63, i32 0, i32 5
  store i32 %t55, ptr %t64
  %t65 = load i32, ptr %t49
  ret i32 %t65
L10:
  %t66 = load ptr, ptr %t0
  %t67 = call i32 @parsePostfix(ptr %t66)
  ret i32 %t67
}

define i32 @parsePostfix(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parsePrimary(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  br label %L0
L0:
  br i1 true, label %L1, label %L2
L1:
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = load i32, ptr @TK_DOT
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L3, label %L5
L3:
  %t8 = load ptr, ptr %t0
  %t9 = call ptr @parserCurrent(ptr %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load ptr, ptr %t10
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 3
  %t13 = load i32, ptr %t12
  %t14 = alloca i32
  store i32 %t13, ptr %t14
  %t15 = load ptr, ptr %t10
  %t16 = getelementptr inbounds %Token, ptr %t15, i32 0, i32 4
  %t17 = load i32, ptr %t16
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t19)
  %t20 = load ptr, ptr %t0
  %t21 = load i32, ptr @TK_IDENT
  %t22 = call ptr @parserExpect(ptr %t20, i32 %t21, ptr @.str.145)
  %t23 = alloca ptr
  store ptr %t22, ptr %t23
  %t24 = load i1, ptr @FAILED
  br i1 %t24, label %L6, label %L8
L6:
  %t25 = load i32, ptr %t3
  ret i32 %t25
L8:
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Parser, ptr %t26, i32 0, i32 1
  %t28 = load ptr, ptr %t27
  %t29 = load i32, ptr @NK_FIELDACCESS
  %t30 = load i32, ptr %t14
  %t31 = load i32, ptr %t18
  %t32 = call i32 @astAdd(ptr %t28, i32 %t29, i32 %t30, i32 %t31)
  %t33 = alloca i32
  store i32 %t32, ptr %t33
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Parser, ptr %t34, i32 0, i32 1
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t33
  %t38 = load ptr, ptr %t23
  call void @astSetText(ptr %t36, i32 %t37, ptr %t38)
  %t39 = load i32, ptr %t3
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr inbounds %Parser, ptr %t40, i32 0, i32 1
  %t42 = load ptr, ptr %t41
  %t43 = getelementptr inbounds %Ast, ptr %t42, i32 0, i32 0
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr %t33
  %t46 = sext i32 %t45 to i64
  %t47 = getelementptr inbounds %Node, ptr %t44, i64 %t46
  %t48 = getelementptr inbounds %Node, ptr %t47, i32 0, i32 5
  store i32 %t39, ptr %t48
  %t49 = load i32, ptr %t33
  store i32 %t49, ptr %t3
  br label %L0
L9:
  br label %L5
L5:
  %t50 = load ptr, ptr %t0
  %t51 = call i32 @parserKind(ptr %t50)
  %t52 = load i32, ptr @TK_LBRACKET
  %t53 = icmp eq i32 %t51, %t52
  br i1 %t53, label %L10, label %L12
L10:
  %t54 = load ptr, ptr %t0
  %t55 = call ptr @parserCurrent(ptr %t54)
  %t56 = alloca ptr
  store ptr %t55, ptr %t56
  %t57 = load ptr, ptr %t56
  %t58 = getelementptr inbounds %Token, ptr %t57, i32 0, i32 3
  %t59 = load i32, ptr %t58
  %t60 = alloca i32
  store i32 %t59, ptr %t60
  %t61 = load ptr, ptr %t56
  %t62 = getelementptr inbounds %Token, ptr %t61, i32 0, i32 4
  %t63 = load i32, ptr %t62
  %t64 = alloca i32
  store i32 %t63, ptr %t64
  %t65 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t65)
  %t66 = load ptr, ptr %t0
  %t67 = call i32 @parseExpr(ptr %t66)
  %t68 = alloca i32
  store i32 %t67, ptr %t68
  %t69 = load ptr, ptr %t0
  %t70 = load i32, ptr @TK_RBRACKET
  %t71 = call ptr @parserExpect(ptr %t69, i32 %t70, ptr @.str.146)
  %t72 = load i1, ptr @FAILED
  br i1 %t72, label %L13, label %L15
L13:
  %t73 = load i32, ptr %t3
  ret i32 %t73
L15:
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %Parser, ptr %t74, i32 0, i32 1
  %t76 = load ptr, ptr %t75
  %t77 = load i32, ptr @NK_INDEX
  %t78 = load i32, ptr %t60
  %t79 = load i32, ptr %t64
  %t80 = call i32 @astAdd(ptr %t76, i32 %t77, i32 %t78, i32 %t79)
  %t81 = alloca i32
  store i32 %t80, ptr %t81
  %t82 = load i32, ptr %t3
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr inbounds %Parser, ptr %t83, i32 0, i32 1
  %t85 = load ptr, ptr %t84
  %t86 = getelementptr inbounds %Ast, ptr %t85, i32 0, i32 0
  %t87 = load ptr, ptr %t86
  %t88 = load i32, ptr %t81
  %t89 = sext i32 %t88 to i64
  %t90 = getelementptr inbounds %Node, ptr %t87, i64 %t89
  %t91 = getelementptr inbounds %Node, ptr %t90, i32 0, i32 5
  store i32 %t82, ptr %t91
  %t92 = load i32, ptr %t68
  %t93 = load ptr, ptr %t0
  %t94 = getelementptr inbounds %Parser, ptr %t93, i32 0, i32 1
  %t95 = load ptr, ptr %t94
  %t96 = getelementptr inbounds %Ast, ptr %t95, i32 0, i32 0
  %t97 = load ptr, ptr %t96
  %t98 = load i32, ptr %t81
  %t99 = sext i32 %t98 to i64
  %t100 = getelementptr inbounds %Node, ptr %t97, i64 %t99
  %t101 = getelementptr inbounds %Node, ptr %t100, i32 0, i32 6
  store i32 %t92, ptr %t101
  %t102 = load i32, ptr %t81
  store i32 %t102, ptr %t3
  br label %L0
L16:
  br label %L12
L12:
  %t103 = load i32, ptr %t3
  ret i32 %t103
L2:
  %t104 = load i32, ptr %t3
  ret i32 %t104
}

define i32 @parseLiteral(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call ptr @parserCurrent(ptr %t2)
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Parser, ptr %t5, i32 0, i32 1
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = load ptr, ptr %t4
  %t10 = getelementptr inbounds %Token, ptr %t9, i32 0, i32 3
  %t11 = load i32, ptr %t10
  %t12 = load ptr, ptr %t4
  %t13 = getelementptr inbounds %Token, ptr %t12, i32 0, i32 4
  %t14 = load i32, ptr %t13
  %t15 = call i32 @astAdd(ptr %t7, i32 %t8, i32 %t11, i32 %t14)
  %t16 = alloca i32
  store i32 %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Parser, ptr %t17, i32 0, i32 1
  %t19 = load ptr, ptr %t18
  %t20 = load i32, ptr %t16
  %t21 = load ptr, ptr %t4
  call void @astSetText(ptr %t19, i32 %t20, ptr %t21)
  %t22 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t22)
  %t23 = load i32, ptr %t16
  ret i32 %t23
}

define i32 @parsePrimary(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i32 @parserKind(ptr %t1)
  %t3 = alloca i32
  store i32 %t2, ptr %t3
  %t4 = load i32, ptr %t3
  %t5 = load i32, ptr @TK_LPAREN
  %t6 = icmp eq i32 %t4, %t5
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t7)
  %t8 = load ptr, ptr %t0
  %t9 = call i32 @parseExpr(ptr %t8)
  %t10 = alloca i32
  store i32 %t9, ptr %t10
  %t11 = load ptr, ptr %t0
  %t12 = load i32, ptr @TK_RPAREN
  %t13 = call ptr @parserExpect(ptr %t11, i32 %t12, ptr @.str.147)
  %t14 = load i32, ptr %t10
  ret i32 %t14
L2:
  %t15 = load i32, ptr %t3
  %t16 = load i32, ptr @TK_NUMBER
  %t17 = icmp eq i32 %t15, %t16
  br i1 %t17, label %L3, label %L5
L3:
  %t18 = load ptr, ptr %t0
  %t19 = load i32, ptr @NK_NUMBER
  %t20 = call i32 @parseLiteral(ptr %t18, i32 %t19)
  ret i32 %t20
L5:
  %t21 = load i32, ptr %t3
  %t22 = load i32, ptr @TK_BOOL
  %t23 = icmp eq i32 %t21, %t22
  br i1 %t23, label %L6, label %L8
L6:
  %t24 = load ptr, ptr %t0
  %t25 = load i32, ptr @NK_BOOL
  %t26 = call i32 @parseLiteral(ptr %t24, i32 %t25)
  ret i32 %t26
L8:
  %t27 = load i32, ptr %t3
  %t28 = load i32, ptr @TK_STRING
  %t29 = icmp eq i32 %t27, %t28
  br i1 %t29, label %L9, label %L11
L9:
  %t30 = load ptr, ptr %t0
  %t31 = load i32, ptr @NK_STRING
  %t32 = call i32 @parseLiteral(ptr %t30, i32 %t31)
  ret i32 %t32
L11:
  %t33 = load i32, ptr %t3
  %t34 = load i32, ptr @TK_CHAR
  %t35 = icmp eq i32 %t33, %t34
  br i1 %t35, label %L12, label %L14
L12:
  %t36 = load ptr, ptr %t0
  %t37 = load i32, ptr @NK_CHAR
  %t38 = call i32 @parseLiteral(ptr %t36, i32 %t37)
  ret i32 %t38
L14:
  %t39 = load i32, ptr %t3
  %t40 = load i32, ptr @TK_SIZEOF
  %t41 = icmp eq i32 %t39, %t40
  br i1 %t41, label %L15, label %L17
L15:
  %t42 = load ptr, ptr %t0
  %t43 = call i32 @parseSizeOf(ptr %t42)
  ret i32 %t43
L17:
  %t44 = load i32, ptr %t3
  %t45 = load i32, ptr @TK_IDENT
  %t46 = icmp eq i32 %t44, %t45
  br i1 %t46, label %L18, label %L20
L18:
  %t47 = load ptr, ptr %t0
  %t48 = call ptr @parserPeek(ptr %t47)
  %t49 = getelementptr inbounds %Token, ptr %t48, i32 0, i32 0
  %t50 = load i32, ptr %t49
  %t51 = load i32, ptr @TK_LPAREN
  %t52 = icmp eq i32 %t50, %t51
  br i1 %t52, label %L21, label %L23
L21:
  %t53 = load ptr, ptr %t0
  %t54 = call i32 @parseFuncCall(ptr %t53)
  ret i32 %t54
L23:
  %t55 = load ptr, ptr %t0
  %t56 = call ptr @parserPeek(ptr %t55)
  %t57 = getelementptr inbounds %Token, ptr %t56, i32 0, i32 0
  %t58 = load i32, ptr %t57
  %t59 = load i32, ptr @TK_LBRACE
  %t60 = icmp eq i32 %t58, %t59
  br i1 %t60, label %L24, label %L26
L24:
  %t61 = load ptr, ptr %t0
  %t62 = call i32 @parseStructLiteral(ptr %t61)
  ret i32 %t62
L26:
  %t63 = load ptr, ptr %t0
  %t64 = load i32, ptr @NK_IDENT
  %t65 = call i32 @parseLiteral(ptr %t63, i32 %t64)
  ret i32 %t65
L20:
  %t66 = load ptr, ptr %t0
  call void @parserFail(ptr %t66, ptr @.str.148)
  %t67 = load ptr, ptr %t0
  %t68 = call i32 @parserErrorNode(ptr %t67)
  ret i32 %t68
}

define i32 @parseSizeOf(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = load i32, ptr @TK_SIZEOF
  %t14 = call ptr @parserExpect(ptr %t12, i32 %t13, ptr @.str.149)
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr @TK_LPAREN
  %t17 = call ptr @parserExpect(ptr %t15, i32 %t16, ptr @.str.150)
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parseType(ptr %t18)
  %t20 = alloca i32
  store i32 %t19, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr @TK_RPAREN
  %t23 = call ptr @parserExpect(ptr %t21, i32 %t22, ptr @.str.151)
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Parser, ptr %t24, i32 0, i32 1
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr @NK_SIZEOF
  %t28 = load i32, ptr %t7
  %t29 = load i32, ptr %t11
  %t30 = call i32 @astAdd(ptr %t26, i32 %t27, i32 %t28, i32 %t29)
  %t31 = alloca i32
  store i32 %t30, ptr %t31
  %t32 = load i32, ptr %t20
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Parser, ptr %t33, i32 0, i32 1
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t31
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 5
  store i32 %t32, ptr %t41
  %t42 = load i32, ptr %t31
  ret i32 %t42
}

define i32 @parseFuncCall(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t12)
  %t13 = load ptr, ptr %t0
  %t14 = load i32, ptr @TK_LPAREN
  %t15 = call ptr @parserExpect(ptr %t13, i32 %t14, ptr @.str.152)
  %t16 = load ptr, ptr %t0
  %t17 = call i32 @parseArgList(ptr %t16)
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = load i32, ptr @TK_RPAREN
  %t21 = call ptr @parserExpect(ptr %t19, i32 %t20, ptr @.str.153)
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Parser, ptr %t22, i32 0, i32 1
  %t24 = load ptr, ptr %t23
  %t25 = load i32, ptr @NK_CALL
  %t26 = load i32, ptr %t7
  %t27 = load i32, ptr %t11
  %t28 = call i32 @astAdd(ptr %t24, i32 %t25, i32 %t26, i32 %t27)
  %t29 = alloca i32
  store i32 %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Parser, ptr %t30, i32 0, i32 1
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t29
  %t34 = load ptr, ptr %t3
  call void @astSetText(ptr %t32, i32 %t33, ptr %t34)
  %t35 = load i32, ptr %t18
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %Parser, ptr %t36, i32 0, i32 1
  %t38 = load ptr, ptr %t37
  %t39 = getelementptr inbounds %Ast, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t29
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %Node, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %Node, ptr %t43, i32 0, i32 5
  store i32 %t35, ptr %t44
  %t45 = load i32, ptr %t29
  ret i32 %t45
}

define i32 @parseArgList(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_ARGS
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = call i32 @parserKind(ptr %t16)
  %t18 = load i32, ptr @TK_RPAREN
  %t19 = icmp eq i32 %t17, %t18
  br i1 %t19, label %L0, label %L2
L0:
  %t20 = load i32, ptr %t15
  ret i32 %t20
L2:
  br label %L3
L3:
  br i1 true, label %L4, label %L5
L4:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Parser, ptr %t21, i32 0, i32 1
  %t23 = load ptr, ptr %t22
  %t24 = load i32, ptr %t15
  %t25 = load ptr, ptr %t0
  %t26 = call i32 @parseExpr(ptr %t25)
  call void @astAddItem(ptr %t23, i32 %t24, i32 %t26)
  %t27 = load ptr, ptr %t0
  %t28 = call i32 @parserKind(ptr %t27)
  %t29 = load i32, ptr @TK_COMMA
  %t30 = icmp ne i32 %t28, %t29
  br i1 %t30, label %L6, label %L8
L6:
  br label %L5
L9:
  br label %L8
L8:
  %t31 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t31)
  br label %L3
L5:
  %t32 = load i32, ptr %t15
  ret i32 %t32
}

define i32 @parseStructLiteral(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_IDENT
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.154)
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Parser, ptr %t5, i32 0, i32 1
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr @NK_STRUCTLIT
  %t9 = load ptr, ptr %t4
  %t10 = getelementptr inbounds %Token, ptr %t9, i32 0, i32 3
  %t11 = load i32, ptr %t10
  %t12 = load ptr, ptr %t4
  %t13 = getelementptr inbounds %Token, ptr %t12, i32 0, i32 4
  %t14 = load i32, ptr %t13
  %t15 = call i32 @astAdd(ptr %t7, i32 %t8, i32 %t11, i32 %t14)
  %t16 = alloca i32
  store i32 %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Parser, ptr %t17, i32 0, i32 1
  %t19 = load ptr, ptr %t18
  %t20 = load i32, ptr %t16
  %t21 = load ptr, ptr %t4
  call void @astSetText(ptr %t19, i32 %t20, ptr %t21)
  %t22 = load ptr, ptr %t0
  %t23 = load i32, ptr @TK_LBRACE
  %t24 = call ptr @parserExpect(ptr %t22, i32 %t23, ptr @.str.155)
  br label %L0
L0:
  %t25 = alloca i1
  %t26 = load ptr, ptr %t0
  %t27 = call i32 @parserKind(ptr %t26)
  %t28 = load i32, ptr @TK_RBRACE
  %t29 = icmp ne i32 %t27, %t28
  store i1 %t29, ptr %t25
  br i1 %t29, label %L3, label %L4
L3:
  %t30 = load ptr, ptr %t0
  %t31 = call i32 @parserKind(ptr %t30)
  %t32 = load i32, ptr @TK_END
  %t33 = icmp ne i32 %t31, %t32
  store i1 %t33, ptr %t25
  br label %L4
L4:
  %t34 = load i1, ptr %t25
  br i1 %t34, label %L1, label %L2
L1:
  %t35 = load ptr, ptr %t0
  %t36 = load i32, ptr @TK_IDENT
  %t37 = call ptr @parserExpect(ptr %t35, i32 %t36, ptr @.str.156)
  %t38 = alloca ptr
  store ptr %t37, ptr %t38
  %t39 = load ptr, ptr %t0
  %t40 = load i32, ptr @TK_COLON
  %t41 = call ptr @parserExpect(ptr %t39, i32 %t40, ptr @.str.157)
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Parser, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr @NK_FINIT
  %t46 = load ptr, ptr %t38
  %t47 = getelementptr inbounds %Token, ptr %t46, i32 0, i32 3
  %t48 = load i32, ptr %t47
  %t49 = load ptr, ptr %t38
  %t50 = getelementptr inbounds %Token, ptr %t49, i32 0, i32 4
  %t51 = load i32, ptr %t50
  %t52 = call i32 @astAdd(ptr %t44, i32 %t45, i32 %t48, i32 %t51)
  %t53 = alloca i32
  store i32 %t52, ptr %t53
  %t54 = load ptr, ptr %t0
  %t55 = getelementptr inbounds %Parser, ptr %t54, i32 0, i32 1
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t53
  %t58 = load ptr, ptr %t38
  call void @astSetText(ptr %t56, i32 %t57, ptr %t58)
  %t59 = load ptr, ptr %t0
  %t60 = call i32 @parseExpr(ptr %t59)
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Parser, ptr %t61, i32 0, i32 1
  %t63 = load ptr, ptr %t62
  %t64 = getelementptr inbounds %Ast, ptr %t63, i32 0, i32 0
  %t65 = load ptr, ptr %t64
  %t66 = load i32, ptr %t53
  %t67 = sext i32 %t66 to i64
  %t68 = getelementptr inbounds %Node, ptr %t65, i64 %t67
  %t69 = getelementptr inbounds %Node, ptr %t68, i32 0, i32 5
  store i32 %t60, ptr %t69
  %t70 = load ptr, ptr %t0
  %t71 = getelementptr inbounds %Parser, ptr %t70, i32 0, i32 1
  %t72 = load ptr, ptr %t71
  %t73 = load i32, ptr %t16
  %t74 = load i32, ptr %t53
  call void @astAddItem(ptr %t72, i32 %t73, i32 %t74)
  %t75 = load ptr, ptr %t0
  %t76 = call i32 @parserKind(ptr %t75)
  %t77 = load i32, ptr @TK_COMMA
  %t78 = icmp eq i32 %t76, %t77
  br i1 %t78, label %L5, label %L7
L5:
  %t79 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t79)
  br label %L7
L7:
  %t80 = load i1, ptr @FAILED
  br i1 %t80, label %L8, label %L10
L8:
  br label %L2
L11:
  br label %L10
L10:
  br label %L0
L2:
  %t81 = load ptr, ptr %t0
  %t82 = load i32, ptr @TK_RBRACE
  %t83 = call ptr @parserExpect(ptr %t81, i32 %t82, ptr @.str.158)
  %t84 = load i32, ptr %t16
  ret i32 %t84
}

define i32 @compoundAssignOp(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = load i32, ptr @TK_PLUS_ASSIGN
  %t3 = icmp eq i32 %t1, %t2
  br i1 %t3, label %L0, label %L2
L0:
  %t4 = load i32, ptr @TK_PLUS
  ret i32 %t4
L2:
  %t5 = load i32, ptr %t0
  %t6 = load i32, ptr @TK_MINUS_ASSIGN
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L3, label %L5
L3:
  %t8 = load i32, ptr @TK_MINUS
  ret i32 %t8
L5:
  %t9 = load i32, ptr %t0
  %t10 = load i32, ptr @TK_STAR_ASSIGN
  %t11 = icmp eq i32 %t9, %t10
  br i1 %t11, label %L6, label %L8
L6:
  %t12 = load i32, ptr @TK_STAR
  ret i32 %t12
L8:
  %t13 = load i32, ptr %t0
  %t14 = load i32, ptr @TK_SLASH_ASSIGN
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L9, label %L11
L9:
  %t16 = load i32, ptr @TK_SLASH
  ret i32 %t16
L11:
  %t17 = load i32, ptr %t0
  %t18 = load i32, ptr @TK_PERCENT_ASSIGN
  %t19 = icmp eq i32 %t17, %t18
  br i1 %t19, label %L12, label %L14
L12:
  %t20 = load i32, ptr @TK_PERCENT
  ret i32 %t20
L14:
  %t21 = load i32, ptr @TK_NONE
  ret i32 %t21
}

define i32 @parserReparse(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Parser, ptr %t2, i32 0, i32 2
  %t4 = load i32, ptr %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load i32, ptr %t1
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Parser, ptr %t7, i32 0, i32 2
  store i32 %t6, ptr %t8
  %t9 = load ptr, ptr %t0
  %t10 = call i32 @parseExpr(ptr %t9)
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load i32, ptr %t5
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Parser, ptr %t13, i32 0, i32 2
  store i32 %t12, ptr %t14
  %t15 = load i32, ptr %t11
  ret i32 %t15
}

define i32 @parseStatementRecovering(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Parser, ptr %t1, i32 0, i32 2
  %t3 = load i32, ptr %t2
  %t4 = alloca i32
  store i32 %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @parseStatement(ptr %t5)
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load i1, ptr @FAILED
  %t9 = xor i1 %t8, true
  br i1 %t9, label %L0, label %L2
L0:
  %t10 = load i32, ptr %t7
  ret i32 %t10
L2:
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Parser, ptr %t11, i32 0, i32 2
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr %t4
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L3, label %L5
L3:
  %t16 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t16)
  br label %L5
L5:
  %t17 = load ptr, ptr %t0
  call void @parserSynchronize(ptr %t17)
  store i1 false, ptr @FAILED
  %t18 = load i32, ptr @NO_NODE
  ret i32 %t18
}

define i32 @parseStatement(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t3
  %t14 = call i32 @parseStatementInner(ptr %t12, ptr %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Parser, ptr %t16, i32 0, i32 1
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t15
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 1
  %t25 = load i32, ptr %t24
  %t26 = icmp eq i32 %t25, 0
  br i1 %t26, label %L0, label %L2
L0:
  %t27 = load i32, ptr %t7
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Parser, ptr %t28, i32 0, i32 1
  %t30 = load ptr, ptr %t29
  %t31 = getelementptr inbounds %Ast, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t15
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %Node, ptr %t32, i64 %t34
  %t36 = getelementptr inbounds %Node, ptr %t35, i32 0, i32 1
  store i32 %t27, ptr %t36
  %t37 = load i32, ptr %t11
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %Parser, ptr %t38, i32 0, i32 1
  %t40 = load ptr, ptr %t39
  %t41 = getelementptr inbounds %Ast, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = load i32, ptr %t15
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds %Node, ptr %t42, i64 %t44
  %t46 = getelementptr inbounds %Node, ptr %t45, i32 0, i32 2
  store i32 %t37, ptr %t46
  br label %L2
L2:
  %t47 = load i32, ptr %t15
  ret i32 %t47
}

define i32 @parseStatementInner(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call i32 @parserKind(ptr %t2)
  %t4 = alloca i32
  store i32 %t3, ptr %t4
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TK_LET
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = load ptr, ptr %t0
  %t9 = call i32 @parseVarDecl(ptr %t8)
  ret i32 %t9
L2:
  %t10 = load i32, ptr %t4
  %t11 = load i32, ptr @TK_LBRACE
  %t12 = icmp eq i32 %t10, %t11
  br i1 %t12, label %L3, label %L5
L3:
  %t13 = load ptr, ptr %t0
  %t14 = call i32 @parseBlock(ptr %t13)
  ret i32 %t14
L5:
  %t15 = load i32, ptr %t4
  %t16 = load i32, ptr @TK_IF
  %t17 = icmp eq i32 %t15, %t16
  br i1 %t17, label %L6, label %L8
L6:
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parseIfStmt(ptr %t18)
  ret i32 %t19
L8:
  %t20 = load i32, ptr %t4
  %t21 = load i32, ptr @TK_WHILE
  %t22 = icmp eq i32 %t20, %t21
  br i1 %t22, label %L9, label %L11
L9:
  %t23 = load ptr, ptr %t0
  %t24 = call i32 @parseWhileStmt(ptr %t23)
  ret i32 %t24
L11:
  %t25 = load i32, ptr %t4
  %t26 = load i32, ptr @TK_BREAK
  %t27 = icmp eq i32 %t25, %t26
  br i1 %t27, label %L12, label %L14
L12:
  %t28 = load ptr, ptr %t0
  %t29 = call i32 @parseBreakStmt(ptr %t28)
  ret i32 %t29
L14:
  %t30 = load i32, ptr %t4
  %t31 = load i32, ptr @TK_CONTINUE
  %t32 = icmp eq i32 %t30, %t31
  br i1 %t32, label %L15, label %L17
L15:
  %t33 = load ptr, ptr %t0
  %t34 = call i32 @parseContinueStmt(ptr %t33)
  ret i32 %t34
L17:
  %t35 = load i32, ptr %t4
  %t36 = load i32, ptr @TK_RETURN
  %t37 = icmp eq i32 %t35, %t36
  br i1 %t37, label %L18, label %L20
L18:
  %t38 = load ptr, ptr %t0
  %t39 = call i32 @parseReturnStmt(ptr %t38)
  ret i32 %t39
L20:
  %t40 = load i32, ptr %t4
  %t41 = load i32, ptr @TK_PRINT
  %t42 = icmp eq i32 %t40, %t41
  br i1 %t42, label %L21, label %L23
L21:
  %t43 = load ptr, ptr %t0
  %t44 = call i32 @parsePrintStmt(ptr %t43)
  ret i32 %t44
L23:
  %t45 = load i32, ptr %t4
  %t46 = load i32, ptr @TK_FN
  %t47 = icmp eq i32 %t45, %t46
  br i1 %t47, label %L24, label %L26
L24:
  %t48 = load ptr, ptr %t0
  %t49 = call i32 @parseFuncDecl(ptr %t48)
  %t50 = alloca i32
  store i32 %t49, ptr %t50
  %t51 = load ptr, ptr %t0
  %t52 = load ptr, ptr %t1
  %t53 = load i32, ptr %t50
  %t54 = call i32 @requireTopLevel(ptr %t51, ptr %t52, ptr @.str.159, i32 %t53)
  ret i32 %t54
L26:
  %t55 = load i32, ptr %t4
  %t56 = load i32, ptr @TK_EXTERN
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L27, label %L29
L27:
  %t58 = load ptr, ptr %t0
  %t59 = call i32 @parseExternDecl(ptr %t58)
  %t60 = alloca i32
  store i32 %t59, ptr %t60
  %t61 = load ptr, ptr %t0
  %t62 = load ptr, ptr %t1
  %t63 = load i32, ptr %t60
  %t64 = call i32 @requireTopLevel(ptr %t61, ptr %t62, ptr @.str.160, i32 %t63)
  ret i32 %t64
L29:
  %t65 = load i32, ptr %t4
  %t66 = load i32, ptr @TK_STRUCT
  %t67 = icmp eq i32 %t65, %t66
  br i1 %t67, label %L30, label %L32
L30:
  %t68 = load ptr, ptr %t0
  %t69 = call i32 @parseStructDecl(ptr %t68)
  %t70 = alloca i32
  store i32 %t69, ptr %t70
  %t71 = load ptr, ptr %t0
  %t72 = load ptr, ptr %t1
  %t73 = load i32, ptr %t70
  %t74 = call i32 @requireTopLevel(ptr %t71, ptr %t72, ptr @.str.161, i32 %t73)
  ret i32 %t74
L32:
  %t75 = load i32, ptr %t4
  %t76 = load i32, ptr @TK_IMPORT
  %t77 = icmp eq i32 %t75, %t76
  br i1 %t77, label %L33, label %L35
L33:
  %t78 = load ptr, ptr %t0
  %t79 = call i32 @parseImportDecl(ptr %t78)
  %t80 = alloca i32
  store i32 %t79, ptr %t80
  %t81 = load ptr, ptr %t0
  %t82 = load ptr, ptr %t1
  %t83 = load i32, ptr %t80
  %t84 = call i32 @requireTopLevel(ptr %t81, ptr %t82, ptr @.str.162, i32 %t83)
  ret i32 %t84
L35:
  %t85 = load i32, ptr %t4
  %t86 = load i32, ptr @TK_EXPORT
  %t87 = icmp eq i32 %t85, %t86
  br i1 %t87, label %L36, label %L38
L36:
  %t88 = load ptr, ptr %t0
  %t89 = call i32 @parseExportDecl(ptr %t88)
  %t90 = alloca i32
  store i32 %t89, ptr %t90
  %t91 = load ptr, ptr %t0
  %t92 = load ptr, ptr %t1
  %t93 = load i32, ptr %t90
  %t94 = call i32 @requireTopLevel(ptr %t91, ptr %t92, ptr @.str.163, i32 %t93)
  ret i32 %t94
L38:
  %t95 = load ptr, ptr %t0
  %t96 = call i32 @parseExprStmt(ptr %t95)
  ret i32 %t96
}

define i32 @requireTopLevel(ptr %p0, ptr %p1, ptr %p2, i32 %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i32
  store i32 %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 3
  %t6 = load i1, ptr %t5
  %t7 = xor i1 %t6, true
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = call ptr @bufNew()
  %t9 = alloca ptr
  store ptr %t8, ptr %t9
  %t10 = load ptr, ptr %t9
  call void @bufPush(ptr %t10, i8 39)
  %t11 = load ptr, ptr %t9
  %t12 = load ptr, ptr %t2
  call void @bufAdd(ptr %t11, ptr %t12)
  %t13 = load ptr, ptr %t9
  call void @bufAdd(ptr %t13, ptr @.str.164)
  %t14 = load ptr, ptr %t9
  call void @bufAdd(ptr %t14, ptr @.str.165)
  %t15 = load ptr, ptr %t1
  %t16 = getelementptr inbounds %Token, ptr %t15, i32 0, i32 3
  %t17 = load i32, ptr %t16
  %t18 = load ptr, ptr %t1
  %t19 = getelementptr inbounds %Token, ptr %t18, i32 0, i32 4
  %t20 = load i32, ptr %t19
  %t21 = load ptr, ptr %t9
  %t22 = getelementptr inbounds %Buf, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  call void @report(i32 %t17, i32 %t20, ptr %t23)
  br label %L2
L2:
  %t24 = load i32, ptr %t3
  ret i32 %t24
}

define i32 @parseVarDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_LET
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.166)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr @TK_IDENT
  %t6 = call ptr @parserExpect(ptr %t4, i32 %t5, ptr @.str.167)
  %t7 = alloca ptr
  store ptr %t6, ptr %t7
  %t8 = load ptr, ptr %t0
  %t9 = load i32, ptr @TK_COLON
  %t10 = call ptr @parserExpect(ptr %t8, i32 %t9, ptr @.str.168)
  %t11 = load ptr, ptr %t0
  %t12 = call i32 @parseType(ptr %t11)
  %t13 = alloca i32
  store i32 %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = load i32, ptr @TK_ASSIGN
  %t16 = call ptr @parserExpect(ptr %t14, i32 %t15, ptr @.str.169)
  %t17 = load ptr, ptr %t0
  %t18 = call i32 @parseExpr(ptr %t17)
  %t19 = alloca i32
  store i32 %t18, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = load i32, ptr @TK_SEMICOLON
  %t22 = call ptr @parserExpect(ptr %t20, i32 %t21, ptr @.str.170)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Parser, ptr %t23, i32 0, i32 1
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr @NK_VARDECL
  %t27 = call i32 @astAdd(ptr %t25, i32 %t26, i32 0, i32 0)
  %t28 = alloca i32
  store i32 %t27, ptr %t28
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Parser, ptr %t29, i32 0, i32 1
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t28
  %t33 = load ptr, ptr %t7
  call void @astSetText(ptr %t31, i32 %t32, ptr %t33)
  %t34 = load i32, ptr %t13
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %Parser, ptr %t35, i32 0, i32 1
  %t37 = load ptr, ptr %t36
  %t38 = getelementptr inbounds %Ast, ptr %t37, i32 0, i32 0
  %t39 = load ptr, ptr %t38
  %t40 = load i32, ptr %t28
  %t41 = sext i32 %t40 to i64
  %t42 = getelementptr inbounds %Node, ptr %t39, i64 %t41
  %t43 = getelementptr inbounds %Node, ptr %t42, i32 0, i32 5
  store i32 %t34, ptr %t43
  %t44 = load i32, ptr %t19
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %Parser, ptr %t45, i32 0, i32 1
  %t47 = load ptr, ptr %t46
  %t48 = getelementptr inbounds %Ast, ptr %t47, i32 0, i32 0
  %t49 = load ptr, ptr %t48
  %t50 = load i32, ptr %t28
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds %Node, ptr %t49, i64 %t51
  %t53 = getelementptr inbounds %Node, ptr %t52, i32 0, i32 6
  store i32 %t44, ptr %t53
  %t54 = load i32, ptr %t28
  ret i32 %t54
}

define i32 @parseExprStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Parser, ptr %t1, i32 0, i32 2
  %t3 = load i32, ptr %t2
  %t4 = alloca i32
  store i32 %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  %t6 = call i32 @parseExpr(ptr %t5)
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t0
  %t9 = call i32 @parserKind(ptr %t8)
  %t10 = load i32, ptr @TK_ASSIGN
  %t11 = icmp eq i32 %t9, %t10
  br i1 %t11, label %L0, label %L2
L0:
  %t12 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t12)
  %t13 = load ptr, ptr %t0
  %t14 = call i32 @parseExpr(ptr %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr @TK_SEMICOLON
  %t18 = call ptr @parserExpect(ptr %t16, i32 %t17, ptr @.str.171)
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Parser, ptr %t19, i32 0, i32 1
  %t21 = load ptr, ptr %t20
  %t22 = load i32, ptr @NK_ASSIGN
  %t23 = call i32 @astAdd(ptr %t21, i32 %t22, i32 0, i32 0)
  %t24 = alloca i32
  store i32 %t23, ptr %t24
  %t25 = load i32, ptr %t7
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Parser, ptr %t26, i32 0, i32 1
  %t28 = load ptr, ptr %t27
  %t29 = getelementptr inbounds %Ast, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = load i32, ptr %t24
  %t32 = sext i32 %t31 to i64
  %t33 = getelementptr inbounds %Node, ptr %t30, i64 %t32
  %t34 = getelementptr inbounds %Node, ptr %t33, i32 0, i32 5
  store i32 %t25, ptr %t34
  %t35 = load i32, ptr %t15
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %Parser, ptr %t36, i32 0, i32 1
  %t38 = load ptr, ptr %t37
  %t39 = getelementptr inbounds %Ast, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t24
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %Node, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %Node, ptr %t43, i32 0, i32 6
  store i32 %t35, ptr %t44
  %t45 = load i32, ptr %t24
  ret i32 %t45
L2:
  %t46 = load ptr, ptr %t0
  %t47 = call i32 @parserKind(ptr %t46)
  %t48 = call i32 @compoundAssignOp(i32 %t47)
  %t49 = alloca i32
  store i32 %t48, ptr %t49
  %t50 = load i32, ptr %t49
  %t51 = load i32, ptr @TK_NONE
  %t52 = icmp ne i32 %t50, %t51
  br i1 %t52, label %L3, label %L5
L3:
  %t53 = load ptr, ptr %t0
  %t54 = load i32, ptr %t4
  %t55 = call i32 @parserReparse(ptr %t53, i32 %t54)
  %t56 = alloca i32
  store i32 %t55, ptr %t56
  %t57 = load ptr, ptr %t0
  %t58 = call ptr @parserCurrent(ptr %t57)
  %t59 = alloca ptr
  store ptr %t58, ptr %t59
  %t60 = load ptr, ptr %t59
  %t61 = getelementptr inbounds %Token, ptr %t60, i32 0, i32 3
  %t62 = load i32, ptr %t61
  %t63 = alloca i32
  store i32 %t62, ptr %t63
  %t64 = load ptr, ptr %t59
  %t65 = getelementptr inbounds %Token, ptr %t64, i32 0, i32 4
  %t66 = load i32, ptr %t65
  %t67 = alloca i32
  store i32 %t66, ptr %t67
  %t68 = load ptr, ptr %t59
  %t69 = getelementptr inbounds %Token, ptr %t68, i32 0, i32 1
  %t70 = load ptr, ptr %t69
  %t71 = sext i32 0 to i64
  %t72 = load ptr, ptr %t59
  %t73 = getelementptr inbounds %Token, ptr %t72, i32 0, i32 2
  %t74 = load i64, ptr %t73
  %t75 = sext i32 1 to i64
  %t76 = sub i64 %t74, %t75
  %t77 = call ptr @textSlice(ptr %t70, i64 %t71, i64 %t76)
  %t78 = alloca ptr
  store ptr %t77, ptr %t78
  %t79 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t79)
  %t80 = load ptr, ptr %t0
  %t81 = call i32 @parseExpr(ptr %t80)
  %t82 = alloca i32
  store i32 %t81, ptr %t82
  %t83 = load ptr, ptr %t0
  %t84 = load i32, ptr @TK_SEMICOLON
  %t85 = call ptr @parserExpect(ptr %t83, i32 %t84, ptr @.str.172)
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr inbounds %Parser, ptr %t86, i32 0, i32 1
  %t88 = load ptr, ptr %t87
  %t89 = load i32, ptr @NK_BINARY
  %t90 = load i32, ptr %t63
  %t91 = load i32, ptr %t67
  %t92 = call i32 @astAdd(ptr %t88, i32 %t89, i32 %t90, i32 %t91)
  %t93 = alloca i32
  store i32 %t92, ptr %t93
  %t94 = load ptr, ptr %t78
  %t95 = load ptr, ptr %t0
  %t96 = getelementptr inbounds %Parser, ptr %t95, i32 0, i32 1
  %t97 = load ptr, ptr %t96
  %t98 = getelementptr inbounds %Ast, ptr %t97, i32 0, i32 0
  %t99 = load ptr, ptr %t98
  %t100 = load i32, ptr %t93
  %t101 = sext i32 %t100 to i64
  %t102 = getelementptr inbounds %Node, ptr %t99, i64 %t101
  %t103 = getelementptr inbounds %Node, ptr %t102, i32 0, i32 3
  store ptr %t94, ptr %t103
  %t104 = load ptr, ptr %t59
  %t105 = getelementptr inbounds %Token, ptr %t104, i32 0, i32 2
  %t106 = load i64, ptr %t105
  %t107 = sext i32 1 to i64
  %t108 = sub i64 %t106, %t107
  %t109 = load ptr, ptr %t0
  %t110 = getelementptr inbounds %Parser, ptr %t109, i32 0, i32 1
  %t111 = load ptr, ptr %t110
  %t112 = getelementptr inbounds %Ast, ptr %t111, i32 0, i32 0
  %t113 = load ptr, ptr %t112
  %t114 = load i32, ptr %t93
  %t115 = sext i32 %t114 to i64
  %t116 = getelementptr inbounds %Node, ptr %t113, i64 %t115
  %t117 = getelementptr inbounds %Node, ptr %t116, i32 0, i32 4
  store i64 %t108, ptr %t117
  %t118 = load i32, ptr %t56
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr inbounds %Parser, ptr %t119, i32 0, i32 1
  %t121 = load ptr, ptr %t120
  %t122 = getelementptr inbounds %Ast, ptr %t121, i32 0, i32 0
  %t123 = load ptr, ptr %t122
  %t124 = load i32, ptr %t93
  %t125 = sext i32 %t124 to i64
  %t126 = getelementptr inbounds %Node, ptr %t123, i64 %t125
  %t127 = getelementptr inbounds %Node, ptr %t126, i32 0, i32 5
  store i32 %t118, ptr %t127
  %t128 = load i32, ptr %t82
  %t129 = load ptr, ptr %t0
  %t130 = getelementptr inbounds %Parser, ptr %t129, i32 0, i32 1
  %t131 = load ptr, ptr %t130
  %t132 = getelementptr inbounds %Ast, ptr %t131, i32 0, i32 0
  %t133 = load ptr, ptr %t132
  %t134 = load i32, ptr %t93
  %t135 = sext i32 %t134 to i64
  %t136 = getelementptr inbounds %Node, ptr %t133, i64 %t135
  %t137 = getelementptr inbounds %Node, ptr %t136, i32 0, i32 6
  store i32 %t128, ptr %t137
  %t138 = load ptr, ptr %t0
  %t139 = getelementptr inbounds %Parser, ptr %t138, i32 0, i32 1
  %t140 = load ptr, ptr %t139
  %t141 = load i32, ptr @NK_ASSIGN
  %t142 = call i32 @astAdd(ptr %t140, i32 %t141, i32 0, i32 0)
  %t143 = alloca i32
  store i32 %t142, ptr %t143
  %t144 = load i32, ptr %t7
  %t145 = load ptr, ptr %t0
  %t146 = getelementptr inbounds %Parser, ptr %t145, i32 0, i32 1
  %t147 = load ptr, ptr %t146
  %t148 = getelementptr inbounds %Ast, ptr %t147, i32 0, i32 0
  %t149 = load ptr, ptr %t148
  %t150 = load i32, ptr %t143
  %t151 = sext i32 %t150 to i64
  %t152 = getelementptr inbounds %Node, ptr %t149, i64 %t151
  %t153 = getelementptr inbounds %Node, ptr %t152, i32 0, i32 5
  store i32 %t144, ptr %t153
  %t154 = load i32, ptr %t93
  %t155 = load ptr, ptr %t0
  %t156 = getelementptr inbounds %Parser, ptr %t155, i32 0, i32 1
  %t157 = load ptr, ptr %t156
  %t158 = getelementptr inbounds %Ast, ptr %t157, i32 0, i32 0
  %t159 = load ptr, ptr %t158
  %t160 = load i32, ptr %t143
  %t161 = sext i32 %t160 to i64
  %t162 = getelementptr inbounds %Node, ptr %t159, i64 %t161
  %t163 = getelementptr inbounds %Node, ptr %t162, i32 0, i32 6
  store i32 %t154, ptr %t163
  %t164 = load i32, ptr %t143
  ret i32 %t164
L5:
  %t165 = load ptr, ptr %t0
  %t166 = load i32, ptr @TK_SEMICOLON
  %t167 = call ptr @parserExpect(ptr %t165, i32 %t166, ptr @.str.173)
  %t168 = load ptr, ptr %t0
  %t169 = getelementptr inbounds %Parser, ptr %t168, i32 0, i32 1
  %t170 = load ptr, ptr %t169
  %t171 = load i32, ptr @NK_EXPRSTMT
  %t172 = call i32 @astAdd(ptr %t170, i32 %t171, i32 0, i32 0)
  %t173 = alloca i32
  store i32 %t172, ptr %t173
  %t174 = load i32, ptr %t7
  %t175 = load ptr, ptr %t0
  %t176 = getelementptr inbounds %Parser, ptr %t175, i32 0, i32 1
  %t177 = load ptr, ptr %t176
  %t178 = getelementptr inbounds %Ast, ptr %t177, i32 0, i32 0
  %t179 = load ptr, ptr %t178
  %t180 = load i32, ptr %t173
  %t181 = sext i32 %t180 to i64
  %t182 = getelementptr inbounds %Node, ptr %t179, i64 %t181
  %t183 = getelementptr inbounds %Node, ptr %t182, i32 0, i32 5
  store i32 %t174, ptr %t183
  %t184 = load i32, ptr %t173
  ret i32 %t184
}

define i32 @parseBlock(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_BLOCK
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr @TK_LBRACE
  %t18 = call ptr @parserExpect(ptr %t16, i32 %t17, ptr @.str.174)
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Parser, ptr %t19, i32 0, i32 3
  %t21 = load i1, ptr %t20
  %t22 = alloca i1
  store i1 %t21, ptr %t22
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Parser, ptr %t23, i32 0, i32 3
  store i1 false, ptr %t24
  br label %L0
L0:
  %t25 = alloca i1
  %t26 = load ptr, ptr %t0
  %t27 = call i32 @parserKind(ptr %t26)
  %t28 = load i32, ptr @TK_RBRACE
  %t29 = icmp ne i32 %t27, %t28
  store i1 %t29, ptr %t25
  br i1 %t29, label %L3, label %L4
L3:
  %t30 = load ptr, ptr %t0
  %t31 = call i32 @parserKind(ptr %t30)
  %t32 = load i32, ptr @TK_END
  %t33 = icmp ne i32 %t31, %t32
  store i1 %t33, ptr %t25
  br label %L4
L4:
  %t34 = load i1, ptr %t25
  br i1 %t34, label %L1, label %L2
L1:
  %t35 = load ptr, ptr %t0
  %t36 = call i32 @parseStatementRecovering(ptr %t35)
  %t37 = alloca i32
  store i32 %t36, ptr %t37
  %t38 = load i32, ptr %t37
  %t39 = load i32, ptr @NO_NODE
  %t40 = icmp ne i32 %t38, %t39
  br i1 %t40, label %L5, label %L7
L5:
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Parser, ptr %t41, i32 0, i32 1
  %t43 = load ptr, ptr %t42
  %t44 = load i32, ptr %t15
  %t45 = load i32, ptr %t37
  call void @astAddItem(ptr %t43, i32 %t44, i32 %t45)
  br label %L7
L7:
  br label %L0
L2:
  %t46 = load i1, ptr %t22
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr inbounds %Parser, ptr %t47, i32 0, i32 3
  store i1 %t46, ptr %t48
  %t49 = load ptr, ptr %t0
  %t50 = load i32, ptr @TK_RBRACE
  %t51 = call ptr @parserExpect(ptr %t49, i32 %t50, ptr @.str.175)
  %t52 = load i32, ptr %t15
  ret i32 %t52
}

define i32 @parseIfStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_IF
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.176)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr @TK_LPAREN
  %t6 = call ptr @parserExpect(ptr %t4, i32 %t5, ptr @.str.177)
  %t7 = load ptr, ptr %t0
  %t8 = call i32 @parseExpr(ptr %t7)
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = load i32, ptr @TK_RPAREN
  %t12 = call ptr @parserExpect(ptr %t10, i32 %t11, ptr @.str.178)
  %t13 = load ptr, ptr %t0
  %t14 = call i32 @parseBlock(ptr %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load i32, ptr @NO_NODE
  %t17 = alloca i32
  store i32 %t16, ptr %t17
  %t18 = load ptr, ptr %t0
  %t19 = call i32 @parserKind(ptr %t18)
  %t20 = load i32, ptr @TK_ELSE
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L0, label %L2
L0:
  %t22 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t22)
  %t23 = load ptr, ptr %t0
  %t24 = call i32 @parserKind(ptr %t23)
  %t25 = load i32, ptr @TK_IF
  %t26 = icmp eq i32 %t24, %t25
  br i1 %t26, label %L3, label %L4
L3:
  %t27 = load ptr, ptr %t0
  %t28 = call i32 @parseIfStmt(ptr %t27)
  store i32 %t28, ptr %t17
  br label %L5
L4:
  %t29 = load ptr, ptr %t0
  %t30 = call i32 @parseBlock(ptr %t29)
  store i32 %t30, ptr %t17
  br label %L5
L5:
  br label %L2
L2:
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Parser, ptr %t31, i32 0, i32 1
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr @NK_IF
  %t35 = call i32 @astAdd(ptr %t33, i32 %t34, i32 0, i32 0)
  %t36 = alloca i32
  store i32 %t35, ptr %t36
  %t37 = load i32, ptr %t9
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %Parser, ptr %t38, i32 0, i32 1
  %t40 = load ptr, ptr %t39
  %t41 = getelementptr inbounds %Ast, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = load i32, ptr %t36
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds %Node, ptr %t42, i64 %t44
  %t46 = getelementptr inbounds %Node, ptr %t45, i32 0, i32 5
  store i32 %t37, ptr %t46
  %t47 = load i32, ptr %t15
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Parser, ptr %t48, i32 0, i32 1
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %Ast, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t36
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Node, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Node, ptr %t55, i32 0, i32 6
  store i32 %t47, ptr %t56
  %t57 = load i32, ptr %t17
  %t58 = load ptr, ptr %t0
  %t59 = getelementptr inbounds %Parser, ptr %t58, i32 0, i32 1
  %t60 = load ptr, ptr %t59
  %t61 = getelementptr inbounds %Ast, ptr %t60, i32 0, i32 0
  %t62 = load ptr, ptr %t61
  %t63 = load i32, ptr %t36
  %t64 = sext i32 %t63 to i64
  %t65 = getelementptr inbounds %Node, ptr %t62, i64 %t64
  %t66 = getelementptr inbounds %Node, ptr %t65, i32 0, i32 7
  store i32 %t57, ptr %t66
  %t67 = load i32, ptr %t36
  ret i32 %t67
}

define i32 @parseWhileStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_WHILE
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.179)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr @TK_LPAREN
  %t6 = call ptr @parserExpect(ptr %t4, i32 %t5, ptr @.str.180)
  %t7 = load ptr, ptr %t0
  %t8 = call i32 @parseExpr(ptr %t7)
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = load i32, ptr @TK_RPAREN
  %t12 = call ptr @parserExpect(ptr %t10, i32 %t11, ptr @.str.181)
  %t13 = load ptr, ptr %t0
  %t14 = call i32 @parseBlock(ptr %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Parser, ptr %t16, i32 0, i32 1
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr @NK_WHILE
  %t20 = call i32 @astAdd(ptr %t18, i32 %t19, i32 0, i32 0)
  %t21 = alloca i32
  store i32 %t20, ptr %t21
  %t22 = load i32, ptr %t9
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Parser, ptr %t23, i32 0, i32 1
  %t25 = load ptr, ptr %t24
  %t26 = getelementptr inbounds %Ast, ptr %t25, i32 0, i32 0
  %t27 = load ptr, ptr %t26
  %t28 = load i32, ptr %t21
  %t29 = sext i32 %t28 to i64
  %t30 = getelementptr inbounds %Node, ptr %t27, i64 %t29
  %t31 = getelementptr inbounds %Node, ptr %t30, i32 0, i32 5
  store i32 %t22, ptr %t31
  %t32 = load i32, ptr %t15
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Parser, ptr %t33, i32 0, i32 1
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t21
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 6
  store i32 %t32, ptr %t41
  %t42 = load i32, ptr %t21
  ret i32 %t42
}

define i32 @parseBreakStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_BREAK
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.182)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr @TK_SEMICOLON
  %t6 = call ptr @parserExpect(ptr %t4, i32 %t5, ptr @.str.183)
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Parser, ptr %t7, i32 0, i32 1
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr @NK_BREAK
  %t11 = call i32 @astAdd(ptr %t9, i32 %t10, i32 0, i32 0)
  ret i32 %t11
}

define i32 @parseContinueStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_CONTINUE
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.184)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr @TK_SEMICOLON
  %t6 = call ptr @parserExpect(ptr %t4, i32 %t5, ptr @.str.185)
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Parser, ptr %t7, i32 0, i32 1
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr @NK_CONTINUE
  %t11 = call i32 @astAdd(ptr %t9, i32 %t10, i32 0, i32 0)
  ret i32 %t11
}

define i32 @parseReturnStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_RETURN
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.186)
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_RETURN
  %t8 = call i32 @astAdd(ptr %t6, i32 %t7, i32 0, i32 0)
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load ptr, ptr %t0
  %t11 = call i32 @parserKind(ptr %t10)
  %t12 = load i32, ptr @TK_SEMICOLON
  %t13 = icmp eq i32 %t11, %t12
  br i1 %t13, label %L0, label %L2
L0:
  %t14 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t14)
  %t15 = load i32, ptr %t9
  ret i32 %t15
L2:
  %t16 = load ptr, ptr %t0
  %t17 = call i32 @parseExpr(ptr %t16)
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %Parser, ptr %t18, i32 0, i32 1
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t9
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 5
  store i32 %t17, ptr %t26
  %t27 = load ptr, ptr %t0
  %t28 = load i32, ptr @TK_SEMICOLON
  %t29 = call ptr @parserExpect(ptr %t27, i32 %t28, ptr @.str.187)
  %t30 = load i32, ptr %t9
  ret i32 %t30
}

define i32 @parsePrintStmt(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_PRINT
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.188)
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parseExpr(ptr %t4)
  %t6 = alloca i32
  store i32 %t5, ptr %t6
  %t7 = load ptr, ptr %t0
  %t8 = load i32, ptr @TK_SEMICOLON
  %t9 = call ptr @parserExpect(ptr %t7, i32 %t8, ptr @.str.189)
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Parser, ptr %t10, i32 0, i32 1
  %t12 = load ptr, ptr %t11
  %t13 = load i32, ptr @NK_PRINT
  %t14 = call i32 @astAdd(ptr %t12, i32 %t13, i32 0, i32 0)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load i32, ptr %t6
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Parser, ptr %t17, i32 0, i32 1
  %t19 = load ptr, ptr %t18
  %t20 = getelementptr inbounds %Ast, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = load i32, ptr %t15
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr inbounds %Node, ptr %t21, i64 %t23
  %t25 = getelementptr inbounds %Node, ptr %t24, i32 0, i32 5
  store i32 %t16, ptr %t25
  %t26 = load i32, ptr %t15
  ret i32 %t26
}

define i32 @parseParamList(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_PARAMS
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr @TK_LPAREN
  %t18 = call ptr @parserExpect(ptr %t16, i32 %t17, ptr @.str.190)
  %t19 = load ptr, ptr %t0
  %t20 = call i32 @parserKind(ptr %t19)
  %t21 = load i32, ptr @TK_RPAREN
  %t22 = icmp eq i32 %t20, %t21
  br i1 %t22, label %L0, label %L2
L0:
  %t23 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t23)
  %t24 = load i32, ptr %t15
  ret i32 %t24
L2:
  br label %L3
L3:
  br i1 true, label %L4, label %L5
L4:
  %t25 = load ptr, ptr %t0
  %t26 = load i32, ptr @TK_IDENT
  %t27 = call ptr @parserExpect(ptr %t25, i32 %t26, ptr @.str.191)
  %t28 = alloca ptr
  store ptr %t27, ptr %t28
  %t29 = load ptr, ptr %t0
  %t30 = load i32, ptr @TK_COLON
  %t31 = call ptr @parserExpect(ptr %t29, i32 %t30, ptr @.str.192)
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Parser, ptr %t32, i32 0, i32 1
  %t34 = load ptr, ptr %t33
  %t35 = load i32, ptr @NK_PARAM
  %t36 = load ptr, ptr %t28
  %t37 = getelementptr inbounds %Token, ptr %t36, i32 0, i32 3
  %t38 = load i32, ptr %t37
  %t39 = load ptr, ptr %t28
  %t40 = getelementptr inbounds %Token, ptr %t39, i32 0, i32 4
  %t41 = load i32, ptr %t40
  %t42 = call i32 @astAdd(ptr %t34, i32 %t35, i32 %t38, i32 %t41)
  %t43 = alloca i32
  store i32 %t42, ptr %t43
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr inbounds %Parser, ptr %t44, i32 0, i32 1
  %t46 = load ptr, ptr %t45
  %t47 = load i32, ptr %t43
  %t48 = load ptr, ptr %t28
  call void @astSetText(ptr %t46, i32 %t47, ptr %t48)
  %t49 = load ptr, ptr %t0
  %t50 = call i32 @parseType(ptr %t49)
  %t51 = load ptr, ptr %t0
  %t52 = getelementptr inbounds %Parser, ptr %t51, i32 0, i32 1
  %t53 = load ptr, ptr %t52
  %t54 = getelementptr inbounds %Ast, ptr %t53, i32 0, i32 0
  %t55 = load ptr, ptr %t54
  %t56 = load i32, ptr %t43
  %t57 = sext i32 %t56 to i64
  %t58 = getelementptr inbounds %Node, ptr %t55, i64 %t57
  %t59 = getelementptr inbounds %Node, ptr %t58, i32 0, i32 5
  store i32 %t50, ptr %t59
  %t60 = load ptr, ptr %t0
  %t61 = getelementptr inbounds %Parser, ptr %t60, i32 0, i32 1
  %t62 = load ptr, ptr %t61
  %t63 = load i32, ptr %t15
  %t64 = load i32, ptr %t43
  call void @astAddItem(ptr %t62, i32 %t63, i32 %t64)
  %t65 = load ptr, ptr %t0
  %t66 = call i32 @parserKind(ptr %t65)
  %t67 = load i32, ptr @TK_COMMA
  %t68 = icmp ne i32 %t66, %t67
  br i1 %t68, label %L6, label %L8
L6:
  br label %L5
L9:
  br label %L8
L8:
  %t69 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t69)
  br label %L3
L5:
  %t70 = load ptr, ptr %t0
  %t71 = load i32, ptr @TK_RPAREN
  %t72 = call ptr @parserExpect(ptr %t70, i32 %t71, ptr @.str.193)
  %t73 = load i32, ptr %t15
  ret i32 %t73
}

define i32 @parseFuncDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = load i32, ptr @TK_FN
  %t14 = call ptr @parserExpect(ptr %t12, i32 %t13, ptr @.str.194)
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr @TK_IDENT
  %t17 = call ptr @parserExpect(ptr %t15, i32 %t16, ptr @.str.195)
  %t18 = alloca ptr
  store ptr %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = call i32 @parseParamList(ptr %t19)
  %t21 = alloca i32
  store i32 %t20, ptr %t21
  %t22 = load ptr, ptr %t0
  %t23 = load i32, ptr @TK_COLON
  %t24 = call ptr @parserExpect(ptr %t22, i32 %t23, ptr @.str.196)
  %t25 = load ptr, ptr %t0
  %t26 = call i32 @parseType(ptr %t25)
  %t27 = alloca i32
  store i32 %t26, ptr %t27
  %t28 = load ptr, ptr %t0
  %t29 = call i32 @parseBlock(ptr %t28)
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Parser, ptr %t31, i32 0, i32 1
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr @NK_FN
  %t35 = load i32, ptr %t7
  %t36 = load i32, ptr %t11
  %t37 = call i32 @astAdd(ptr %t33, i32 %t34, i32 %t35, i32 %t36)
  %t38 = alloca i32
  store i32 %t37, ptr %t38
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Parser, ptr %t39, i32 0, i32 1
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t38
  %t43 = load ptr, ptr %t18
  call void @astSetText(ptr %t41, i32 %t42, ptr %t43)
  %t44 = load i32, ptr %t27
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %Parser, ptr %t45, i32 0, i32 1
  %t47 = load ptr, ptr %t46
  %t48 = getelementptr inbounds %Ast, ptr %t47, i32 0, i32 0
  %t49 = load ptr, ptr %t48
  %t50 = load i32, ptr %t38
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds %Node, ptr %t49, i64 %t51
  %t53 = getelementptr inbounds %Node, ptr %t52, i32 0, i32 5
  store i32 %t44, ptr %t53
  %t54 = load i32, ptr %t21
  %t55 = load ptr, ptr %t0
  %t56 = getelementptr inbounds %Parser, ptr %t55, i32 0, i32 1
  %t57 = load ptr, ptr %t56
  %t58 = getelementptr inbounds %Ast, ptr %t57, i32 0, i32 0
  %t59 = load ptr, ptr %t58
  %t60 = load i32, ptr %t38
  %t61 = sext i32 %t60 to i64
  %t62 = getelementptr inbounds %Node, ptr %t59, i64 %t61
  %t63 = getelementptr inbounds %Node, ptr %t62, i32 0, i32 6
  store i32 %t54, ptr %t63
  %t64 = load i32, ptr %t30
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr inbounds %Parser, ptr %t65, i32 0, i32 1
  %t67 = load ptr, ptr %t66
  %t68 = getelementptr inbounds %Ast, ptr %t67, i32 0, i32 0
  %t69 = load ptr, ptr %t68
  %t70 = load i32, ptr %t38
  %t71 = sext i32 %t70 to i64
  %t72 = getelementptr inbounds %Node, ptr %t69, i64 %t71
  %t73 = getelementptr inbounds %Node, ptr %t72, i32 0, i32 7
  store i32 %t64, ptr %t73
  %t74 = load i32, ptr %t38
  ret i32 %t74
}

define i32 @parseExternDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = load i32, ptr @TK_EXTERN
  %t14 = call ptr @parserExpect(ptr %t12, i32 %t13, ptr @.str.197)
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr @TK_FN
  %t17 = call ptr @parserExpect(ptr %t15, i32 %t16, ptr @.str.198)
  %t18 = load ptr, ptr %t0
  %t19 = load i32, ptr @TK_IDENT
  %t20 = call ptr @parserExpect(ptr %t18, i32 %t19, ptr @.str.199)
  %t21 = alloca ptr
  store ptr %t20, ptr %t21
  %t22 = load ptr, ptr %t0
  %t23 = call i32 @parseParamList(ptr %t22)
  %t24 = alloca i32
  store i32 %t23, ptr %t24
  %t25 = load ptr, ptr %t0
  %t26 = load i32, ptr @TK_COLON
  %t27 = call ptr @parserExpect(ptr %t25, i32 %t26, ptr @.str.200)
  %t28 = load ptr, ptr %t0
  %t29 = call i32 @parseType(ptr %t28)
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = load ptr, ptr %t0
  %t32 = load i32, ptr @TK_SEMICOLON
  %t33 = call ptr @parserExpect(ptr %t31, i32 %t32, ptr @.str.201)
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Parser, ptr %t34, i32 0, i32 1
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr @NK_EXTERN
  %t38 = load i32, ptr %t7
  %t39 = load i32, ptr %t11
  %t40 = call i32 @astAdd(ptr %t36, i32 %t37, i32 %t38, i32 %t39)
  %t41 = alloca i32
  store i32 %t40, ptr %t41
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Parser, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr %t41
  %t46 = load ptr, ptr %t21
  call void @astSetText(ptr %t44, i32 %t45, ptr %t46)
  %t47 = load i32, ptr %t30
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Parser, ptr %t48, i32 0, i32 1
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %Ast, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t41
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Node, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Node, ptr %t55, i32 0, i32 5
  store i32 %t47, ptr %t56
  %t57 = load i32, ptr %t24
  %t58 = load ptr, ptr %t0
  %t59 = getelementptr inbounds %Parser, ptr %t58, i32 0, i32 1
  %t60 = load ptr, ptr %t59
  %t61 = getelementptr inbounds %Ast, ptr %t60, i32 0, i32 0
  %t62 = load ptr, ptr %t61
  %t63 = load i32, ptr %t41
  %t64 = sext i32 %t63 to i64
  %t65 = getelementptr inbounds %Node, ptr %t62, i64 %t64
  %t66 = getelementptr inbounds %Node, ptr %t65, i32 0, i32 6
  store i32 %t57, ptr %t66
  %t67 = load i32, ptr %t41
  ret i32 %t67
}

define i32 @parseStructDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Token, ptr %t4, i32 0, i32 3
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 4
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = load i32, ptr @TK_STRUCT
  %t14 = call ptr @parserExpect(ptr %t12, i32 %t13, ptr @.str.202)
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr @TK_IDENT
  %t17 = call ptr @parserExpect(ptr %t15, i32 %t16, ptr @.str.203)
  %t18 = alloca ptr
  store ptr %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = load i32, ptr @TK_LBRACE
  %t21 = call ptr @parserExpect(ptr %t19, i32 %t20, ptr @.str.204)
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Parser, ptr %t22, i32 0, i32 1
  %t24 = load ptr, ptr %t23
  %t25 = load i32, ptr @NK_STRUCT
  %t26 = load i32, ptr %t7
  %t27 = load i32, ptr %t11
  %t28 = call i32 @astAdd(ptr %t24, i32 %t25, i32 %t26, i32 %t27)
  %t29 = alloca i32
  store i32 %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Parser, ptr %t30, i32 0, i32 1
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t29
  %t34 = load ptr, ptr %t18
  call void @astSetText(ptr %t32, i32 %t33, ptr %t34)
  br label %L0
L0:
  %t35 = alloca i1
  %t36 = load ptr, ptr %t0
  %t37 = call i32 @parserKind(ptr %t36)
  %t38 = load i32, ptr @TK_RBRACE
  %t39 = icmp ne i32 %t37, %t38
  store i1 %t39, ptr %t35
  br i1 %t39, label %L3, label %L4
L3:
  %t40 = load ptr, ptr %t0
  %t41 = call i32 @parserKind(ptr %t40)
  %t42 = load i32, ptr @TK_END
  %t43 = icmp ne i32 %t41, %t42
  store i1 %t43, ptr %t35
  br label %L4
L4:
  %t44 = load i1, ptr %t35
  br i1 %t44, label %L1, label %L2
L1:
  %t45 = load ptr, ptr %t0
  %t46 = load i32, ptr @TK_IDENT
  %t47 = call ptr @parserExpect(ptr %t45, i32 %t46, ptr @.str.205)
  %t48 = alloca ptr
  store ptr %t47, ptr %t48
  %t49 = load ptr, ptr %t0
  %t50 = load i32, ptr @TK_COLON
  %t51 = call ptr @parserExpect(ptr %t49, i32 %t50, ptr @.str.206)
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Parser, ptr %t52, i32 0, i32 1
  %t54 = load ptr, ptr %t53
  %t55 = load i32, ptr @NK_FIELD
  %t56 = load ptr, ptr %t48
  %t57 = getelementptr inbounds %Token, ptr %t56, i32 0, i32 3
  %t58 = load i32, ptr %t57
  %t59 = load ptr, ptr %t48
  %t60 = getelementptr inbounds %Token, ptr %t59, i32 0, i32 4
  %t61 = load i32, ptr %t60
  %t62 = call i32 @astAdd(ptr %t54, i32 %t55, i32 %t58, i32 %t61)
  %t63 = alloca i32
  store i32 %t62, ptr %t63
  %t64 = load ptr, ptr %t0
  %t65 = getelementptr inbounds %Parser, ptr %t64, i32 0, i32 1
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t63
  %t68 = load ptr, ptr %t48
  call void @astSetText(ptr %t66, i32 %t67, ptr %t68)
  %t69 = load ptr, ptr %t0
  %t70 = call i32 @parseType(ptr %t69)
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr inbounds %Parser, ptr %t71, i32 0, i32 1
  %t73 = load ptr, ptr %t72
  %t74 = getelementptr inbounds %Ast, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr %t63
  %t77 = sext i32 %t76 to i64
  %t78 = getelementptr inbounds %Node, ptr %t75, i64 %t77
  %t79 = getelementptr inbounds %Node, ptr %t78, i32 0, i32 5
  store i32 %t70, ptr %t79
  %t80 = load ptr, ptr %t0
  %t81 = getelementptr inbounds %Parser, ptr %t80, i32 0, i32 1
  %t82 = load ptr, ptr %t81
  %t83 = load i32, ptr %t29
  %t84 = load i32, ptr %t63
  call void @astAddItem(ptr %t82, i32 %t83, i32 %t84)
  %t85 = load ptr, ptr %t0
  %t86 = call i32 @parserKind(ptr %t85)
  %t87 = load i32, ptr @TK_COMMA
  %t88 = icmp eq i32 %t86, %t87
  br i1 %t88, label %L5, label %L7
L5:
  %t89 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t89)
  br label %L7
L7:
  %t90 = load i1, ptr @FAILED
  br i1 %t90, label %L8, label %L10
L8:
  br label %L2
L11:
  br label %L10
L10:
  br label %L0
L2:
  %t91 = load ptr, ptr %t0
  %t92 = load i32, ptr @TK_RBRACE
  %t93 = call ptr @parserExpect(ptr %t91, i32 %t92, ptr @.str.207)
  %t94 = load i32, ptr %t29
  ret i32 %t94
}

define i32 @parseImportDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call ptr @parserCurrent(ptr %t1)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Parser, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr @NK_IMPORT
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Token, ptr %t8, i32 0, i32 3
  %t10 = load i32, ptr %t9
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Token, ptr %t11, i32 0, i32 4
  %t13 = load i32, ptr %t12
  %t14 = call i32 @astAdd(ptr %t6, i32 %t7, i32 %t10, i32 %t13)
  %t15 = alloca i32
  store i32 %t14, ptr %t15
  %t16 = sub i32 0, 1
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Parser, ptr %t17, i32 0, i32 1
  %t19 = load ptr, ptr %t18
  %t20 = getelementptr inbounds %Ast, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = load i32, ptr %t15
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr inbounds %Node, ptr %t21, i64 %t23
  %t25 = getelementptr inbounds %Node, ptr %t24, i32 0, i32 8
  store i32 %t16, ptr %t25
  %t26 = load ptr, ptr %t0
  %t27 = load i32, ptr @TK_IMPORT
  %t28 = call ptr @parserExpect(ptr %t26, i32 %t27, ptr @.str.208)
  %t29 = load ptr, ptr %t0
  %t30 = load i32, ptr @TK_LBRACE
  %t31 = call ptr @parserExpect(ptr %t29, i32 %t30, ptr @.str.209)
  br label %L0
L0:
  %t32 = alloca i1
  %t33 = load ptr, ptr %t0
  %t34 = call i32 @parserKind(ptr %t33)
  %t35 = load i32, ptr @TK_RBRACE
  %t36 = icmp ne i32 %t34, %t35
  store i1 %t36, ptr %t32
  br i1 %t36, label %L3, label %L4
L3:
  %t37 = load ptr, ptr %t0
  %t38 = call i32 @parserKind(ptr %t37)
  %t39 = load i32, ptr @TK_END
  %t40 = icmp ne i32 %t38, %t39
  store i1 %t40, ptr %t32
  br label %L4
L4:
  %t41 = load i1, ptr %t32
  br i1 %t41, label %L1, label %L2
L1:
  %t42 = load ptr, ptr %t0
  %t43 = load i32, ptr @TK_IDENT
  %t44 = call ptr @parserExpect(ptr %t42, i32 %t43, ptr @.str.210)
  %t45 = alloca ptr
  store ptr %t44, ptr %t45
  %t46 = load i1, ptr @FAILED
  br i1 %t46, label %L5, label %L7
L5:
  br label %L2
L8:
  br label %L7
L7:
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr inbounds %Parser, ptr %t47, i32 0, i32 1
  %t49 = load ptr, ptr %t48
  %t50 = load i32, ptr @NK_IMPORTNAME
  %t51 = load ptr, ptr %t45
  %t52 = getelementptr inbounds %Token, ptr %t51, i32 0, i32 3
  %t53 = load i32, ptr %t52
  %t54 = load ptr, ptr %t45
  %t55 = getelementptr inbounds %Token, ptr %t54, i32 0, i32 4
  %t56 = load i32, ptr %t55
  %t57 = call i32 @astAdd(ptr %t49, i32 %t50, i32 %t53, i32 %t56)
  %t58 = alloca i32
  store i32 %t57, ptr %t58
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Parser, ptr %t59, i32 0, i32 1
  %t61 = load ptr, ptr %t60
  %t62 = load i32, ptr %t58
  %t63 = load ptr, ptr %t45
  call void @astSetText(ptr %t61, i32 %t62, ptr %t63)
  %t64 = load ptr, ptr %t0
  %t65 = call i32 @parserKind(ptr %t64)
  %t66 = load i32, ptr @TK_AS
  %t67 = icmp eq i32 %t65, %t66
  br i1 %t67, label %L9, label %L11
L9:
  %t68 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t68)
  %t69 = load ptr, ptr %t0
  %t70 = load i32, ptr @TK_IDENT
  %t71 = call ptr @parserExpect(ptr %t69, i32 %t70, ptr @.str.211)
  %t72 = alloca ptr
  store ptr %t71, ptr %t72
  %t73 = load ptr, ptr %t0
  %t74 = getelementptr inbounds %Parser, ptr %t73, i32 0, i32 1
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr @NK_IDENT
  %t77 = load ptr, ptr %t72
  %t78 = getelementptr inbounds %Token, ptr %t77, i32 0, i32 3
  %t79 = load i32, ptr %t78
  %t80 = load ptr, ptr %t72
  %t81 = getelementptr inbounds %Token, ptr %t80, i32 0, i32 4
  %t82 = load i32, ptr %t81
  %t83 = call i32 @astAdd(ptr %t75, i32 %t76, i32 %t79, i32 %t82)
  %t84 = alloca i32
  store i32 %t83, ptr %t84
  %t85 = load ptr, ptr %t0
  %t86 = getelementptr inbounds %Parser, ptr %t85, i32 0, i32 1
  %t87 = load ptr, ptr %t86
  %t88 = load i32, ptr %t84
  %t89 = load ptr, ptr %t72
  call void @astSetText(ptr %t87, i32 %t88, ptr %t89)
  %t90 = load i32, ptr %t84
  %t91 = load ptr, ptr %t0
  %t92 = getelementptr inbounds %Parser, ptr %t91, i32 0, i32 1
  %t93 = load ptr, ptr %t92
  %t94 = getelementptr inbounds %Ast, ptr %t93, i32 0, i32 0
  %t95 = load ptr, ptr %t94
  %t96 = load i32, ptr %t58
  %t97 = sext i32 %t96 to i64
  %t98 = getelementptr inbounds %Node, ptr %t95, i64 %t97
  %t99 = getelementptr inbounds %Node, ptr %t98, i32 0, i32 5
  store i32 %t90, ptr %t99
  br label %L11
L11:
  %t100 = load ptr, ptr %t0
  %t101 = getelementptr inbounds %Parser, ptr %t100, i32 0, i32 1
  %t102 = load ptr, ptr %t101
  %t103 = load i32, ptr %t15
  %t104 = load i32, ptr %t58
  call void @astAddItem(ptr %t102, i32 %t103, i32 %t104)
  %t105 = load ptr, ptr %t0
  %t106 = call i32 @parserKind(ptr %t105)
  %t107 = load i32, ptr @TK_COMMA
  %t108 = icmp ne i32 %t106, %t107
  br i1 %t108, label %L12, label %L14
L12:
  br label %L2
L15:
  br label %L14
L14:
  %t109 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t109)
  br label %L0
L2:
  %t110 = load ptr, ptr %t0
  %t111 = load i32, ptr @TK_RBRACE
  %t112 = call ptr @parserExpect(ptr %t110, i32 %t111, ptr @.str.212)
  %t113 = load i1, ptr @FAILED
  br i1 %t113, label %L16, label %L18
L16:
  br label %L19
L19:
  %t114 = alloca i1
  %t115 = alloca i1
  %t116 = load ptr, ptr %t0
  %t117 = call i32 @parserKind(ptr %t116)
  %t118 = load i32, ptr @TK_SEMICOLON
  %t119 = icmp ne i32 %t117, %t118
  store i1 %t119, ptr %t115
  br i1 %t119, label %L22, label %L23
L22:
  %t120 = load ptr, ptr %t0
  %t121 = call i32 @parserKind(ptr %t120)
  %t122 = load i32, ptr @TK_END
  %t123 = icmp ne i32 %t121, %t122
  store i1 %t123, ptr %t115
  br label %L23
L23:
  %t124 = load i1, ptr %t115
  store i1 %t124, ptr %t114
  br i1 %t124, label %L24, label %L25
L24:
  %t125 = load ptr, ptr %t0
  %t126 = call i32 @parserKind(ptr %t125)
  %t127 = call i1 @startsStatement(i32 %t126)
  %t128 = xor i1 %t127, true
  store i1 %t128, ptr %t114
  br label %L25
L25:
  %t129 = load i1, ptr %t114
  br i1 %t129, label %L20, label %L21
L20:
  %t130 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t130)
  br label %L19
L21:
  %t131 = load ptr, ptr %t0
  %t132 = call i32 @parserKind(ptr %t131)
  %t133 = load i32, ptr @TK_SEMICOLON
  %t134 = icmp eq i32 %t132, %t133
  br i1 %t134, label %L26, label %L28
L26:
  %t135 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t135)
  br label %L28
L28:
  %t136 = load i32, ptr %t15
  ret i32 %t136
L18:
  %t137 = load ptr, ptr %t0
  %t138 = call ptr @parserCurrent(ptr %t137)
  %t139 = alloca ptr
  store ptr %t138, ptr %t139
  %t140 = alloca i1
  %t141 = load ptr, ptr %t139
  %t142 = getelementptr inbounds %Token, ptr %t141, i32 0, i32 0
  %t143 = load i32, ptr %t142
  %t144 = load i32, ptr @TK_IDENT
  %t145 = icmp eq i32 %t143, %t144
  store i1 %t145, ptr %t140
  br i1 %t145, label %L29, label %L30
L29:
  %t146 = load ptr, ptr %t139
  %t147 = getelementptr inbounds %Token, ptr %t146, i32 0, i32 1
  %t148 = load ptr, ptr %t147
  %t149 = call i1 @textEquals(ptr %t148, ptr @.str.213)
  store i1 %t149, ptr %t140
  br label %L30
L30:
  %t150 = load i1, ptr %t140
  br i1 %t150, label %L31, label %L32
L31:
  %t151 = load ptr, ptr %t0
  call void @parserAdvance(ptr %t151)
  br label %L33
L32:
  %t152 = load ptr, ptr %t0
  call void @parserFail(ptr %t152, ptr @.str.214)
  br label %L33
L33:
  %t153 = load ptr, ptr %t0
  %t154 = load i32, ptr @TK_STRING
  %t155 = call ptr @parserExpect(ptr %t153, i32 %t154, ptr @.str.215)
  %t156 = alloca ptr
  store ptr %t155, ptr %t156
  %t157 = load ptr, ptr %t0
  %t158 = getelementptr inbounds %Parser, ptr %t157, i32 0, i32 1
  %t159 = load ptr, ptr %t158
  %t160 = load i32, ptr %t15
  %t161 = load ptr, ptr %t156
  call void @astSetText(ptr %t159, i32 %t160, ptr %t161)
  %t162 = load ptr, ptr %t0
  %t163 = load i32, ptr @TK_SEMICOLON
  %t164 = call ptr @parserExpect(ptr %t162, i32 %t163, ptr @.str.216)
  %t165 = load i32, ptr %t15
  ret i32 %t165
}

define i32 @parseExportDecl(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = load i32, ptr @TK_EXPORT
  %t3 = call ptr @parserExpect(ptr %t1, i32 %t2, ptr @.str.217)
  %t4 = load ptr, ptr %t0
  %t5 = call i32 @parserKind(ptr %t4)
  %t6 = alloca i32
  store i32 %t5, ptr %t6
  %t7 = load i32, ptr @NO_NODE
  %t8 = alloca i32
  store i32 %t7, ptr %t8
  %t9 = load i32, ptr %t6
  %t10 = load i32, ptr @TK_FN
  %t11 = icmp eq i32 %t9, %t10
  br i1 %t11, label %L0, label %L1
L0:
  %t12 = load ptr, ptr %t0
  %t13 = call i32 @parseFuncDecl(ptr %t12)
  store i32 %t13, ptr %t8
  br label %L2
L1:
  %t14 = load i32, ptr %t6
  %t15 = load i32, ptr @TK_EXTERN
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L3, label %L4
L3:
  %t17 = load ptr, ptr %t0
  %t18 = call i32 @parseExternDecl(ptr %t17)
  store i32 %t18, ptr %t8
  br label %L5
L4:
  %t19 = load i32, ptr %t6
  %t20 = load i32, ptr @TK_STRUCT
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L6, label %L7
L6:
  %t22 = load ptr, ptr %t0
  %t23 = call i32 @parseStructDecl(ptr %t22)
  store i32 %t23, ptr %t8
  br label %L8
L7:
  %t24 = load i32, ptr %t6
  %t25 = load i32, ptr @TK_LET
  %t26 = icmp eq i32 %t24, %t25
  br i1 %t26, label %L9, label %L10
L9:
  %t27 = load ptr, ptr %t0
  %t28 = call i32 @parseVarDecl(ptr %t27)
  store i32 %t28, ptr %t8
  br label %L11
L10:
  %t29 = load ptr, ptr %t0
  call void @parserFail(ptr %t29, ptr @.str.218)
  %t30 = load ptr, ptr %t0
  %t31 = call i32 @parserErrorNode(ptr %t30)
  ret i32 %t31
L11:
  br label %L8
L8:
  br label %L5
L5:
  br label %L2
L2:
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Parser, ptr %t32, i32 0, i32 1
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr inbounds %Ast, ptr %t34, i32 0, i32 0
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t8
  %t38 = sext i32 %t37 to i64
  %t39 = getelementptr inbounds %Node, ptr %t36, i64 %t38
  %t40 = getelementptr inbounds %Node, ptr %t39, i32 0, i32 13
  store i1 true, ptr %t40
  %t41 = load i32, ptr %t8
  ret i32 %t41
}

define void @parseModuleInto(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  br label %L0
L0:
  %t2 = load ptr, ptr %t0
  %t3 = call i32 @parserKind(ptr %t2)
  %t4 = load i32, ptr @TK_END
  %t5 = icmp ne i32 %t3, %t4
  br i1 %t5, label %L1, label %L2
L1:
  %t6 = load ptr, ptr %t0
  %t7 = call i32 @parseStatementRecovering(ptr %t6)
  %t8 = alloca i32
  store i32 %t7, ptr %t8
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr @NO_NODE
  %t11 = icmp ne i32 %t9, %t10
  br i1 %t11, label %L3, label %L5
L3:
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %Parser, ptr %t12, i32 0, i32 1
  %t14 = load ptr, ptr %t13
  %t15 = load i32, ptr %t1
  %t16 = load i32, ptr %t8
  call void @astAddItem(ptr %t14, i32 %t15, i32 %t16)
  br label %L5
L5:
  br label %L0
L2:
  ret void
}

define %Type @typeMake(i32 %p0, i32 %p1) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i32, ptr %t0
  %t3 = insertvalue %Type undef, i32 %t2, 0
  %t4 = load i32, ptr %t1
  %t5 = insertvalue %Type %t3, i32 %t4, 1
  %t6 = call ptr @nullText()
  %t7 = insertvalue %Type %t5, ptr %t6, 2
  ret %Type %t7
}

define %Type @typeStruct(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i32, ptr @TY_STRUCT
  %t3 = insertvalue %Type undef, i32 %t2, 0
  %t4 = load i32, ptr %t1
  %t5 = insertvalue %Type %t3, i32 %t4, 1
  %t6 = load ptr, ptr %t0
  %t7 = insertvalue %Type %t5, ptr %t6, 2
  ret %Type %t7
}

define i1 @typeIsPointer(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t2 = load i32, ptr %t1
  %t3 = icmp sgt i32 %t2, 0
  ret i1 %t3
}

define i1 @typeIsStruct(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load %Type, ptr %t0
  %t3 = call i1 @typeIsPointer(%Type %t2)
  %t4 = xor i1 %t3, true
  store i1 %t4, ptr %t1
  br i1 %t4, label %L0, label %L1
L0:
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = load i32, ptr @TY_STRUCT
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t1
  br label %L1
L1:
  %t9 = load i1, ptr %t1
  ret i1 %t9
}

define i1 @typeIsVoid(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load %Type, ptr %t0
  %t3 = call i1 @typeIsPointer(%Type %t2)
  %t4 = xor i1 %t3, true
  store i1 %t4, ptr %t1
  br i1 %t4, label %L0, label %L1
L0:
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = load i32, ptr @TY_VOID
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t1
  br label %L1
L1:
  %t9 = load i1, ptr %t1
  ret i1 %t9
}

define i1 @typeIsBool(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load %Type, ptr %t0
  %t3 = call i1 @typeIsPointer(%Type %t2)
  %t4 = xor i1 %t3, true
  store i1 %t4, ptr %t1
  br i1 %t4, label %L0, label %L1
L0:
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = load i32, ptr @TY_BOOL
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t1
  br label %L1
L1:
  %t9 = load i1, ptr %t1
  ret i1 %t9
}

define i1 @typeIsInteger(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsPointer(%Type %t1)
  br i1 %t2, label %L0, label %L2
L0:
  ret i1 false
L2:
  %t3 = alloca i1
  %t4 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_I8
  %t7 = icmp sge i32 %t5, %t6
  store i1 %t7, ptr %t3
  br i1 %t7, label %L3, label %L4
L3:
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr @TY_U64
  %t11 = icmp sle i32 %t9, %t10
  store i1 %t11, ptr %t3
  br label %L4
L4:
  %t12 = load i1, ptr %t3
  ret i1 %t12
}

define i1 @typeIsFloat(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsPointer(%Type %t1)
  br i1 %t2, label %L0, label %L2
L0:
  ret i1 false
L2:
  %t3 = alloca i1
  %t4 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_F32
  %t7 = icmp eq i32 %t5, %t6
  store i1 %t7, ptr %t3
  br i1 %t7, label %L4, label %L3
L3:
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr @TY_F64
  %t11 = icmp eq i32 %t9, %t10
  store i1 %t11, ptr %t3
  br label %L4
L4:
  %t12 = load i1, ptr %t3
  ret i1 %t12
}

define i1 @typeIsNumeric(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca i1
  %t2 = load %Type, ptr %t0
  %t3 = call i1 @typeIsInteger(%Type %t2)
  store i1 %t3, ptr %t1
  br i1 %t3, label %L1, label %L0
L0:
  %t4 = load %Type, ptr %t0
  %t5 = call i1 @typeIsFloat(%Type %t4)
  store i1 %t5, ptr %t1
  br label %L1
L1:
  %t6 = load i1, ptr %t1
  ret i1 %t6
}

define i1 @typeIsSigned(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsInteger(%Type %t1)
  %t3 = xor i1 %t2, true
  br i1 %t3, label %L0, label %L2
L0:
  ret i1 false
L2:
  %t4 = alloca i1
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = load i32, ptr @TY_U8
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t4
  br i1 %t8, label %L4, label %L3
L3:
  %t9 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t10 = load i32, ptr %t9
  %t11 = load i32, ptr @TY_U16
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t4
  br label %L4
L4:
  %t13 = load i1, ptr %t4
  br i1 %t13, label %L5, label %L7
L5:
  ret i1 false
L7:
  %t14 = alloca i1
  %t15 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t16 = load i32, ptr %t15
  %t17 = load i32, ptr @TY_U32
  %t18 = icmp ne i32 %t16, %t17
  store i1 %t18, ptr %t14
  br i1 %t18, label %L8, label %L9
L8:
  %t19 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t20 = load i32, ptr %t19
  %t21 = load i32, ptr @TY_U64
  %t22 = icmp ne i32 %t20, %t21
  store i1 %t22, ptr %t14
  br label %L9
L9:
  %t23 = load i1, ptr %t14
  ret i1 %t23
}

define i32 @typeBitWidth(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca i1
  %t2 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t3 = load i32, ptr %t2
  %t4 = load i32, ptr @TY_I8
  %t5 = icmp eq i32 %t3, %t4
  store i1 %t5, ptr %t1
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t7 = load i32, ptr %t6
  %t8 = load i32, ptr @TY_U8
  %t9 = icmp eq i32 %t7, %t8
  store i1 %t9, ptr %t1
  br label %L1
L1:
  %t10 = load i1, ptr %t1
  br i1 %t10, label %L2, label %L4
L2:
  ret i32 8
L4:
  %t11 = alloca i1
  %t12 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @TY_I16
  %t15 = icmp eq i32 %t13, %t14
  store i1 %t15, ptr %t11
  br i1 %t15, label %L6, label %L5
L5:
  %t16 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t17 = load i32, ptr %t16
  %t18 = load i32, ptr @TY_U16
  %t19 = icmp eq i32 %t17, %t18
  store i1 %t19, ptr %t11
  br label %L6
L6:
  %t20 = load i1, ptr %t11
  br i1 %t20, label %L7, label %L9
L7:
  ret i32 16
L9:
  %t21 = alloca i1
  %t22 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t23 = load i32, ptr %t22
  %t24 = load i32, ptr @TY_I32
  %t25 = icmp eq i32 %t23, %t24
  store i1 %t25, ptr %t21
  br i1 %t25, label %L11, label %L10
L10:
  %t26 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t27 = load i32, ptr %t26
  %t28 = load i32, ptr @TY_U32
  %t29 = icmp eq i32 %t27, %t28
  store i1 %t29, ptr %t21
  br label %L11
L11:
  %t30 = load i1, ptr %t21
  br i1 %t30, label %L12, label %L14
L12:
  ret i32 32
L14:
  %t31 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t32 = load i32, ptr %t31
  %t33 = load i32, ptr @TY_F32
  %t34 = icmp eq i32 %t32, %t33
  br i1 %t34, label %L15, label %L17
L15:
  ret i32 32
L17:
  %t35 = alloca i1
  %t36 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t37 = load i32, ptr %t36
  %t38 = load i32, ptr @TY_I64
  %t39 = icmp eq i32 %t37, %t38
  store i1 %t39, ptr %t35
  br i1 %t39, label %L19, label %L18
L18:
  %t40 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t41 = load i32, ptr %t40
  %t42 = load i32, ptr @TY_U64
  %t43 = icmp eq i32 %t41, %t42
  store i1 %t43, ptr %t35
  br label %L19
L19:
  %t44 = load i1, ptr %t35
  br i1 %t44, label %L20, label %L22
L20:
  ret i32 64
L22:
  %t45 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t46 = load i32, ptr %t45
  %t47 = load i32, ptr @TY_F64
  %t48 = icmp eq i32 %t46, %t47
  br i1 %t48, label %L23, label %L25
L23:
  ret i32 64
L25:
  ret i32 0
}

define %Type @typePointee(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t2 = load i32, ptr %t1
  %t3 = insertvalue %Type undef, i32 %t2, 0
  %t4 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t5 = load i32, ptr %t4
  %t6 = sub i32 %t5, 1
  %t7 = insertvalue %Type %t3, i32 %t6, 1
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 2
  %t9 = load ptr, ptr %t8
  %t10 = insertvalue %Type %t7, ptr %t9, 2
  ret %Type %t10
}

define %Type @typePointerTo(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t2 = load i32, ptr %t1
  %t3 = insertvalue %Type undef, i32 %t2, 0
  %t4 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t5 = load i32, ptr %t4
  %t6 = add i32 %t5, 1
  %t7 = insertvalue %Type %t3, i32 %t6, 1
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 2
  %t9 = load ptr, ptr %t8
  %t10 = insertvalue %Type %t7, ptr %t9, 2
  ret %Type %t10
}

define i1 @typeEquals(%Type %p0, %Type %p1) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = alloca i1
  %t3 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t4 = load i32, ptr %t3
  %t5 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = icmp ne i32 %t4, %t6
  store i1 %t7, ptr %t2
  br i1 %t7, label %L1, label %L0
L0:
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t9 = load i32, ptr %t8
  %t10 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 1
  %t11 = load i32, ptr %t10
  %t12 = icmp ne i32 %t9, %t11
  store i1 %t12, ptr %t2
  br label %L1
L1:
  %t13 = load i1, ptr %t2
  br i1 %t13, label %L2, label %L4
L2:
  ret i1 false
L4:
  %t14 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t15 = load i32, ptr %t14
  %t16 = load i32, ptr @TY_STRUCT
  %t17 = icmp ne i32 %t15, %t16
  br i1 %t17, label %L5, label %L7
L5:
  ret i1 true
L7:
  %t18 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 2
  %t19 = load ptr, ptr %t18
  %t20 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 2
  %t21 = load ptr, ptr %t20
  %t22 = call i1 @textEquals(ptr %t19, ptr %t21)
  ret i1 %t22
}

define ptr @typeBaseName(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t2 = load i32, ptr %t1
  %t3 = load i32, ptr @TY_I8
  %t4 = icmp eq i32 %t2, %t3
  br i1 %t4, label %L0, label %L2
L0:
  ret ptr @.str.219
L2:
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t6 = load i32, ptr %t5
  %t7 = load i32, ptr @TY_U8
  %t8 = icmp eq i32 %t6, %t7
  br i1 %t8, label %L3, label %L5
L3:
  ret ptr @.str.220
L5:
  %t9 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t10 = load i32, ptr %t9
  %t11 = load i32, ptr @TY_I16
  %t12 = icmp eq i32 %t10, %t11
  br i1 %t12, label %L6, label %L8
L6:
  ret ptr @.str.221
L8:
  %t13 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t14 = load i32, ptr %t13
  %t15 = load i32, ptr @TY_U16
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L9, label %L11
L9:
  ret ptr @.str.222
L11:
  %t17 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t18 = load i32, ptr %t17
  %t19 = load i32, ptr @TY_I32
  %t20 = icmp eq i32 %t18, %t19
  br i1 %t20, label %L12, label %L14
L12:
  ret ptr @.str.223
L14:
  %t21 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t22 = load i32, ptr %t21
  %t23 = load i32, ptr @TY_U32
  %t24 = icmp eq i32 %t22, %t23
  br i1 %t24, label %L15, label %L17
L15:
  ret ptr @.str.224
L17:
  %t25 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t26 = load i32, ptr %t25
  %t27 = load i32, ptr @TY_I64
  %t28 = icmp eq i32 %t26, %t27
  br i1 %t28, label %L18, label %L20
L18:
  ret ptr @.str.225
L20:
  %t29 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t30 = load i32, ptr %t29
  %t31 = load i32, ptr @TY_U64
  %t32 = icmp eq i32 %t30, %t31
  br i1 %t32, label %L21, label %L23
L21:
  ret ptr @.str.226
L23:
  %t33 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t34 = load i32, ptr %t33
  %t35 = load i32, ptr @TY_F32
  %t36 = icmp eq i32 %t34, %t35
  br i1 %t36, label %L24, label %L26
L24:
  ret ptr @.str.227
L26:
  %t37 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t38 = load i32, ptr %t37
  %t39 = load i32, ptr @TY_F64
  %t40 = icmp eq i32 %t38, %t39
  br i1 %t40, label %L27, label %L29
L27:
  ret ptr @.str.228
L29:
  %t41 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t42 = load i32, ptr %t41
  %t43 = load i32, ptr @TY_BOOL
  %t44 = icmp eq i32 %t42, %t43
  br i1 %t44, label %L30, label %L32
L30:
  ret ptr @.str.229
L32:
  %t45 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t46 = load i32, ptr %t45
  %t47 = load i32, ptr @TY_VOID
  %t48 = icmp eq i32 %t46, %t47
  br i1 %t48, label %L33, label %L35
L33:
  ret ptr @.str.230
L35:
  %t49 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t50 = load i32, ptr %t49
  %t51 = load i32, ptr @TY_STRUCT
  %t52 = icmp eq i32 %t50, %t51
  br i1 %t52, label %L36, label %L38
L36:
  %t53 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 2
  %t54 = load ptr, ptr %t53
  ret ptr %t54
L38:
  ret ptr @.str.231
}

define ptr @typeToText(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = alloca i32
  store i32 0, ptr %t3
  br label %L0
L0:
  %t4 = load i32, ptr %t3
  %t5 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = icmp slt i32 %t4, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t2
  call void @bufPush(ptr %t8, i8 42)
  %t9 = load i32, ptr %t3
  %t10 = add i32 %t9, 1
  store i32 %t10, ptr %t3
  br label %L0
L2:
  %t11 = load ptr, ptr %t2
  %t12 = load %Type, ptr %t0
  %t13 = call ptr @typeBaseName(%Type %t12)
  call void @bufAdd(ptr %t11, ptr %t13)
  %t14 = load ptr, ptr %t2
  %t15 = call ptr @bufTake(ptr %t14)
  ret ptr %t15
}

define i32 @typeKindFromName(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i1 @textEquals(ptr %t1, ptr @.str.232)
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load i32, ptr @TY_I8
  ret i32 %t3
L2:
  %t4 = load ptr, ptr %t0
  %t5 = call i1 @textEquals(ptr %t4, ptr @.str.233)
  br i1 %t5, label %L3, label %L5
L3:
  %t6 = load i32, ptr @TY_U8
  ret i32 %t6
L5:
  %t7 = load ptr, ptr %t0
  %t8 = call i1 @textEquals(ptr %t7, ptr @.str.234)
  br i1 %t8, label %L6, label %L8
L6:
  %t9 = load i32, ptr @TY_I16
  ret i32 %t9
L8:
  %t10 = load ptr, ptr %t0
  %t11 = call i1 @textEquals(ptr %t10, ptr @.str.235)
  br i1 %t11, label %L9, label %L11
L9:
  %t12 = load i32, ptr @TY_U16
  ret i32 %t12
L11:
  %t13 = load ptr, ptr %t0
  %t14 = call i1 @textEquals(ptr %t13, ptr @.str.236)
  br i1 %t14, label %L12, label %L14
L12:
  %t15 = load i32, ptr @TY_I32
  ret i32 %t15
L14:
  %t16 = load ptr, ptr %t0
  %t17 = call i1 @textEquals(ptr %t16, ptr @.str.237)
  br i1 %t17, label %L15, label %L17
L15:
  %t18 = load i32, ptr @TY_U32
  ret i32 %t18
L17:
  %t19 = load ptr, ptr %t0
  %t20 = call i1 @textEquals(ptr %t19, ptr @.str.238)
  br i1 %t20, label %L18, label %L20
L18:
  %t21 = load i32, ptr @TY_I64
  ret i32 %t21
L20:
  %t22 = load ptr, ptr %t0
  %t23 = call i1 @textEquals(ptr %t22, ptr @.str.239)
  br i1 %t23, label %L21, label %L23
L21:
  %t24 = load i32, ptr @TY_U64
  ret i32 %t24
L23:
  %t25 = load ptr, ptr %t0
  %t26 = call i1 @textEquals(ptr %t25, ptr @.str.240)
  br i1 %t26, label %L24, label %L26
L24:
  %t27 = load i32, ptr @TY_U64
  ret i32 %t27
L26:
  %t28 = load ptr, ptr %t0
  %t29 = call i1 @textEquals(ptr %t28, ptr @.str.241)
  br i1 %t29, label %L27, label %L29
L27:
  %t30 = load i32, ptr @TY_F32
  ret i32 %t30
L29:
  %t31 = load ptr, ptr %t0
  %t32 = call i1 @textEquals(ptr %t31, ptr @.str.242)
  br i1 %t32, label %L30, label %L32
L30:
  %t33 = load i32, ptr @TY_F64
  ret i32 %t33
L32:
  %t34 = load ptr, ptr %t0
  %t35 = call i1 @textEquals(ptr %t34, ptr @.str.243)
  br i1 %t35, label %L33, label %L35
L33:
  %t36 = load i32, ptr @TY_BOOL
  ret i32 %t36
L35:
  %t37 = load ptr, ptr %t0
  %t38 = call i1 @textEquals(ptr %t37, ptr @.str.244)
  br i1 %t38, label %L36, label %L38
L36:
  %t39 = load i32, ptr @TY_VOID
  ret i32 %t39
L38:
  %t40 = load i32, ptr @TY_NONE
  ret i32 %t40
}

define i64 @unsignedMax(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = icmp sge i32 %t1, 64
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load i64, ptr @MAX_U64
  ret i64 %t3
L2:
  %t4 = sext i32 1 to i64
  %t5 = load i32, ptr %t0
  %t6 = sext i32 %t5 to i64
  %t7 = shl i64 %t4, %t6
  %t8 = sext i32 1 to i64
  %t9 = sub i64 %t7, %t8
  ret i64 %t9
}

define i64 @signedMax(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = icmp sge i32 %t1, 64
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load i64, ptr @MAX_U64
  %t4 = sext i32 2 to i64
  %t5 = udiv i64 %t3, %t4
  ret i64 %t5
L2:
  %t6 = sext i32 1 to i64
  %t7 = load i32, ptr %t0
  %t8 = sub i32 %t7, 1
  %t9 = sext i32 %t8 to i64
  %t10 = shl i64 %t6, %t9
  %t11 = sext i32 1 to i64
  %t12 = sub i64 %t10, %t11
  ret i64 %t12
}

define i1 @fitsIn(i64 %p0, i1 %p1, %Type %p2) {
entry:
  %t0 = alloca i64
  store i64 %p0, ptr %t0
  %t1 = alloca i1
  store i1 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = load %Type, ptr %t2
  %t4 = call i32 @typeBitWidth(%Type %t3)
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load %Type, ptr %t2
  %t7 = call i1 @typeIsSigned(%Type %t6)
  %t8 = xor i1 %t7, true
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = load i1, ptr %t1
  br i1 %t9, label %L3, label %L5
L3:
  ret i1 false
L5:
  %t10 = load i64, ptr %t0
  %t11 = load i32, ptr %t5
  %t12 = call i64 @unsignedMax(i32 %t11)
  %t13 = icmp ule i64 %t10, %t12
  ret i1 %t13
L2:
  %t14 = load i32, ptr %t5
  %t15 = call i64 @signedMax(i32 %t14)
  %t16 = alloca i64
  store i64 %t15, ptr %t16
  %t17 = load i1, ptr %t1
  br i1 %t17, label %L6, label %L8
L6:
  %t18 = load i64, ptr %t0
  %t19 = load i64, ptr %t16
  %t20 = sext i32 1 to i64
  %t21 = add i64 %t19, %t20
  %t22 = icmp ule i64 %t18, %t21
  ret i1 %t22
L8:
  %t23 = load i64, ptr %t0
  %t24 = load i64, ptr %t16
  %t25 = icmp ule i64 %t23, %t24
  ret i1 %t25
}

define i64 @parseMagnitude(ptr %p0, i64 %p1, i64 %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i64
  store i64 %p1, ptr %t1
  %t2 = alloca i64
  store i64 %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = sext i32 0 to i64
  %t5 = alloca i64
  store i64 %t4, ptr %t5
  %t6 = load i64, ptr %t1
  %t7 = alloca i64
  store i64 %t6, ptr %t7
  %t8 = load ptr, ptr %t3
  store i1 false, ptr %t8
  br label %L0
L0:
  %t9 = load i64, ptr %t7
  %t10 = load i64, ptr %t2
  %t11 = icmp slt i64 %t9, %t10
  br i1 %t11, label %L1, label %L2
L1:
  %t12 = load ptr, ptr %t0
  %t13 = load i64, ptr %t7
  %t14 = getelementptr inbounds i8, ptr %t12, i64 %t13
  %t15 = load i8, ptr %t14
  %t16 = sext i8 %t15 to i64
  %t17 = sext i8 48 to i64
  %t18 = sub i64 %t16, %t17
  %t19 = alloca i64
  store i64 %t18, ptr %t19
  %t20 = load i64, ptr %t5
  %t21 = load i64, ptr @MAX_U64
  %t22 = load i64, ptr %t19
  %t23 = sub i64 %t21, %t22
  %t24 = sext i32 10 to i64
  %t25 = udiv i64 %t23, %t24
  %t26 = icmp ugt i64 %t20, %t25
  br i1 %t26, label %L3, label %L5
L3:
  %t27 = load ptr, ptr %t3
  store i1 true, ptr %t27
  %t28 = sext i32 0 to i64
  ret i64 %t28
L5:
  %t29 = load i64, ptr %t5
  %t30 = sext i32 10 to i64
  %t31 = mul i64 %t29, %t30
  %t32 = load i64, ptr %t19
  %t33 = add i64 %t31, %t32
  store i64 %t33, ptr %t5
  %t34 = load i64, ptr %t7
  %t35 = sext i32 1 to i64
  %t36 = add i64 %t34, %t35
  store i64 %t36, ptr %t7
  br label %L0
L2:
  %t37 = load i64, ptr %t5
  ret i64 %t37
}

define ptr @structTableNew() {
entry:
  %t0 = call ptr @malloc(i64 16)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  %t3 = getelementptr inbounds %StructTable, ptr %t2, i32 0, i32 2
  store i32 16, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = getelementptr inbounds %StructTable, ptr %t4, i32 0, i32 1
  store i32 0, ptr %t5
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %StructTable, ptr %t6, i32 0, i32 2
  %t8 = load i32, ptr %t7
  %t9 = sext i32 %t8 to i64
  %t10 = mul i64 24, %t9
  %t11 = call ptr @malloc(i64 %t10)
  %t12 = load ptr, ptr %t1
  %t13 = getelementptr inbounds %StructTable, ptr %t12, i32 0, i32 0
  store ptr %t11, ptr %t13
  %t14 = load ptr, ptr %t1
  ret ptr %t14
}

define i32 @structIndexOf(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %StructTable, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = icmp slt i32 %t3, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %StructTable, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t2
  %t12 = sext i32 %t11 to i64
  %t13 = getelementptr inbounds %StructLayout, ptr %t10, i64 %t12
  %t14 = getelementptr inbounds %StructLayout, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  %t16 = load ptr, ptr %t1
  %t17 = call i1 @textEquals(ptr %t15, ptr %t16)
  br i1 %t17, label %L3, label %L5
L3:
  %t18 = load i32, ptr %t2
  ret i32 %t18
L5:
  %t19 = load i32, ptr %t2
  %t20 = add i32 %t19, 1
  store i32 %t20, ptr %t2
  br label %L0
L2:
  ret i32 -1
}

define i32 @structTableAdd(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %StructTable, ptr %t2, i32 0, i32 1
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %StructTable, ptr %t5, i32 0, i32 2
  %t7 = load i32, ptr %t6
  %t8 = icmp eq i32 %t4, %t7
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %StructTable, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = mul i32 %t11, 2
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %StructTable, ptr %t13, i32 0, i32 2
  store i32 %t12, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %StructTable, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %StructTable, ptr %t18, i32 0, i32 2
  %t20 = load i32, ptr %t19
  %t21 = sext i32 %t20 to i64
  %t22 = mul i64 24, %t21
  %t23 = call ptr @realloc(ptr %t17, i64 %t22)
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %StructTable, ptr %t24, i32 0, i32 0
  store ptr %t23, ptr %t25
  br label %L2
L2:
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %StructTable, ptr %t26, i32 0, i32 1
  %t28 = load i32, ptr %t27
  %t29 = alloca i32
  store i32 %t28, ptr %t29
  %t30 = load ptr, ptr %t1
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %StructTable, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t29
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %StructLayout, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %StructLayout, ptr %t36, i32 0, i32 0
  store ptr %t30, ptr %t37
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %StructTable, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t29
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %StructLayout, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %StructLayout, ptr %t43, i32 0, i32 2
  store i32 0, ptr %t44
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %StructTable, ptr %t45, i32 0, i32 0
  %t47 = load ptr, ptr %t46
  %t48 = load i32, ptr %t29
  %t49 = sext i32 %t48 to i64
  %t50 = getelementptr inbounds %StructLayout, ptr %t47, i64 %t49
  %t51 = getelementptr inbounds %StructLayout, ptr %t50, i32 0, i32 3
  store i32 4, ptr %t51
  %t52 = sext i32 4 to i64
  %t53 = mul i64 24, %t52
  %t54 = call ptr @malloc(i64 %t53)
  %t55 = load ptr, ptr %t0
  %t56 = getelementptr inbounds %StructTable, ptr %t55, i32 0, i32 0
  %t57 = load ptr, ptr %t56
  %t58 = load i32, ptr %t29
  %t59 = sext i32 %t58 to i64
  %t60 = getelementptr inbounds %StructLayout, ptr %t57, i64 %t59
  %t61 = getelementptr inbounds %StructLayout, ptr %t60, i32 0, i32 1
  store ptr %t54, ptr %t61
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %StructTable, ptr %t62, i32 0, i32 1
  %t64 = load i32, ptr %t63
  %t65 = add i32 %t64, 1
  %t66 = load ptr, ptr %t0
  %t67 = getelementptr inbounds %StructTable, ptr %t66, i32 0, i32 1
  store i32 %t65, ptr %t67
  %t68 = load i32, ptr %t29
  ret i32 %t68
}

define i32 @structFieldIndex(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i32
  store i32 0, ptr %t3
  br label %L0
L0:
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %StructTable, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %StructLayout, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %StructLayout, ptr %t10, i32 0, i32 2
  %t12 = load i32, ptr %t11
  %t13 = icmp slt i32 %t4, %t12
  br i1 %t13, label %L1, label %L2
L1:
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %StructTable, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = load i32, ptr %t1
  %t18 = sext i32 %t17 to i64
  %t19 = getelementptr inbounds %StructLayout, ptr %t16, i64 %t18
  %t20 = getelementptr inbounds %StructLayout, ptr %t19, i32 0, i32 1
  %t21 = load ptr, ptr %t20
  %t22 = load i32, ptr %t3
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr inbounds %FieldDef, ptr %t21, i64 %t23
  %t25 = getelementptr inbounds %FieldDef, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load ptr, ptr %t2
  %t28 = call i1 @textEquals(ptr %t26, ptr %t27)
  br i1 %t28, label %L3, label %L5
L3:
  %t29 = load i32, ptr %t3
  ret i32 %t29
L5:
  %t30 = load i32, ptr %t3
  %t31 = add i32 %t30, 1
  store i32 %t31, ptr %t3
  br label %L0
L2:
  ret i32 -1
}

define void @structAddField(ptr %p0, i32 %p1, ptr %p2, %Type %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca %Type
  store %Type %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %StructTable, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %StructLayout, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %StructLayout, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %StructTable, ptr %t12, i32 0, i32 0
  %t14 = load ptr, ptr %t13
  %t15 = load i32, ptr %t1
  %t16 = sext i32 %t15 to i64
  %t17 = getelementptr inbounds %StructLayout, ptr %t14, i64 %t16
  %t18 = getelementptr inbounds %StructLayout, ptr %t17, i32 0, i32 3
  %t19 = load i32, ptr %t18
  %t20 = icmp eq i32 %t11, %t19
  br i1 %t20, label %L0, label %L2
L0:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %StructTable, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = load i32, ptr %t1
  %t25 = sext i32 %t24 to i64
  %t26 = getelementptr inbounds %StructLayout, ptr %t23, i64 %t25
  %t27 = getelementptr inbounds %StructLayout, ptr %t26, i32 0, i32 3
  %t28 = load i32, ptr %t27
  %t29 = mul i32 %t28, 2
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %StructTable, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t1
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %StructLayout, ptr %t32, i64 %t34
  %t36 = getelementptr inbounds %StructLayout, ptr %t35, i32 0, i32 3
  store i32 %t29, ptr %t36
  %t37 = load ptr, ptr %t0
  %t38 = getelementptr inbounds %StructTable, ptr %t37, i32 0, i32 0
  %t39 = load ptr, ptr %t38
  %t40 = load i32, ptr %t1
  %t41 = sext i32 %t40 to i64
  %t42 = getelementptr inbounds %StructLayout, ptr %t39, i64 %t41
  %t43 = getelementptr inbounds %StructLayout, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %StructTable, ptr %t45, i32 0, i32 0
  %t47 = load ptr, ptr %t46
  %t48 = load i32, ptr %t1
  %t49 = sext i32 %t48 to i64
  %t50 = getelementptr inbounds %StructLayout, ptr %t47, i64 %t49
  %t51 = getelementptr inbounds %StructLayout, ptr %t50, i32 0, i32 3
  %t52 = load i32, ptr %t51
  %t53 = sext i32 %t52 to i64
  %t54 = mul i64 24, %t53
  %t55 = call ptr @realloc(ptr %t44, i64 %t54)
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %StructTable, ptr %t56, i32 0, i32 0
  %t58 = load ptr, ptr %t57
  %t59 = load i32, ptr %t1
  %t60 = sext i32 %t59 to i64
  %t61 = getelementptr inbounds %StructLayout, ptr %t58, i64 %t60
  %t62 = getelementptr inbounds %StructLayout, ptr %t61, i32 0, i32 1
  store ptr %t55, ptr %t62
  br label %L2
L2:
  %t63 = load ptr, ptr %t0
  %t64 = getelementptr inbounds %StructTable, ptr %t63, i32 0, i32 0
  %t65 = load ptr, ptr %t64
  %t66 = load i32, ptr %t1
  %t67 = sext i32 %t66 to i64
  %t68 = getelementptr inbounds %StructLayout, ptr %t65, i64 %t67
  %t69 = getelementptr inbounds %StructLayout, ptr %t68, i32 0, i32 2
  %t70 = load i32, ptr %t69
  %t71 = alloca i32
  store i32 %t70, ptr %t71
  %t72 = load ptr, ptr %t2
  %t73 = load ptr, ptr %t0
  %t74 = getelementptr inbounds %StructTable, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr %t1
  %t77 = sext i32 %t76 to i64
  %t78 = getelementptr inbounds %StructLayout, ptr %t75, i64 %t77
  %t79 = getelementptr inbounds %StructLayout, ptr %t78, i32 0, i32 1
  %t80 = load ptr, ptr %t79
  %t81 = load i32, ptr %t71
  %t82 = sext i32 %t81 to i64
  %t83 = getelementptr inbounds %FieldDef, ptr %t80, i64 %t82
  %t84 = getelementptr inbounds %FieldDef, ptr %t83, i32 0, i32 0
  store ptr %t72, ptr %t84
  %t85 = load %Type, ptr %t3
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr inbounds %StructTable, ptr %t86, i32 0, i32 0
  %t88 = load ptr, ptr %t87
  %t89 = load i32, ptr %t1
  %t90 = sext i32 %t89 to i64
  %t91 = getelementptr inbounds %StructLayout, ptr %t88, i64 %t90
  %t92 = getelementptr inbounds %StructLayout, ptr %t91, i32 0, i32 1
  %t93 = load ptr, ptr %t92
  %t94 = load i32, ptr %t71
  %t95 = sext i32 %t94 to i64
  %t96 = getelementptr inbounds %FieldDef, ptr %t93, i64 %t95
  %t97 = getelementptr inbounds %FieldDef, ptr %t96, i32 0, i32 1
  store %Type %t85, ptr %t97
  %t98 = load i32, ptr %t71
  %t99 = add i32 %t98, 1
  %t100 = load ptr, ptr %t0
  %t101 = getelementptr inbounds %StructTable, ptr %t100, i32 0, i32 0
  %t102 = load ptr, ptr %t101
  %t103 = load i32, ptr %t1
  %t104 = sext i32 %t103 to i64
  %t105 = getelementptr inbounds %StructLayout, ptr %t102, i64 %t104
  %t106 = getelementptr inbounds %StructLayout, ptr %t105, i32 0, i32 2
  store i32 %t99, ptr %t106
  ret void
}

define ptr @symbolTableNew() {
entry:
  %t0 = call ptr @malloc(i64 32)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 2
  store i32 64, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = getelementptr inbounds %SymbolTable, ptr %t4, i32 0, i32 1
  store i32 0, ptr %t5
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %SymbolTable, ptr %t6, i32 0, i32 2
  %t8 = load i32, ptr %t7
  %t9 = sext i32 %t8 to i64
  %t10 = mul i64 56, %t9
  %t11 = call ptr @malloc(i64 %t10)
  %t12 = load ptr, ptr %t1
  %t13 = getelementptr inbounds %SymbolTable, ptr %t12, i32 0, i32 0
  store ptr %t11, ptr %t13
  %t14 = load ptr, ptr %t1
  %t15 = getelementptr inbounds %SymbolTable, ptr %t14, i32 0, i32 5
  store i32 16, ptr %t15
  %t16 = load ptr, ptr %t1
  %t17 = getelementptr inbounds %SymbolTable, ptr %t16, i32 0, i32 4
  store i32 0, ptr %t17
  %t18 = load ptr, ptr %t1
  %t19 = getelementptr inbounds %SymbolTable, ptr %t18, i32 0, i32 5
  %t20 = load i32, ptr %t19
  %t21 = sext i32 %t20 to i64
  %t22 = mul i64 4, %t21
  %t23 = call ptr @malloc(i64 %t22)
  %t24 = load ptr, ptr %t1
  %t25 = getelementptr inbounds %SymbolTable, ptr %t24, i32 0, i32 3
  store ptr %t23, ptr %t25
  %t26 = load ptr, ptr %t1
  call void @symbolEnterScope(ptr %t26)
  %t27 = load ptr, ptr %t1
  ret ptr %t27
}

define void @symbolEnterScope(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %SymbolTable, ptr %t1, i32 0, i32 4
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %SymbolTable, ptr %t4, i32 0, i32 5
  %t6 = load i32, ptr %t5
  %t7 = icmp eq i32 %t3, %t6
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %SymbolTable, ptr %t8, i32 0, i32 5
  %t10 = load i32, ptr %t9
  %t11 = mul i32 %t10, 2
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %SymbolTable, ptr %t12, i32 0, i32 5
  store i32 %t11, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %SymbolTable, ptr %t14, i32 0, i32 3
  %t16 = load ptr, ptr %t15
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %SymbolTable, ptr %t17, i32 0, i32 5
  %t19 = load i32, ptr %t18
  %t20 = sext i32 %t19 to i64
  %t21 = mul i64 4, %t20
  %t22 = call ptr @realloc(ptr %t16, i64 %t21)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %SymbolTable, ptr %t23, i32 0, i32 3
  store ptr %t22, ptr %t24
  br label %L2
L2:
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %SymbolTable, ptr %t25, i32 0, i32 1
  %t27 = load i32, ptr %t26
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %SymbolTable, ptr %t28, i32 0, i32 3
  %t30 = load ptr, ptr %t29
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %SymbolTable, ptr %t31, i32 0, i32 4
  %t33 = load i32, ptr %t32
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds i32, ptr %t30, i64 %t34
  store i32 %t27, ptr %t35
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %SymbolTable, ptr %t36, i32 0, i32 4
  %t38 = load i32, ptr %t37
  %t39 = add i32 %t38, 1
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr inbounds %SymbolTable, ptr %t40, i32 0, i32 4
  store i32 %t39, ptr %t41
  ret void
}

define void @symbolExitScope(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %SymbolTable, ptr %t1, i32 0, i32 4
  %t3 = load i32, ptr %t2
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %L0, label %L2
L0:
  ret void
L2:
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %SymbolTable, ptr %t5, i32 0, i32 4
  %t7 = load i32, ptr %t6
  %t8 = sub i32 %t7, 1
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %SymbolTable, ptr %t9, i32 0, i32 4
  store i32 %t8, ptr %t10
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %SymbolTable, ptr %t11, i32 0, i32 3
  %t13 = load ptr, ptr %t12
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %SymbolTable, ptr %t14, i32 0, i32 4
  %t16 = load i32, ptr %t15
  %t17 = sext i32 %t16 to i64
  %t18 = getelementptr inbounds i32, ptr %t13, i64 %t17
  %t19 = load i32, ptr %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %SymbolTable, ptr %t20, i32 0, i32 1
  store i32 %t19, ptr %t21
  ret void
}

define void @symbolTruncateScopes(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  br label %L0
L0:
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 4
  %t4 = load i32, ptr %t3
  %t5 = load i32, ptr %t1
  %t6 = icmp sgt i32 %t4, %t5
  br i1 %t6, label %L1, label %L2
L1:
  %t7 = load ptr, ptr %t0
  call void @symbolExitScope(ptr %t7)
  br label %L0
L2:
  ret void
}

define i32 @symbolFind(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 1
  %t4 = load i32, ptr %t3
  %t5 = sub i32 %t4, 1
  %t6 = alloca i32
  store i32 %t5, ptr %t6
  br label %L0
L0:
  %t7 = load i32, ptr %t6
  %t8 = icmp sge i32 %t7, 0
  br i1 %t8, label %L1, label %L2
L1:
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %SymbolTable, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t6
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Symbol, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Symbol, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = load ptr, ptr %t1
  %t18 = call i1 @textEquals(ptr %t16, ptr %t17)
  br i1 %t18, label %L3, label %L5
L3:
  %t19 = load i32, ptr %t6
  ret i32 %t19
L5:
  %t20 = load i32, ptr %t6
  %t21 = sub i32 %t20, 1
  store i32 %t21, ptr %t6
  br label %L0
L2:
  ret i32 -1
}

define i32 @symbolFindInScope(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 3
  %t4 = load ptr, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %SymbolTable, ptr %t5, i32 0, i32 4
  %t7 = load i32, ptr %t6
  %t8 = sub i32 %t7, 1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds i32, ptr %t4, i64 %t9
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %SymbolTable, ptr %t13, i32 0, i32 1
  %t15 = load i32, ptr %t14
  %t16 = sub i32 %t15, 1
  %t17 = alloca i32
  store i32 %t16, ptr %t17
  br label %L0
L0:
  %t18 = load i32, ptr %t17
  %t19 = load i32, ptr %t12
  %t20 = icmp sge i32 %t18, %t19
  br i1 %t20, label %L1, label %L2
L1:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %SymbolTable, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = load i32, ptr %t17
  %t25 = sext i32 %t24 to i64
  %t26 = getelementptr inbounds %Symbol, ptr %t23, i64 %t25
  %t27 = getelementptr inbounds %Symbol, ptr %t26, i32 0, i32 0
  %t28 = load ptr, ptr %t27
  %t29 = load ptr, ptr %t1
  %t30 = call i1 @textEquals(ptr %t28, ptr %t29)
  br i1 %t30, label %L3, label %L5
L3:
  %t31 = load i32, ptr %t17
  ret i32 %t31
L5:
  %t32 = load i32, ptr %t17
  %t33 = sub i32 %t32, 1
  store i32 %t33, ptr %t17
  br label %L0
L2:
  ret i32 -1
}

define void @symbolDeclare(ptr %p0, ptr %p1, i32 %p2, %Type %p3, ptr %p4, i32 %p5, i32 %p6, i32 %p7) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca %Type
  store %Type %p3, ptr %t3
  %t4 = alloca ptr
  store ptr %p4, ptr %t4
  %t5 = alloca i32
  store i32 %p5, ptr %t5
  %t6 = alloca i32
  store i32 %p6, ptr %t6
  %t7 = alloca i32
  store i32 %p7, ptr %t7
  %t8 = load ptr, ptr %t0
  %t9 = load ptr, ptr %t1
  %t10 = call i32 @symbolFindInScope(ptr %t8, ptr %t9)
  %t11 = icmp sge i32 %t10, 0
  br i1 %t11, label %L0, label %L2
L0:
  %t12 = call ptr @bufNew()
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  %t14 = load ptr, ptr %t13
  call void @bufAdd(ptr %t14, ptr @.str.245)
  %t15 = load ptr, ptr %t13
  %t16 = load ptr, ptr %t1
  call void @bufAdd(ptr %t15, ptr %t16)
  %t17 = load ptr, ptr %t13
  call void @bufAdd(ptr %t17, ptr @.str.246)
  %t18 = load i32, ptr %t6
  %t19 = load i32, ptr %t7
  %t20 = load ptr, ptr %t13
  %t21 = getelementptr inbounds %Buf, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  call void @report(i32 %t18, i32 %t19, ptr %t22)
  ret void
L2:
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %SymbolTable, ptr %t23, i32 0, i32 1
  %t25 = load i32, ptr %t24
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %SymbolTable, ptr %t26, i32 0, i32 2
  %t28 = load i32, ptr %t27
  %t29 = icmp eq i32 %t25, %t28
  br i1 %t29, label %L3, label %L5
L3:
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %SymbolTable, ptr %t30, i32 0, i32 2
  %t32 = load i32, ptr %t31
  %t33 = mul i32 %t32, 2
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %SymbolTable, ptr %t34, i32 0, i32 2
  store i32 %t33, ptr %t35
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %SymbolTable, ptr %t36, i32 0, i32 0
  %t38 = load ptr, ptr %t37
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %SymbolTable, ptr %t39, i32 0, i32 2
  %t41 = load i32, ptr %t40
  %t42 = sext i32 %t41 to i64
  %t43 = mul i64 56, %t42
  %t44 = call ptr @realloc(ptr %t38, i64 %t43)
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %SymbolTable, ptr %t45, i32 0, i32 0
  store ptr %t44, ptr %t46
  br label %L5
L5:
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr inbounds %SymbolTable, ptr %t47, i32 0, i32 1
  %t49 = load i32, ptr %t48
  %t50 = alloca i32
  store i32 %t49, ptr %t50
  %t51 = load ptr, ptr %t1
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %SymbolTable, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = load i32, ptr %t50
  %t56 = sext i32 %t55 to i64
  %t57 = getelementptr inbounds %Symbol, ptr %t54, i64 %t56
  %t58 = getelementptr inbounds %Symbol, ptr %t57, i32 0, i32 0
  store ptr %t51, ptr %t58
  %t59 = load i32, ptr %t2
  %t60 = load ptr, ptr %t0
  %t61 = getelementptr inbounds %SymbolTable, ptr %t60, i32 0, i32 0
  %t62 = load ptr, ptr %t61
  %t63 = load i32, ptr %t50
  %t64 = sext i32 %t63 to i64
  %t65 = getelementptr inbounds %Symbol, ptr %t62, i64 %t64
  %t66 = getelementptr inbounds %Symbol, ptr %t65, i32 0, i32 1
  store i32 %t59, ptr %t66
  %t67 = load %Type, ptr %t3
  %t68 = load ptr, ptr %t0
  %t69 = getelementptr inbounds %SymbolTable, ptr %t68, i32 0, i32 0
  %t70 = load ptr, ptr %t69
  %t71 = load i32, ptr %t50
  %t72 = sext i32 %t71 to i64
  %t73 = getelementptr inbounds %Symbol, ptr %t70, i64 %t72
  %t74 = getelementptr inbounds %Symbol, ptr %t73, i32 0, i32 2
  store %Type %t67, ptr %t74
  %t75 = load ptr, ptr %t4
  %t76 = load ptr, ptr %t0
  %t77 = getelementptr inbounds %SymbolTable, ptr %t76, i32 0, i32 0
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr %t50
  %t80 = sext i32 %t79 to i64
  %t81 = getelementptr inbounds %Symbol, ptr %t78, i64 %t80
  %t82 = getelementptr inbounds %Symbol, ptr %t81, i32 0, i32 3
  store ptr %t75, ptr %t82
  %t83 = load i32, ptr %t5
  %t84 = load ptr, ptr %t0
  %t85 = getelementptr inbounds %SymbolTable, ptr %t84, i32 0, i32 0
  %t86 = load ptr, ptr %t85
  %t87 = load i32, ptr %t50
  %t88 = sext i32 %t87 to i64
  %t89 = getelementptr inbounds %Symbol, ptr %t86, i64 %t88
  %t90 = getelementptr inbounds %Symbol, ptr %t89, i32 0, i32 4
  store i32 %t83, ptr %t90
  %t91 = call ptr @nullText()
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr inbounds %SymbolTable, ptr %t92, i32 0, i32 0
  %t94 = load ptr, ptr %t93
  %t95 = load i32, ptr %t50
  %t96 = sext i32 %t95 to i64
  %t97 = getelementptr inbounds %Symbol, ptr %t94, i64 %t96
  %t98 = getelementptr inbounds %Symbol, ptr %t97, i32 0, i32 5
  store ptr %t91, ptr %t98
  %t99 = load i32, ptr %t50
  %t100 = add i32 %t99, 1
  %t101 = load ptr, ptr %t0
  %t102 = getelementptr inbounds %SymbolTable, ptr %t101, i32 0, i32 1
  store i32 %t100, ptr %t102
  ret void
}

define void @declareSymbolCopy(ptr %p0, %Symbol %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Symbol
  store %Symbol %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 1
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %SymbolTable, ptr %t5, i32 0, i32 2
  %t7 = load i32, ptr %t6
  %t8 = icmp eq i32 %t4, %t7
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %SymbolTable, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = mul i32 %t11, 2
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %SymbolTable, ptr %t13, i32 0, i32 2
  store i32 %t12, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %SymbolTable, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %SymbolTable, ptr %t18, i32 0, i32 2
  %t20 = load i32, ptr %t19
  %t21 = sext i32 %t20 to i64
  %t22 = mul i64 56, %t21
  %t23 = call ptr @realloc(ptr %t17, i64 %t22)
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %SymbolTable, ptr %t24, i32 0, i32 0
  store ptr %t23, ptr %t25
  br label %L2
L2:
  %t26 = load %Symbol, ptr %t1
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %SymbolTable, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %SymbolTable, ptr %t30, i32 0, i32 1
  %t32 = load i32, ptr %t31
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Symbol, ptr %t29, i64 %t33
  store %Symbol %t26, ptr %t34
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %SymbolTable, ptr %t35, i32 0, i32 1
  %t37 = load i32, ptr %t36
  %t38 = add i32 %t37, 1
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %SymbolTable, ptr %t39, i32 0, i32 1
  store i32 %t38, ptr %t40
  ret void
}

define i32 @moduleAdd(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load i32, ptr @MODULE_COUNT
  %t3 = load i32, ptr @MODULE_CAPACITY
  %t4 = icmp eq i32 %t2, %t3
  br i1 %t4, label %L0, label %L2
L0:
  %t5 = load i32, ptr @MODULE_CAPACITY
  %t6 = icmp eq i32 %t5, 0
  br i1 %t6, label %L3, label %L4
L3:
  store i32 8, ptr @MODULE_CAPACITY
  %t7 = sext i32 8 to i64
  %t8 = mul i64 16, %t7
  %t9 = call ptr @malloc(i64 %t8)
  store ptr %t9, ptr @MODULES
  br label %L5
L4:
  %t10 = load i32, ptr @MODULE_CAPACITY
  %t11 = mul i32 %t10, 2
  store i32 %t11, ptr @MODULE_CAPACITY
  %t12 = load ptr, ptr @MODULES
  %t13 = load i32, ptr @MODULE_CAPACITY
  %t14 = sext i32 %t13 to i64
  %t15 = mul i64 16, %t14
  %t16 = call ptr @realloc(ptr %t12, i64 %t15)
  store ptr %t16, ptr @MODULES
  br label %L5
L5:
  br label %L2
L2:
  %t17 = load i32, ptr @MODULE_COUNT
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr @MODULES
  %t21 = load i32, ptr %t18
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Module, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Module, ptr %t23, i32 0, i32 0
  store ptr %t19, ptr %t24
  %t25 = load ptr, ptr %t1
  %t26 = load ptr, ptr @MODULES
  %t27 = load i32, ptr %t18
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Module, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Module, ptr %t29, i32 0, i32 1
  store ptr %t25, ptr %t30
  %t31 = load i32, ptr %t18
  %t32 = add i32 %t31, 1
  store i32 %t32, ptr @MODULE_COUNT
  %t33 = load i32, ptr %t18
  ret i32 %t33
}

define i32 @moduleFind(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 0, ptr %t1
  br label %L0
L0:
  %t2 = load i32, ptr %t1
  %t3 = load i32, ptr @MODULE_COUNT
  %t4 = icmp slt i32 %t2, %t3
  br i1 %t4, label %L1, label %L2
L1:
  %t5 = load ptr, ptr @MODULES
  %t6 = load i32, ptr %t1
  %t7 = sext i32 %t6 to i64
  %t8 = getelementptr inbounds %Module, ptr %t5, i64 %t7
  %t9 = getelementptr inbounds %Module, ptr %t8, i32 0, i32 1
  %t10 = load ptr, ptr %t9
  %t11 = load ptr, ptr %t0
  %t12 = call i1 @textEquals(ptr %t10, ptr %t11)
  br i1 %t12, label %L3, label %L5
L3:
  %t13 = load i32, ptr %t1
  ret i32 %t13
L5:
  %t14 = load i32, ptr %t1
  %t15 = add i32 %t14, 1
  store i32 %t15, ptr %t1
  br label %L0
L2:
  ret i32 -1
}

define ptr @modulePath(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load ptr, ptr @MODULES
  %t2 = load i32, ptr %t0
  %t3 = sext i32 %t2 to i64
  %t4 = getelementptr inbounds %Module, ptr %t1, i64 %t3
  %t5 = getelementptr inbounds %Module, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  ret ptr %t6
}

define i1 @textEndsWith(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call i64 @strlen(ptr %t2)
  %t4 = alloca i64
  store i64 %t3, ptr %t4
  %t5 = load ptr, ptr %t1
  %t6 = call i64 @strlen(ptr %t5)
  %t7 = alloca i64
  store i64 %t6, ptr %t7
  %t8 = load i64, ptr %t7
  %t9 = load i64, ptr %t4
  %t10 = icmp sgt i64 %t8, %t9
  br i1 %t10, label %L0, label %L2
L0:
  ret i1 false
L2:
  %t11 = load ptr, ptr %t0
  %t12 = load i64, ptr %t4
  %t13 = load i64, ptr %t7
  %t14 = sub i64 %t12, %t13
  %t15 = getelementptr inbounds i8, ptr %t11, i64 %t14
  %t16 = load ptr, ptr %t1
  %t17 = call i1 @textEquals(ptr %t15, ptr %t16)
  ret i1 %t17
}

define ptr @directoryOf(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i64 @strlen(ptr %t1)
  %t3 = alloca i64
  store i64 %t2, ptr %t3
  %t4 = sext i32 0 to i64
  %t5 = alloca i64
  store i64 %t4, ptr %t5
  %t6 = sext i32 0 to i64
  %t7 = alloca i64
  store i64 %t6, ptr %t7
  br label %L0
L0:
  %t8 = load i64, ptr %t7
  %t9 = load i64, ptr %t3
  %t10 = icmp slt i64 %t8, %t9
  br i1 %t10, label %L1, label %L2
L1:
  %t11 = load ptr, ptr %t0
  %t12 = load i64, ptr %t7
  %t13 = getelementptr inbounds i8, ptr %t11, i64 %t12
  %t14 = load i8, ptr %t13
  %t15 = icmp eq i8 %t14, 47
  br i1 %t15, label %L3, label %L5
L3:
  %t16 = load i64, ptr %t7
  %t17 = sext i32 1 to i64
  %t18 = add i64 %t16, %t17
  store i64 %t18, ptr %t5
  br label %L5
L5:
  %t19 = load i64, ptr %t7
  %t20 = sext i32 1 to i64
  %t21 = add i64 %t19, %t20
  store i64 %t21, ptr %t7
  br label %L0
L2:
  %t22 = load ptr, ptr %t0
  %t23 = sext i32 0 to i64
  %t24 = load i64, ptr %t5
  %t25 = call ptr @textSlice(ptr %t22, i64 %t23, i64 %t24)
  ret ptr %t25
}

define ptr @resolveImportPath(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = call ptr @bufNew()
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = sext i32 0 to i64
  %t6 = getelementptr inbounds i8, ptr %t4, i64 %t5
  %t7 = load i8, ptr %t6
  %t8 = icmp ne i8 %t7, 47
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = load ptr, ptr %t3
  %t10 = load ptr, ptr %t0
  %t11 = call ptr @directoryOf(ptr %t10)
  call void @bufAdd(ptr %t9, ptr %t11)
  br label %L2
L2:
  %t12 = load ptr, ptr %t1
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  br label %L3
L3:
  %t14 = alloca i1
  %t15 = load ptr, ptr %t13
  %t16 = sext i32 0 to i64
  %t17 = getelementptr inbounds i8, ptr %t15, i64 %t16
  %t18 = load i8, ptr %t17
  %t19 = icmp eq i8 %t18, 46
  store i1 %t19, ptr %t14
  br i1 %t19, label %L6, label %L7
L6:
  %t20 = load ptr, ptr %t13
  %t21 = sext i32 1 to i64
  %t22 = getelementptr inbounds i8, ptr %t20, i64 %t21
  %t23 = load i8, ptr %t22
  %t24 = icmp eq i8 %t23, 47
  store i1 %t24, ptr %t14
  br label %L7
L7:
  %t25 = load i1, ptr %t14
  br i1 %t25, label %L4, label %L5
L4:
  %t26 = load ptr, ptr %t13
  %t27 = sext i32 2 to i64
  %t28 = getelementptr inbounds i8, ptr %t26, i64 %t27
  store ptr %t28, ptr %t13
  br label %L3
L5:
  %t29 = load ptr, ptr %t3
  %t30 = load ptr, ptr %t13
  call void @bufAdd(ptr %t29, ptr %t30)
  %t31 = load ptr, ptr %t13
  %t32 = call i1 @textEndsWith(ptr %t31, ptr @.str.247)
  %t33 = xor i1 %t32, true
  br i1 %t33, label %L8, label %L10
L8:
  %t34 = load ptr, ptr %t3
  call void @bufAdd(ptr %t34, ptr @.str.248)
  br label %L10
L10:
  %t35 = load ptr, ptr %t3
  %t36 = call ptr @bufTake(ptr %t35)
  ret ptr %t36
}

define ptr @nameSetNew() {
entry:
  %t0 = call ptr @malloc(i64 16)
  %t1 = alloca ptr
  store ptr %t0, ptr %t1
  %t2 = load ptr, ptr %t1
  %t3 = getelementptr inbounds %NameSet, ptr %t2, i32 0, i32 2
  store i32 64, ptr %t3
  %t4 = load ptr, ptr %t1
  %t5 = getelementptr inbounds %NameSet, ptr %t4, i32 0, i32 1
  store i32 0, ptr %t5
  %t6 = load ptr, ptr %t1
  %t7 = getelementptr inbounds %NameSet, ptr %t6, i32 0, i32 2
  %t8 = load i32, ptr %t7
  %t9 = sext i32 %t8 to i64
  %t10 = mul i64 8, %t9
  %t11 = call ptr @malloc(i64 %t10)
  %t12 = load ptr, ptr %t1
  %t13 = getelementptr inbounds %NameSet, ptr %t12, i32 0, i32 0
  store ptr %t11, ptr %t13
  %t14 = load ptr, ptr %t1
  ret ptr %t14
}

define i1 @nameSetHas(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %NameSet, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = icmp slt i32 %t3, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %NameSet, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t2
  %t12 = sext i32 %t11 to i64
  %t13 = getelementptr inbounds ptr, ptr %t10, i64 %t12
  %t14 = load ptr, ptr %t13
  %t15 = load ptr, ptr %t1
  %t16 = call i1 @textEquals(ptr %t14, ptr %t15)
  br i1 %t16, label %L3, label %L5
L3:
  ret i1 true
L5:
  %t17 = load i32, ptr %t2
  %t18 = add i32 %t17, 1
  store i32 %t18, ptr %t2
  br label %L0
L2:
  ret i1 false
}

define void @nameSetAdd(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %NameSet, ptr %t2, i32 0, i32 1
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %NameSet, ptr %t5, i32 0, i32 2
  %t7 = load i32, ptr %t6
  %t8 = icmp eq i32 %t4, %t7
  br i1 %t8, label %L0, label %L2
L0:
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %NameSet, ptr %t9, i32 0, i32 2
  %t11 = load i32, ptr %t10
  %t12 = mul i32 %t11, 2
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %NameSet, ptr %t13, i32 0, i32 2
  store i32 %t12, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %NameSet, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %NameSet, ptr %t18, i32 0, i32 2
  %t20 = load i32, ptr %t19
  %t21 = sext i32 %t20 to i64
  %t22 = mul i64 8, %t21
  %t23 = call ptr @realloc(ptr %t17, i64 %t22)
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %NameSet, ptr %t24, i32 0, i32 0
  store ptr %t23, ptr %t25
  br label %L2
L2:
  %t26 = load ptr, ptr %t1
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %NameSet, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %NameSet, ptr %t30, i32 0, i32 1
  %t32 = load i32, ptr %t31
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds ptr, ptr %t29, i64 %t33
  store ptr %t26, ptr %t34
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %NameSet, ptr %t35, i32 0, i32 1
  %t37 = load i32, ptr %t36
  %t38 = add i32 %t37, 1
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %NameSet, ptr %t39, i32 0, i32 1
  store i32 %t38, ptr %t40
  ret void
}

define ptr @claimName(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t2
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t0
  %t6 = load ptr, ptr %t4
  %t7 = call i1 @nameSetHas(ptr %t5, ptr %t6)
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = call ptr @bufNew()
  %t9 = alloca ptr
  store ptr %t8, ptr %t9
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t1
  %t12 = call ptr @modulePath(i32 %t11)
  %t13 = call ptr @stemOf(ptr %t12)
  call void @bufAdd(ptr %t10, ptr %t13)
  %t14 = load ptr, ptr %t9
  call void @bufPush(ptr %t14, i8 46)
  %t15 = load ptr, ptr %t9
  %t16 = load ptr, ptr %t2
  call void @bufAdd(ptr %t15, ptr %t16)
  %t17 = load ptr, ptr %t9
  %t18 = call ptr @bufTake(ptr %t17)
  store ptr %t18, ptr %t4
  br label %L2
L2:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t4
  %t21 = call i1 @nameSetHas(ptr %t19, ptr %t20)
  br i1 %t21, label %L3, label %L5
L3:
  %t22 = call ptr @bufNew()
  %t23 = alloca ptr
  store ptr %t22, ptr %t23
  %t24 = load ptr, ptr %t23
  %t25 = load i32, ptr %t1
  %t26 = call ptr @modulePath(i32 %t25)
  %t27 = call ptr @stemOf(ptr %t26)
  call void @bufAdd(ptr %t24, ptr %t27)
  %t28 = load ptr, ptr %t23
  %t29 = load i32, ptr %t1
  %t30 = sext i32 %t29 to i64
  call void @bufAddInt(ptr %t28, i64 %t30)
  %t31 = load ptr, ptr %t23
  call void @bufPush(ptr %t31, i8 46)
  %t32 = load ptr, ptr %t23
  %t33 = load ptr, ptr %t2
  call void @bufAdd(ptr %t32, ptr %t33)
  %t34 = load ptr, ptr %t23
  %t35 = call ptr @bufTake(ptr %t34)
  store ptr %t35, ptr %t4
  br label %L5
L5:
  %t36 = load ptr, ptr %t0
  %t37 = load ptr, ptr %t4
  call void @nameSetAdd(ptr %t36, ptr %t37)
  %t38 = load ptr, ptr %t4
  ret ptr %t38
}

define i1 @isValueDecl(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i1
  %t2 = alloca i1
  %t3 = load i32, ptr %t0
  %t4 = load i32, ptr @NK_FN
  %t5 = icmp eq i32 %t3, %t4
  store i1 %t5, ptr %t2
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = load i32, ptr %t0
  %t7 = load i32, ptr @NK_EXTERN
  %t8 = icmp eq i32 %t6, %t7
  store i1 %t8, ptr %t2
  br label %L1
L1:
  %t9 = load i1, ptr %t2
  store i1 %t9, ptr %t1
  br i1 %t9, label %L3, label %L2
L2:
  %t10 = load i32, ptr %t0
  %t11 = load i32, ptr @NK_VARDECL
  %t12 = icmp eq i32 %t10, %t11
  store i1 %t12, ptr %t1
  br label %L3
L3:
  %t13 = load i1, ptr %t1
  ret i1 %t13
}

define i32 @findTopLevel(ptr %p0, i32 %p1, i32 %p2, ptr %p3, i1 %p4) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = alloca i1
  store i1 %p4, ptr %t4
  %t5 = alloca i32
  store i32 0, ptr %t5
  br label %L0
L0:
  %t6 = load i32, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Analyzer, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = getelementptr inbounds %Ast, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t1
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Node, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Node, ptr %t14, i32 0, i32 10
  %t16 = load i32, ptr %t15
  %t17 = icmp slt i32 %t6, %t16
  br i1 %t17, label %L1, label %L2
L1:
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %Analyzer, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t1
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 9
  %t27 = load ptr, ptr %t26
  %t28 = load i32, ptr %t5
  %t29 = sext i32 %t28 to i64
  %t30 = getelementptr inbounds i32, ptr %t27, i64 %t29
  %t31 = load i32, ptr %t30
  %t32 = alloca i32
  store i32 %t31, ptr %t32
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t32
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 0
  %t42 = load i32, ptr %t41
  %t43 = alloca i32
  store i32 %t42, ptr %t43
  %t44 = alloca i1
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %Analyzer, ptr %t45, i32 0, i32 0
  %t47 = load ptr, ptr %t46
  %t48 = getelementptr inbounds %Ast, ptr %t47, i32 0, i32 0
  %t49 = load ptr, ptr %t48
  %t50 = load i32, ptr %t32
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds %Node, ptr %t49, i64 %t51
  %t53 = getelementptr inbounds %Node, ptr %t52, i32 0, i32 12
  %t54 = load i32, ptr %t53
  %t55 = load i32, ptr %t2
  %t56 = icmp eq i32 %t54, %t55
  store i1 %t56, ptr %t44
  br i1 %t56, label %L3, label %L4
L3:
  %t57 = load ptr, ptr %t0
  %t58 = getelementptr inbounds %Analyzer, ptr %t57, i32 0, i32 0
  %t59 = load ptr, ptr %t58
  %t60 = getelementptr inbounds %Ast, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = load i32, ptr %t32
  %t63 = sext i32 %t62 to i64
  %t64 = getelementptr inbounds %Node, ptr %t61, i64 %t63
  %t65 = getelementptr inbounds %Node, ptr %t64, i32 0, i32 3
  %t66 = load ptr, ptr %t65
  %t67 = load ptr, ptr %t3
  %t68 = call i1 @textEquals(ptr %t66, ptr %t67)
  store i1 %t68, ptr %t44
  br label %L4
L4:
  %t69 = load i1, ptr %t44
  br i1 %t69, label %L5, label %L7
L5:
  %t70 = alloca i1
  %t71 = load i1, ptr %t4
  store i1 %t71, ptr %t70
  br i1 %t71, label %L8, label %L9
L8:
  %t72 = load i32, ptr %t43
  %t73 = load i32, ptr @NK_STRUCT
  %t74 = icmp eq i32 %t72, %t73
  store i1 %t74, ptr %t70
  br label %L9
L9:
  %t75 = load i1, ptr %t70
  br i1 %t75, label %L10, label %L12
L10:
  %t76 = load i32, ptr %t32
  ret i32 %t76
L12:
  %t77 = alloca i1
  %t78 = load i1, ptr %t4
  %t79 = xor i1 %t78, true
  store i1 %t79, ptr %t77
  br i1 %t79, label %L13, label %L14
L13:
  %t80 = load i32, ptr %t43
  %t81 = call i1 @isValueDecl(i32 %t80)
  store i1 %t81, ptr %t77
  br label %L14
L14:
  %t82 = load i1, ptr %t77
  br i1 %t82, label %L15, label %L17
L15:
  %t83 = load i32, ptr %t32
  ret i32 %t83
L17:
  br label %L7
L7:
  %t84 = load i32, ptr %t5
  %t85 = add i32 %t84, 1
  store i32 %t85, ptr %t5
  br label %L0
L2:
  %t86 = load i32, ptr @NO_NODE
  ret i32 %t86
}

define void @assignLinkNames(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 10
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = call ptr @nameSetNew()
  %t14 = alloca ptr
  store ptr %t13, ptr %t14
  %t15 = call ptr @nameSetNew()
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = alloca i32
  store i32 0, ptr %t17
  br label %L0
L0:
  %t18 = load i32, ptr %t17
  %t19 = load i32, ptr %t12
  %t20 = icmp slt i32 %t18, %t19
  br i1 %t20, label %L1, label %L2
L1:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Analyzer, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = getelementptr inbounds %Ast, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t1
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds %Node, ptr %t25, i64 %t27
  %t29 = getelementptr inbounds %Node, ptr %t28, i32 0, i32 9
  %t30 = load ptr, ptr %t29
  %t31 = load i32, ptr %t17
  %t32 = sext i32 %t31 to i64
  %t33 = getelementptr inbounds i32, ptr %t30, i64 %t32
  %t34 = load i32, ptr %t33
  %t35 = alloca i32
  store i32 %t34, ptr %t35
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %Analyzer, ptr %t36, i32 0, i32 0
  %t38 = load ptr, ptr %t37
  %t39 = getelementptr inbounds %Ast, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t35
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %Node, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %Node, ptr %t43, i32 0, i32 0
  %t45 = load i32, ptr %t44
  %t46 = load i32, ptr @NK_EXTERN
  %t47 = icmp eq i32 %t45, %t46
  br i1 %t47, label %L3, label %L5
L3:
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Analyzer, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %Ast, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t35
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Node, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Node, ptr %t55, i32 0, i32 3
  %t57 = load ptr, ptr %t56
  %t58 = alloca ptr
  store ptr %t57, ptr %t58
  %t59 = load ptr, ptr %t58
  %t60 = load ptr, ptr %t0
  %t61 = getelementptr inbounds %Analyzer, ptr %t60, i32 0, i32 5
  %t62 = load ptr, ptr %t61
  %t63 = load i32, ptr %t35
  %t64 = sext i32 %t63 to i64
  %t65 = getelementptr inbounds ptr, ptr %t62, i64 %t64
  store ptr %t59, ptr %t65
  %t66 = load ptr, ptr %t14
  %t67 = load ptr, ptr %t58
  %t68 = call i1 @nameSetHas(ptr %t66, ptr %t67)
  %t69 = xor i1 %t68, true
  br i1 %t69, label %L6, label %L8
L6:
  %t70 = load ptr, ptr %t14
  %t71 = load ptr, ptr %t58
  call void @nameSetAdd(ptr %t70, ptr %t71)
  br label %L8
L8:
  br label %L5
L5:
  %t72 = load i32, ptr %t17
  %t73 = add i32 %t72, 1
  store i32 %t73, ptr %t17
  br label %L0
L2:
  %t74 = alloca i32
  store i32 0, ptr %t74
  br label %L9
L9:
  %t75 = load i32, ptr %t74
  %t76 = load i32, ptr @MODULE_COUNT
  %t77 = icmp slt i32 %t75, %t76
  br i1 %t77, label %L10, label %L11
L10:
  store i32 0, ptr %t17
  br label %L12
L12:
  %t78 = load i32, ptr %t17
  %t79 = load i32, ptr %t12
  %t80 = icmp slt i32 %t78, %t79
  br i1 %t80, label %L13, label %L14
L13:
  %t81 = load ptr, ptr %t0
  %t82 = getelementptr inbounds %Analyzer, ptr %t81, i32 0, i32 0
  %t83 = load ptr, ptr %t82
  %t84 = getelementptr inbounds %Ast, ptr %t83, i32 0, i32 0
  %t85 = load ptr, ptr %t84
  %t86 = load i32, ptr %t1
  %t87 = sext i32 %t86 to i64
  %t88 = getelementptr inbounds %Node, ptr %t85, i64 %t87
  %t89 = getelementptr inbounds %Node, ptr %t88, i32 0, i32 9
  %t90 = load ptr, ptr %t89
  %t91 = load i32, ptr %t17
  %t92 = sext i32 %t91 to i64
  %t93 = getelementptr inbounds i32, ptr %t90, i64 %t92
  %t94 = load i32, ptr %t93
  %t95 = alloca i32
  store i32 %t94, ptr %t95
  %t96 = load ptr, ptr %t0
  %t97 = getelementptr inbounds %Analyzer, ptr %t96, i32 0, i32 0
  %t98 = load ptr, ptr %t97
  %t99 = getelementptr inbounds %Ast, ptr %t98, i32 0, i32 0
  %t100 = load ptr, ptr %t99
  %t101 = load i32, ptr %t95
  %t102 = sext i32 %t101 to i64
  %t103 = getelementptr inbounds %Node, ptr %t100, i64 %t102
  %t104 = getelementptr inbounds %Node, ptr %t103, i32 0, i32 0
  %t105 = load i32, ptr %t104
  %t106 = alloca i32
  store i32 %t105, ptr %t106
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr inbounds %Analyzer, ptr %t107, i32 0, i32 0
  %t109 = load ptr, ptr %t108
  %t110 = getelementptr inbounds %Ast, ptr %t109, i32 0, i32 0
  %t111 = load ptr, ptr %t110
  %t112 = load i32, ptr %t95
  %t113 = sext i32 %t112 to i64
  %t114 = getelementptr inbounds %Node, ptr %t111, i64 %t113
  %t115 = getelementptr inbounds %Node, ptr %t114, i32 0, i32 3
  %t116 = load ptr, ptr %t115
  %t117 = alloca ptr
  store ptr %t116, ptr %t117
  %t118 = load ptr, ptr %t0
  %t119 = getelementptr inbounds %Analyzer, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = getelementptr inbounds %Ast, ptr %t120, i32 0, i32 0
  %t122 = load ptr, ptr %t121
  %t123 = load i32, ptr %t95
  %t124 = sext i32 %t123 to i64
  %t125 = getelementptr inbounds %Node, ptr %t122, i64 %t124
  %t126 = getelementptr inbounds %Node, ptr %t125, i32 0, i32 12
  %t127 = load i32, ptr %t126
  %t128 = load i32, ptr %t74
  %t129 = icmp eq i32 %t127, %t128
  br i1 %t129, label %L15, label %L17
L15:
  %t130 = alloca i1
  %t131 = load i32, ptr %t106
  %t132 = load i32, ptr @NK_FN
  %t133 = icmp eq i32 %t131, %t132
  store i1 %t133, ptr %t130
  br i1 %t133, label %L19, label %L18
L18:
  %t134 = load i32, ptr %t106
  %t135 = load i32, ptr @NK_VARDECL
  %t136 = icmp eq i32 %t134, %t135
  store i1 %t136, ptr %t130
  br label %L19
L19:
  %t137 = load i1, ptr %t130
  br i1 %t137, label %L20, label %L22
L20:
  %t138 = load ptr, ptr %t14
  %t139 = load i32, ptr %t74
  %t140 = load ptr, ptr %t117
  %t141 = call ptr @claimName(ptr %t138, i32 %t139, ptr %t140)
  %t142 = load ptr, ptr %t0
  %t143 = getelementptr inbounds %Analyzer, ptr %t142, i32 0, i32 5
  %t144 = load ptr, ptr %t143
  %t145 = load i32, ptr %t95
  %t146 = sext i32 %t145 to i64
  %t147 = getelementptr inbounds ptr, ptr %t144, i64 %t146
  store ptr %t141, ptr %t147
  br label %L22
L22:
  %t148 = load i32, ptr %t106
  %t149 = load i32, ptr @NK_STRUCT
  %t150 = icmp eq i32 %t148, %t149
  br i1 %t150, label %L23, label %L25
L23:
  %t151 = load ptr, ptr %t0
  %t152 = load i32, ptr %t1
  %t153 = load i32, ptr %t74
  %t154 = load ptr, ptr %t117
  %t155 = call i32 @findTopLevel(ptr %t151, i32 %t152, i32 %t153, ptr %t154, i1 true)
  %t156 = alloca i32
  store i32 %t155, ptr %t156
  %t157 = load i32, ptr %t156
  %t158 = load i32, ptr %t95
  %t159 = icmp ne i32 %t157, %t158
  br i1 %t159, label %L26, label %L27
L26:
  %t160 = load ptr, ptr %t0
  %t161 = getelementptr inbounds %Analyzer, ptr %t160, i32 0, i32 5
  %t162 = load ptr, ptr %t161
  %t163 = load i32, ptr %t156
  %t164 = sext i32 %t163 to i64
  %t165 = getelementptr inbounds ptr, ptr %t162, i64 %t164
  %t166 = load ptr, ptr %t165
  %t167 = load ptr, ptr %t0
  %t168 = getelementptr inbounds %Analyzer, ptr %t167, i32 0, i32 5
  %t169 = load ptr, ptr %t168
  %t170 = load i32, ptr %t95
  %t171 = sext i32 %t170 to i64
  %t172 = getelementptr inbounds ptr, ptr %t169, i64 %t171
  store ptr %t166, ptr %t172
  br label %L28
L27:
  %t173 = load ptr, ptr %t16
  %t174 = load i32, ptr %t74
  %t175 = load ptr, ptr %t117
  %t176 = call ptr @claimName(ptr %t173, i32 %t174, ptr %t175)
  %t177 = load ptr, ptr %t0
  %t178 = getelementptr inbounds %Analyzer, ptr %t177, i32 0, i32 5
  %t179 = load ptr, ptr %t178
  %t180 = load i32, ptr %t95
  %t181 = sext i32 %t180 to i64
  %t182 = getelementptr inbounds ptr, ptr %t179, i64 %t181
  store ptr %t176, ptr %t182
  br label %L28
L28:
  br label %L25
L25:
  br label %L17
L17:
  %t183 = load i32, ptr %t17
  %t184 = add i32 %t183, 1
  store i32 %t184, ptr %t17
  br label %L12
L14:
  %t185 = load i32, ptr %t74
  %t186 = add i32 %t185, 1
  store i32 %t186, ptr %t74
  br label %L9
L11:
  ret void
}

define ptr @importLocalName(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 5
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @NO_NODE
  %t15 = icmp ne i32 %t13, %t14
  br i1 %t15, label %L0, label %L2
L0:
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t12
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 3
  %t25 = load ptr, ptr %t24
  ret ptr %t25
L2:
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Analyzer, ptr %t26, i32 0, i32 0
  %t28 = load ptr, ptr %t27
  %t29 = getelementptr inbounds %Ast, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = load i32, ptr %t1
  %t32 = sext i32 %t31 to i64
  %t33 = getelementptr inbounds %Node, ptr %t30, i64 %t32
  %t34 = getelementptr inbounds %Node, ptr %t33, i32 0, i32 3
  %t35 = load ptr, ptr %t34
  ret ptr %t35
}

define void @importFail(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 12
  %t12 = load i32, ptr %t11
  %t13 = call ptr @modulePath(i32 %t12)
  store ptr %t13, ptr @SOURCE_PATH
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 1
  %t23 = load i32, ptr %t22
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Analyzer, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = getelementptr inbounds %Ast, ptr %t26, i32 0, i32 0
  %t28 = load ptr, ptr %t27
  %t29 = load i32, ptr %t1
  %t30 = sext i32 %t29 to i64
  %t31 = getelementptr inbounds %Node, ptr %t28, i64 %t30
  %t32 = getelementptr inbounds %Node, ptr %t31, i32 0, i32 2
  %t33 = load i32, ptr %t32
  %t34 = load ptr, ptr %t2
  call void @report(i32 %t23, i32 %t33, ptr %t34)
  store i1 false, ptr @FAILED
  ret void
}

define void @checkImports(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = load i32, ptr %t1
  %t10 = sext i32 %t9 to i64
  %t11 = getelementptr inbounds %Node, ptr %t8, i64 %t10
  %t12 = getelementptr inbounds %Node, ptr %t11, i32 0, i32 10
  %t13 = load i32, ptr %t12
  %t14 = icmp slt i32 %t3, %t13
  br i1 %t14, label %L1, label %L2
L1:
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Analyzer, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = getelementptr inbounds %Ast, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  %t20 = load i32, ptr %t1
  %t21 = sext i32 %t20 to i64
  %t22 = getelementptr inbounds %Node, ptr %t19, i64 %t21
  %t23 = getelementptr inbounds %Node, ptr %t22, i32 0, i32 9
  %t24 = load ptr, ptr %t23
  %t25 = load i32, ptr %t2
  %t26 = sext i32 %t25 to i64
  %t27 = getelementptr inbounds i32, ptr %t24, i64 %t26
  %t28 = load i32, ptr %t27
  %t29 = alloca i32
  store i32 %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Analyzer, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = getelementptr inbounds %Ast, ptr %t32, i32 0, i32 0
  %t34 = load ptr, ptr %t33
  %t35 = load i32, ptr %t29
  %t36 = sext i32 %t35 to i64
  %t37 = getelementptr inbounds %Node, ptr %t34, i64 %t36
  %t38 = getelementptr inbounds %Node, ptr %t37, i32 0, i32 8
  %t39 = load i32, ptr %t38
  %t40 = alloca i32
  store i32 %t39, ptr %t40
  %t41 = alloca i1
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Analyzer, ptr %t42, i32 0, i32 0
  %t44 = load ptr, ptr %t43
  %t45 = getelementptr inbounds %Ast, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = load i32, ptr %t29
  %t48 = sext i32 %t47 to i64
  %t49 = getelementptr inbounds %Node, ptr %t46, i64 %t48
  %t50 = getelementptr inbounds %Node, ptr %t49, i32 0, i32 0
  %t51 = load i32, ptr %t50
  %t52 = load i32, ptr @NK_IMPORT
  %t53 = icmp eq i32 %t51, %t52
  store i1 %t53, ptr %t41
  br i1 %t53, label %L3, label %L4
L3:
  %t54 = load i32, ptr %t40
  %t55 = icmp sge i32 %t54, 0
  store i1 %t55, ptr %t41
  br label %L4
L4:
  %t56 = load i1, ptr %t41
  br i1 %t56, label %L5, label %L7
L5:
  %t57 = alloca i32
  store i32 0, ptr %t57
  br label %L8
L8:
  %t58 = load i32, ptr %t57
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Analyzer, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = getelementptr inbounds %Ast, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t29
  %t65 = sext i32 %t64 to i64
  %t66 = getelementptr inbounds %Node, ptr %t63, i64 %t65
  %t67 = getelementptr inbounds %Node, ptr %t66, i32 0, i32 10
  %t68 = load i32, ptr %t67
  %t69 = icmp slt i32 %t58, %t68
  br i1 %t69, label %L9, label %L10
L9:
  %t70 = load ptr, ptr %t0
  %t71 = getelementptr inbounds %Analyzer, ptr %t70, i32 0, i32 0
  %t72 = load ptr, ptr %t71
  %t73 = getelementptr inbounds %Ast, ptr %t72, i32 0, i32 0
  %t74 = load ptr, ptr %t73
  %t75 = load i32, ptr %t29
  %t76 = sext i32 %t75 to i64
  %t77 = getelementptr inbounds %Node, ptr %t74, i64 %t76
  %t78 = getelementptr inbounds %Node, ptr %t77, i32 0, i32 9
  %t79 = load ptr, ptr %t78
  %t80 = load i32, ptr %t57
  %t81 = sext i32 %t80 to i64
  %t82 = getelementptr inbounds i32, ptr %t79, i64 %t81
  %t83 = load i32, ptr %t82
  %t84 = alloca i32
  store i32 %t83, ptr %t84
  %t85 = load ptr, ptr %t0
  %t86 = getelementptr inbounds %Analyzer, ptr %t85, i32 0, i32 0
  %t87 = load ptr, ptr %t86
  %t88 = getelementptr inbounds %Ast, ptr %t87, i32 0, i32 0
  %t89 = load ptr, ptr %t88
  %t90 = load i32, ptr %t84
  %t91 = sext i32 %t90 to i64
  %t92 = getelementptr inbounds %Node, ptr %t89, i64 %t91
  %t93 = getelementptr inbounds %Node, ptr %t92, i32 0, i32 3
  %t94 = load ptr, ptr %t93
  %t95 = alloca ptr
  store ptr %t94, ptr %t95
  %t96 = load ptr, ptr %t0
  %t97 = load i32, ptr %t1
  %t98 = load i32, ptr %t40
  %t99 = load ptr, ptr %t95
  %t100 = call i32 @findTopLevel(ptr %t96, i32 %t97, i32 %t98, ptr %t99, i1 true)
  %t101 = alloca i32
  store i32 %t100, ptr %t101
  %t102 = load ptr, ptr %t0
  %t103 = load i32, ptr %t1
  %t104 = load i32, ptr %t40
  %t105 = load ptr, ptr %t95
  %t106 = call i32 @findTopLevel(ptr %t102, i32 %t103, i32 %t104, ptr %t105, i1 false)
  %t107 = alloca i32
  store i32 %t106, ptr %t107
  %t108 = alloca i1
  store i1 false, ptr %t108
  %t109 = alloca i1
  %t110 = load i32, ptr %t101
  %t111 = load i32, ptr @NO_NODE
  %t112 = icmp ne i32 %t110, %t111
  store i1 %t112, ptr %t109
  br i1 %t112, label %L11, label %L12
L11:
  %t113 = load ptr, ptr %t0
  %t114 = getelementptr inbounds %Analyzer, ptr %t113, i32 0, i32 0
  %t115 = load ptr, ptr %t114
  %t116 = getelementptr inbounds %Ast, ptr %t115, i32 0, i32 0
  %t117 = load ptr, ptr %t116
  %t118 = load i32, ptr %t101
  %t119 = sext i32 %t118 to i64
  %t120 = getelementptr inbounds %Node, ptr %t117, i64 %t119
  %t121 = getelementptr inbounds %Node, ptr %t120, i32 0, i32 13
  %t122 = load i1, ptr %t121
  store i1 %t122, ptr %t109
  br label %L12
L12:
  %t123 = load i1, ptr %t109
  br i1 %t123, label %L13, label %L15
L13:
  store i1 true, ptr %t108
  br label %L15
L15:
  %t124 = alloca i1
  %t125 = load i32, ptr %t107
  %t126 = load i32, ptr @NO_NODE
  %t127 = icmp ne i32 %t125, %t126
  store i1 %t127, ptr %t124
  br i1 %t127, label %L16, label %L17
L16:
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr inbounds %Analyzer, ptr %t128, i32 0, i32 0
  %t130 = load ptr, ptr %t129
  %t131 = getelementptr inbounds %Ast, ptr %t130, i32 0, i32 0
  %t132 = load ptr, ptr %t131
  %t133 = load i32, ptr %t107
  %t134 = sext i32 %t133 to i64
  %t135 = getelementptr inbounds %Node, ptr %t132, i64 %t134
  %t136 = getelementptr inbounds %Node, ptr %t135, i32 0, i32 13
  %t137 = load i1, ptr %t136
  store i1 %t137, ptr %t124
  br label %L17
L17:
  %t138 = load i1, ptr %t124
  br i1 %t138, label %L18, label %L20
L18:
  store i1 true, ptr %t108
  br label %L20
L20:
  %t139 = alloca i1
  %t140 = load i32, ptr %t101
  %t141 = load i32, ptr @NO_NODE
  %t142 = icmp eq i32 %t140, %t141
  store i1 %t142, ptr %t139
  br i1 %t142, label %L21, label %L22
L21:
  %t143 = load i32, ptr %t107
  %t144 = load i32, ptr @NO_NODE
  %t145 = icmp eq i32 %t143, %t144
  store i1 %t145, ptr %t139
  br label %L22
L22:
  %t146 = load i1, ptr %t139
  br i1 %t146, label %L23, label %L24
L23:
  %t147 = call ptr @bufNew()
  %t148 = alloca ptr
  store ptr %t147, ptr %t148
  %t149 = load ptr, ptr %t148
  call void @bufAdd(ptr %t149, ptr @.str.249)
  %t150 = load ptr, ptr %t148
  %t151 = load ptr, ptr %t0
  %t152 = getelementptr inbounds %Analyzer, ptr %t151, i32 0, i32 0
  %t153 = load ptr, ptr %t152
  %t154 = getelementptr inbounds %Ast, ptr %t153, i32 0, i32 0
  %t155 = load ptr, ptr %t154
  %t156 = load i32, ptr %t29
  %t157 = sext i32 %t156 to i64
  %t158 = getelementptr inbounds %Node, ptr %t155, i64 %t157
  %t159 = getelementptr inbounds %Node, ptr %t158, i32 0, i32 3
  %t160 = load ptr, ptr %t159
  call void @bufAdd(ptr %t150, ptr %t160)
  %t161 = load ptr, ptr %t148
  call void @bufAdd(ptr %t161, ptr @.str.250)
  %t162 = load ptr, ptr %t148
  %t163 = load ptr, ptr %t95
  call void @bufAdd(ptr %t162, ptr %t163)
  %t164 = load ptr, ptr %t148
  call void @bufPush(ptr %t164, i8 39)
  %t165 = load ptr, ptr %t0
  %t166 = load i32, ptr %t84
  %t167 = load ptr, ptr %t148
  %t168 = getelementptr inbounds %Buf, ptr %t167, i32 0, i32 0
  %t169 = load ptr, ptr %t168
  call void @importFail(ptr %t165, i32 %t166, ptr %t169)
  br label %L25
L24:
  %t170 = load i1, ptr %t108
  %t171 = xor i1 %t170, true
  br i1 %t171, label %L26, label %L28
L26:
  %t172 = call ptr @bufNew()
  %t173 = alloca ptr
  store ptr %t172, ptr %t173
  %t174 = load ptr, ptr %t173
  call void @bufPush(ptr %t174, i8 39)
  %t175 = load ptr, ptr %t173
  %t176 = load ptr, ptr %t95
  call void @bufAdd(ptr %t175, ptr %t176)
  %t177 = load ptr, ptr %t173
  call void @bufAdd(ptr %t177, ptr @.str.251)
  %t178 = load ptr, ptr %t173
  %t179 = load ptr, ptr %t0
  %t180 = getelementptr inbounds %Analyzer, ptr %t179, i32 0, i32 0
  %t181 = load ptr, ptr %t180
  %t182 = getelementptr inbounds %Ast, ptr %t181, i32 0, i32 0
  %t183 = load ptr, ptr %t182
  %t184 = load i32, ptr %t29
  %t185 = sext i32 %t184 to i64
  %t186 = getelementptr inbounds %Node, ptr %t183, i64 %t185
  %t187 = getelementptr inbounds %Node, ptr %t186, i32 0, i32 3
  %t188 = load ptr, ptr %t187
  call void @bufAdd(ptr %t178, ptr %t188)
  %t189 = load ptr, ptr %t173
  call void @bufPush(ptr %t189, i8 39)
  %t190 = load ptr, ptr %t0
  %t191 = load i32, ptr %t84
  %t192 = load ptr, ptr %t173
  %t193 = getelementptr inbounds %Buf, ptr %t192, i32 0, i32 0
  %t194 = load ptr, ptr %t193
  call void @importFail(ptr %t190, i32 %t191, ptr %t194)
  br label %L28
L28:
  br label %L25
L25:
  %t195 = load i32, ptr %t57
  %t196 = add i32 %t195, 1
  store i32 %t196, ptr %t57
  br label %L8
L10:
  br label %L7
L7:
  %t197 = load i32, ptr %t2
  %t198 = add i32 %t197, 1
  store i32 %t198, ptr %t2
  br label %L0
L2:
  ret void
}

define ptr @resolveStructName(ptr %p0, i32 %p1, i32 %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr %t1
  %t6 = load i32, ptr %t2
  %t7 = load ptr, ptr %t3
  %t8 = call i32 @findTopLevel(ptr %t4, i32 %t5, i32 %t6, ptr %t7, i1 true)
  %t9 = alloca i32
  store i32 %t8, ptr %t9
  %t10 = load i32, ptr %t9
  %t11 = load i32, ptr @NO_NODE
  %t12 = icmp ne i32 %t10, %t11
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 5
  %t15 = load ptr, ptr %t14
  %t16 = load i32, ptr %t9
  %t17 = sext i32 %t16 to i64
  %t18 = getelementptr inbounds ptr, ptr %t15, i64 %t17
  %t19 = load ptr, ptr %t18
  ret ptr %t19
L2:
  %t20 = alloca i32
  store i32 0, ptr %t20
  br label %L3
L3:
  %t21 = load i32, ptr %t20
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Analyzer, ptr %t22, i32 0, i32 0
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %Ast, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Node, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Node, ptr %t29, i32 0, i32 10
  %t31 = load i32, ptr %t30
  %t32 = icmp slt i32 %t21, %t31
  br i1 %t32, label %L4, label %L5
L4:
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 9
  %t42 = load ptr, ptr %t41
  %t43 = load i32, ptr %t20
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds i32, ptr %t42, i64 %t44
  %t46 = load i32, ptr %t45
  %t47 = alloca i32
  store i32 %t46, ptr %t47
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Analyzer, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %Ast, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t47
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Node, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Node, ptr %t55, i32 0, i32 8
  %t57 = load i32, ptr %t56
  %t58 = alloca i32
  store i32 %t57, ptr %t58
  %t59 = alloca i1
  %t60 = alloca i1
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Analyzer, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = getelementptr inbounds %Ast, ptr %t63, i32 0, i32 0
  %t65 = load ptr, ptr %t64
  %t66 = load i32, ptr %t47
  %t67 = sext i32 %t66 to i64
  %t68 = getelementptr inbounds %Node, ptr %t65, i64 %t67
  %t69 = getelementptr inbounds %Node, ptr %t68, i32 0, i32 0
  %t70 = load i32, ptr %t69
  %t71 = load i32, ptr @NK_IMPORT
  %t72 = icmp eq i32 %t70, %t71
  store i1 %t72, ptr %t60
  br i1 %t72, label %L6, label %L7
L6:
  %t73 = load ptr, ptr %t0
  %t74 = getelementptr inbounds %Analyzer, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  %t76 = getelementptr inbounds %Ast, ptr %t75, i32 0, i32 0
  %t77 = load ptr, ptr %t76
  %t78 = load i32, ptr %t47
  %t79 = sext i32 %t78 to i64
  %t80 = getelementptr inbounds %Node, ptr %t77, i64 %t79
  %t81 = getelementptr inbounds %Node, ptr %t80, i32 0, i32 12
  %t82 = load i32, ptr %t81
  %t83 = load i32, ptr %t2
  %t84 = icmp eq i32 %t82, %t83
  store i1 %t84, ptr %t60
  br label %L7
L7:
  %t85 = load i1, ptr %t60
  store i1 %t85, ptr %t59
  br i1 %t85, label %L8, label %L9
L8:
  %t86 = load i32, ptr %t58
  %t87 = icmp sge i32 %t86, 0
  store i1 %t87, ptr %t59
  br label %L9
L9:
  %t88 = load i1, ptr %t59
  br i1 %t88, label %L10, label %L12
L10:
  %t89 = alloca i32
  store i32 0, ptr %t89
  br label %L13
L13:
  %t90 = load i32, ptr %t89
  %t91 = load ptr, ptr %t0
  %t92 = getelementptr inbounds %Analyzer, ptr %t91, i32 0, i32 0
  %t93 = load ptr, ptr %t92
  %t94 = getelementptr inbounds %Ast, ptr %t93, i32 0, i32 0
  %t95 = load ptr, ptr %t94
  %t96 = load i32, ptr %t47
  %t97 = sext i32 %t96 to i64
  %t98 = getelementptr inbounds %Node, ptr %t95, i64 %t97
  %t99 = getelementptr inbounds %Node, ptr %t98, i32 0, i32 10
  %t100 = load i32, ptr %t99
  %t101 = icmp slt i32 %t90, %t100
  br i1 %t101, label %L14, label %L15
L14:
  %t102 = load ptr, ptr %t0
  %t103 = getelementptr inbounds %Analyzer, ptr %t102, i32 0, i32 0
  %t104 = load ptr, ptr %t103
  %t105 = getelementptr inbounds %Ast, ptr %t104, i32 0, i32 0
  %t106 = load ptr, ptr %t105
  %t107 = load i32, ptr %t47
  %t108 = sext i32 %t107 to i64
  %t109 = getelementptr inbounds %Node, ptr %t106, i64 %t108
  %t110 = getelementptr inbounds %Node, ptr %t109, i32 0, i32 9
  %t111 = load ptr, ptr %t110
  %t112 = load i32, ptr %t89
  %t113 = sext i32 %t112 to i64
  %t114 = getelementptr inbounds i32, ptr %t111, i64 %t113
  %t115 = load i32, ptr %t114
  %t116 = alloca i32
  store i32 %t115, ptr %t116
  %t117 = load ptr, ptr %t0
  %t118 = load i32, ptr %t116
  %t119 = call ptr @importLocalName(ptr %t117, i32 %t118)
  %t120 = load ptr, ptr %t3
  %t121 = call i1 @textEquals(ptr %t119, ptr %t120)
  br i1 %t121, label %L16, label %L18
L16:
  %t122 = load ptr, ptr %t0
  %t123 = load i32, ptr %t1
  %t124 = load i32, ptr %t58
  %t125 = load ptr, ptr %t0
  %t126 = getelementptr inbounds %Analyzer, ptr %t125, i32 0, i32 0
  %t127 = load ptr, ptr %t126
  %t128 = getelementptr inbounds %Ast, ptr %t127, i32 0, i32 0
  %t129 = load ptr, ptr %t128
  %t130 = load i32, ptr %t116
  %t131 = sext i32 %t130 to i64
  %t132 = getelementptr inbounds %Node, ptr %t129, i64 %t131
  %t133 = getelementptr inbounds %Node, ptr %t132, i32 0, i32 3
  %t134 = load ptr, ptr %t133
  %t135 = call i32 @findTopLevel(ptr %t122, i32 %t123, i32 %t124, ptr %t134, i1 true)
  %t136 = alloca i32
  store i32 %t135, ptr %t136
  %t137 = load i32, ptr %t136
  %t138 = load i32, ptr @NO_NODE
  %t139 = icmp ne i32 %t137, %t138
  br i1 %t139, label %L19, label %L21
L19:
  %t140 = load ptr, ptr %t0
  %t141 = getelementptr inbounds %Analyzer, ptr %t140, i32 0, i32 5
  %t142 = load ptr, ptr %t141
  %t143 = load i32, ptr %t136
  %t144 = sext i32 %t143 to i64
  %t145 = getelementptr inbounds ptr, ptr %t142, i64 %t144
  %t146 = load ptr, ptr %t145
  ret ptr %t146
L21:
  br label %L18
L18:
  %t147 = load i32, ptr %t89
  %t148 = add i32 %t147, 1
  store i32 %t148, ptr %t89
  br label %L13
L15:
  br label %L12
L12:
  %t149 = load i32, ptr %t20
  %t150 = add i32 %t149, 1
  store i32 %t150, ptr %t20
  br label %L3
L5:
  %t151 = call ptr @nullText()
  ret ptr %t151
}

define i32 @findStructAnywhere(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i32
  store i32 0, ptr %t3
  br label %L0
L0:
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Analyzer, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = getelementptr inbounds %Ast, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr %t1
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr inbounds %Node, ptr %t9, i64 %t11
  %t13 = getelementptr inbounds %Node, ptr %t12, i32 0, i32 10
  %t14 = load i32, ptr %t13
  %t15 = icmp slt i32 %t4, %t14
  br i1 %t15, label %L1, label %L2
L1:
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 9
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t3
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds i32, ptr %t25, i64 %t27
  %t29 = load i32, ptr %t28
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = alloca i1
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Analyzer, ptr %t32, i32 0, i32 0
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr inbounds %Ast, ptr %t34, i32 0, i32 0
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t30
  %t38 = sext i32 %t37 to i64
  %t39 = getelementptr inbounds %Node, ptr %t36, i64 %t38
  %t40 = getelementptr inbounds %Node, ptr %t39, i32 0, i32 0
  %t41 = load i32, ptr %t40
  %t42 = load i32, ptr @NK_STRUCT
  %t43 = icmp eq i32 %t41, %t42
  store i1 %t43, ptr %t31
  br i1 %t43, label %L3, label %L4
L3:
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr inbounds %Analyzer, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = getelementptr inbounds %Ast, ptr %t46, i32 0, i32 0
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t30
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds %Node, ptr %t48, i64 %t50
  %t52 = getelementptr inbounds %Node, ptr %t51, i32 0, i32 3
  %t53 = load ptr, ptr %t52
  %t54 = load ptr, ptr %t2
  %t55 = call i1 @textEquals(ptr %t53, ptr %t54)
  store i1 %t55, ptr %t31
  br label %L4
L4:
  %t56 = load i1, ptr %t31
  br i1 %t56, label %L5, label %L7
L5:
  %t57 = load i32, ptr %t30
  ret i32 %t57
L7:
  %t58 = load i32, ptr %t3
  %t59 = add i32 %t58, 1
  store i32 %t59, ptr %t3
  br label %L0
L2:
  %t60 = load i32, ptr @NO_NODE
  ret i32 %t60
}

define void @setNodeText(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 3
  %t12 = load ptr, ptr %t11
  %t13 = load ptr, ptr %t2
  %t14 = call i1 @textEquals(ptr %t12, ptr %t13)
  br i1 %t14, label %L0, label %L2
L0:
  ret void
L2:
  %t15 = load ptr, ptr %t2
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 3
  store ptr %t15, ptr %t24
  %t25 = load ptr, ptr %t2
  %t26 = call i64 @strlen(ptr %t25)
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Analyzer, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = getelementptr inbounds %Ast, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t1
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Node, ptr %t31, i64 %t33
  %t35 = getelementptr inbounds %Node, ptr %t34, i32 0, i32 4
  store i64 %t26, ptr %t35
  ret void
}

define void @rewriteStructNames(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 1
  %t8 = load i32, ptr %t7
  %t9 = icmp slt i32 %t3, %t8
  br i1 %t9, label %L1, label %L2
L1:
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Analyzer, ptr %t10, i32 0, i32 0
  %t12 = load ptr, ptr %t11
  %t13 = getelementptr inbounds %Ast, ptr %t12, i32 0, i32 0
  %t14 = load ptr, ptr %t13
  %t15 = load i32, ptr %t2
  %t16 = sext i32 %t15 to i64
  %t17 = getelementptr inbounds %Node, ptr %t14, i64 %t16
  %t18 = getelementptr inbounds %Node, ptr %t17, i32 0, i32 0
  %t19 = load i32, ptr %t18
  %t20 = alloca i32
  store i32 %t19, ptr %t20
  %t21 = load i32, ptr %t20
  %t22 = load i32, ptr @NK_STRUCTLIT
  %t23 = icmp eq i32 %t21, %t22
  %t24 = alloca i1
  store i1 %t23, ptr %t24
  %t25 = load i32, ptr %t20
  %t26 = load i32, ptr @NK_TYPE
  %t27 = icmp eq i32 %t25, %t26
  br i1 %t27, label %L3, label %L5
L3:
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Analyzer, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = getelementptr inbounds %Ast, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t2
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %Node, ptr %t32, i64 %t34
  %t36 = getelementptr inbounds %Node, ptr %t35, i32 0, i32 3
  %t37 = load ptr, ptr %t36
  %t38 = call i32 @typeKindFromName(ptr %t37)
  %t39 = load i32, ptr @TY_NONE
  %t40 = icmp eq i32 %t38, %t39
  store i1 %t40, ptr %t24
  br label %L5
L5:
  %t41 = load i1, ptr %t24
  br i1 %t41, label %L6, label %L8
L6:
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Analyzer, ptr %t42, i32 0, i32 0
  %t44 = load ptr, ptr %t43
  %t45 = getelementptr inbounds %Ast, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = load i32, ptr %t2
  %t48 = sext i32 %t47 to i64
  %t49 = getelementptr inbounds %Node, ptr %t46, i64 %t48
  %t50 = getelementptr inbounds %Node, ptr %t49, i32 0, i32 3
  %t51 = load ptr, ptr %t50
  %t52 = alloca ptr
  store ptr %t51, ptr %t52
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr inbounds %Analyzer, ptr %t53, i32 0, i32 0
  %t55 = load ptr, ptr %t54
  %t56 = getelementptr inbounds %Ast, ptr %t55, i32 0, i32 0
  %t57 = load ptr, ptr %t56
  %t58 = load i32, ptr %t2
  %t59 = sext i32 %t58 to i64
  %t60 = getelementptr inbounds %Node, ptr %t57, i64 %t59
  %t61 = getelementptr inbounds %Node, ptr %t60, i32 0, i32 12
  %t62 = load i32, ptr %t61
  %t63 = alloca i32
  store i32 %t62, ptr %t63
  %t64 = load ptr, ptr %t0
  %t65 = load i32, ptr %t1
  %t66 = load i32, ptr %t63
  %t67 = load ptr, ptr %t52
  %t68 = call ptr @resolveStructName(ptr %t64, i32 %t65, i32 %t66, ptr %t67)
  %t69 = alloca ptr
  store ptr %t68, ptr %t69
  %t70 = load ptr, ptr %t69
  %t71 = call i1 @isNullText(ptr %t70)
  %t72 = xor i1 %t71, true
  br i1 %t72, label %L9, label %L10
L9:
  %t73 = load ptr, ptr %t0
  %t74 = load i32, ptr %t2
  %t75 = load ptr, ptr %t69
  call void @setNodeText(ptr %t73, i32 %t74, ptr %t75)
  br label %L11
L10:
  %t76 = load ptr, ptr %t0
  %t77 = load i32, ptr %t1
  %t78 = load ptr, ptr %t52
  %t79 = call i32 @findStructAnywhere(ptr %t76, i32 %t77, ptr %t78)
  %t80 = alloca i32
  store i32 %t79, ptr %t80
  %t81 = load i32, ptr %t80
  %t82 = load i32, ptr @NO_NODE
  %t83 = icmp ne i32 %t81, %t82
  br i1 %t83, label %L12, label %L14
L12:
  %t84 = call ptr @bufNew()
  %t85 = alloca ptr
  store ptr %t84, ptr %t85
  %t86 = load ptr, ptr %t85
  call void @bufAdd(ptr %t86, ptr @.str.252)
  %t87 = load ptr, ptr %t85
  %t88 = load ptr, ptr %t52
  call void @bufAdd(ptr %t87, ptr %t88)
  %t89 = load ptr, ptr %t85
  call void @bufAdd(ptr %t89, ptr @.str.253)
  %t90 = load ptr, ptr %t85
  %t91 = load ptr, ptr %t0
  %t92 = getelementptr inbounds %Analyzer, ptr %t91, i32 0, i32 0
  %t93 = load ptr, ptr %t92
  %t94 = getelementptr inbounds %Ast, ptr %t93, i32 0, i32 0
  %t95 = load ptr, ptr %t94
  %t96 = load i32, ptr %t80
  %t97 = sext i32 %t96 to i64
  %t98 = getelementptr inbounds %Node, ptr %t95, i64 %t97
  %t99 = getelementptr inbounds %Node, ptr %t98, i32 0, i32 12
  %t100 = load i32, ptr %t99
  %t101 = call ptr @modulePath(i32 %t100)
  call void @bufAdd(ptr %t90, ptr %t101)
  %t102 = load ptr, ptr %t85
  call void @bufAdd(ptr %t102, ptr @.str.254)
  %t103 = load ptr, ptr %t0
  %t104 = load i32, ptr %t2
  %t105 = load ptr, ptr %t85
  %t106 = getelementptr inbounds %Buf, ptr %t105, i32 0, i32 0
  %t107 = load ptr, ptr %t106
  call void @importFail(ptr %t103, i32 %t104, ptr %t107)
  %t108 = load ptr, ptr %t0
  %t109 = load i32, ptr %t2
  %t110 = load ptr, ptr %t0
  %t111 = getelementptr inbounds %Analyzer, ptr %t110, i32 0, i32 5
  %t112 = load ptr, ptr %t111
  %t113 = load i32, ptr %t80
  %t114 = sext i32 %t113 to i64
  %t115 = getelementptr inbounds ptr, ptr %t112, i64 %t114
  %t116 = load ptr, ptr %t115
  call void @setNodeText(ptr %t108, i32 %t109, ptr %t116)
  br label %L14
L14:
  br label %L11
L11:
  br label %L8
L8:
  %t117 = load i32, ptr %t2
  %t118 = add i32 %t117, 1
  store i32 %t118, ptr %t2
  br label %L0
L2:
  %t119 = alloca i32
  store i32 0, ptr %t119
  br label %L15
L15:
  %t120 = load i32, ptr %t119
  %t121 = load ptr, ptr %t0
  %t122 = getelementptr inbounds %Analyzer, ptr %t121, i32 0, i32 0
  %t123 = load ptr, ptr %t122
  %t124 = getelementptr inbounds %Ast, ptr %t123, i32 0, i32 0
  %t125 = load ptr, ptr %t124
  %t126 = load i32, ptr %t1
  %t127 = sext i32 %t126 to i64
  %t128 = getelementptr inbounds %Node, ptr %t125, i64 %t127
  %t129 = getelementptr inbounds %Node, ptr %t128, i32 0, i32 10
  %t130 = load i32, ptr %t129
  %t131 = icmp slt i32 %t120, %t130
  br i1 %t131, label %L16, label %L17
L16:
  %t132 = load ptr, ptr %t0
  %t133 = getelementptr inbounds %Analyzer, ptr %t132, i32 0, i32 0
  %t134 = load ptr, ptr %t133
  %t135 = getelementptr inbounds %Ast, ptr %t134, i32 0, i32 0
  %t136 = load ptr, ptr %t135
  %t137 = load i32, ptr %t1
  %t138 = sext i32 %t137 to i64
  %t139 = getelementptr inbounds %Node, ptr %t136, i64 %t138
  %t140 = getelementptr inbounds %Node, ptr %t139, i32 0, i32 9
  %t141 = load ptr, ptr %t140
  %t142 = load i32, ptr %t119
  %t143 = sext i32 %t142 to i64
  %t144 = getelementptr inbounds i32, ptr %t141, i64 %t143
  %t145 = load i32, ptr %t144
  %t146 = alloca i32
  store i32 %t145, ptr %t146
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 0
  %t149 = load ptr, ptr %t148
  %t150 = getelementptr inbounds %Ast, ptr %t149, i32 0, i32 0
  %t151 = load ptr, ptr %t150
  %t152 = load i32, ptr %t146
  %t153 = sext i32 %t152 to i64
  %t154 = getelementptr inbounds %Node, ptr %t151, i64 %t153
  %t155 = getelementptr inbounds %Node, ptr %t154, i32 0, i32 0
  %t156 = load i32, ptr %t155
  %t157 = load i32, ptr @NK_STRUCT
  %t158 = icmp eq i32 %t156, %t157
  br i1 %t158, label %L18, label %L20
L18:
  %t159 = load ptr, ptr %t0
  %t160 = load i32, ptr %t146
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr inbounds %Analyzer, ptr %t161, i32 0, i32 5
  %t163 = load ptr, ptr %t162
  %t164 = load i32, ptr %t146
  %t165 = sext i32 %t164 to i64
  %t166 = getelementptr inbounds ptr, ptr %t163, i64 %t165
  %t167 = load ptr, ptr %t166
  call void @setNodeText(ptr %t159, i32 %t160, ptr %t167)
  br label %L20
L20:
  %t168 = load i32, ptr %t119
  %t169 = add i32 %t168, 1
  store i32 %t169, ptr %t119
  br label %L15
L17:
  ret void
}

define void @linkModules(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load i32, ptr %t1
  call void @assignLinkNames(ptr %t2, i32 %t3)
  %t4 = load ptr, ptr %t0
  %t5 = load i32, ptr %t1
  call void @checkImports(ptr %t4, i32 %t5)
  %t6 = load ptr, ptr %t0
  %t7 = load i32, ptr %t1
  call void @rewriteStructNames(ptr %t6, i32 %t7)
  ret void
}

define %SymbolList @symbolListCopy(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %SymbolTable, ptr %t2, i32 0, i32 1
  %t4 = load i32, ptr %t3
  %t5 = load i32, ptr %t1
  %t6 = sub i32 %t4, %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = sext i32 0 to i64
  %t9 = inttoptr i64 %t8 to ptr
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load i32, ptr %t7
  %t12 = icmp sgt i32 %t11, 0
  br i1 %t12, label %L0, label %L2
L0:
  %t13 = load i32, ptr %t7
  %t14 = sext i32 %t13 to i64
  %t15 = mul i64 56, %t14
  %t16 = call ptr @malloc(i64 %t15)
  store ptr %t16, ptr %t10
  %t17 = load ptr, ptr %t10
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %SymbolTable, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Symbol, ptr %t20, i64 %t22
  %t24 = load i32, ptr %t7
  %t25 = sext i32 %t24 to i64
  %t26 = mul i64 56, %t25
  %t27 = call ptr @memcpy(ptr %t17, ptr %t23, i64 %t26)
  br label %L2
L2:
  %t28 = load ptr, ptr %t10
  %t29 = insertvalue %SymbolList undef, ptr %t28, 0
  %t30 = load i32, ptr %t7
  %t31 = insertvalue %SymbolList %t29, i32 %t30, 1
  ret %SymbolList %t31
}

define i32 @symbolListFind(%SymbolList %p0, ptr %p1) {
entry:
  %t0 = alloca %SymbolList
  store %SymbolList %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = getelementptr inbounds %SymbolList, ptr %t0, i32 0, i32 1
  %t5 = load i32, ptr %t4
  %t6 = icmp slt i32 %t3, %t5
  br i1 %t6, label %L1, label %L2
L1:
  %t7 = getelementptr inbounds %SymbolList, ptr %t0, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = load i32, ptr %t2
  %t10 = sext i32 %t9 to i64
  %t11 = getelementptr inbounds %Symbol, ptr %t8, i64 %t10
  %t12 = getelementptr inbounds %Symbol, ptr %t11, i32 0, i32 0
  %t13 = load ptr, ptr %t12
  %t14 = load ptr, ptr %t1
  %t15 = call i1 @textEquals(ptr %t13, ptr %t14)
  br i1 %t15, label %L3, label %L5
L3:
  %t16 = load i32, ptr %t2
  ret i32 %t16
L5:
  %t17 = load i32, ptr %t2
  %t18 = add i32 %t17, 1
  store i32 %t18, ptr %t2
  br label %L0
L2:
  ret i32 -1
}

define void @declareImports(ptr %p0, i32 %p1, i32 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca i32
  store i32 0, ptr %t3
  br label %L0
L0:
  %t4 = load i32, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Analyzer, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = getelementptr inbounds %Ast, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr %t1
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr inbounds %Node, ptr %t9, i64 %t11
  %t13 = getelementptr inbounds %Node, ptr %t12, i32 0, i32 10
  %t14 = load i32, ptr %t13
  %t15 = icmp slt i32 %t4, %t14
  br i1 %t15, label %L1, label %L2
L1:
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 9
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t3
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds i32, ptr %t25, i64 %t27
  %t29 = load i32, ptr %t28
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Analyzer, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = getelementptr inbounds %Ast, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = load i32, ptr %t30
  %t37 = sext i32 %t36 to i64
  %t38 = getelementptr inbounds %Node, ptr %t35, i64 %t37
  %t39 = getelementptr inbounds %Node, ptr %t38, i32 0, i32 8
  %t40 = load i32, ptr %t39
  %t41 = alloca i32
  store i32 %t40, ptr %t41
  %t42 = alloca i1
  %t43 = alloca i1
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr inbounds %Analyzer, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = getelementptr inbounds %Ast, ptr %t46, i32 0, i32 0
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t30
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds %Node, ptr %t48, i64 %t50
  %t52 = getelementptr inbounds %Node, ptr %t51, i32 0, i32 0
  %t53 = load i32, ptr %t52
  %t54 = load i32, ptr @NK_IMPORT
  %t55 = icmp eq i32 %t53, %t54
  store i1 %t55, ptr %t43
  br i1 %t55, label %L3, label %L4
L3:
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %Analyzer, ptr %t56, i32 0, i32 0
  %t58 = load ptr, ptr %t57
  %t59 = getelementptr inbounds %Ast, ptr %t58, i32 0, i32 0
  %t60 = load ptr, ptr %t59
  %t61 = load i32, ptr %t30
  %t62 = sext i32 %t61 to i64
  %t63 = getelementptr inbounds %Node, ptr %t60, i64 %t62
  %t64 = getelementptr inbounds %Node, ptr %t63, i32 0, i32 12
  %t65 = load i32, ptr %t64
  %t66 = load i32, ptr %t2
  %t67 = icmp eq i32 %t65, %t66
  store i1 %t67, ptr %t43
  br label %L4
L4:
  %t68 = load i1, ptr %t43
  store i1 %t68, ptr %t42
  br i1 %t68, label %L5, label %L6
L5:
  %t69 = load i32, ptr %t41
  %t70 = icmp sge i32 %t69, 0
  store i1 %t70, ptr %t42
  br label %L6
L6:
  %t71 = load i1, ptr %t42
  br i1 %t71, label %L7, label %L9
L7:
  %t72 = alloca i32
  store i32 0, ptr %t72
  br label %L10
L10:
  %t73 = load i32, ptr %t72
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %Analyzer, ptr %t74, i32 0, i32 0
  %t76 = load ptr, ptr %t75
  %t77 = getelementptr inbounds %Ast, ptr %t76, i32 0, i32 0
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr %t30
  %t80 = sext i32 %t79 to i64
  %t81 = getelementptr inbounds %Node, ptr %t78, i64 %t80
  %t82 = getelementptr inbounds %Node, ptr %t81, i32 0, i32 10
  %t83 = load i32, ptr %t82
  %t84 = icmp slt i32 %t73, %t83
  br i1 %t84, label %L11, label %L12
L11:
  %t85 = load ptr, ptr %t0
  %t86 = getelementptr inbounds %Analyzer, ptr %t85, i32 0, i32 0
  %t87 = load ptr, ptr %t86
  %t88 = getelementptr inbounds %Ast, ptr %t87, i32 0, i32 0
  %t89 = load ptr, ptr %t88
  %t90 = load i32, ptr %t30
  %t91 = sext i32 %t90 to i64
  %t92 = getelementptr inbounds %Node, ptr %t89, i64 %t91
  %t93 = getelementptr inbounds %Node, ptr %t92, i32 0, i32 9
  %t94 = load ptr, ptr %t93
  %t95 = load i32, ptr %t72
  %t96 = sext i32 %t95 to i64
  %t97 = getelementptr inbounds i32, ptr %t94, i64 %t96
  %t98 = load i32, ptr %t97
  %t99 = alloca i32
  store i32 %t98, ptr %t99
  %t100 = load ptr, ptr %t0
  %t101 = load i32, ptr %t1
  %t102 = load i32, ptr %t41
  %t103 = load ptr, ptr %t0
  %t104 = getelementptr inbounds %Analyzer, ptr %t103, i32 0, i32 0
  %t105 = load ptr, ptr %t104
  %t106 = getelementptr inbounds %Ast, ptr %t105, i32 0, i32 0
  %t107 = load ptr, ptr %t106
  %t108 = load i32, ptr %t99
  %t109 = sext i32 %t108 to i64
  %t110 = getelementptr inbounds %Node, ptr %t107, i64 %t109
  %t111 = getelementptr inbounds %Node, ptr %t110, i32 0, i32 3
  %t112 = load ptr, ptr %t111
  %t113 = call i32 @findTopLevel(ptr %t100, i32 %t101, i32 %t102, ptr %t112, i1 false)
  %t114 = alloca i32
  store i32 %t113, ptr %t114
  %t115 = load i32, ptr %t114
  %t116 = load i32, ptr @NO_NODE
  %t117 = icmp ne i32 %t115, %t116
  br i1 %t117, label %L13, label %L15
L13:
  %t118 = load ptr, ptr %t0
  %t119 = getelementptr inbounds %Analyzer, ptr %t118, i32 0, i32 6
  %t120 = load ptr, ptr %t119
  %t121 = load i32, ptr %t41
  %t122 = sext i32 %t121 to i64
  %t123 = getelementptr inbounds %SymbolList, ptr %t120, i64 %t122
  %t124 = load %SymbolList, ptr %t123
  %t125 = alloca %SymbolList
  store %SymbolList %t124, ptr %t125
  %t126 = load %SymbolList, ptr %t125
  %t127 = load ptr, ptr %t0
  %t128 = getelementptr inbounds %Analyzer, ptr %t127, i32 0, i32 0
  %t129 = load ptr, ptr %t128
  %t130 = getelementptr inbounds %Ast, ptr %t129, i32 0, i32 0
  %t131 = load ptr, ptr %t130
  %t132 = load i32, ptr %t99
  %t133 = sext i32 %t132 to i64
  %t134 = getelementptr inbounds %Node, ptr %t131, i64 %t133
  %t135 = getelementptr inbounds %Node, ptr %t134, i32 0, i32 3
  %t136 = load ptr, ptr %t135
  %t137 = call i32 @symbolListFind(%SymbolList %t126, ptr %t136)
  %t138 = alloca i32
  store i32 %t137, ptr %t138
  %t139 = load i32, ptr %t138
  %t140 = icmp sge i32 %t139, 0
  br i1 %t140, label %L16, label %L18
L16:
  %t141 = load ptr, ptr %t0
  %t142 = getelementptr inbounds %Analyzer, ptr %t141, i32 0, i32 1
  %t143 = load ptr, ptr %t142
  %t144 = getelementptr inbounds %SymbolTable, ptr %t143, i32 0, i32 1
  %t145 = load i32, ptr %t144
  %t146 = alloca i32
  store i32 %t145, ptr %t146
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 1
  %t149 = load ptr, ptr %t148
  %t150 = load ptr, ptr %t0
  %t151 = load i32, ptr %t99
  %t152 = call ptr @importLocalName(ptr %t150, i32 %t151)
  %t153 = getelementptr inbounds %SymbolList, ptr %t125, i32 0, i32 0
  %t154 = load ptr, ptr %t153
  %t155 = load i32, ptr %t138
  %t156 = sext i32 %t155 to i64
  %t157 = getelementptr inbounds %Symbol, ptr %t154, i64 %t156
  %t158 = getelementptr inbounds %Symbol, ptr %t157, i32 0, i32 1
  %t159 = load i32, ptr %t158
  %t160 = getelementptr inbounds %SymbolList, ptr %t125, i32 0, i32 0
  %t161 = load ptr, ptr %t160
  %t162 = load i32, ptr %t138
  %t163 = sext i32 %t162 to i64
  %t164 = getelementptr inbounds %Symbol, ptr %t161, i64 %t163
  %t165 = getelementptr inbounds %Symbol, ptr %t164, i32 0, i32 2
  %t166 = load %Type, ptr %t165
  %t167 = getelementptr inbounds %SymbolList, ptr %t125, i32 0, i32 0
  %t168 = load ptr, ptr %t167
  %t169 = load i32, ptr %t138
  %t170 = sext i32 %t169 to i64
  %t171 = getelementptr inbounds %Symbol, ptr %t168, i64 %t170
  %t172 = getelementptr inbounds %Symbol, ptr %t171, i32 0, i32 3
  %t173 = load ptr, ptr %t172
  %t174 = getelementptr inbounds %SymbolList, ptr %t125, i32 0, i32 0
  %t175 = load ptr, ptr %t174
  %t176 = load i32, ptr %t138
  %t177 = sext i32 %t176 to i64
  %t178 = getelementptr inbounds %Symbol, ptr %t175, i64 %t177
  %t179 = getelementptr inbounds %Symbol, ptr %t178, i32 0, i32 4
  %t180 = load i32, ptr %t179
  %t181 = load ptr, ptr %t0
  %t182 = getelementptr inbounds %Analyzer, ptr %t181, i32 0, i32 0
  %t183 = load ptr, ptr %t182
  %t184 = getelementptr inbounds %Ast, ptr %t183, i32 0, i32 0
  %t185 = load ptr, ptr %t184
  %t186 = load i32, ptr %t99
  %t187 = sext i32 %t186 to i64
  %t188 = getelementptr inbounds %Node, ptr %t185, i64 %t187
  %t189 = getelementptr inbounds %Node, ptr %t188, i32 0, i32 1
  %t190 = load i32, ptr %t189
  %t191 = load ptr, ptr %t0
  %t192 = getelementptr inbounds %Analyzer, ptr %t191, i32 0, i32 0
  %t193 = load ptr, ptr %t192
  %t194 = getelementptr inbounds %Ast, ptr %t193, i32 0, i32 0
  %t195 = load ptr, ptr %t194
  %t196 = load i32, ptr %t99
  %t197 = sext i32 %t196 to i64
  %t198 = getelementptr inbounds %Node, ptr %t195, i64 %t197
  %t199 = getelementptr inbounds %Node, ptr %t198, i32 0, i32 2
  %t200 = load i32, ptr %t199
  call void @symbolDeclare(ptr %t149, ptr %t152, i32 %t159, %Type %t166, ptr %t173, i32 %t180, i32 %t190, i32 %t200)
  %t201 = load ptr, ptr %t0
  %t202 = getelementptr inbounds %Analyzer, ptr %t201, i32 0, i32 1
  %t203 = load ptr, ptr %t202
  %t204 = getelementptr inbounds %SymbolTable, ptr %t203, i32 0, i32 1
  %t205 = load i32, ptr %t204
  %t206 = load i32, ptr %t146
  %t207 = icmp sgt i32 %t205, %t206
  br i1 %t207, label %L19, label %L21
L19:
  %t208 = getelementptr inbounds %SymbolList, ptr %t125, i32 0, i32 0
  %t209 = load ptr, ptr %t208
  %t210 = load i32, ptr %t138
  %t211 = sext i32 %t210 to i64
  %t212 = getelementptr inbounds %Symbol, ptr %t209, i64 %t211
  %t213 = getelementptr inbounds %Symbol, ptr %t212, i32 0, i32 5
  %t214 = load ptr, ptr %t213
  %t215 = load ptr, ptr %t0
  %t216 = getelementptr inbounds %Analyzer, ptr %t215, i32 0, i32 1
  %t217 = load ptr, ptr %t216
  %t218 = getelementptr inbounds %SymbolTable, ptr %t217, i32 0, i32 0
  %t219 = load ptr, ptr %t218
  %t220 = load i32, ptr %t146
  %t221 = sext i32 %t220 to i64
  %t222 = getelementptr inbounds %Symbol, ptr %t219, i64 %t221
  %t223 = getelementptr inbounds %Symbol, ptr %t222, i32 0, i32 5
  store ptr %t214, ptr %t223
  br label %L21
L21:
  store i1 false, ptr @FAILED
  br label %L18
L18:
  br label %L15
L15:
  %t224 = load i32, ptr %t72
  %t225 = add i32 %t224, 1
  store i32 %t225, ptr %t72
  br label %L10
L12:
  br label %L9
L9:
  %t226 = load i32, ptr %t3
  %t227 = add i32 %t226, 1
  store i32 %t227, ptr %t3
  br label %L0
L2:
  ret void
}

define ptr @analyzerNew(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call ptr @malloc(i64 80)
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = load ptr, ptr %t2
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 0
  store ptr %t3, ptr %t5
  %t6 = call ptr @symbolTableNew()
  %t7 = load ptr, ptr %t2
  %t8 = getelementptr inbounds %Analyzer, ptr %t7, i32 0, i32 1
  store ptr %t6, ptr %t8
  %t9 = call ptr @structTableNew()
  %t10 = load ptr, ptr %t2
  %t11 = getelementptr inbounds %Analyzer, ptr %t10, i32 0, i32 2
  store ptr %t9, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %Ast, ptr %t12, i32 0, i32 1
  %t14 = load i32, ptr %t13
  %t15 = sext i32 %t14 to i64
  %t16 = mul i64 16, %t15
  %t17 = call ptr @malloc(i64 %t16)
  %t18 = load ptr, ptr %t2
  %t19 = getelementptr inbounds %Analyzer, ptr %t18, i32 0, i32 3
  store ptr %t17, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 1
  %t22 = load i32, ptr %t21
  %t23 = sext i32 %t22 to i64
  %t24 = call ptr @malloc(i64 %t23)
  %t25 = load ptr, ptr %t2
  %t26 = getelementptr inbounds %Analyzer, ptr %t25, i32 0, i32 4
  store ptr %t24, ptr %t26
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Ast, ptr %t27, i32 0, i32 1
  %t29 = load i32, ptr %t28
  %t30 = sext i32 %t29 to i64
  %t31 = mul i64 8, %t30
  %t32 = call ptr @malloc(i64 %t31)
  %t33 = load ptr, ptr %t2
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 5
  store ptr %t32, ptr %t34
  %t35 = load i32, ptr @MODULE_COUNT
  %t36 = sext i32 %t35 to i64
  %t37 = mul i64 16, %t36
  %t38 = call ptr @malloc(i64 %t37)
  %t39 = load ptr, ptr %t2
  %t40 = getelementptr inbounds %Analyzer, ptr %t39, i32 0, i32 6
  store ptr %t38, ptr %t40
  %t41 = load ptr, ptr %t2
  %t42 = getelementptr inbounds %Analyzer, ptr %t41, i32 0, i32 7
  store i32 0, ptr %t42
  %t43 = load ptr, ptr %t2
  %t44 = getelementptr inbounds %Analyzer, ptr %t43, i32 0, i32 8
  store i1 false, ptr %t44
  %t45 = load i32, ptr @TY_VOID
  %t46 = call %Type @typeMake(i32 %t45, i32 0)
  %t47 = load ptr, ptr %t2
  %t48 = getelementptr inbounds %Analyzer, ptr %t47, i32 0, i32 9
  store %Type %t46, ptr %t48
  %t49 = alloca i32
  store i32 0, ptr %t49
  br label %L0
L0:
  %t50 = load i32, ptr %t49
  %t51 = load ptr, ptr %t0
  %t52 = getelementptr inbounds %Ast, ptr %t51, i32 0, i32 1
  %t53 = load i32, ptr %t52
  %t54 = icmp slt i32 %t50, %t53
  br i1 %t54, label %L1, label %L2
L1:
  %t55 = load i32, ptr @TY_NONE
  %t56 = call %Type @typeMake(i32 %t55, i32 0)
  %t57 = load ptr, ptr %t2
  %t58 = getelementptr inbounds %Analyzer, ptr %t57, i32 0, i32 3
  %t59 = load ptr, ptr %t58
  %t60 = load i32, ptr %t49
  %t61 = sext i32 %t60 to i64
  %t62 = getelementptr inbounds %Type, ptr %t59, i64 %t61
  store %Type %t56, ptr %t62
  %t63 = trunc i32 0 to i8
  %t64 = load ptr, ptr %t2
  %t65 = getelementptr inbounds %Analyzer, ptr %t64, i32 0, i32 4
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t49
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds i8, ptr %t66, i64 %t68
  store i8 %t63, ptr %t69
  %t70 = call ptr @nullText()
  %t71 = load ptr, ptr %t2
  %t72 = getelementptr inbounds %Analyzer, ptr %t71, i32 0, i32 5
  %t73 = load ptr, ptr %t72
  %t74 = load i32, ptr %t49
  %t75 = sext i32 %t74 to i64
  %t76 = getelementptr inbounds ptr, ptr %t73, i64 %t75
  store ptr %t70, ptr %t76
  %t77 = load i32, ptr %t49
  %t78 = add i32 %t77, 1
  store i32 %t78, ptr %t49
  br label %L0
L2:
  %t79 = load ptr, ptr %t2
  ret ptr %t79
}

define void @analyzerFail(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 12
  %t12 = load i32, ptr %t11
  %t13 = call ptr @modulePath(i32 %t12)
  store ptr %t13, ptr @SOURCE_PATH
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 1
  %t23 = load i32, ptr %t22
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Analyzer, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = getelementptr inbounds %Ast, ptr %t26, i32 0, i32 0
  %t28 = load ptr, ptr %t27
  %t29 = load i32, ptr %t1
  %t30 = sext i32 %t29 to i64
  %t31 = getelementptr inbounds %Node, ptr %t28, i64 %t30
  %t32 = getelementptr inbounds %Node, ptr %t31, i32 0, i32 2
  %t33 = load i32, ptr %t32
  %t34 = load ptr, ptr %t2
  call void @report(i32 %t23, i32 %t33, ptr %t34)
  ret void
}

define void @analyzerFail2(ptr %p0, i32 %p1, ptr %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = call ptr @bufNew()
  %t5 = alloca ptr
  store ptr %t4, ptr %t5
  %t6 = load ptr, ptr %t5
  %t7 = load ptr, ptr %t2
  call void @bufAdd(ptr %t6, ptr %t7)
  %t8 = load ptr, ptr %t5
  call void @bufAdd(ptr %t8, ptr @.str.255)
  %t9 = load ptr, ptr %t5
  %t10 = load ptr, ptr %t3
  call void @bufAdd(ptr %t9, ptr %t10)
  %t11 = load ptr, ptr %t0
  %t12 = load i32, ptr %t1
  %t13 = load ptr, ptr %t5
  %t14 = getelementptr inbounds %Buf, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  call void @analyzerFail(ptr %t11, i32 %t12, ptr %t15)
  ret void
}

define ptr @expectedButGot(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = call ptr @bufNew()
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  call void @bufAdd(ptr %t4, ptr @.str.256)
  %t5 = load ptr, ptr %t3
  %t6 = load ptr, ptr %t0
  call void @bufAdd(ptr %t5, ptr %t6)
  %t7 = load ptr, ptr %t3
  call void @bufAdd(ptr %t7, ptr @.str.257)
  %t8 = load ptr, ptr %t3
  %t9 = load ptr, ptr %t1
  call void @bufAdd(ptr %t8, ptr %t9)
  %t10 = load ptr, ptr %t3
  call void @bufPush(ptr %t10, i8 39)
  %t11 = load ptr, ptr %t3
  %t12 = call ptr @bufTake(ptr %t11)
  ret ptr %t12
}

define ptr @gotType(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t2
  call void @bufAdd(ptr %t3, ptr @.str.258)
  %t4 = load ptr, ptr %t2
  %t5 = load %Type, ptr %t0
  %t6 = call ptr @typeToText(%Type %t5)
  call void @bufAdd(ptr %t4, ptr %t6)
  %t7 = load ptr, ptr %t2
  call void @bufPush(ptr %t7, i8 39)
  %t8 = load ptr, ptr %t2
  %t9 = call ptr @bufTake(ptr %t8)
  ret ptr %t9
}

define ptr @gotTwoTypes(%Type %p0, %Type %p1) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = call ptr @bufNew()
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  call void @bufAdd(ptr %t4, ptr @.str.259)
  %t5 = load ptr, ptr %t3
  %t6 = load %Type, ptr %t0
  %t7 = call ptr @typeToText(%Type %t6)
  call void @bufAdd(ptr %t5, ptr %t7)
  %t8 = load ptr, ptr %t3
  call void @bufAdd(ptr %t8, ptr @.str.260)
  %t9 = load ptr, ptr %t3
  %t10 = load %Type, ptr %t1
  %t11 = call ptr @typeToText(%Type %t10)
  call void @bufAdd(ptr %t9, ptr %t11)
  %t12 = load ptr, ptr %t3
  call void @bufPush(ptr %t12, i8 39)
  %t13 = load ptr, ptr %t3
  %t14 = call ptr @bufTake(ptr %t13)
  ret ptr %t14
}

define ptr @quoted(ptr %p0, ptr %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = call ptr @bufNew()
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t4
  %t6 = load ptr, ptr %t0
  call void @bufAdd(ptr %t5, ptr %t6)
  %t7 = load ptr, ptr %t4
  call void @bufPush(ptr %t7, i8 39)
  %t8 = load ptr, ptr %t4
  %t9 = load ptr, ptr %t1
  call void @bufAdd(ptr %t8, ptr %t9)
  %t10 = load ptr, ptr %t4
  call void @bufPush(ptr %t10, i8 39)
  %t11 = load ptr, ptr %t4
  %t12 = load ptr, ptr %t2
  call void @bufAdd(ptr %t11, ptr %t12)
  %t13 = load ptr, ptr %t4
  %t14 = call ptr @bufTake(ptr %t13)
  ret ptr %t14
}

define %Type @analyzerParseType(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i1
  %t3 = load i32, ptr %t1
  %t4 = load i32, ptr @NO_NODE
  %t5 = icmp eq i32 %t3, %t4
  store i1 %t5, ptr %t2
  br i1 %t5, label %L1, label %L0
L0:
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Analyzer, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = getelementptr inbounds %Ast, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t1
  %t12 = sext i32 %t11 to i64
  %t13 = getelementptr inbounds %Node, ptr %t10, i64 %t12
  %t14 = getelementptr inbounds %Node, ptr %t13, i32 0, i32 0
  %t15 = load i32, ptr %t14
  %t16 = load i32, ptr @NK_TYPE
  %t17 = icmp ne i32 %t15, %t16
  store i1 %t17, ptr %t2
  br label %L1
L1:
  %t18 = load i1, ptr %t2
  br i1 %t18, label %L2, label %L4
L2:
  call void @failAt(i32 0, i32 0, ptr @.str.261)
  br label %L4
L4:
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Analyzer, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = getelementptr inbounds %Ast, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = load i32, ptr %t1
  %t25 = sext i32 %t24 to i64
  %t26 = getelementptr inbounds %Node, ptr %t23, i64 %t25
  %t27 = getelementptr inbounds %Node, ptr %t26, i32 0, i32 3
  %t28 = load ptr, ptr %t27
  %t29 = alloca ptr
  store ptr %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Analyzer, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = getelementptr inbounds %Ast, ptr %t32, i32 0, i32 0
  %t34 = load ptr, ptr %t33
  %t35 = load i32, ptr %t1
  %t36 = sext i32 %t35 to i64
  %t37 = getelementptr inbounds %Node, ptr %t34, i64 %t36
  %t38 = getelementptr inbounds %Node, ptr %t37, i32 0, i32 8
  %t39 = load i32, ptr %t38
  %t40 = alloca i32
  store i32 %t39, ptr %t40
  %t41 = load ptr, ptr %t29
  %t42 = call i32 @typeKindFromName(ptr %t41)
  %t43 = alloca i32
  store i32 %t42, ptr %t43
  %t44 = load i32, ptr %t43
  %t45 = load i32, ptr @TY_NONE
  %t46 = icmp eq i32 %t44, %t45
  br i1 %t46, label %L5, label %L7
L5:
  %t47 = load ptr, ptr %t29
  %t48 = load i32, ptr %t40
  %t49 = call %Type @typeStruct(ptr %t47, i32 %t48)
  ret %Type %t49
L7:
  %t50 = load i32, ptr %t43
  %t51 = load i32, ptr %t40
  %t52 = call %Type @typeMake(i32 %t50, i32 %t51)
  ret %Type %t52
}

define void @analyzerValidateType(ptr %p0, i32 %p1, %Type %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = getelementptr inbounds %Type, ptr %t2, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_STRUCT
  %t7 = icmp ne i32 %t5, %t6
  br i1 %t7, label %L0, label %L2
L0:
  ret void
L2:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Analyzer, ptr %t8, i32 0, i32 2
  %t10 = load ptr, ptr %t9
  %t11 = getelementptr inbounds %Type, ptr %t2, i32 0, i32 2
  %t12 = load ptr, ptr %t11
  %t13 = call i32 @structIndexOf(ptr %t10, ptr %t12)
  %t14 = icmp slt i32 %t13, 0
  br i1 %t14, label %L3, label %L5
L3:
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t1
  %t17 = load ptr, ptr %t3
  %t18 = load %Type, ptr %t2
  %t19 = call ptr @typeToText(%Type %t18)
  %t20 = call ptr @quoted(ptr @.str.262, ptr %t19, ptr @.str.263)
  call void @analyzerFail2(ptr %t15, i32 %t16, ptr %t17, ptr %t20)
  br label %L5
L5:
  ret void
}

define ptr @analyzerParamTypes(ptr %p0, i32 %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i1
  %t4 = load i32, ptr %t1
  %t5 = load i32, ptr @NO_NODE
  %t6 = icmp eq i32 %t4, %t5
  store i1 %t6, ptr %t3
  br i1 %t6, label %L1, label %L0
L0:
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Analyzer, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = getelementptr inbounds %Ast, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t1
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Node, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Node, ptr %t14, i32 0, i32 0
  %t16 = load i32, ptr %t15
  %t17 = load i32, ptr @NK_PARAMS
  %t18 = icmp ne i32 %t16, %t17
  store i1 %t18, ptr %t3
  br label %L1
L1:
  %t19 = load i1, ptr %t3
  br i1 %t19, label %L2, label %L4
L2:
  %t20 = load ptr, ptr %t2
  store i32 0, ptr %t20
  %t21 = sext i32 0 to i64
  %t22 = inttoptr i64 %t21 to ptr
  ret ptr %t22
L4:
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Analyzer, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = getelementptr inbounds %Ast, ptr %t25, i32 0, i32 0
  %t27 = load ptr, ptr %t26
  %t28 = load i32, ptr %t1
  %t29 = sext i32 %t28 to i64
  %t30 = getelementptr inbounds %Node, ptr %t27, i64 %t29
  %t31 = getelementptr inbounds %Node, ptr %t30, i32 0, i32 10
  %t32 = load i32, ptr %t31
  %t33 = alloca i32
  store i32 %t32, ptr %t33
  %t34 = load i32, ptr %t33
  %t35 = load ptr, ptr %t2
  store i32 %t34, ptr %t35
  %t36 = load i32, ptr %t33
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %L5, label %L7
L5:
  %t38 = sext i32 0 to i64
  %t39 = inttoptr i64 %t38 to ptr
  ret ptr %t39
L7:
  %t40 = load i32, ptr %t33
  %t41 = sext i32 %t40 to i64
  %t42 = mul i64 16, %t41
  %t43 = call ptr @malloc(i64 %t42)
  %t44 = alloca ptr
  store ptr %t43, ptr %t44
  %t45 = alloca i32
  store i32 0, ptr %t45
  br label %L8
L8:
  %t46 = load i32, ptr %t45
  %t47 = load i32, ptr %t33
  %t48 = icmp slt i32 %t46, %t47
  br i1 %t48, label %L9, label %L10
L9:
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr inbounds %Analyzer, ptr %t49, i32 0, i32 0
  %t51 = load ptr, ptr %t50
  %t52 = getelementptr inbounds %Ast, ptr %t51, i32 0, i32 0
  %t53 = load ptr, ptr %t52
  %t54 = load i32, ptr %t1
  %t55 = sext i32 %t54 to i64
  %t56 = getelementptr inbounds %Node, ptr %t53, i64 %t55
  %t57 = getelementptr inbounds %Node, ptr %t56, i32 0, i32 9
  %t58 = load ptr, ptr %t57
  %t59 = load i32, ptr %t45
  %t60 = sext i32 %t59 to i64
  %t61 = getelementptr inbounds i32, ptr %t58, i64 %t60
  %t62 = load i32, ptr %t61
  %t63 = alloca i32
  store i32 %t62, ptr %t63
  %t64 = load ptr, ptr %t0
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr inbounds %Analyzer, ptr %t65, i32 0, i32 0
  %t67 = load ptr, ptr %t66
  %t68 = getelementptr inbounds %Ast, ptr %t67, i32 0, i32 0
  %t69 = load ptr, ptr %t68
  %t70 = load i32, ptr %t63
  %t71 = sext i32 %t70 to i64
  %t72 = getelementptr inbounds %Node, ptr %t69, i64 %t71
  %t73 = getelementptr inbounds %Node, ptr %t72, i32 0, i32 5
  %t74 = load i32, ptr %t73
  %t75 = call %Type @analyzerParseType(ptr %t64, i32 %t74)
  %t76 = load ptr, ptr %t44
  %t77 = load i32, ptr %t45
  %t78 = sext i32 %t77 to i64
  %t79 = getelementptr inbounds %Type, ptr %t76, i64 %t78
  store %Type %t75, ptr %t79
  %t80 = load i32, ptr %t45
  %t81 = add i32 %t80, 1
  store i32 %t81, ptr %t45
  br label %L8
L10:
  %t82 = load ptr, ptr %t44
  ret ptr %t82
}

define i1 @isLValue(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i1
  %t14 = alloca i1
  %t15 = load i32, ptr %t12
  %t16 = load i32, ptr @NK_IDENT
  %t17 = icmp eq i32 %t15, %t16
  store i1 %t17, ptr %t14
  br i1 %t17, label %L1, label %L0
L0:
  %t18 = load i32, ptr %t12
  %t19 = load i32, ptr @NK_FIELDACCESS
  %t20 = icmp eq i32 %t18, %t19
  store i1 %t20, ptr %t14
  br label %L1
L1:
  %t21 = load i1, ptr %t14
  store i1 %t21, ptr %t13
  br i1 %t21, label %L3, label %L2
L2:
  %t22 = load i32, ptr %t12
  %t23 = load i32, ptr @NK_INDEX
  %t24 = icmp eq i32 %t22, %t23
  store i1 %t24, ptr %t13
  br label %L3
L3:
  %t25 = load i1, ptr %t13
  br i1 %t25, label %L4, label %L6
L4:
  ret i1 true
L6:
  %t26 = load i32, ptr %t12
  %t27 = load i32, ptr @NK_UNARY
  %t28 = icmp eq i32 %t26, %t27
  br i1 %t28, label %L7, label %L9
L7:
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Analyzer, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = getelementptr inbounds %Ast, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t1
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %Node, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %Node, ptr %t36, i32 0, i32 3
  %t38 = load ptr, ptr %t37
  %t39 = call i1 @textEquals(ptr %t38, ptr @.str.264)
  ret i1 %t39
L9:
  ret i1 false
}

define %Type @checkExpr(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i1, ptr @FAILED
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = load i32, ptr @TY_NONE
  %t4 = call %Type @typeMake(i32 %t3, i32 0)
  ret %Type %t4
L2:
  %t5 = load ptr, ptr %t0
  %t6 = load i32, ptr %t1
  %t7 = call %Type @inferExprType(ptr %t5, i32 %t6)
  %t8 = alloca %Type
  store %Type %t7, ptr %t8
  %t9 = load %Type, ptr %t8
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Analyzer, ptr %t10, i32 0, i32 3
  %t12 = load ptr, ptr %t11
  %t13 = load i32, ptr %t1
  %t14 = sext i32 %t13 to i64
  %t15 = getelementptr inbounds %Type, ptr %t12, i64 %t14
  store %Type %t9, ptr %t15
  %t16 = load %Type, ptr %t8
  ret %Type %t16
}

define %Type @inferExprType(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @NK_BINARY
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L0, label %L2
L0:
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr %t1
  %t18 = call %Type @checkBinaryOp(ptr %t16, i32 %t17)
  ret %Type %t18
L2:
  %t19 = load i32, ptr %t12
  %t20 = load i32, ptr @NK_UNARY
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L3, label %L5
L3:
  %t22 = load ptr, ptr %t0
  %t23 = load i32, ptr %t1
  %t24 = call %Type @checkUnaryOp(ptr %t22, i32 %t23)
  ret %Type %t24
L5:
  %t25 = load i32, ptr %t12
  %t26 = load i32, ptr @NK_CAST
  %t27 = icmp eq i32 %t25, %t26
  br i1 %t27, label %L6, label %L8
L6:
  %t28 = load ptr, ptr %t0
  %t29 = load i32, ptr %t1
  %t30 = call %Type @checkCast(ptr %t28, i32 %t29)
  ret %Type %t30
L8:
  %t31 = load i32, ptr %t12
  %t32 = load i32, ptr @NK_FIELDACCESS
  %t33 = icmp eq i32 %t31, %t32
  br i1 %t33, label %L9, label %L11
L9:
  %t34 = load ptr, ptr %t0
  %t35 = load i32, ptr %t1
  %t36 = call %Type @checkFieldAccess(ptr %t34, i32 %t35)
  ret %Type %t36
L11:
  %t37 = load i32, ptr %t12
  %t38 = load i32, ptr @NK_INDEX
  %t39 = icmp eq i32 %t37, %t38
  br i1 %t39, label %L12, label %L14
L12:
  %t40 = load ptr, ptr %t0
  %t41 = load i32, ptr %t1
  %t42 = call %Type @checkIndex(ptr %t40, i32 %t41)
  ret %Type %t42
L14:
  %t43 = load i32, ptr %t12
  %t44 = load i32, ptr @NK_STRUCTLIT
  %t45 = icmp eq i32 %t43, %t44
  br i1 %t45, label %L15, label %L17
L15:
  %t46 = load ptr, ptr %t0
  %t47 = load i32, ptr %t1
  %t48 = call %Type @checkStructLiteral(ptr %t46, i32 %t47)
  ret %Type %t48
L17:
  %t49 = load i32, ptr %t12
  %t50 = load i32, ptr @NK_CALL
  %t51 = icmp eq i32 %t49, %t50
  br i1 %t51, label %L18, label %L20
L18:
  %t52 = load ptr, ptr %t0
  %t53 = load i32, ptr %t1
  %t54 = call %Type @checkCall(ptr %t52, i32 %t53)
  ret %Type %t54
L20:
  %t55 = load i32, ptr %t12
  %t56 = load i32, ptr @NK_NUMBER
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L21, label %L23
L21:
  %t58 = load ptr, ptr %t0
  %t59 = load i32, ptr %t1
  %t60 = load i32, ptr @TY_I32
  %t61 = call %Type @typeMake(i32 %t60, i32 0)
  %t62 = call %Type @checkNumberLiteral(ptr %t58, i32 %t59, %Type %t61)
  ret %Type %t62
L23:
  %t63 = load i32, ptr %t12
  %t64 = load i32, ptr @NK_BOOL
  %t65 = icmp eq i32 %t63, %t64
  br i1 %t65, label %L24, label %L26
L24:
  %t66 = load i32, ptr @TY_BOOL
  %t67 = call %Type @typeMake(i32 %t66, i32 0)
  ret %Type %t67
L26:
  %t68 = load i32, ptr %t12
  %t69 = load i32, ptr @NK_STRING
  %t70 = icmp eq i32 %t68, %t69
  br i1 %t70, label %L27, label %L29
L27:
  %t71 = load i32, ptr @TY_I8
  %t72 = call %Type @typeMake(i32 %t71, i32 1)
  ret %Type %t72
L29:
  %t73 = load i32, ptr %t12
  %t74 = load i32, ptr @NK_CHAR
  %t75 = icmp eq i32 %t73, %t74
  br i1 %t75, label %L30, label %L32
L30:
  %t76 = load i32, ptr @TY_I8
  %t77 = call %Type @typeMake(i32 %t76, i32 0)
  ret %Type %t77
L32:
  %t78 = load i32, ptr %t12
  %t79 = load i32, ptr @NK_SIZEOF
  %t80 = icmp eq i32 %t78, %t79
  br i1 %t80, label %L33, label %L35
L33:
  %t81 = load ptr, ptr %t0
  %t82 = load ptr, ptr %t0
  %t83 = getelementptr inbounds %Analyzer, ptr %t82, i32 0, i32 0
  %t84 = load ptr, ptr %t83
  %t85 = getelementptr inbounds %Ast, ptr %t84, i32 0, i32 0
  %t86 = load ptr, ptr %t85
  %t87 = load i32, ptr %t1
  %t88 = sext i32 %t87 to i64
  %t89 = getelementptr inbounds %Node, ptr %t86, i64 %t88
  %t90 = getelementptr inbounds %Node, ptr %t89, i32 0, i32 5
  %t91 = load i32, ptr %t90
  %t92 = call %Type @analyzerParseType(ptr %t81, i32 %t91)
  %t93 = alloca %Type
  store %Type %t92, ptr %t93
  %t94 = load ptr, ptr %t0
  %t95 = load i32, ptr %t1
  %t96 = load %Type, ptr %t93
  call void @analyzerValidateType(ptr %t94, i32 %t95, %Type %t96, ptr @.str.265)
  %t97 = load %Type, ptr %t93
  %t98 = call i1 @typeIsVoid(%Type %t97)
  br i1 %t98, label %L36, label %L38
L36:
  %t99 = load ptr, ptr %t0
  %t100 = load i32, ptr %t1
  call void @analyzerFail(ptr %t99, i32 %t100, ptr @.str.266)
  br label %L38
L38:
  %t101 = load i32, ptr @TY_U64
  %t102 = call %Type @typeMake(i32 %t101, i32 0)
  ret %Type %t102
L35:
  %t103 = load i32, ptr %t12
  %t104 = load i32, ptr @NK_IDENT
  %t105 = icmp eq i32 %t103, %t104
  br i1 %t105, label %L39, label %L41
L39:
  %t106 = load ptr, ptr %t0
  %t107 = getelementptr inbounds %Analyzer, ptr %t106, i32 0, i32 0
  %t108 = load ptr, ptr %t107
  %t109 = getelementptr inbounds %Ast, ptr %t108, i32 0, i32 0
  %t110 = load ptr, ptr %t109
  %t111 = load i32, ptr %t1
  %t112 = sext i32 %t111 to i64
  %t113 = getelementptr inbounds %Node, ptr %t110, i64 %t112
  %t114 = getelementptr inbounds %Node, ptr %t113, i32 0, i32 3
  %t115 = load ptr, ptr %t114
  %t116 = alloca ptr
  store ptr %t115, ptr %t116
  %t117 = load ptr, ptr %t0
  %t118 = getelementptr inbounds %Analyzer, ptr %t117, i32 0, i32 1
  %t119 = load ptr, ptr %t118
  %t120 = load ptr, ptr %t116
  %t121 = call i32 @symbolFind(ptr %t119, ptr %t120)
  %t122 = alloca i32
  store i32 %t121, ptr %t122
  %t123 = load i32, ptr %t122
  %t124 = icmp slt i32 %t123, 0
  br i1 %t124, label %L42, label %L44
L42:
  %t125 = load ptr, ptr %t0
  %t126 = load i32, ptr %t1
  %t127 = load ptr, ptr %t116
  %t128 = call ptr @quoted(ptr @.str.267, ptr %t127, ptr @.str.268)
  call void @analyzerFail(ptr %t125, i32 %t126, ptr %t128)
  %t129 = load i32, ptr @TY_NONE
  %t130 = call %Type @typeMake(i32 %t129, i32 0)
  ret %Type %t130
L44:
  %t131 = load ptr, ptr %t0
  %t132 = getelementptr inbounds %Analyzer, ptr %t131, i32 0, i32 1
  %t133 = load ptr, ptr %t132
  %t134 = getelementptr inbounds %SymbolTable, ptr %t133, i32 0, i32 0
  %t135 = load ptr, ptr %t134
  %t136 = load i32, ptr %t122
  %t137 = sext i32 %t136 to i64
  %t138 = getelementptr inbounds %Symbol, ptr %t135, i64 %t137
  %t139 = getelementptr inbounds %Symbol, ptr %t138, i32 0, i32 1
  %t140 = load i32, ptr %t139
  %t141 = load i32, ptr @SYM_VAR
  %t142 = icmp ne i32 %t140, %t141
  br i1 %t142, label %L45, label %L47
L45:
  %t143 = load ptr, ptr %t0
  %t144 = load i32, ptr %t1
  %t145 = load ptr, ptr %t116
  %t146 = call ptr @quoted(ptr @.str.269, ptr %t145, ptr @.str.270)
  call void @analyzerFail(ptr %t143, i32 %t144, ptr %t146)
  br label %L47
L47:
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 1
  %t149 = load ptr, ptr %t148
  %t150 = getelementptr inbounds %SymbolTable, ptr %t149, i32 0, i32 0
  %t151 = load ptr, ptr %t150
  %t152 = load i32, ptr %t122
  %t153 = sext i32 %t152 to i64
  %t154 = getelementptr inbounds %Symbol, ptr %t151, i64 %t153
  %t155 = getelementptr inbounds %Symbol, ptr %t154, i32 0, i32 5
  %t156 = load ptr, ptr %t155
  %t157 = load ptr, ptr %t0
  %t158 = getelementptr inbounds %Analyzer, ptr %t157, i32 0, i32 5
  %t159 = load ptr, ptr %t158
  %t160 = load i32, ptr %t1
  %t161 = sext i32 %t160 to i64
  %t162 = getelementptr inbounds ptr, ptr %t159, i64 %t161
  store ptr %t156, ptr %t162
  %t163 = load ptr, ptr %t0
  %t164 = getelementptr inbounds %Analyzer, ptr %t163, i32 0, i32 1
  %t165 = load ptr, ptr %t164
  %t166 = getelementptr inbounds %SymbolTable, ptr %t165, i32 0, i32 0
  %t167 = load ptr, ptr %t166
  %t168 = load i32, ptr %t122
  %t169 = sext i32 %t168 to i64
  %t170 = getelementptr inbounds %Symbol, ptr %t167, i64 %t169
  %t171 = getelementptr inbounds %Symbol, ptr %t170, i32 0, i32 2
  %t172 = load %Type, ptr %t171
  ret %Type %t172
L41:
  %t173 = load ptr, ptr %t0
  %t174 = load i32, ptr %t1
  call void @analyzerFail(ptr %t173, i32 %t174, ptr @.str.271)
  %t175 = load i32, ptr @TY_VOID
  %t176 = call %Type @typeMake(i32 %t175, i32 0)
  ret %Type %t176
}

define %Type @checkAssignTarget(ptr %p0, i32 %p1, i32 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = load i32, ptr %t2
  %t5 = call i1 @isLValue(ptr %t3, i32 %t4)
  %t6 = xor i1 %t5, true
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t0
  %t8 = load i32, ptr %t1
  call void @analyzerFail(ptr %t7, i32 %t8, ptr @.str.272)
  br label %L2
L2:
  %t9 = load ptr, ptr %t0
  %t10 = load i32, ptr %t2
  %t11 = call %Type @checkExpr(ptr %t9, i32 %t10)
  ret %Type %t11
}

define %Type @checkCall(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 1
  %t15 = load ptr, ptr %t14
  %t16 = load ptr, ptr %t12
  %t17 = call i32 @symbolFind(ptr %t15, ptr %t16)
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load i32, ptr %t18
  %t20 = icmp slt i32 %t19, 0
  br i1 %t20, label %L0, label %L2
L0:
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr %t1
  %t23 = load ptr, ptr %t12
  %t24 = call ptr @quoted(ptr @.str.273, ptr %t23, ptr @.str.274)
  call void @analyzerFail(ptr %t21, i32 %t22, ptr %t24)
  %t25 = load i32, ptr @TY_NONE
  %t26 = call %Type @typeMake(i32 %t25, i32 0)
  ret %Type %t26
L2:
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Analyzer, ptr %t27, i32 0, i32 1
  %t29 = load ptr, ptr %t28
  %t30 = getelementptr inbounds %SymbolTable, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t18
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Symbol, ptr %t31, i64 %t33
  %t35 = getelementptr inbounds %Symbol, ptr %t34, i32 0, i32 1
  %t36 = load i32, ptr %t35
  %t37 = load i32, ptr @SYM_FN
  %t38 = icmp ne i32 %t36, %t37
  br i1 %t38, label %L3, label %L5
L3:
  %t39 = load ptr, ptr %t0
  %t40 = load i32, ptr %t1
  %t41 = load ptr, ptr %t12
  %t42 = call ptr @quoted(ptr @.str.275, ptr %t41, ptr @.str.276)
  call void @analyzerFail(ptr %t39, i32 %t40, ptr %t42)
  br label %L5
L5:
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr inbounds %Analyzer, ptr %t43, i32 0, i32 1
  %t45 = load ptr, ptr %t44
  %t46 = getelementptr inbounds %SymbolTable, ptr %t45, i32 0, i32 0
  %t47 = load ptr, ptr %t46
  %t48 = load i32, ptr %t18
  %t49 = sext i32 %t48 to i64
  %t50 = getelementptr inbounds %Symbol, ptr %t47, i64 %t49
  %t51 = getelementptr inbounds %Symbol, ptr %t50, i32 0, i32 5
  %t52 = load ptr, ptr %t51
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr inbounds %Analyzer, ptr %t53, i32 0, i32 5
  %t55 = load ptr, ptr %t54
  %t56 = load i32, ptr %t1
  %t57 = sext i32 %t56 to i64
  %t58 = getelementptr inbounds ptr, ptr %t55, i64 %t57
  store ptr %t52, ptr %t58
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Analyzer, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = getelementptr inbounds %Ast, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t1
  %t65 = sext i32 %t64 to i64
  %t66 = getelementptr inbounds %Node, ptr %t63, i64 %t65
  %t67 = getelementptr inbounds %Node, ptr %t66, i32 0, i32 5
  %t68 = load i32, ptr %t67
  %t69 = alloca i32
  store i32 %t68, ptr %t69
  %t70 = alloca i32
  store i32 0, ptr %t70
  %t71 = load i32, ptr %t69
  %t72 = load i32, ptr @NO_NODE
  %t73 = icmp ne i32 %t71, %t72
  br i1 %t73, label %L6, label %L8
L6:
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %Analyzer, ptr %t74, i32 0, i32 0
  %t76 = load ptr, ptr %t75
  %t77 = getelementptr inbounds %Ast, ptr %t76, i32 0, i32 0
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr %t69
  %t80 = sext i32 %t79 to i64
  %t81 = getelementptr inbounds %Node, ptr %t78, i64 %t80
  %t82 = getelementptr inbounds %Node, ptr %t81, i32 0, i32 10
  %t83 = load i32, ptr %t82
  store i32 %t83, ptr %t70
  br label %L8
L8:
  %t84 = load ptr, ptr %t0
  %t85 = getelementptr inbounds %Analyzer, ptr %t84, i32 0, i32 1
  %t86 = load ptr, ptr %t85
  %t87 = getelementptr inbounds %SymbolTable, ptr %t86, i32 0, i32 0
  %t88 = load ptr, ptr %t87
  %t89 = load i32, ptr %t18
  %t90 = sext i32 %t89 to i64
  %t91 = getelementptr inbounds %Symbol, ptr %t88, i64 %t90
  %t92 = getelementptr inbounds %Symbol, ptr %t91, i32 0, i32 4
  %t93 = load i32, ptr %t92
  %t94 = alloca i32
  store i32 %t93, ptr %t94
  %t95 = load i32, ptr %t70
  %t96 = load i32, ptr %t94
  %t97 = icmp ne i32 %t95, %t96
  br i1 %t97, label %L9, label %L11
L9:
  %t98 = call ptr @bufNew()
  %t99 = alloca ptr
  store ptr %t98, ptr %t99
  %t100 = load ptr, ptr %t99
  call void @bufAdd(ptr %t100, ptr @.str.277)
  %t101 = load ptr, ptr %t99
  %t102 = load i32, ptr %t94
  %t103 = sext i32 %t102 to i64
  call void @bufAddInt(ptr %t101, i64 %t103)
  %t104 = load ptr, ptr %t99
  call void @bufAdd(ptr %t104, ptr @.str.278)
  %t105 = load ptr, ptr %t99
  %t106 = load i32, ptr %t70
  %t107 = sext i32 %t106 to i64
  call void @bufAddInt(ptr %t105, i64 %t107)
  %t108 = load ptr, ptr %t0
  %t109 = load i32, ptr %t1
  %t110 = load ptr, ptr %t12
  %t111 = call ptr @quoted(ptr @.str.279, ptr %t110, ptr @.str.280)
  %t112 = load ptr, ptr %t99
  %t113 = getelementptr inbounds %Buf, ptr %t112, i32 0, i32 0
  %t114 = load ptr, ptr %t113
  call void @analyzerFail2(ptr %t108, i32 %t109, ptr %t111, ptr %t114)
  br label %L11
L11:
  %t115 = alloca i32
  store i32 0, ptr %t115
  br label %L12
L12:
  %t116 = load i32, ptr %t115
  %t117 = load i32, ptr %t70
  %t118 = icmp slt i32 %t116, %t117
  br i1 %t118, label %L13, label %L14
L13:
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr inbounds %Analyzer, ptr %t119, i32 0, i32 0
  %t121 = load ptr, ptr %t120
  %t122 = getelementptr inbounds %Ast, ptr %t121, i32 0, i32 0
  %t123 = load ptr, ptr %t122
  %t124 = load i32, ptr %t69
  %t125 = sext i32 %t124 to i64
  %t126 = getelementptr inbounds %Node, ptr %t123, i64 %t125
  %t127 = getelementptr inbounds %Node, ptr %t126, i32 0, i32 9
  %t128 = load ptr, ptr %t127
  %t129 = load i32, ptr %t115
  %t130 = sext i32 %t129 to i64
  %t131 = getelementptr inbounds i32, ptr %t128, i64 %t130
  %t132 = load i32, ptr %t131
  %t133 = alloca i32
  store i32 %t132, ptr %t133
  %t134 = load ptr, ptr %t0
  %t135 = load i32, ptr %t133
  %t136 = call %Type @checkExpr(ptr %t134, i32 %t135)
  %t137 = alloca %Type
  store %Type %t136, ptr %t137
  %t138 = load ptr, ptr %t0
  %t139 = getelementptr inbounds %Analyzer, ptr %t138, i32 0, i32 1
  %t140 = load ptr, ptr %t139
  %t141 = getelementptr inbounds %SymbolTable, ptr %t140, i32 0, i32 0
  %t142 = load ptr, ptr %t141
  %t143 = load i32, ptr %t18
  %t144 = sext i32 %t143 to i64
  %t145 = getelementptr inbounds %Symbol, ptr %t142, i64 %t144
  %t146 = getelementptr inbounds %Symbol, ptr %t145, i32 0, i32 3
  %t147 = load ptr, ptr %t146
  %t148 = load i32, ptr %t115
  %t149 = sext i32 %t148 to i64
  %t150 = getelementptr inbounds %Type, ptr %t147, i64 %t149
  %t151 = load %Type, ptr %t150
  %t152 = alloca %Type
  store %Type %t151, ptr %t152
  %t153 = load %Type, ptr %t137
  %t154 = load %Type, ptr %t152
  %t155 = call i1 @typeEquals(%Type %t153, %Type %t154)
  %t156 = xor i1 %t155, true
  br i1 %t156, label %L15, label %L17
L15:
  %t157 = call ptr @bufNew()
  %t158 = alloca ptr
  store ptr %t157, ptr %t158
  %t159 = load ptr, ptr %t158
  call void @bufAdd(ptr %t159, ptr @.str.281)
  %t160 = load ptr, ptr %t158
  %t161 = load i32, ptr %t115
  %t162 = add i32 %t161, 1
  %t163 = sext i32 %t162 to i64
  call void @bufAddInt(ptr %t160, i64 %t163)
  %t164 = load ptr, ptr %t158
  call void @bufAdd(ptr %t164, ptr @.str.282)
  %t165 = load ptr, ptr %t158
  %t166 = load ptr, ptr %t12
  call void @bufAdd(ptr %t165, ptr %t166)
  %t167 = load ptr, ptr %t158
  call void @bufAdd(ptr %t167, ptr @.str.283)
  %t168 = load ptr, ptr %t0
  %t169 = load i32, ptr %t1
  %t170 = load ptr, ptr %t158
  %t171 = getelementptr inbounds %Buf, ptr %t170, i32 0, i32 0
  %t172 = load ptr, ptr %t171
  %t173 = load %Type, ptr %t152
  %t174 = call ptr @typeToText(%Type %t173)
  %t175 = load %Type, ptr %t137
  %t176 = call ptr @typeToText(%Type %t175)
  %t177 = call ptr @expectedButGot(ptr %t174, ptr %t176)
  call void @analyzerFail2(ptr %t168, i32 %t169, ptr %t172, ptr %t177)
  br label %L17
L17:
  %t178 = load i32, ptr %t115
  %t179 = add i32 %t178, 1
  store i32 %t179, ptr %t115
  br label %L12
L14:
  %t180 = load ptr, ptr %t0
  %t181 = getelementptr inbounds %Analyzer, ptr %t180, i32 0, i32 1
  %t182 = load ptr, ptr %t181
  %t183 = getelementptr inbounds %SymbolTable, ptr %t182, i32 0, i32 0
  %t184 = load ptr, ptr %t183
  %t185 = load i32, ptr %t18
  %t186 = sext i32 %t185 to i64
  %t187 = getelementptr inbounds %Symbol, ptr %t184, i64 %t186
  %t188 = getelementptr inbounds %Symbol, ptr %t187, i32 0, i32 2
  %t189 = load %Type, ptr %t188
  ret %Type %t189
}

define %Type @checkUnaryOp(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  %t16 = getelementptr inbounds %Ast, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load i32, ptr %t1
  %t19 = sext i32 %t18 to i64
  %t20 = getelementptr inbounds %Node, ptr %t17, i64 %t19
  %t21 = getelementptr inbounds %Node, ptr %t20, i32 0, i32 5
  %t22 = load i32, ptr %t21
  %t23 = alloca i32
  store i32 %t22, ptr %t23
  %t24 = load ptr, ptr %t12
  %t25 = call i1 @textEquals(ptr %t24, ptr @.str.284)
  br i1 %t25, label %L0, label %L2
L0:
  %t26 = load ptr, ptr %t0
  %t27 = load i32, ptr %t23
  %t28 = call i1 @isLValue(ptr %t26, i32 %t27)
  %t29 = xor i1 %t28, true
  br i1 %t29, label %L3, label %L5
L3:
  %t30 = load ptr, ptr %t0
  %t31 = load i32, ptr %t1
  call void @analyzerFail(ptr %t30, i32 %t31, ptr @.str.285)
  br label %L5
L5:
  %t32 = load ptr, ptr %t0
  %t33 = load i32, ptr %t23
  %t34 = call %Type @checkExpr(ptr %t32, i32 %t33)
  %t35 = alloca %Type
  store %Type %t34, ptr %t35
  %t36 = load %Type, ptr %t35
  %t37 = call i1 @typeIsVoid(%Type %t36)
  br i1 %t37, label %L6, label %L8
L6:
  %t38 = load ptr, ptr %t0
  %t39 = load i32, ptr %t1
  call void @analyzerFail(ptr %t38, i32 %t39, ptr @.str.286)
  br label %L8
L8:
  %t40 = load %Type, ptr %t35
  %t41 = call %Type @typePointerTo(%Type %t40)
  ret %Type %t41
L2:
  %t42 = load ptr, ptr %t0
  %t43 = load i32, ptr %t23
  %t44 = call %Type @checkExpr(ptr %t42, i32 %t43)
  %t45 = alloca %Type
  store %Type %t44, ptr %t45
  %t46 = load ptr, ptr %t12
  %t47 = call i1 @textEquals(ptr %t46, ptr @.str.287)
  br i1 %t47, label %L9, label %L11
L9:
  %t48 = load %Type, ptr %t45
  %t49 = call i1 @typeIsNumeric(%Type %t48)
  %t50 = xor i1 %t49, true
  br i1 %t50, label %L12, label %L14
L12:
  %t51 = load ptr, ptr %t0
  %t52 = load i32, ptr %t1
  %t53 = load %Type, ptr %t45
  %t54 = call ptr @gotType(%Type %t53)
  call void @analyzerFail2(ptr %t51, i32 %t52, ptr @.str.288, ptr %t54)
  br label %L14
L14:
  %t55 = load %Type, ptr %t45
  ret %Type %t55
L11:
  %t56 = load ptr, ptr %t12
  %t57 = call i1 @textEquals(ptr %t56, ptr @.str.289)
  br i1 %t57, label %L15, label %L17
L15:
  %t58 = load %Type, ptr %t45
  %t59 = call i1 @typeIsNumeric(%Type %t58)
  %t60 = xor i1 %t59, true
  br i1 %t60, label %L18, label %L20
L18:
  %t61 = load ptr, ptr %t0
  %t62 = load i32, ptr %t1
  %t63 = load %Type, ptr %t45
  %t64 = call ptr @gotType(%Type %t63)
  call void @analyzerFail2(ptr %t61, i32 %t62, ptr @.str.290, ptr %t64)
  br label %L20
L20:
  %t65 = load %Type, ptr %t45
  ret %Type %t65
L17:
  %t66 = load ptr, ptr %t12
  %t67 = call i1 @textEquals(ptr %t66, ptr @.str.291)
  br i1 %t67, label %L21, label %L23
L21:
  %t68 = load %Type, ptr %t45
  %t69 = call i1 @typeIsBool(%Type %t68)
  %t70 = xor i1 %t69, true
  br i1 %t70, label %L24, label %L26
L24:
  %t71 = load ptr, ptr %t0
  %t72 = load i32, ptr %t1
  %t73 = load %Type, ptr %t45
  %t74 = call ptr @gotType(%Type %t73)
  call void @analyzerFail2(ptr %t71, i32 %t72, ptr @.str.292, ptr %t74)
  br label %L26
L26:
  %t75 = load i32, ptr @TY_BOOL
  %t76 = call %Type @typeMake(i32 %t75, i32 0)
  ret %Type %t76
L23:
  %t77 = load ptr, ptr %t12
  %t78 = call i1 @textEquals(ptr %t77, ptr @.str.293)
  br i1 %t78, label %L27, label %L29
L27:
  %t79 = load %Type, ptr %t45
  %t80 = call i1 @typeIsPointer(%Type %t79)
  %t81 = xor i1 %t80, true
  br i1 %t81, label %L30, label %L32
L30:
  %t82 = load ptr, ptr %t0
  %t83 = load i32, ptr %t1
  %t84 = load %Type, ptr %t45
  %t85 = call ptr @gotType(%Type %t84)
  call void @analyzerFail2(ptr %t82, i32 %t83, ptr @.str.294, ptr %t85)
  br label %L32
L32:
  %t86 = load %Type, ptr %t45
  %t87 = call %Type @typePointee(%Type %t86)
  %t88 = call i1 @typeIsVoid(%Type %t87)
  br i1 %t88, label %L33, label %L35
L33:
  %t89 = load ptr, ptr %t0
  %t90 = load i32, ptr %t1
  call void @analyzerFail2(ptr %t89, i32 %t90, ptr @.str.295, ptr @.str.296)
  br label %L35
L35:
  %t91 = load %Type, ptr %t45
  %t92 = call %Type @typePointee(%Type %t91)
  ret %Type %t92
L29:
  %t93 = load ptr, ptr %t0
  %t94 = load i32, ptr %t1
  %t95 = load ptr, ptr %t12
  %t96 = call ptr @quoted(ptr @.str.297, ptr %t95, ptr @.str.298)
  call void @analyzerFail(ptr %t93, i32 %t94, ptr %t96)
  %t97 = load i32, ptr @TY_VOID
  %t98 = call %Type @typeMake(i32 %t97, i32 0)
  ret %Type %t98
}

define %Type @checkBinaryOp(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 5
  %t23 = load i32, ptr %t22
  %t24 = call %Type @checkExpr(ptr %t13, i32 %t23)
  %t25 = alloca %Type
  store %Type %t24, ptr %t25
  %t26 = load ptr, ptr %t0
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Analyzer, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = getelementptr inbounds %Ast, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t1
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Node, ptr %t31, i64 %t33
  %t35 = getelementptr inbounds %Node, ptr %t34, i32 0, i32 6
  %t36 = load i32, ptr %t35
  %t37 = call %Type @checkExpr(ptr %t26, i32 %t36)
  %t38 = alloca %Type
  store %Type %t37, ptr %t38
  %t39 = alloca i1
  %t40 = load ptr, ptr %t12
  %t41 = call i1 @textEquals(ptr %t40, ptr @.str.299)
  store i1 %t41, ptr %t39
  br i1 %t41, label %L1, label %L0
L0:
  %t42 = load ptr, ptr %t12
  %t43 = call i1 @textEquals(ptr %t42, ptr @.str.300)
  store i1 %t43, ptr %t39
  br label %L1
L1:
  %t44 = load i1, ptr %t39
  br i1 %t44, label %L2, label %L4
L2:
  %t45 = alloca i1
  %t46 = load %Type, ptr %t25
  %t47 = call i1 @typeIsBool(%Type %t46)
  %t48 = xor i1 %t47, true
  store i1 %t48, ptr %t45
  br i1 %t48, label %L6, label %L5
L5:
  %t49 = load %Type, ptr %t38
  %t50 = call i1 @typeIsBool(%Type %t49)
  %t51 = xor i1 %t50, true
  store i1 %t51, ptr %t45
  br label %L6
L6:
  %t52 = load i1, ptr %t45
  br i1 %t52, label %L7, label %L9
L7:
  %t53 = load ptr, ptr %t0
  %t54 = load i32, ptr %t1
  %t55 = load %Type, ptr %t25
  %t56 = load %Type, ptr %t38
  %t57 = call ptr @gotTwoTypes(%Type %t55, %Type %t56)
  call void @analyzerFail2(ptr %t53, i32 %t54, ptr @.str.301, ptr %t57)
  br label %L9
L9:
  %t58 = load i32, ptr @TY_BOOL
  %t59 = call %Type @typeMake(i32 %t58, i32 0)
  ret %Type %t59
L4:
  %t60 = alloca i1
  %t61 = load ptr, ptr %t12
  %t62 = call i1 @textEquals(ptr %t61, ptr @.str.302)
  store i1 %t62, ptr %t60
  br i1 %t62, label %L11, label %L10
L10:
  %t63 = load ptr, ptr %t12
  %t64 = call i1 @textEquals(ptr %t63, ptr @.str.303)
  store i1 %t64, ptr %t60
  br label %L11
L11:
  %t65 = load i1, ptr %t60
  br i1 %t65, label %L12, label %L14
L12:
  %t66 = load %Type, ptr %t25
  %t67 = load %Type, ptr %t38
  %t68 = call i1 @typeEquals(%Type %t66, %Type %t67)
  %t69 = xor i1 %t68, true
  br i1 %t69, label %L15, label %L17
L15:
  %t70 = load ptr, ptr %t0
  %t71 = load i32, ptr %t1
  %t72 = load %Type, ptr %t25
  %t73 = load %Type, ptr %t38
  %t74 = call ptr @gotTwoTypes(%Type %t72, %Type %t73)
  call void @analyzerFail2(ptr %t70, i32 %t71, ptr @.str.304, ptr %t74)
  br label %L17
L17:
  %t75 = load %Type, ptr %t25
  %t76 = call i1 @typeIsVoid(%Type %t75)
  br i1 %t76, label %L18, label %L20
L18:
  %t77 = load ptr, ptr %t0
  %t78 = load i32, ptr %t1
  call void @analyzerFail(ptr %t77, i32 %t78, ptr @.str.305)
  br label %L20
L20:
  %t79 = load %Type, ptr %t25
  %t80 = call i1 @typeIsStruct(%Type %t79)
  br i1 %t80, label %L21, label %L23
L21:
  %t81 = load ptr, ptr %t0
  %t82 = load i32, ptr %t1
  %t83 = getelementptr inbounds %Type, ptr %t25, i32 0, i32 2
  %t84 = load ptr, ptr %t83
  %t85 = call ptr @quoted(ptr @.str.306, ptr %t84, ptr @.str.307)
  call void @analyzerFail2(ptr %t81, i32 %t82, ptr %t85, ptr @.str.308)
  br label %L23
L23:
  %t86 = load i32, ptr @TY_BOOL
  %t87 = call %Type @typeMake(i32 %t86, i32 0)
  ret %Type %t87
L14:
  %t88 = alloca i1
  %t89 = alloca i1
  %t90 = alloca i1
  %t91 = load ptr, ptr %t12
  %t92 = call i1 @textEquals(ptr %t91, ptr @.str.309)
  store i1 %t92, ptr %t90
  br i1 %t92, label %L25, label %L24
L24:
  %t93 = load ptr, ptr %t12
  %t94 = call i1 @textEquals(ptr %t93, ptr @.str.310)
  store i1 %t94, ptr %t90
  br label %L25
L25:
  %t95 = load i1, ptr %t90
  store i1 %t95, ptr %t89
  br i1 %t95, label %L27, label %L26
L26:
  %t96 = load ptr, ptr %t12
  %t97 = call i1 @textEquals(ptr %t96, ptr @.str.311)
  store i1 %t97, ptr %t89
  br label %L27
L27:
  %t98 = load i1, ptr %t89
  store i1 %t98, ptr %t88
  br i1 %t98, label %L29, label %L28
L28:
  %t99 = load ptr, ptr %t12
  %t100 = call i1 @textEquals(ptr %t99, ptr @.str.312)
  store i1 %t100, ptr %t88
  br label %L29
L29:
  %t101 = load i1, ptr %t88
  br i1 %t101, label %L30, label %L32
L30:
  %t102 = load %Type, ptr %t25
  %t103 = load %Type, ptr %t38
  %t104 = call i1 @typeEquals(%Type %t102, %Type %t103)
  %t105 = xor i1 %t104, true
  br i1 %t105, label %L33, label %L35
L33:
  %t106 = load ptr, ptr %t0
  %t107 = load i32, ptr %t1
  %t108 = load %Type, ptr %t25
  %t109 = load %Type, ptr %t38
  %t110 = call ptr @gotTwoTypes(%Type %t108, %Type %t109)
  call void @analyzerFail2(ptr %t106, i32 %t107, ptr @.str.313, ptr %t110)
  br label %L35
L35:
  %t111 = alloca i1
  %t112 = load %Type, ptr %t25
  %t113 = call i1 @typeIsBool(%Type %t112)
  store i1 %t113, ptr %t111
  br i1 %t113, label %L37, label %L36
L36:
  %t114 = load %Type, ptr %t25
  %t115 = call i1 @typeIsVoid(%Type %t114)
  store i1 %t115, ptr %t111
  br label %L37
L37:
  %t116 = load i1, ptr %t111
  br i1 %t116, label %L38, label %L40
L38:
  %t117 = load ptr, ptr %t0
  %t118 = load i32, ptr %t1
  call void @analyzerFail(ptr %t117, i32 %t118, ptr @.str.314)
  br label %L40
L40:
  %t119 = load %Type, ptr %t25
  %t120 = call i1 @typeIsStruct(%Type %t119)
  br i1 %t120, label %L41, label %L43
L41:
  %t121 = load ptr, ptr %t0
  %t122 = load i32, ptr %t1
  %t123 = getelementptr inbounds %Type, ptr %t25, i32 0, i32 2
  %t124 = load ptr, ptr %t123
  %t125 = call ptr @quoted(ptr @.str.315, ptr %t124, ptr @.str.316)
  call void @analyzerFail2(ptr %t121, i32 %t122, ptr %t125, ptr @.str.317)
  br label %L43
L43:
  %t126 = load i32, ptr @TY_BOOL
  %t127 = call %Type @typeMake(i32 %t126, i32 0)
  ret %Type %t127
L32:
  %t128 = load ptr, ptr %t12
  %t129 = call i1 @textEquals(ptr %t128, ptr @.str.318)
  %t130 = alloca i1
  store i1 %t129, ptr %t130
  %t131 = load ptr, ptr %t12
  %t132 = call i1 @textEquals(ptr %t131, ptr @.str.319)
  %t133 = alloca i1
  store i1 %t132, ptr %t133
  %t134 = alloca i1
  %t135 = load i1, ptr %t130
  store i1 %t135, ptr %t134
  br i1 %t135, label %L45, label %L44
L44:
  %t136 = load i1, ptr %t133
  store i1 %t136, ptr %t134
  br label %L45
L45:
  %t137 = load i1, ptr %t134
  br i1 %t137, label %L46, label %L48
L46:
  %t138 = alloca i1
  %t139 = load %Type, ptr %t25
  %t140 = call i1 @typeIsPointer(%Type %t139)
  store i1 %t140, ptr %t138
  br i1 %t140, label %L50, label %L49
L49:
  %t141 = load %Type, ptr %t38
  %t142 = call i1 @typeIsPointer(%Type %t141)
  store i1 %t142, ptr %t138
  br label %L50
L50:
  %t143 = load i1, ptr %t138
  br i1 %t143, label %L51, label %L53
L51:
  %t144 = alloca i1
  %t145 = load %Type, ptr %t25
  %t146 = call i1 @typeIsPointer(%Type %t145)
  store i1 %t146, ptr %t144
  br i1 %t146, label %L54, label %L55
L54:
  %t147 = load %Type, ptr %t38
  %t148 = call i1 @typeIsPointer(%Type %t147)
  store i1 %t148, ptr %t144
  br label %L55
L55:
  %t149 = load i1, ptr %t144
  br i1 %t149, label %L56, label %L58
L56:
  %t150 = load i1, ptr %t133
  %t151 = xor i1 %t150, true
  br i1 %t151, label %L59, label %L61
L59:
  %t152 = load ptr, ptr %t0
  %t153 = load i32, ptr %t1
  call void @analyzerFail(ptr %t152, i32 %t153, ptr @.str.320)
  br label %L61
L61:
  %t154 = load %Type, ptr %t25
  %t155 = load %Type, ptr %t38
  %t156 = call i1 @typeEquals(%Type %t154, %Type %t155)
  %t157 = xor i1 %t156, true
  br i1 %t157, label %L62, label %L64
L62:
  %t158 = load ptr, ptr %t0
  %t159 = load i32, ptr %t1
  %t160 = load %Type, ptr %t25
  %t161 = load %Type, ptr %t38
  %t162 = call ptr @gotTwoTypes(%Type %t160, %Type %t161)
  call void @analyzerFail2(ptr %t158, i32 %t159, ptr @.str.321, ptr %t162)
  br label %L64
L64:
  %t163 = load %Type, ptr %t25
  %t164 = call %Type @typePointee(%Type %t163)
  %t165 = call i1 @typeIsVoid(%Type %t164)
  br i1 %t165, label %L65, label %L67
L65:
  %t166 = load ptr, ptr %t0
  %t167 = load i32, ptr %t1
  call void @analyzerFail(ptr %t166, i32 %t167, ptr @.str.322)
  br label %L67
L67:
  %t168 = load i32, ptr @TY_I64
  %t169 = call %Type @typeMake(i32 %t168, i32 0)
  ret %Type %t169
L58:
  %t170 = load %Type, ptr %t25
  %t171 = alloca %Type
  store %Type %t170, ptr %t171
  %t172 = load %Type, ptr %t38
  %t173 = alloca %Type
  store %Type %t172, ptr %t173
  %t174 = load %Type, ptr %t25
  %t175 = call i1 @typeIsPointer(%Type %t174)
  %t176 = xor i1 %t175, true
  br i1 %t176, label %L68, label %L70
L68:
  %t177 = load %Type, ptr %t38
  store %Type %t177, ptr %t171
  %t178 = load %Type, ptr %t25
  store %Type %t178, ptr %t173
  br label %L70
L70:
  %t179 = alloca i1
  %t180 = load %Type, ptr %t38
  %t181 = call i1 @typeIsPointer(%Type %t180)
  store i1 %t181, ptr %t179
  br i1 %t181, label %L71, label %L72
L71:
  %t182 = load i1, ptr %t133
  store i1 %t182, ptr %t179
  br label %L72
L72:
  %t183 = load i1, ptr %t179
  br i1 %t183, label %L73, label %L75
L73:
  %t184 = load ptr, ptr %t0
  %t185 = load i32, ptr %t1
  call void @analyzerFail(ptr %t184, i32 %t185, ptr @.str.323)
  br label %L75
L75:
  %t186 = load %Type, ptr %t173
  %t187 = call i1 @typeIsInteger(%Type %t186)
  %t188 = xor i1 %t187, true
  br i1 %t188, label %L76, label %L78
L76:
  %t189 = load ptr, ptr %t0
  %t190 = load i32, ptr %t1
  %t191 = load %Type, ptr %t173
  %t192 = call ptr @gotType(%Type %t191)
  call void @analyzerFail2(ptr %t189, i32 %t190, ptr @.str.324, ptr %t192)
  br label %L78
L78:
  %t193 = load %Type, ptr %t171
  %t194 = call %Type @typePointee(%Type %t193)
  %t195 = call i1 @typeIsVoid(%Type %t194)
  br i1 %t195, label %L79, label %L81
L79:
  %t196 = load ptr, ptr %t0
  %t197 = load i32, ptr %t1
  call void @analyzerFail2(ptr %t196, i32 %t197, ptr @.str.325, ptr @.str.326)
  br label %L81
L81:
  %t198 = load %Type, ptr %t171
  ret %Type %t198
L53:
  br label %L48
L48:
  %t199 = alloca i1
  %t200 = alloca i1
  %t201 = alloca i1
  %t202 = load i1, ptr %t130
  store i1 %t202, ptr %t201
  br i1 %t202, label %L83, label %L82
L82:
  %t203 = load i1, ptr %t133
  store i1 %t203, ptr %t201
  br label %L83
L83:
  %t204 = load i1, ptr %t201
  store i1 %t204, ptr %t200
  br i1 %t204, label %L85, label %L84
L84:
  %t205 = load ptr, ptr %t12
  %t206 = call i1 @textEquals(ptr %t205, ptr @.str.327)
  store i1 %t206, ptr %t200
  br label %L85
L85:
  %t207 = load i1, ptr %t200
  store i1 %t207, ptr %t199
  br i1 %t207, label %L87, label %L86
L86:
  %t208 = load ptr, ptr %t12
  %t209 = call i1 @textEquals(ptr %t208, ptr @.str.328)
  store i1 %t209, ptr %t199
  br label %L87
L87:
  %t210 = load i1, ptr %t199
  br i1 %t210, label %L88, label %L90
L88:
  %t211 = alloca i1
  %t212 = load %Type, ptr %t25
  %t213 = call i1 @typeIsPointer(%Type %t212)
  store i1 %t213, ptr %t211
  br i1 %t213, label %L92, label %L91
L91:
  %t214 = load %Type, ptr %t38
  %t215 = call i1 @typeIsPointer(%Type %t214)
  store i1 %t215, ptr %t211
  br label %L92
L92:
  %t216 = load i1, ptr %t211
  br i1 %t216, label %L93, label %L95
L93:
  %t217 = load ptr, ptr %t0
  %t218 = load i32, ptr %t1
  call void @analyzerFail(ptr %t217, i32 %t218, ptr @.str.329)
  br label %L95
L95:
  %t219 = load %Type, ptr %t25
  %t220 = load %Type, ptr %t38
  %t221 = call i1 @typeEquals(%Type %t219, %Type %t220)
  %t222 = xor i1 %t221, true
  br i1 %t222, label %L96, label %L98
L96:
  %t223 = load ptr, ptr %t0
  %t224 = load i32, ptr %t1
  %t225 = load %Type, ptr %t25
  %t226 = load %Type, ptr %t38
  %t227 = call ptr @gotTwoTypes(%Type %t225, %Type %t226)
  call void @analyzerFail2(ptr %t223, i32 %t224, ptr @.str.330, ptr %t227)
  br label %L98
L98:
  %t228 = load %Type, ptr %t25
  %t229 = call i1 @typeIsNumeric(%Type %t228)
  %t230 = xor i1 %t229, true
  br i1 %t230, label %L99, label %L101
L99:
  %t231 = load ptr, ptr %t0
  %t232 = load i32, ptr %t1
  %t233 = load %Type, ptr %t25
  %t234 = call ptr @gotType(%Type %t233)
  call void @analyzerFail2(ptr %t231, i32 %t232, ptr @.str.331, ptr %t234)
  br label %L101
L101:
  %t235 = load %Type, ptr %t25
  ret %Type %t235
L90:
  %t236 = alloca i1
  %t237 = alloca i1
  %t238 = alloca i1
  %t239 = alloca i1
  %t240 = alloca i1
  %t241 = load ptr, ptr %t12
  %t242 = call i1 @textEquals(ptr %t241, ptr @.str.332)
  store i1 %t242, ptr %t240
  br i1 %t242, label %L103, label %L102
L102:
  %t243 = load ptr, ptr %t12
  %t244 = call i1 @textEquals(ptr %t243, ptr @.str.333)
  store i1 %t244, ptr %t240
  br label %L103
L103:
  %t245 = load i1, ptr %t240
  store i1 %t245, ptr %t239
  br i1 %t245, label %L105, label %L104
L104:
  %t246 = load ptr, ptr %t12
  %t247 = call i1 @textEquals(ptr %t246, ptr @.str.334)
  store i1 %t247, ptr %t239
  br label %L105
L105:
  %t248 = load i1, ptr %t239
  store i1 %t248, ptr %t238
  br i1 %t248, label %L107, label %L106
L106:
  %t249 = load ptr, ptr %t12
  %t250 = call i1 @textEquals(ptr %t249, ptr @.str.335)
  store i1 %t250, ptr %t238
  br label %L107
L107:
  %t251 = load i1, ptr %t238
  store i1 %t251, ptr %t237
  br i1 %t251, label %L109, label %L108
L108:
  %t252 = load ptr, ptr %t12
  %t253 = call i1 @textEquals(ptr %t252, ptr @.str.336)
  store i1 %t253, ptr %t237
  br label %L109
L109:
  %t254 = load i1, ptr %t237
  store i1 %t254, ptr %t236
  br i1 %t254, label %L111, label %L110
L110:
  %t255 = load ptr, ptr %t12
  %t256 = call i1 @textEquals(ptr %t255, ptr @.str.337)
  store i1 %t256, ptr %t236
  br label %L111
L111:
  %t257 = load i1, ptr %t236
  br i1 %t257, label %L112, label %L114
L112:
  %t258 = load %Type, ptr %t25
  %t259 = load %Type, ptr %t38
  %t260 = call i1 @typeEquals(%Type %t258, %Type %t259)
  %t261 = xor i1 %t260, true
  br i1 %t261, label %L115, label %L117
L115:
  %t262 = load ptr, ptr %t0
  %t263 = load i32, ptr %t1
  %t264 = load ptr, ptr %t12
  %t265 = call ptr @quoted(ptr @.str.338, ptr %t264, ptr @.str.339)
  %t266 = load %Type, ptr %t25
  %t267 = load %Type, ptr %t38
  %t268 = call ptr @gotTwoTypes(%Type %t266, %Type %t267)
  call void @analyzerFail2(ptr %t262, i32 %t263, ptr %t265, ptr %t268)
  br label %L117
L117:
  %t269 = load %Type, ptr %t25
  %t270 = call i1 @typeIsInteger(%Type %t269)
  %t271 = xor i1 %t270, true
  br i1 %t271, label %L118, label %L120
L118:
  %t272 = load ptr, ptr %t0
  %t273 = load i32, ptr %t1
  %t274 = load ptr, ptr %t12
  %t275 = call ptr @quoted(ptr @.str.340, ptr %t274, ptr @.str.341)
  %t276 = load %Type, ptr %t25
  %t277 = call ptr @gotType(%Type %t276)
  call void @analyzerFail2(ptr %t272, i32 %t273, ptr %t275, ptr %t277)
  br label %L120
L120:
  %t278 = load %Type, ptr %t25
  ret %Type %t278
L114:
  %t279 = load ptr, ptr %t0
  %t280 = load i32, ptr %t1
  call void @analyzerFail(ptr %t279, i32 %t280, ptr @.str.342)
  %t281 = load i32, ptr @TY_VOID
  %t282 = call %Type @typeMake(i32 %t281, i32 0)
  ret %Type %t282
}

define void @castRejection(ptr %p0, i32 %p1, %Type %p2, %Type %p3, ptr %p4) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = alloca %Type
  store %Type %p3, ptr %t3
  %t4 = alloca ptr
  store ptr %p4, ptr %t4
  %t5 = call ptr @bufNew()
  %t6 = alloca ptr
  store ptr %t5, ptr %t6
  %t7 = load ptr, ptr %t6
  call void @bufAdd(ptr %t7, ptr @.str.343)
  %t8 = load ptr, ptr %t6
  %t9 = load %Type, ptr %t2
  %t10 = call ptr @typeToText(%Type %t9)
  call void @bufAdd(ptr %t8, ptr %t10)
  %t11 = load ptr, ptr %t6
  call void @bufAdd(ptr %t11, ptr @.str.344)
  %t12 = load ptr, ptr %t6
  %t13 = load %Type, ptr %t3
  %t14 = call ptr @typeToText(%Type %t13)
  call void @bufAdd(ptr %t12, ptr %t14)
  %t15 = load ptr, ptr %t6
  call void @bufPush(ptr %t15, i8 39)
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr %t1
  %t18 = load ptr, ptr %t6
  %t19 = getelementptr inbounds %Buf, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load ptr, ptr %t4
  call void @analyzerFail2(ptr %t16, i32 %t17, ptr %t20, ptr %t21)
  ret void
}

define %Type @checkCast(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 6
  %t12 = load i32, ptr %t11
  %t13 = call %Type @analyzerParseType(ptr %t2, i32 %t12)
  %t14 = alloca %Type
  store %Type %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 5
  %t25 = load i32, ptr %t24
  %t26 = load %Type, ptr %t14
  %t27 = call %Type @checkCastOperand(ptr %t15, i32 %t25, %Type %t26)
  %t28 = alloca %Type
  store %Type %t27, ptr %t28
  %t29 = alloca i1
  %t30 = load %Type, ptr %t28
  %t31 = call i1 @typeIsVoid(%Type %t30)
  store i1 %t31, ptr %t29
  br i1 %t31, label %L1, label %L0
L0:
  %t32 = load %Type, ptr %t14
  %t33 = call i1 @typeIsVoid(%Type %t32)
  store i1 %t33, ptr %t29
  br label %L1
L1:
  %t34 = load i1, ptr %t29
  br i1 %t34, label %L2, label %L4
L2:
  %t35 = load ptr, ptr %t0
  %t36 = load i32, ptr %t1
  %t37 = load %Type, ptr %t28
  %t38 = load %Type, ptr %t14
  call void @castRejection(ptr %t35, i32 %t36, %Type %t37, %Type %t38, ptr @.str.345)
  br label %L4
L4:
  %t39 = load %Type, ptr %t28
  %t40 = load %Type, ptr %t14
  %t41 = call i1 @typeEquals(%Type %t39, %Type %t40)
  br i1 %t41, label %L5, label %L7
L5:
  %t42 = load %Type, ptr %t14
  ret %Type %t42
L7:
  %t43 = alloca i1
  %t44 = load %Type, ptr %t28
  %t45 = call i1 @typeIsNumeric(%Type %t44)
  store i1 %t45, ptr %t43
  br i1 %t45, label %L8, label %L9
L8:
  %t46 = load %Type, ptr %t14
  %t47 = call i1 @typeIsNumeric(%Type %t46)
  store i1 %t47, ptr %t43
  br label %L9
L9:
  %t48 = load i1, ptr %t43
  br i1 %t48, label %L10, label %L12
L10:
  %t49 = load %Type, ptr %t14
  ret %Type %t49
L12:
  %t50 = alloca i1
  %t51 = load %Type, ptr %t28
  %t52 = call i1 @typeIsBool(%Type %t51)
  store i1 %t52, ptr %t50
  br i1 %t52, label %L13, label %L14
L13:
  %t53 = load %Type, ptr %t14
  %t54 = call i1 @typeIsInteger(%Type %t53)
  store i1 %t54, ptr %t50
  br label %L14
L14:
  %t55 = load i1, ptr %t50
  br i1 %t55, label %L15, label %L17
L15:
  %t56 = load %Type, ptr %t14
  ret %Type %t56
L17:
  %t57 = alloca i1
  %t58 = load %Type, ptr %t28
  %t59 = call i1 @typeIsInteger(%Type %t58)
  store i1 %t59, ptr %t57
  br i1 %t59, label %L18, label %L19
L18:
  %t60 = load %Type, ptr %t14
  %t61 = call i1 @typeIsBool(%Type %t60)
  store i1 %t61, ptr %t57
  br label %L19
L19:
  %t62 = load i1, ptr %t57
  br i1 %t62, label %L20, label %L22
L20:
  %t63 = load %Type, ptr %t14
  ret %Type %t63
L22:
  %t64 = alloca i1
  %t65 = load %Type, ptr %t28
  %t66 = call i1 @typeIsPointer(%Type %t65)
  store i1 %t66, ptr %t64
  br i1 %t66, label %L23, label %L24
L23:
  %t67 = load %Type, ptr %t14
  %t68 = call i1 @typeIsPointer(%Type %t67)
  store i1 %t68, ptr %t64
  br label %L24
L24:
  %t69 = load i1, ptr %t64
  br i1 %t69, label %L25, label %L27
L25:
  %t70 = load %Type, ptr %t14
  ret %Type %t70
L27:
  %t71 = alloca i1
  %t72 = load %Type, ptr %t28
  %t73 = call i1 @typeIsPointer(%Type %t72)
  store i1 %t73, ptr %t71
  br i1 %t73, label %L28, label %L29
L28:
  %t74 = load %Type, ptr %t14
  %t75 = call i1 @typeIsInteger(%Type %t74)
  store i1 %t75, ptr %t71
  br label %L29
L29:
  %t76 = load i1, ptr %t71
  br i1 %t76, label %L30, label %L32
L30:
  %t77 = load %Type, ptr %t14
  %t78 = call i32 @typeBitWidth(%Type %t77)
  %t79 = icmp ne i32 %t78, 64
  br i1 %t79, label %L33, label %L35
L33:
  %t80 = load ptr, ptr %t0
  %t81 = load i32, ptr %t1
  %t82 = load %Type, ptr %t28
  %t83 = load %Type, ptr %t14
  call void @castRejection(ptr %t80, i32 %t81, %Type %t82, %Type %t83, ptr @.str.346)
  br label %L35
L35:
  %t84 = load %Type, ptr %t14
  ret %Type %t84
L32:
  %t85 = alloca i1
  %t86 = load %Type, ptr %t28
  %t87 = call i1 @typeIsInteger(%Type %t86)
  store i1 %t87, ptr %t85
  br i1 %t87, label %L36, label %L37
L36:
  %t88 = load %Type, ptr %t14
  %t89 = call i1 @typeIsPointer(%Type %t88)
  store i1 %t89, ptr %t85
  br label %L37
L37:
  %t90 = load i1, ptr %t85
  br i1 %t90, label %L38, label %L40
L38:
  %t91 = load %Type, ptr %t28
  %t92 = call i32 @typeBitWidth(%Type %t91)
  %t93 = icmp ne i32 %t92, 64
  br i1 %t93, label %L41, label %L43
L41:
  %t94 = load ptr, ptr %t0
  %t95 = load i32, ptr %t1
  %t96 = load %Type, ptr %t28
  %t97 = load %Type, ptr %t14
  call void @castRejection(ptr %t94, i32 %t95, %Type %t96, %Type %t97, ptr @.str.347)
  br label %L43
L43:
  %t98 = load %Type, ptr %t14
  ret %Type %t98
L40:
  %t99 = load ptr, ptr %t0
  %t100 = load i32, ptr %t1
  %t101 = load %Type, ptr %t28
  %t102 = load %Type, ptr %t14
  call void @castRejection(ptr %t99, i32 %t100, %Type %t101, %Type %t102, ptr @.str.348)
  %t103 = load %Type, ptr %t14
  ret %Type %t103
}

define %Type @checkCastOperand(ptr %p0, i32 %p1, %Type %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 0
  %t12 = load i32, ptr %t11
  %t13 = load i32, ptr @NK_NUMBER
  %t14 = icmp ne i32 %t12, %t13
  br i1 %t14, label %L0, label %L2
L0:
  %t15 = load ptr, ptr %t0
  %t16 = load i32, ptr %t1
  %t17 = call %Type @checkExpr(ptr %t15, i32 %t16)
  ret %Type %t17
L2:
  %t18 = load ptr, ptr %t0
  %t19 = load i32, ptr %t1
  %t20 = load %Type, ptr %t2
  %t21 = call %Type @checkNumberLiteral(ptr %t18, i32 %t19, %Type %t20)
  %t22 = alloca %Type
  store %Type %t21, ptr %t22
  %t23 = load %Type, ptr %t22
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Analyzer, ptr %t24, i32 0, i32 3
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Type, ptr %t26, i64 %t28
  store %Type %t23, ptr %t29
  %t30 = load %Type, ptr %t22
  ret %Type %t30
}

define i1 @textHasDot(ptr %p0, i64 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i64
  store i64 %p1, ptr %t1
  %t2 = sext i32 0 to i64
  %t3 = alloca i64
  store i64 %t2, ptr %t3
  br label %L0
L0:
  %t4 = load i64, ptr %t3
  %t5 = load i64, ptr %t1
  %t6 = icmp slt i64 %t4, %t5
  br i1 %t6, label %L1, label %L2
L1:
  %t7 = load ptr, ptr %t0
  %t8 = load i64, ptr %t3
  %t9 = getelementptr inbounds i8, ptr %t7, i64 %t8
  %t10 = load i8, ptr %t9
  %t11 = icmp eq i8 %t10, 46
  br i1 %t11, label %L3, label %L5
L3:
  ret i1 true
L5:
  %t12 = load i64, ptr %t3
  %t13 = sext i32 1 to i64
  %t14 = add i64 %t12, %t13
  store i64 %t14, ptr %t3
  br label %L0
L2:
  ret i1 false
}

define %Type @checkNumberLiteral(ptr %p0, i32 %p1, %Type %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 3
  %t12 = load ptr, ptr %t11
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 4
  %t23 = load i64, ptr %t22
  %t24 = alloca i64
  store i64 %t23, ptr %t24
  %t25 = load ptr, ptr %t13
  %t26 = load i64, ptr %t24
  %t27 = call i1 @textHasDot(ptr %t25, i64 %t26)
  br i1 %t27, label %L0, label %L2
L0:
  %t28 = load %Type, ptr %t2
  %t29 = call i1 @typeIsFloat(%Type %t28)
  br i1 %t29, label %L3, label %L5
L3:
  %t30 = load %Type, ptr %t2
  ret %Type %t30
L5:
  %t31 = load i32, ptr @TY_F32
  %t32 = call %Type @typeMake(i32 %t31, i32 0)
  ret %Type %t32
L2:
  %t33 = load i32, ptr @TY_I32
  %t34 = call %Type @typeMake(i32 %t33, i32 0)
  %t35 = alloca %Type
  store %Type %t34, ptr %t35
  %t36 = load %Type, ptr %t2
  %t37 = alloca %Type
  store %Type %t36, ptr %t37
  %t38 = load %Type, ptr %t2
  %t39 = call i1 @typeIsInteger(%Type %t38)
  %t40 = xor i1 %t39, true
  br i1 %t40, label %L6, label %L8
L6:
  %t41 = load %Type, ptr %t35
  store %Type %t41, ptr %t37
  br label %L8
L8:
  %t42 = load ptr, ptr %t13
  %t43 = sext i32 0 to i64
  %t44 = getelementptr inbounds i8, ptr %t42, i64 %t43
  %t45 = load i8, ptr %t44
  %t46 = icmp eq i8 %t45, 45
  %t47 = alloca i1
  store i1 %t46, ptr %t47
  %t48 = sext i32 0 to i64
  %t49 = alloca i64
  store i64 %t48, ptr %t49
  %t50 = load i1, ptr %t47
  br i1 %t50, label %L9, label %L11
L9:
  %t51 = sext i32 1 to i64
  store i64 %t51, ptr %t49
  br label %L11
L11:
  %t52 = call ptr @malloc(i64 1)
  %t53 = alloca ptr
  store ptr %t52, ptr %t53
  %t54 = load ptr, ptr %t13
  %t55 = load i64, ptr %t49
  %t56 = load i64, ptr %t24
  %t57 = load ptr, ptr %t53
  %t58 = call i64 @parseMagnitude(ptr %t54, i64 %t55, i64 %t56, ptr %t57)
  %t59 = alloca i64
  store i64 %t58, ptr %t59
  %t60 = load ptr, ptr %t53
  %t61 = load i1, ptr %t60
  br i1 %t61, label %L12, label %L14
L12:
  %t62 = load ptr, ptr %t0
  %t63 = load i32, ptr %t1
  %t64 = load %Type, ptr %t37
  %t65 = call ptr @typeToText(%Type %t64)
  %t66 = call ptr @quoted(ptr @.str.349, ptr %t65, ptr @.str.350)
  call void @analyzerFail(ptr %t62, i32 %t63, ptr %t66)
  br label %L14
L14:
  %t67 = load i64, ptr %t59
  %t68 = load i1, ptr %t47
  %t69 = load %Type, ptr %t35
  %t70 = call i1 @fitsIn(i64 %t67, i1 %t68, %Type %t69)
  br i1 %t70, label %L15, label %L17
L15:
  %t71 = load %Type, ptr %t35
  ret %Type %t71
L17:
  %t72 = load i64, ptr %t59
  %t73 = load i1, ptr %t47
  %t74 = load %Type, ptr %t37
  %t75 = call i1 @fitsIn(i64 %t72, i1 %t73, %Type %t74)
  %t76 = xor i1 %t75, true
  br i1 %t76, label %L18, label %L20
L18:
  %t77 = alloca ptr
  store ptr @.str.351, ptr %t77
  %t78 = load %Type, ptr %t37
  %t79 = load %Type, ptr %t35
  %t80 = call i1 @typeEquals(%Type %t78, %Type %t79)
  br i1 %t80, label %L21, label %L23
L21:
  store ptr @.str.352, ptr %t77
  br label %L23
L23:
  %t81 = load ptr, ptr %t0
  %t82 = load i32, ptr %t1
  %t83 = load %Type, ptr %t37
  %t84 = call ptr @typeToText(%Type %t83)
  %t85 = call ptr @quoted(ptr @.str.353, ptr %t84, ptr @.str.354)
  %t86 = load ptr, ptr %t77
  call void @analyzerFail2(ptr %t81, i32 %t82, ptr %t85, ptr %t86)
  br label %L20
L20:
  %t87 = load %Type, ptr %t37
  ret %Type %t87
}

define %Type @checkFieldAccess(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 5
  %t23 = load i32, ptr %t22
  %t24 = call %Type @checkExpr(ptr %t13, i32 %t23)
  %t25 = alloca %Type
  store %Type %t24, ptr %t25
  %t26 = load %Type, ptr %t25
  %t27 = alloca %Type
  store %Type %t26, ptr %t27
  %t28 = getelementptr inbounds %Type, ptr %t25, i32 0, i32 1
  %t29 = load i32, ptr %t28
  %t30 = icmp eq i32 %t29, 1
  br i1 %t30, label %L0, label %L2
L0:
  %t31 = load %Type, ptr %t25
  %t32 = call %Type @typePointee(%Type %t31)
  store %Type %t32, ptr %t27
  br label %L2
L2:
  %t33 = load %Type, ptr %t27
  %t34 = call i1 @typeIsStruct(%Type %t33)
  %t35 = xor i1 %t34, true
  br i1 %t35, label %L3, label %L5
L3:
  %t36 = load ptr, ptr %t0
  %t37 = load i32, ptr %t1
  %t38 = load ptr, ptr %t12
  %t39 = call ptr @quoted(ptr @.str.355, ptr %t38, ptr @.str.356)
  %t40 = load %Type, ptr %t25
  %t41 = call ptr @typeToText(%Type %t40)
  %t42 = call ptr @quoted(ptr @.str.357, ptr %t41, ptr @.str.358)
  call void @analyzerFail2(ptr %t36, i32 %t37, ptr %t39, ptr %t42)
  br label %L5
L5:
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr inbounds %Analyzer, ptr %t43, i32 0, i32 2
  %t45 = load ptr, ptr %t44
  %t46 = getelementptr inbounds %Type, ptr %t27, i32 0, i32 2
  %t47 = load ptr, ptr %t46
  %t48 = call i32 @structIndexOf(ptr %t45, ptr %t47)
  %t49 = alloca i32
  store i32 %t48, ptr %t49
  %t50 = load i32, ptr %t49
  %t51 = icmp slt i32 %t50, 0
  br i1 %t51, label %L6, label %L8
L6:
  %t52 = load ptr, ptr %t0
  %t53 = load i32, ptr %t1
  %t54 = load ptr, ptr %t12
  %t55 = call ptr @quoted(ptr @.str.359, ptr %t54, ptr @.str.360)
  %t56 = load %Type, ptr %t27
  %t57 = call ptr @typeToText(%Type %t56)
  %t58 = call ptr @quoted(ptr @.str.361, ptr %t57, ptr @.str.362)
  call void @analyzerFail2(ptr %t52, i32 %t53, ptr %t55, ptr %t58)
  %t59 = load i32, ptr @TY_NONE
  %t60 = call %Type @typeMake(i32 %t59, i32 0)
  ret %Type %t60
L8:
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Analyzer, ptr %t61, i32 0, i32 2
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t49
  %t65 = load ptr, ptr %t12
  %t66 = call i32 @structFieldIndex(ptr %t63, i32 %t64, ptr %t65)
  %t67 = alloca i32
  store i32 %t66, ptr %t67
  %t68 = load i32, ptr %t67
  %t69 = icmp slt i32 %t68, 0
  br i1 %t69, label %L9, label %L11
L9:
  %t70 = call ptr @bufNew()
  %t71 = alloca ptr
  store ptr %t70, ptr %t71
  %t72 = load ptr, ptr %t71
  call void @bufAdd(ptr %t72, ptr @.str.363)
  %t73 = load ptr, ptr %t71
  %t74 = getelementptr inbounds %Type, ptr %t27, i32 0, i32 2
  %t75 = load ptr, ptr %t74
  call void @bufAdd(ptr %t73, ptr %t75)
  %t76 = load ptr, ptr %t71
  call void @bufAdd(ptr %t76, ptr @.str.364)
  %t77 = load ptr, ptr %t71
  %t78 = load ptr, ptr %t12
  call void @bufAdd(ptr %t77, ptr %t78)
  %t79 = load ptr, ptr %t71
  call void @bufPush(ptr %t79, i8 39)
  %t80 = load ptr, ptr %t0
  %t81 = load i32, ptr %t1
  %t82 = load ptr, ptr %t71
  %t83 = getelementptr inbounds %Buf, ptr %t82, i32 0, i32 0
  %t84 = load ptr, ptr %t83
  call void @analyzerFail(ptr %t80, i32 %t81, ptr %t84)
  %t85 = load i32, ptr @TY_NONE
  %t86 = call %Type @typeMake(i32 %t85, i32 0)
  ret %Type %t86
L11:
  %t87 = load ptr, ptr %t0
  %t88 = getelementptr inbounds %Analyzer, ptr %t87, i32 0, i32 2
  %t89 = load ptr, ptr %t88
  %t90 = getelementptr inbounds %StructTable, ptr %t89, i32 0, i32 0
  %t91 = load ptr, ptr %t90
  %t92 = load i32, ptr %t49
  %t93 = sext i32 %t92 to i64
  %t94 = getelementptr inbounds %StructLayout, ptr %t91, i64 %t93
  %t95 = getelementptr inbounds %StructLayout, ptr %t94, i32 0, i32 1
  %t96 = load ptr, ptr %t95
  %t97 = load i32, ptr %t67
  %t98 = sext i32 %t97 to i64
  %t99 = getelementptr inbounds %FieldDef, ptr %t96, i64 %t98
  %t100 = getelementptr inbounds %FieldDef, ptr %t99, i32 0, i32 1
  %t101 = load %Type, ptr %t100
  ret %Type %t101
}

define %Type @checkIndex(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 5
  %t12 = load i32, ptr %t11
  %t13 = call %Type @checkExpr(ptr %t2, i32 %t12)
  %t14 = alloca %Type
  store %Type %t13, ptr %t14
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Ast, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = load i32, ptr %t1
  %t22 = sext i32 %t21 to i64
  %t23 = getelementptr inbounds %Node, ptr %t20, i64 %t22
  %t24 = getelementptr inbounds %Node, ptr %t23, i32 0, i32 6
  %t25 = load i32, ptr %t24
  %t26 = call %Type @checkExpr(ptr %t15, i32 %t25)
  %t27 = alloca %Type
  store %Type %t26, ptr %t27
  %t28 = load %Type, ptr %t14
  %t29 = call i1 @typeIsPointer(%Type %t28)
  %t30 = xor i1 %t29, true
  br i1 %t30, label %L0, label %L2
L0:
  %t31 = load ptr, ptr %t0
  %t32 = load i32, ptr %t1
  %t33 = load %Type, ptr %t14
  %t34 = call ptr @gotType(%Type %t33)
  call void @analyzerFail2(ptr %t31, i32 %t32, ptr @.str.365, ptr %t34)
  br label %L2
L2:
  %t35 = load %Type, ptr %t14
  %t36 = call %Type @typePointee(%Type %t35)
  %t37 = call i1 @typeIsVoid(%Type %t36)
  br i1 %t37, label %L3, label %L5
L3:
  %t38 = load ptr, ptr %t0
  %t39 = load i32, ptr %t1
  call void @analyzerFail2(ptr %t38, i32 %t39, ptr @.str.366, ptr @.str.367)
  br label %L5
L5:
  %t40 = load %Type, ptr %t27
  %t41 = call i1 @typeIsInteger(%Type %t40)
  %t42 = xor i1 %t41, true
  br i1 %t42, label %L6, label %L8
L6:
  %t43 = load ptr, ptr %t0
  %t44 = load i32, ptr %t1
  %t45 = load %Type, ptr %t27
  %t46 = call ptr @gotType(%Type %t45)
  call void @analyzerFail2(ptr %t43, i32 %t44, ptr @.str.368, ptr %t46)
  br label %L8
L8:
  %t47 = load %Type, ptr %t14
  %t48 = call %Type @typePointee(%Type %t47)
  ret %Type %t48
}

define %Type @checkStructLiteral(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 2
  %t15 = load ptr, ptr %t14
  %t16 = load ptr, ptr %t12
  %t17 = call i32 @structIndexOf(ptr %t15, ptr %t16)
  %t18 = alloca i32
  store i32 %t17, ptr %t18
  %t19 = load i32, ptr %t18
  %t20 = icmp slt i32 %t19, 0
  br i1 %t20, label %L0, label %L2
L0:
  %t21 = load ptr, ptr %t0
  %t22 = load i32, ptr %t1
  %t23 = load ptr, ptr %t12
  %t24 = call ptr @quoted(ptr @.str.369, ptr %t23, ptr @.str.370)
  %t25 = load ptr, ptr %t12
  %t26 = call ptr @quoted(ptr @.str.371, ptr %t25, ptr @.str.372)
  call void @analyzerFail2(ptr %t21, i32 %t22, ptr %t24, ptr %t26)
  %t27 = load ptr, ptr %t12
  %t28 = call %Type @typeStruct(ptr %t27, i32 0)
  ret %Type %t28
L2:
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Analyzer, ptr %t29, i32 0, i32 2
  %t31 = load ptr, ptr %t30
  %t32 = getelementptr inbounds %StructTable, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t18
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %StructLayout, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %StructLayout, ptr %t36, i32 0, i32 2
  %t38 = load i32, ptr %t37
  %t39 = alloca i32
  store i32 %t38, ptr %t39
  %t40 = load i32, ptr %t39
  %t41 = sext i32 %t40 to i64
  %t42 = call ptr @malloc(i64 %t41)
  %t43 = alloca ptr
  store ptr %t42, ptr %t43
  %t44 = alloca i32
  store i32 0, ptr %t44
  br label %L3
L3:
  %t45 = load i32, ptr %t44
  %t46 = load i32, ptr %t39
  %t47 = icmp slt i32 %t45, %t46
  br i1 %t47, label %L4, label %L5
L4:
  %t48 = trunc i32 0 to i8
  %t49 = load ptr, ptr %t43
  %t50 = load i32, ptr %t44
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds i8, ptr %t49, i64 %t51
  store i8 %t48, ptr %t52
  %t53 = load i32, ptr %t44
  %t54 = add i32 %t53, 1
  store i32 %t54, ptr %t44
  br label %L3
L5:
  store i32 0, ptr %t44
  br label %L6
L6:
  %t55 = load i32, ptr %t44
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %Analyzer, ptr %t56, i32 0, i32 0
  %t58 = load ptr, ptr %t57
  %t59 = getelementptr inbounds %Ast, ptr %t58, i32 0, i32 0
  %t60 = load ptr, ptr %t59
  %t61 = load i32, ptr %t1
  %t62 = sext i32 %t61 to i64
  %t63 = getelementptr inbounds %Node, ptr %t60, i64 %t62
  %t64 = getelementptr inbounds %Node, ptr %t63, i32 0, i32 10
  %t65 = load i32, ptr %t64
  %t66 = icmp slt i32 %t55, %t65
  br i1 %t66, label %L7, label %L8
L7:
  %t67 = load ptr, ptr %t0
  %t68 = getelementptr inbounds %Analyzer, ptr %t67, i32 0, i32 0
  %t69 = load ptr, ptr %t68
  %t70 = getelementptr inbounds %Ast, ptr %t69, i32 0, i32 0
  %t71 = load ptr, ptr %t70
  %t72 = load i32, ptr %t1
  %t73 = sext i32 %t72 to i64
  %t74 = getelementptr inbounds %Node, ptr %t71, i64 %t73
  %t75 = getelementptr inbounds %Node, ptr %t74, i32 0, i32 9
  %t76 = load ptr, ptr %t75
  %t77 = load i32, ptr %t44
  %t78 = sext i32 %t77 to i64
  %t79 = getelementptr inbounds i32, ptr %t76, i64 %t78
  %t80 = load i32, ptr %t79
  %t81 = alloca i32
  store i32 %t80, ptr %t81
  %t82 = load ptr, ptr %t0
  %t83 = getelementptr inbounds %Analyzer, ptr %t82, i32 0, i32 0
  %t84 = load ptr, ptr %t83
  %t85 = getelementptr inbounds %Ast, ptr %t84, i32 0, i32 0
  %t86 = load ptr, ptr %t85
  %t87 = load i32, ptr %t81
  %t88 = sext i32 %t87 to i64
  %t89 = getelementptr inbounds %Node, ptr %t86, i64 %t88
  %t90 = getelementptr inbounds %Node, ptr %t89, i32 0, i32 3
  %t91 = load ptr, ptr %t90
  %t92 = alloca ptr
  store ptr %t91, ptr %t92
  %t93 = load ptr, ptr %t0
  %t94 = getelementptr inbounds %Analyzer, ptr %t93, i32 0, i32 2
  %t95 = load ptr, ptr %t94
  %t96 = load i32, ptr %t18
  %t97 = load ptr, ptr %t92
  %t98 = call i32 @structFieldIndex(ptr %t95, i32 %t96, ptr %t97)
  %t99 = alloca i32
  store i32 %t98, ptr %t99
  %t100 = load i32, ptr %t99
  %t101 = icmp slt i32 %t100, 0
  br i1 %t101, label %L9, label %L11
L9:
  %t102 = call ptr @bufNew()
  %t103 = alloca ptr
  store ptr %t102, ptr %t103
  %t104 = load ptr, ptr %t103
  call void @bufAdd(ptr %t104, ptr @.str.373)
  %t105 = load ptr, ptr %t103
  %t106 = load ptr, ptr %t12
  call void @bufAdd(ptr %t105, ptr %t106)
  %t107 = load ptr, ptr %t103
  call void @bufAdd(ptr %t107, ptr @.str.374)
  %t108 = load ptr, ptr %t103
  %t109 = load ptr, ptr %t92
  call void @bufAdd(ptr %t108, ptr %t109)
  %t110 = load ptr, ptr %t103
  call void @bufPush(ptr %t110, i8 39)
  %t111 = load ptr, ptr %t0
  %t112 = load i32, ptr %t1
  %t113 = load ptr, ptr %t103
  %t114 = getelementptr inbounds %Buf, ptr %t113, i32 0, i32 0
  %t115 = load ptr, ptr %t114
  call void @analyzerFail(ptr %t111, i32 %t112, ptr %t115)
  %t116 = load ptr, ptr %t12
  %t117 = call %Type @typeStruct(ptr %t116, i32 0)
  ret %Type %t117
L11:
  %t118 = load ptr, ptr %t43
  %t119 = load i32, ptr %t99
  %t120 = sext i32 %t119 to i64
  %t121 = getelementptr inbounds i8, ptr %t118, i64 %t120
  %t122 = load i8, ptr %t121
  %t123 = trunc i32 0 to i8
  %t124 = icmp ne i8 %t122, %t123
  br i1 %t124, label %L12, label %L14
L12:
  %t125 = load ptr, ptr %t0
  %t126 = load i32, ptr %t1
  %t127 = load ptr, ptr %t92
  %t128 = call ptr @quoted(ptr @.str.375, ptr %t127, ptr @.str.376)
  call void @analyzerFail(ptr %t125, i32 %t126, ptr %t128)
  br label %L14
L14:
  %t129 = trunc i32 1 to i8
  %t130 = load ptr, ptr %t43
  %t131 = load i32, ptr %t99
  %t132 = sext i32 %t131 to i64
  %t133 = getelementptr inbounds i8, ptr %t130, i64 %t132
  store i8 %t129, ptr %t133
  %t134 = load ptr, ptr %t0
  %t135 = load ptr, ptr %t0
  %t136 = getelementptr inbounds %Analyzer, ptr %t135, i32 0, i32 0
  %t137 = load ptr, ptr %t136
  %t138 = getelementptr inbounds %Ast, ptr %t137, i32 0, i32 0
  %t139 = load ptr, ptr %t138
  %t140 = load i32, ptr %t81
  %t141 = sext i32 %t140 to i64
  %t142 = getelementptr inbounds %Node, ptr %t139, i64 %t141
  %t143 = getelementptr inbounds %Node, ptr %t142, i32 0, i32 5
  %t144 = load i32, ptr %t143
  %t145 = call %Type @checkExpr(ptr %t134, i32 %t144)
  %t146 = alloca %Type
  store %Type %t145, ptr %t146
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 2
  %t149 = load ptr, ptr %t148
  %t150 = getelementptr inbounds %StructTable, ptr %t149, i32 0, i32 0
  %t151 = load ptr, ptr %t150
  %t152 = load i32, ptr %t18
  %t153 = sext i32 %t152 to i64
  %t154 = getelementptr inbounds %StructLayout, ptr %t151, i64 %t153
  %t155 = getelementptr inbounds %StructLayout, ptr %t154, i32 0, i32 1
  %t156 = load ptr, ptr %t155
  %t157 = load i32, ptr %t99
  %t158 = sext i32 %t157 to i64
  %t159 = getelementptr inbounds %FieldDef, ptr %t156, i64 %t158
  %t160 = getelementptr inbounds %FieldDef, ptr %t159, i32 0, i32 1
  %t161 = load %Type, ptr %t160
  %t162 = alloca %Type
  store %Type %t161, ptr %t162
  %t163 = load %Type, ptr %t146
  %t164 = load %Type, ptr %t162
  %t165 = call i1 @typeEquals(%Type %t163, %Type %t164)
  %t166 = xor i1 %t165, true
  br i1 %t166, label %L15, label %L17
L15:
  %t167 = call ptr @bufNew()
  %t168 = alloca ptr
  store ptr %t167, ptr %t168
  %t169 = load ptr, ptr %t168
  call void @bufAdd(ptr %t169, ptr @.str.377)
  %t170 = load ptr, ptr %t168
  %t171 = load ptr, ptr %t92
  call void @bufAdd(ptr %t170, ptr %t171)
  %t172 = load ptr, ptr %t168
  call void @bufAdd(ptr %t172, ptr @.str.378)
  %t173 = load ptr, ptr %t168
  %t174 = load ptr, ptr %t12
  call void @bufAdd(ptr %t173, ptr %t174)
  %t175 = load ptr, ptr %t168
  call void @bufAdd(ptr %t175, ptr @.str.379)
  %t176 = load ptr, ptr %t0
  %t177 = load i32, ptr %t1
  %t178 = load ptr, ptr %t168
  %t179 = getelementptr inbounds %Buf, ptr %t178, i32 0, i32 0
  %t180 = load ptr, ptr %t179
  %t181 = load %Type, ptr %t162
  %t182 = call ptr @typeToText(%Type %t181)
  %t183 = load %Type, ptr %t146
  %t184 = call ptr @typeToText(%Type %t183)
  %t185 = call ptr @expectedButGot(ptr %t182, ptr %t184)
  call void @analyzerFail2(ptr %t176, i32 %t177, ptr %t180, ptr %t185)
  br label %L17
L17:
  %t186 = load i32, ptr %t44
  %t187 = add i32 %t186, 1
  store i32 %t187, ptr %t44
  br label %L6
L8:
  store i32 0, ptr %t44
  br label %L18
L18:
  %t188 = load i32, ptr %t44
  %t189 = load i32, ptr %t39
  %t190 = icmp slt i32 %t188, %t189
  br i1 %t190, label %L19, label %L20
L19:
  %t191 = load ptr, ptr %t43
  %t192 = load i32, ptr %t44
  %t193 = sext i32 %t192 to i64
  %t194 = getelementptr inbounds i8, ptr %t191, i64 %t193
  %t195 = load i8, ptr %t194
  %t196 = trunc i32 0 to i8
  %t197 = icmp eq i8 %t195, %t196
  br i1 %t197, label %L21, label %L23
L21:
  %t198 = call ptr @bufNew()
  %t199 = alloca ptr
  store ptr %t198, ptr %t199
  %t200 = load ptr, ptr %t199
  call void @bufAdd(ptr %t200, ptr @.str.380)
  %t201 = load ptr, ptr %t199
  %t202 = load ptr, ptr %t0
  %t203 = getelementptr inbounds %Analyzer, ptr %t202, i32 0, i32 2
  %t204 = load ptr, ptr %t203
  %t205 = getelementptr inbounds %StructTable, ptr %t204, i32 0, i32 0
  %t206 = load ptr, ptr %t205
  %t207 = load i32, ptr %t18
  %t208 = sext i32 %t207 to i64
  %t209 = getelementptr inbounds %StructLayout, ptr %t206, i64 %t208
  %t210 = getelementptr inbounds %StructLayout, ptr %t209, i32 0, i32 1
  %t211 = load ptr, ptr %t210
  %t212 = load i32, ptr %t44
  %t213 = sext i32 %t212 to i64
  %t214 = getelementptr inbounds %FieldDef, ptr %t211, i64 %t213
  %t215 = getelementptr inbounds %FieldDef, ptr %t214, i32 0, i32 0
  %t216 = load ptr, ptr %t215
  call void @bufAdd(ptr %t201, ptr %t216)
  %t217 = load ptr, ptr %t199
  call void @bufAdd(ptr %t217, ptr @.str.381)
  %t218 = load ptr, ptr %t199
  %t219 = load ptr, ptr %t12
  call void @bufAdd(ptr %t218, ptr %t219)
  %t220 = load ptr, ptr %t199
  call void @bufAdd(ptr %t220, ptr @.str.382)
  %t221 = load ptr, ptr %t0
  %t222 = load i32, ptr %t1
  %t223 = load ptr, ptr %t199
  %t224 = getelementptr inbounds %Buf, ptr %t223, i32 0, i32 0
  %t225 = load ptr, ptr %t224
  call void @analyzerFail(ptr %t221, i32 %t222, ptr %t225)
  br label %L23
L23:
  %t226 = load i32, ptr %t44
  %t227 = add i32 %t226, 1
  store i32 %t227, ptr %t44
  br label %L18
L20:
  %t228 = load ptr, ptr %t12
  %t229 = call %Type @typeStruct(ptr %t228, i32 0)
  ret %Type %t229
}

define i1 @isConstantExpr(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i1
  %t14 = alloca i1
  %t15 = load i32, ptr %t12
  %t16 = load i32, ptr @NK_NUMBER
  %t17 = icmp eq i32 %t15, %t16
  store i1 %t17, ptr %t14
  br i1 %t17, label %L1, label %L0
L0:
  %t18 = load i32, ptr %t12
  %t19 = load i32, ptr @NK_BOOL
  %t20 = icmp eq i32 %t18, %t19
  store i1 %t20, ptr %t14
  br label %L1
L1:
  %t21 = load i1, ptr %t14
  store i1 %t21, ptr %t13
  br i1 %t21, label %L3, label %L2
L2:
  %t22 = load i32, ptr %t12
  %t23 = load i32, ptr @NK_STRING
  %t24 = icmp eq i32 %t22, %t23
  store i1 %t24, ptr %t13
  br label %L3
L3:
  %t25 = load i1, ptr %t13
  br i1 %t25, label %L4, label %L6
L4:
  ret i1 true
L6:
  %t26 = alloca i1
  %t27 = load i32, ptr %t12
  %t28 = load i32, ptr @NK_CHAR
  %t29 = icmp eq i32 %t27, %t28
  store i1 %t29, ptr %t26
  br i1 %t29, label %L8, label %L7
L7:
  %t30 = load i32, ptr %t12
  %t31 = load i32, ptr @NK_SIZEOF
  %t32 = icmp eq i32 %t30, %t31
  store i1 %t32, ptr %t26
  br label %L8
L8:
  %t33 = load i1, ptr %t26
  br i1 %t33, label %L9, label %L11
L9:
  ret i1 true
L11:
  %t34 = load i32, ptr %t12
  %t35 = load i32, ptr @NK_CAST
  %t36 = icmp eq i32 %t34, %t35
  br i1 %t36, label %L12, label %L14
L12:
  %t37 = load ptr, ptr %t0
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %Analyzer, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = getelementptr inbounds %Ast, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = load i32, ptr %t1
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds %Node, ptr %t42, i64 %t44
  %t46 = getelementptr inbounds %Node, ptr %t45, i32 0, i32 5
  %t47 = load i32, ptr %t46
  %t48 = call i1 @isConstantExpr(ptr %t37, i32 %t47)
  ret i1 %t48
L14:
  %t49 = load i32, ptr %t12
  %t50 = load i32, ptr @NK_UNARY
  %t51 = icmp eq i32 %t49, %t50
  br i1 %t51, label %L15, label %L17
L15:
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Analyzer, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = getelementptr inbounds %Ast, ptr %t54, i32 0, i32 0
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t1
  %t58 = sext i32 %t57 to i64
  %t59 = getelementptr inbounds %Node, ptr %t56, i64 %t58
  %t60 = getelementptr inbounds %Node, ptr %t59, i32 0, i32 3
  %t61 = load ptr, ptr %t60
  %t62 = call i1 @textEquals(ptr %t61, ptr @.str.383)
  %t63 = xor i1 %t62, true
  br i1 %t63, label %L18, label %L20
L18:
  ret i1 false
L20:
  %t64 = load ptr, ptr %t0
  %t65 = load ptr, ptr %t0
  %t66 = getelementptr inbounds %Analyzer, ptr %t65, i32 0, i32 0
  %t67 = load ptr, ptr %t66
  %t68 = getelementptr inbounds %Ast, ptr %t67, i32 0, i32 0
  %t69 = load ptr, ptr %t68
  %t70 = load i32, ptr %t1
  %t71 = sext i32 %t70 to i64
  %t72 = getelementptr inbounds %Node, ptr %t69, i64 %t71
  %t73 = getelementptr inbounds %Node, ptr %t72, i32 0, i32 5
  %t74 = load i32, ptr %t73
  %t75 = call i1 @isConstantExpr(ptr %t64, i32 %t74)
  ret i1 %t75
L17:
  ret i1 false
}

define void @analyzeRecovering(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 1
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %SymbolTable, ptr %t4, i32 0, i32 4
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Analyzer, ptr %t8, i32 0, i32 7
  %t10 = load i32, ptr %t9
  %t11 = alloca i32
  store i32 %t10, ptr %t11
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %Analyzer, ptr %t12, i32 0, i32 8
  %t14 = load i1, ptr %t13
  %t15 = alloca i1
  store i1 %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Analyzer, ptr %t16, i32 0, i32 9
  %t18 = load %Type, ptr %t17
  %t19 = alloca %Type
  store %Type %t18, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = load i32, ptr %t1
  call void @analyzeStatement(ptr %t20, i32 %t21)
  %t22 = load i1, ptr @FAILED
  %t23 = xor i1 %t22, true
  br i1 %t23, label %L0, label %L2
L0:
  ret void
L2:
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Analyzer, ptr %t24, i32 0, i32 1
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t7
  call void @symbolTruncateScopes(ptr %t26, i32 %t27)
  %t28 = load i32, ptr %t11
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Analyzer, ptr %t29, i32 0, i32 7
  store i32 %t28, ptr %t30
  %t31 = load i1, ptr %t15
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Analyzer, ptr %t32, i32 0, i32 8
  store i1 %t31, ptr %t33
  %t34 = load %Type, ptr %t19
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %Analyzer, ptr %t35, i32 0, i32 9
  store %Type %t34, ptr %t36
  store i1 false, ptr @FAILED
  ret void
}

define void @analyzeStatement(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i1, ptr @FAILED
  br i1 %t2, label %L0, label %L2
L0:
  ret void
L2:
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 0
  %t12 = load i32, ptr %t11
  %t13 = alloca i32
  store i32 %t12, ptr %t13
  %t14 = load i32, ptr %t13
  %t15 = load i32, ptr @NK_BLOCK
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L3, label %L5
L3:
  %t17 = load ptr, ptr %t0
  %t18 = load i32, ptr %t1
  call void @analyzeBlock(ptr %t17, i32 %t18)
  ret void
L5:
  %t19 = load i32, ptr %t13
  %t20 = load i32, ptr @NK_VARDECL
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L6, label %L8
L6:
  %t22 = load ptr, ptr %t0
  %t23 = load i32, ptr %t1
  call void @analyzeVarDecl(ptr %t22, i32 %t23)
  ret void
L8:
  %t24 = load i32, ptr %t13
  %t25 = load i32, ptr @NK_ASSIGN
  %t26 = icmp eq i32 %t24, %t25
  br i1 %t26, label %L9, label %L11
L9:
  %t27 = load ptr, ptr %t0
  %t28 = load i32, ptr %t1
  call void @analyzeAssign(ptr %t27, i32 %t28)
  ret void
L11:
  %t29 = load i32, ptr %t13
  %t30 = load i32, ptr @NK_IF
  %t31 = icmp eq i32 %t29, %t30
  br i1 %t31, label %L12, label %L14
L12:
  %t32 = load ptr, ptr %t0
  %t33 = load i32, ptr %t1
  call void @analyzeIf(ptr %t32, i32 %t33)
  ret void
L14:
  %t34 = load i32, ptr %t13
  %t35 = load i32, ptr @NK_WHILE
  %t36 = icmp eq i32 %t34, %t35
  br i1 %t36, label %L15, label %L17
L15:
  %t37 = load ptr, ptr %t0
  %t38 = load i32, ptr %t1
  call void @analyzeWhile(ptr %t37, i32 %t38)
  ret void
L17:
  %t39 = load i32, ptr %t13
  %t40 = load i32, ptr @NK_FN
  %t41 = icmp eq i32 %t39, %t40
  br i1 %t41, label %L18, label %L20
L18:
  %t42 = load ptr, ptr %t0
  %t43 = load i32, ptr %t1
  call void @analyzeFuncDecl(ptr %t42, i32 %t43)
  ret void
L20:
  %t44 = load i32, ptr %t13
  %t45 = load i32, ptr @NK_EXTERN
  %t46 = icmp eq i32 %t44, %t45
  br i1 %t46, label %L21, label %L23
L21:
  %t47 = load ptr, ptr %t0
  %t48 = load i32, ptr %t1
  call void @analyzeExternDecl(ptr %t47, i32 %t48)
  ret void
L23:
  %t49 = load i32, ptr %t13
  %t50 = load i32, ptr @NK_RETURN
  %t51 = icmp eq i32 %t49, %t50
  br i1 %t51, label %L24, label %L26
L24:
  %t52 = load ptr, ptr %t0
  %t53 = load i32, ptr %t1
  call void @analyzeReturn(ptr %t52, i32 %t53)
  ret void
L26:
  %t54 = load i32, ptr %t13
  %t55 = load i32, ptr @NK_PRINT
  %t56 = icmp eq i32 %t54, %t55
  br i1 %t56, label %L27, label %L29
L27:
  %t57 = load ptr, ptr %t0
  %t58 = load i32, ptr %t1
  call void @analyzePrint(ptr %t57, i32 %t58)
  ret void
L29:
  %t59 = load i32, ptr %t13
  %t60 = load i32, ptr @NK_EXPRSTMT
  %t61 = icmp eq i32 %t59, %t60
  br i1 %t61, label %L30, label %L32
L30:
  %t62 = load ptr, ptr %t0
  %t63 = load ptr, ptr %t0
  %t64 = getelementptr inbounds %Analyzer, ptr %t63, i32 0, i32 0
  %t65 = load ptr, ptr %t64
  %t66 = getelementptr inbounds %Ast, ptr %t65, i32 0, i32 0
  %t67 = load ptr, ptr %t66
  %t68 = load i32, ptr %t1
  %t69 = sext i32 %t68 to i64
  %t70 = getelementptr inbounds %Node, ptr %t67, i64 %t69
  %t71 = getelementptr inbounds %Node, ptr %t70, i32 0, i32 5
  %t72 = load i32, ptr %t71
  %t73 = call %Type @checkExpr(ptr %t62, i32 %t72)
  ret void
L32:
  %t74 = load i32, ptr %t13
  %t75 = load i32, ptr @NK_BREAK
  %t76 = icmp eq i32 %t74, %t75
  br i1 %t76, label %L33, label %L35
L33:
  %t77 = load ptr, ptr %t0
  %t78 = getelementptr inbounds %Analyzer, ptr %t77, i32 0, i32 7
  %t79 = load i32, ptr %t78
  %t80 = icmp eq i32 %t79, 0
  br i1 %t80, label %L36, label %L38
L36:
  %t81 = load ptr, ptr %t0
  %t82 = load i32, ptr %t1
  call void @analyzerFail(ptr %t81, i32 %t82, ptr @.str.384)
  br label %L38
L38:
  ret void
L35:
  %t83 = load i32, ptr %t13
  %t84 = load i32, ptr @NK_CONTINUE
  %t85 = icmp eq i32 %t83, %t84
  br i1 %t85, label %L39, label %L41
L39:
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr inbounds %Analyzer, ptr %t86, i32 0, i32 7
  %t88 = load i32, ptr %t87
  %t89 = icmp eq i32 %t88, 0
  br i1 %t89, label %L42, label %L44
L42:
  %t90 = load ptr, ptr %t0
  %t91 = load i32, ptr %t1
  call void @analyzerFail(ptr %t90, i32 %t91, ptr @.str.385)
  br label %L44
L44:
  ret void
L41:
  %t92 = alloca i1
  %t93 = load i32, ptr %t13
  %t94 = load i32, ptr @NK_STRUCT
  %t95 = icmp eq i32 %t93, %t94
  store i1 %t95, ptr %t92
  br i1 %t95, label %L46, label %L45
L45:
  %t96 = load i32, ptr %t13
  %t97 = load i32, ptr @NK_IMPORT
  %t98 = icmp eq i32 %t96, %t97
  store i1 %t98, ptr %t92
  br label %L46
L46:
  %t99 = load i1, ptr %t92
  br i1 %t99, label %L47, label %L49
L47:
  ret void
L49:
  %t100 = load ptr, ptr %t0
  %t101 = load i32, ptr %t1
  call void @analyzerFail(ptr %t100, i32 %t101, ptr @.str.386)
  ret void
}

define void @analyzeBlock(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 1
  %t4 = load ptr, ptr %t3
  call void @symbolEnterScope(ptr %t4)
  %t5 = alloca i32
  store i32 0, ptr %t5
  br label %L0
L0:
  %t6 = load i32, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Analyzer, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = getelementptr inbounds %Ast, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t1
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Node, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Node, ptr %t14, i32 0, i32 10
  %t16 = load i32, ptr %t15
  %t17 = icmp slt i32 %t6, %t16
  br i1 %t17, label %L1, label %L2
L1:
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Analyzer, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = getelementptr inbounds %Ast, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = load i32, ptr %t1
  %t25 = sext i32 %t24 to i64
  %t26 = getelementptr inbounds %Node, ptr %t23, i64 %t25
  %t27 = getelementptr inbounds %Node, ptr %t26, i32 0, i32 9
  %t28 = load ptr, ptr %t27
  %t29 = load i32, ptr %t5
  %t30 = sext i32 %t29 to i64
  %t31 = getelementptr inbounds i32, ptr %t28, i64 %t30
  %t32 = load i32, ptr %t31
  call void @analyzeRecovering(ptr %t18, i32 %t32)
  %t33 = load i32, ptr %t5
  %t34 = add i32 %t33, 1
  store i32 %t34, ptr %t5
  br label %L0
L2:
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %Analyzer, ptr %t35, i32 0, i32 1
  %t37 = load ptr, ptr %t36
  call void @symbolExitScope(ptr %t37)
  ret void
}

define void @analyzeVarDecl(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 5
  %t23 = load i32, ptr %t22
  %t24 = call %Type @analyzerParseType(ptr %t13, i32 %t23)
  %t25 = alloca %Type
  store %Type %t24, ptr %t25
  %t26 = load ptr, ptr %t0
  %t27 = load i32, ptr %t1
  %t28 = load %Type, ptr %t25
  %t29 = load ptr, ptr %t12
  %t30 = call ptr @quoted(ptr @.str.387, ptr %t29, ptr @.str.388)
  call void @analyzerValidateType(ptr %t26, i32 %t27, %Type %t28, ptr %t30)
  %t31 = load %Type, ptr %t25
  %t32 = call i1 @typeIsVoid(%Type %t31)
  br i1 %t32, label %L0, label %L2
L0:
  %t33 = load ptr, ptr %t0
  %t34 = load i32, ptr %t1
  %t35 = load ptr, ptr %t12
  %t36 = call ptr @quoted(ptr @.str.389, ptr %t35, ptr @.str.390)
  call void @analyzerFail(ptr %t33, i32 %t34, ptr %t36)
  br label %L2
L2:
  %t37 = load ptr, ptr %t0
  %t38 = load ptr, ptr %t0
  %t39 = getelementptr inbounds %Analyzer, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = getelementptr inbounds %Ast, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = load i32, ptr %t1
  %t44 = sext i32 %t43 to i64
  %t45 = getelementptr inbounds %Node, ptr %t42, i64 %t44
  %t46 = getelementptr inbounds %Node, ptr %t45, i32 0, i32 6
  %t47 = load i32, ptr %t46
  %t48 = call %Type @checkExpr(ptr %t37, i32 %t47)
  %t49 = alloca %Type
  store %Type %t48, ptr %t49
  %t50 = alloca i1
  %t51 = load i1, ptr @FAILED
  %t52 = xor i1 %t51, true
  store i1 %t52, ptr %t50
  br i1 %t52, label %L3, label %L4
L3:
  %t53 = load %Type, ptr %t25
  %t54 = load %Type, ptr %t49
  %t55 = call i1 @typeEquals(%Type %t53, %Type %t54)
  %t56 = xor i1 %t55, true
  store i1 %t56, ptr %t50
  br label %L4
L4:
  %t57 = load i1, ptr %t50
  br i1 %t57, label %L5, label %L7
L5:
  %t58 = call ptr @bufNew()
  %t59 = alloca ptr
  store ptr %t58, ptr %t59
  %t60 = load ptr, ptr %t59
  call void @bufAdd(ptr %t60, ptr @.str.391)
  %t61 = load ptr, ptr %t59
  %t62 = load ptr, ptr %t12
  call void @bufAdd(ptr %t61, ptr %t62)
  %t63 = load ptr, ptr %t59
  call void @bufPush(ptr %t63, i8 39)
  %t64 = call ptr @bufNew()
  %t65 = alloca ptr
  store ptr %t64, ptr %t65
  %t66 = load ptr, ptr %t65
  call void @bufAdd(ptr %t66, ptr @.str.392)
  %t67 = load ptr, ptr %t65
  %t68 = load %Type, ptr %t25
  %t69 = call ptr @typeToText(%Type %t68)
  call void @bufAdd(ptr %t67, ptr %t69)
  %t70 = load ptr, ptr %t65
  call void @bufAdd(ptr %t70, ptr @.str.393)
  %t71 = load ptr, ptr %t65
  %t72 = load %Type, ptr %t49
  %t73 = call ptr @typeToText(%Type %t72)
  call void @bufAdd(ptr %t71, ptr %t73)
  %t74 = load ptr, ptr %t65
  call void @bufPush(ptr %t74, i8 39)
  %t75 = load ptr, ptr %t0
  %t76 = load i32, ptr %t1
  %t77 = load ptr, ptr %t59
  %t78 = getelementptr inbounds %Buf, ptr %t77, i32 0, i32 0
  %t79 = load ptr, ptr %t78
  %t80 = load ptr, ptr %t65
  %t81 = getelementptr inbounds %Buf, ptr %t80, i32 0, i32 0
  %t82 = load ptr, ptr %t81
  call void @analyzerFail2(ptr %t75, i32 %t76, ptr %t79, ptr %t82)
  br label %L7
L7:
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr inbounds %Analyzer, ptr %t83, i32 0, i32 4
  %t85 = load ptr, ptr %t84
  %t86 = load i32, ptr %t1
  %t87 = sext i32 %t86 to i64
  %t88 = getelementptr inbounds i8, ptr %t85, i64 %t87
  %t89 = load i8, ptr %t88
  %t90 = trunc i32 0 to i8
  %t91 = icmp ne i8 %t89, %t90
  br i1 %t91, label %L8, label %L10
L8:
  %t92 = alloca i1
  %t93 = load i1, ptr @FAILED
  %t94 = xor i1 %t93, true
  store i1 %t94, ptr %t92
  br i1 %t94, label %L11, label %L12
L11:
  %t95 = load ptr, ptr %t0
  %t96 = load ptr, ptr %t0
  %t97 = getelementptr inbounds %Analyzer, ptr %t96, i32 0, i32 0
  %t98 = load ptr, ptr %t97
  %t99 = getelementptr inbounds %Ast, ptr %t98, i32 0, i32 0
  %t100 = load ptr, ptr %t99
  %t101 = load i32, ptr %t1
  %t102 = sext i32 %t101 to i64
  %t103 = getelementptr inbounds %Node, ptr %t100, i64 %t102
  %t104 = getelementptr inbounds %Node, ptr %t103, i32 0, i32 6
  %t105 = load i32, ptr %t104
  %t106 = call i1 @isConstantExpr(ptr %t95, i32 %t105)
  %t107 = xor i1 %t106, true
  store i1 %t107, ptr %t92
  br label %L12
L12:
  %t108 = load i1, ptr %t92
  br i1 %t108, label %L13, label %L15
L13:
  %t109 = load ptr, ptr %t0
  %t110 = load i32, ptr %t1
  %t111 = load ptr, ptr %t12
  %t112 = call ptr @quoted(ptr @.str.394, ptr %t111, ptr @.str.395)
  call void @analyzerFail2(ptr %t109, i32 %t110, ptr %t112, ptr @.str.396)
  br label %L15
L15:
  ret void
L10:
  %t113 = load ptr, ptr %t0
  %t114 = getelementptr inbounds %Analyzer, ptr %t113, i32 0, i32 1
  %t115 = load ptr, ptr %t114
  %t116 = load ptr, ptr %t12
  %t117 = load i32, ptr @SYM_VAR
  %t118 = load %Type, ptr %t25
  %t119 = sext i32 0 to i64
  %t120 = inttoptr i64 %t119 to ptr
  %t121 = load ptr, ptr %t0
  %t122 = getelementptr inbounds %Analyzer, ptr %t121, i32 0, i32 0
  %t123 = load ptr, ptr %t122
  %t124 = getelementptr inbounds %Ast, ptr %t123, i32 0, i32 0
  %t125 = load ptr, ptr %t124
  %t126 = load i32, ptr %t1
  %t127 = sext i32 %t126 to i64
  %t128 = getelementptr inbounds %Node, ptr %t125, i64 %t127
  %t129 = getelementptr inbounds %Node, ptr %t128, i32 0, i32 1
  %t130 = load i32, ptr %t129
  %t131 = load ptr, ptr %t0
  %t132 = getelementptr inbounds %Analyzer, ptr %t131, i32 0, i32 0
  %t133 = load ptr, ptr %t132
  %t134 = getelementptr inbounds %Ast, ptr %t133, i32 0, i32 0
  %t135 = load ptr, ptr %t134
  %t136 = load i32, ptr %t1
  %t137 = sext i32 %t136 to i64
  %t138 = getelementptr inbounds %Node, ptr %t135, i64 %t137
  %t139 = getelementptr inbounds %Node, ptr %t138, i32 0, i32 2
  %t140 = load i32, ptr %t139
  call void @symbolDeclare(ptr %t115, ptr %t116, i32 %t117, %Type %t118, ptr %t120, i32 0, i32 %t130, i32 %t140)
  ret void
}

define void @analyzeAssign(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load i32, ptr %t1
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = load i32, ptr %t1
  %t10 = sext i32 %t9 to i64
  %t11 = getelementptr inbounds %Node, ptr %t8, i64 %t10
  %t12 = getelementptr inbounds %Node, ptr %t11, i32 0, i32 5
  %t13 = load i32, ptr %t12
  %t14 = call %Type @checkAssignTarget(ptr %t2, i32 %t3, i32 %t13)
  %t15 = alloca %Type
  store %Type %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Analyzer, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  %t20 = getelementptr inbounds %Ast, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  %t22 = load i32, ptr %t1
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr inbounds %Node, ptr %t21, i64 %t23
  %t25 = getelementptr inbounds %Node, ptr %t24, i32 0, i32 6
  %t26 = load i32, ptr %t25
  %t27 = call %Type @checkExpr(ptr %t16, i32 %t26)
  %t28 = alloca %Type
  store %Type %t27, ptr %t28
  %t29 = load %Type, ptr %t15
  %t30 = load %Type, ptr %t28
  %t31 = call i1 @typeEquals(%Type %t29, %Type %t30)
  %t32 = xor i1 %t31, true
  br i1 %t32, label %L0, label %L2
L0:
  %t33 = load ptr, ptr %t0
  %t34 = load i32, ptr %t1
  %t35 = load %Type, ptr %t15
  %t36 = call ptr @typeToText(%Type %t35)
  %t37 = load %Type, ptr %t28
  %t38 = call ptr @typeToText(%Type %t37)
  %t39 = call ptr @expectedButGot(ptr %t36, ptr %t38)
  call void @analyzerFail2(ptr %t33, i32 %t34, ptr @.str.397, ptr %t39)
  br label %L2
L2:
  ret void
}

define void @analyzeIf(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 5
  %t12 = load i32, ptr %t11
  %t13 = call %Type @checkExpr(ptr %t2, i32 %t12)
  %t14 = alloca %Type
  store %Type %t13, ptr %t14
  %t15 = load %Type, ptr %t14
  %t16 = call i1 @typeIsBool(%Type %t15)
  %t17 = xor i1 %t16, true
  br i1 %t17, label %L0, label %L2
L0:
  %t18 = load ptr, ptr %t0
  %t19 = load i32, ptr %t1
  %t20 = load %Type, ptr %t14
  %t21 = call ptr @gotType(%Type %t20)
  call void @analyzerFail2(ptr %t18, i32 %t19, ptr @.str.398, ptr %t21)
  br label %L2
L2:
  %t22 = load ptr, ptr %t0
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Analyzer, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = getelementptr inbounds %Ast, ptr %t25, i32 0, i32 0
  %t27 = load ptr, ptr %t26
  %t28 = load i32, ptr %t1
  %t29 = sext i32 %t28 to i64
  %t30 = getelementptr inbounds %Node, ptr %t27, i64 %t29
  %t31 = getelementptr inbounds %Node, ptr %t30, i32 0, i32 6
  %t32 = load i32, ptr %t31
  call void @analyzeStatement(ptr %t22, i32 %t32)
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 7
  %t42 = load i32, ptr %t41
  %t43 = load i32, ptr @NO_NODE
  %t44 = icmp ne i32 %t42, %t43
  br i1 %t44, label %L3, label %L5
L3:
  %t45 = load ptr, ptr %t0
  %t46 = load ptr, ptr %t0
  %t47 = getelementptr inbounds %Analyzer, ptr %t46, i32 0, i32 0
  %t48 = load ptr, ptr %t47
  %t49 = getelementptr inbounds %Ast, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = load i32, ptr %t1
  %t52 = sext i32 %t51 to i64
  %t53 = getelementptr inbounds %Node, ptr %t50, i64 %t52
  %t54 = getelementptr inbounds %Node, ptr %t53, i32 0, i32 7
  %t55 = load i32, ptr %t54
  call void @analyzeStatement(ptr %t45, i32 %t55)
  br label %L5
L5:
  ret void
}

define void @analyzeWhile(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 5
  %t12 = load i32, ptr %t11
  %t13 = call %Type @checkExpr(ptr %t2, i32 %t12)
  %t14 = alloca %Type
  store %Type %t13, ptr %t14
  %t15 = load %Type, ptr %t14
  %t16 = call i1 @typeIsBool(%Type %t15)
  %t17 = xor i1 %t16, true
  br i1 %t17, label %L0, label %L2
L0:
  %t18 = load ptr, ptr %t0
  %t19 = load i32, ptr %t1
  %t20 = load %Type, ptr %t14
  %t21 = call ptr @gotType(%Type %t20)
  call void @analyzerFail2(ptr %t18, i32 %t19, ptr @.str.399, ptr %t21)
  br label %L2
L2:
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Analyzer, ptr %t22, i32 0, i32 7
  %t24 = load i32, ptr %t23
  %t25 = add i32 %t24, 1
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Analyzer, ptr %t26, i32 0, i32 7
  store i32 %t25, ptr %t27
  %t28 = load ptr, ptr %t0
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Analyzer, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = getelementptr inbounds %Ast, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t1
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %Node, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %Node, ptr %t36, i32 0, i32 6
  %t38 = load i32, ptr %t37
  call void @analyzeStatement(ptr %t28, i32 %t38)
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Analyzer, ptr %t39, i32 0, i32 7
  %t41 = load i32, ptr %t40
  %t42 = sub i32 %t41, 1
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr inbounds %Analyzer, ptr %t43, i32 0, i32 7
  store i32 %t42, ptr %t44
  ret void
}

define void @analyzeReturn(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 8
  %t4 = load i1, ptr %t3
  %t5 = xor i1 %t4, true
  br i1 %t5, label %L0, label %L2
L0:
  %t6 = load ptr, ptr %t0
  %t7 = load i32, ptr %t1
  call void @analyzerFail(ptr %t6, i32 %t7, ptr @.str.400)
  br label %L2
L2:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Analyzer, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = getelementptr inbounds %Ast, ptr %t10, i32 0, i32 0
  %t12 = load ptr, ptr %t11
  %t13 = load i32, ptr %t1
  %t14 = sext i32 %t13 to i64
  %t15 = getelementptr inbounds %Node, ptr %t12, i64 %t14
  %t16 = getelementptr inbounds %Node, ptr %t15, i32 0, i32 5
  %t17 = load i32, ptr %t16
  %t18 = load i32, ptr @NO_NODE
  %t19 = icmp eq i32 %t17, %t18
  br i1 %t19, label %L3, label %L5
L3:
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Analyzer, ptr %t20, i32 0, i32 9
  %t22 = load %Type, ptr %t21
  %t23 = call i1 @typeIsVoid(%Type %t22)
  %t24 = xor i1 %t23, true
  br i1 %t24, label %L6, label %L8
L6:
  %t25 = load ptr, ptr %t0
  %t26 = load i32, ptr %t1
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Analyzer, ptr %t27, i32 0, i32 9
  %t29 = load %Type, ptr %t28
  %t30 = call ptr @typeToText(%Type %t29)
  %t31 = call ptr @quoted(ptr @.str.402, ptr %t30, ptr @.str.403)
  call void @analyzerFail2(ptr %t25, i32 %t26, ptr @.str.401, ptr %t31)
  br label %L8
L8:
  ret void
L5:
  %t32 = load ptr, ptr %t0
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 5
  %t42 = load i32, ptr %t41
  %t43 = call %Type @checkExpr(ptr %t32, i32 %t42)
  %t44 = alloca %Type
  store %Type %t43, ptr %t44
  %t45 = load ptr, ptr %t0
  %t46 = getelementptr inbounds %Analyzer, ptr %t45, i32 0, i32 9
  %t47 = load %Type, ptr %t46
  %t48 = call i1 @typeIsVoid(%Type %t47)
  br i1 %t48, label %L9, label %L11
L9:
  %t49 = load ptr, ptr %t0
  %t50 = load i32, ptr %t1
  %t51 = load %Type, ptr %t44
  %t52 = call ptr @gotType(%Type %t51)
  call void @analyzerFail2(ptr %t49, i32 %t50, ptr @.str.404, ptr %t52)
  br label %L11
L11:
  %t53 = load %Type, ptr %t44
  %t54 = load ptr, ptr %t0
  %t55 = getelementptr inbounds %Analyzer, ptr %t54, i32 0, i32 9
  %t56 = load %Type, ptr %t55
  %t57 = call i1 @typeEquals(%Type %t53, %Type %t56)
  %t58 = xor i1 %t57, true
  br i1 %t58, label %L12, label %L14
L12:
  %t59 = load ptr, ptr %t0
  %t60 = load i32, ptr %t1
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Analyzer, ptr %t61, i32 0, i32 9
  %t63 = load %Type, ptr %t62
  %t64 = call ptr @typeToText(%Type %t63)
  %t65 = load %Type, ptr %t44
  %t66 = call ptr @typeToText(%Type %t65)
  %t67 = call ptr @expectedButGot(ptr %t64, ptr %t66)
  call void @analyzerFail2(ptr %t59, i32 %t60, ptr @.str.405, ptr %t67)
  br label %L14
L14:
  ret void
}

define void @analyzePrint(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Analyzer, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 5
  %t12 = load i32, ptr %t11
  %t13 = call %Type @checkExpr(ptr %t2, i32 %t12)
  %t14 = alloca %Type
  store %Type %t13, ptr %t14
  %t15 = load %Type, ptr %t14
  %t16 = call i1 @typeIsVoid(%Type %t15)
  br i1 %t16, label %L0, label %L2
L0:
  %t17 = load ptr, ptr %t0
  %t18 = load i32, ptr %t1
  call void @analyzerFail(ptr %t17, i32 %t18, ptr @.str.406)
  br label %L2
L2:
  ret void
}

define void @analyzeFuncDecl(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 1
  %t15 = load ptr, ptr %t14
  %t16 = load ptr, ptr %t12
  %t17 = call i32 @symbolFind(ptr %t15, ptr %t16)
  %t18 = icmp slt i32 %t17, 0
  br i1 %t18, label %L0, label %L2
L0:
  %t19 = alloca i32
  store i32 0, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Analyzer, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = getelementptr inbounds %Ast, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t1
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds %Node, ptr %t25, i64 %t27
  %t29 = getelementptr inbounds %Node, ptr %t28, i32 0, i32 6
  %t30 = load i32, ptr %t29
  %t31 = call ptr @analyzerParamTypes(ptr %t20, i32 %t30, ptr %t19)
  %t32 = alloca ptr
  store ptr %t31, ptr %t32
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 1
  %t35 = load ptr, ptr %t34
  %t36 = load ptr, ptr %t12
  %t37 = load i32, ptr @SYM_FN
  %t38 = load ptr, ptr %t0
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Analyzer, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = getelementptr inbounds %Ast, ptr %t41, i32 0, i32 0
  %t43 = load ptr, ptr %t42
  %t44 = load i32, ptr %t1
  %t45 = sext i32 %t44 to i64
  %t46 = getelementptr inbounds %Node, ptr %t43, i64 %t45
  %t47 = getelementptr inbounds %Node, ptr %t46, i32 0, i32 5
  %t48 = load i32, ptr %t47
  %t49 = call %Type @analyzerParseType(ptr %t38, i32 %t48)
  %t50 = load ptr, ptr %t32
  %t51 = load i32, ptr %t19
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Analyzer, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = getelementptr inbounds %Ast, ptr %t54, i32 0, i32 0
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t1
  %t58 = sext i32 %t57 to i64
  %t59 = getelementptr inbounds %Node, ptr %t56, i64 %t58
  %t60 = getelementptr inbounds %Node, ptr %t59, i32 0, i32 1
  %t61 = load i32, ptr %t60
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Analyzer, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = getelementptr inbounds %Ast, ptr %t64, i32 0, i32 0
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t1
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds %Node, ptr %t66, i64 %t68
  %t70 = getelementptr inbounds %Node, ptr %t69, i32 0, i32 2
  %t71 = load i32, ptr %t70
  call void @symbolDeclare(ptr %t35, ptr %t36, i32 %t37, %Type %t49, ptr %t50, i32 %t51, i32 %t61, i32 %t71)
  br label %L2
L2:
  %t72 = load ptr, ptr %t0
  %t73 = getelementptr inbounds %Analyzer, ptr %t72, i32 0, i32 1
  %t74 = load ptr, ptr %t73
  call void @symbolEnterScope(ptr %t74)
  %t75 = load ptr, ptr %t0
  %t76 = getelementptr inbounds %Analyzer, ptr %t75, i32 0, i32 0
  %t77 = load ptr, ptr %t76
  %t78 = getelementptr inbounds %Ast, ptr %t77, i32 0, i32 0
  %t79 = load ptr, ptr %t78
  %t80 = load i32, ptr %t1
  %t81 = sext i32 %t80 to i64
  %t82 = getelementptr inbounds %Node, ptr %t79, i64 %t81
  %t83 = getelementptr inbounds %Node, ptr %t82, i32 0, i32 6
  %t84 = load i32, ptr %t83
  %t85 = alloca i32
  store i32 %t84, ptr %t85
  %t86 = load i32, ptr %t85
  %t87 = load i32, ptr @NO_NODE
  %t88 = icmp ne i32 %t86, %t87
  br i1 %t88, label %L3, label %L5
L3:
  %t89 = alloca i32
  store i32 0, ptr %t89
  br label %L6
L6:
  %t90 = load i32, ptr %t89
  %t91 = load ptr, ptr %t0
  %t92 = getelementptr inbounds %Analyzer, ptr %t91, i32 0, i32 0
  %t93 = load ptr, ptr %t92
  %t94 = getelementptr inbounds %Ast, ptr %t93, i32 0, i32 0
  %t95 = load ptr, ptr %t94
  %t96 = load i32, ptr %t85
  %t97 = sext i32 %t96 to i64
  %t98 = getelementptr inbounds %Node, ptr %t95, i64 %t97
  %t99 = getelementptr inbounds %Node, ptr %t98, i32 0, i32 10
  %t100 = load i32, ptr %t99
  %t101 = icmp slt i32 %t90, %t100
  br i1 %t101, label %L7, label %L8
L7:
  %t102 = load ptr, ptr %t0
  %t103 = getelementptr inbounds %Analyzer, ptr %t102, i32 0, i32 0
  %t104 = load ptr, ptr %t103
  %t105 = getelementptr inbounds %Ast, ptr %t104, i32 0, i32 0
  %t106 = load ptr, ptr %t105
  %t107 = load i32, ptr %t85
  %t108 = sext i32 %t107 to i64
  %t109 = getelementptr inbounds %Node, ptr %t106, i64 %t108
  %t110 = getelementptr inbounds %Node, ptr %t109, i32 0, i32 9
  %t111 = load ptr, ptr %t110
  %t112 = load i32, ptr %t89
  %t113 = sext i32 %t112 to i64
  %t114 = getelementptr inbounds i32, ptr %t111, i64 %t113
  %t115 = load i32, ptr %t114
  %t116 = alloca i32
  store i32 %t115, ptr %t116
  %t117 = load ptr, ptr %t0
  %t118 = load ptr, ptr %t0
  %t119 = getelementptr inbounds %Analyzer, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = getelementptr inbounds %Ast, ptr %t120, i32 0, i32 0
  %t122 = load ptr, ptr %t121
  %t123 = load i32, ptr %t116
  %t124 = sext i32 %t123 to i64
  %t125 = getelementptr inbounds %Node, ptr %t122, i64 %t124
  %t126 = getelementptr inbounds %Node, ptr %t125, i32 0, i32 5
  %t127 = load i32, ptr %t126
  %t128 = call %Type @analyzerParseType(ptr %t117, i32 %t127)
  %t129 = alloca %Type
  store %Type %t128, ptr %t129
  %t130 = load ptr, ptr %t0
  %t131 = getelementptr inbounds %Analyzer, ptr %t130, i32 0, i32 1
  %t132 = load ptr, ptr %t131
  %t133 = load ptr, ptr %t0
  %t134 = getelementptr inbounds %Analyzer, ptr %t133, i32 0, i32 0
  %t135 = load ptr, ptr %t134
  %t136 = getelementptr inbounds %Ast, ptr %t135, i32 0, i32 0
  %t137 = load ptr, ptr %t136
  %t138 = load i32, ptr %t116
  %t139 = sext i32 %t138 to i64
  %t140 = getelementptr inbounds %Node, ptr %t137, i64 %t139
  %t141 = getelementptr inbounds %Node, ptr %t140, i32 0, i32 3
  %t142 = load ptr, ptr %t141
  %t143 = load i32, ptr @SYM_VAR
  %t144 = load %Type, ptr %t129
  %t145 = sext i32 0 to i64
  %t146 = inttoptr i64 %t145 to ptr
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 0
  %t149 = load ptr, ptr %t148
  %t150 = getelementptr inbounds %Ast, ptr %t149, i32 0, i32 0
  %t151 = load ptr, ptr %t150
  %t152 = load i32, ptr %t116
  %t153 = sext i32 %t152 to i64
  %t154 = getelementptr inbounds %Node, ptr %t151, i64 %t153
  %t155 = getelementptr inbounds %Node, ptr %t154, i32 0, i32 1
  %t156 = load i32, ptr %t155
  %t157 = load ptr, ptr %t0
  %t158 = getelementptr inbounds %Analyzer, ptr %t157, i32 0, i32 0
  %t159 = load ptr, ptr %t158
  %t160 = getelementptr inbounds %Ast, ptr %t159, i32 0, i32 0
  %t161 = load ptr, ptr %t160
  %t162 = load i32, ptr %t116
  %t163 = sext i32 %t162 to i64
  %t164 = getelementptr inbounds %Node, ptr %t161, i64 %t163
  %t165 = getelementptr inbounds %Node, ptr %t164, i32 0, i32 2
  %t166 = load i32, ptr %t165
  call void @symbolDeclare(ptr %t132, ptr %t142, i32 %t143, %Type %t144, ptr %t146, i32 0, i32 %t156, i32 %t166)
  %t167 = load i32, ptr %t89
  %t168 = add i32 %t167, 1
  store i32 %t168, ptr %t89
  br label %L6
L8:
  br label %L5
L5:
  %t169 = load ptr, ptr %t0
  %t170 = getelementptr inbounds %Analyzer, ptr %t169, i32 0, i32 8
  %t171 = load i1, ptr %t170
  %t172 = alloca i1
  store i1 %t171, ptr %t172
  %t173 = load ptr, ptr %t0
  %t174 = getelementptr inbounds %Analyzer, ptr %t173, i32 0, i32 9
  %t175 = load %Type, ptr %t174
  %t176 = alloca %Type
  store %Type %t175, ptr %t176
  %t177 = load ptr, ptr %t0
  %t178 = getelementptr inbounds %Analyzer, ptr %t177, i32 0, i32 7
  %t179 = load i32, ptr %t178
  %t180 = alloca i32
  store i32 %t179, ptr %t180
  %t181 = load ptr, ptr %t0
  %t182 = getelementptr inbounds %Analyzer, ptr %t181, i32 0, i32 8
  store i1 true, ptr %t182
  %t183 = load ptr, ptr %t0
  %t184 = load ptr, ptr %t0
  %t185 = getelementptr inbounds %Analyzer, ptr %t184, i32 0, i32 0
  %t186 = load ptr, ptr %t185
  %t187 = getelementptr inbounds %Ast, ptr %t186, i32 0, i32 0
  %t188 = load ptr, ptr %t187
  %t189 = load i32, ptr %t1
  %t190 = sext i32 %t189 to i64
  %t191 = getelementptr inbounds %Node, ptr %t188, i64 %t190
  %t192 = getelementptr inbounds %Node, ptr %t191, i32 0, i32 5
  %t193 = load i32, ptr %t192
  %t194 = call %Type @analyzerParseType(ptr %t183, i32 %t193)
  %t195 = load ptr, ptr %t0
  %t196 = getelementptr inbounds %Analyzer, ptr %t195, i32 0, i32 9
  store %Type %t194, ptr %t196
  %t197 = load ptr, ptr %t0
  %t198 = getelementptr inbounds %Analyzer, ptr %t197, i32 0, i32 7
  store i32 0, ptr %t198
  %t199 = load ptr, ptr %t0
  %t200 = load ptr, ptr %t0
  %t201 = getelementptr inbounds %Analyzer, ptr %t200, i32 0, i32 0
  %t202 = load ptr, ptr %t201
  %t203 = getelementptr inbounds %Ast, ptr %t202, i32 0, i32 0
  %t204 = load ptr, ptr %t203
  %t205 = load i32, ptr %t1
  %t206 = sext i32 %t205 to i64
  %t207 = getelementptr inbounds %Node, ptr %t204, i64 %t206
  %t208 = getelementptr inbounds %Node, ptr %t207, i32 0, i32 7
  %t209 = load i32, ptr %t208
  call void @analyzeStatement(ptr %t199, i32 %t209)
  %t210 = load i1, ptr %t172
  %t211 = load ptr, ptr %t0
  %t212 = getelementptr inbounds %Analyzer, ptr %t211, i32 0, i32 8
  store i1 %t210, ptr %t212
  %t213 = load %Type, ptr %t176
  %t214 = load ptr, ptr %t0
  %t215 = getelementptr inbounds %Analyzer, ptr %t214, i32 0, i32 9
  store %Type %t213, ptr %t215
  %t216 = load i32, ptr %t180
  %t217 = load ptr, ptr %t0
  %t218 = getelementptr inbounds %Analyzer, ptr %t217, i32 0, i32 7
  store i32 %t216, ptr %t218
  %t219 = load ptr, ptr %t0
  %t220 = getelementptr inbounds %Analyzer, ptr %t219, i32 0, i32 1
  %t221 = load ptr, ptr %t220
  call void @symbolExitScope(ptr %t221)
  ret void
}

define void @analyzeExternDecl(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = alloca i32
  store i32 0, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Analyzer, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = getelementptr inbounds %Ast, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  %t20 = load i32, ptr %t1
  %t21 = sext i32 %t20 to i64
  %t22 = getelementptr inbounds %Node, ptr %t19, i64 %t21
  %t23 = getelementptr inbounds %Node, ptr %t22, i32 0, i32 6
  %t24 = load i32, ptr %t23
  %t25 = call ptr @analyzerParamTypes(ptr %t14, i32 %t24, ptr %t13)
  %t26 = alloca ptr
  store ptr %t25, ptr %t26
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Analyzer, ptr %t27, i32 0, i32 1
  %t29 = load ptr, ptr %t28
  %t30 = load ptr, ptr %t12
  %t31 = call i32 @symbolFind(ptr %t29, ptr %t30)
  %t32 = icmp slt i32 %t31, 0
  br i1 %t32, label %L0, label %L2
L0:
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 1
  %t35 = load ptr, ptr %t34
  %t36 = load ptr, ptr %t12
  %t37 = load i32, ptr @SYM_FN
  %t38 = load ptr, ptr %t0
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Analyzer, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = getelementptr inbounds %Ast, ptr %t41, i32 0, i32 0
  %t43 = load ptr, ptr %t42
  %t44 = load i32, ptr %t1
  %t45 = sext i32 %t44 to i64
  %t46 = getelementptr inbounds %Node, ptr %t43, i64 %t45
  %t47 = getelementptr inbounds %Node, ptr %t46, i32 0, i32 5
  %t48 = load i32, ptr %t47
  %t49 = call %Type @analyzerParseType(ptr %t38, i32 %t48)
  %t50 = load ptr, ptr %t26
  %t51 = load i32, ptr %t13
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Analyzer, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = getelementptr inbounds %Ast, ptr %t54, i32 0, i32 0
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t1
  %t58 = sext i32 %t57 to i64
  %t59 = getelementptr inbounds %Node, ptr %t56, i64 %t58
  %t60 = getelementptr inbounds %Node, ptr %t59, i32 0, i32 1
  %t61 = load i32, ptr %t60
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Analyzer, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = getelementptr inbounds %Ast, ptr %t64, i32 0, i32 0
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t1
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds %Node, ptr %t66, i64 %t68
  %t70 = getelementptr inbounds %Node, ptr %t69, i32 0, i32 2
  %t71 = load i32, ptr %t70
  call void @symbolDeclare(ptr %t35, ptr %t36, i32 %t37, %Type %t49, ptr %t50, i32 %t51, i32 %t61, i32 %t71)
  br label %L2
L2:
  %t72 = alloca i32
  store i32 0, ptr %t72
  br label %L3
L3:
  %t73 = load i32, ptr %t72
  %t74 = load i32, ptr %t13
  %t75 = icmp slt i32 %t73, %t74
  br i1 %t75, label %L4, label %L5
L4:
  %t76 = load ptr, ptr %t26
  %t77 = load i32, ptr %t72
  %t78 = sext i32 %t77 to i64
  %t79 = getelementptr inbounds %Type, ptr %t76, i64 %t78
  %t80 = load %Type, ptr %t79
  %t81 = call i1 @typeIsVoid(%Type %t80)
  br i1 %t81, label %L6, label %L8
L6:
  %t82 = load ptr, ptr %t0
  %t83 = load i32, ptr %t1
  %t84 = load ptr, ptr %t12
  %t85 = call ptr @quoted(ptr @.str.407, ptr %t84, ptr @.str.408)
  call void @analyzerFail(ptr %t82, i32 %t83, ptr %t85)
  br label %L8
L8:
  %t86 = load i32, ptr %t72
  %t87 = add i32 %t86, 1
  store i32 %t87, ptr %t72
  br label %L3
L5:
  ret void
}

define void @registerStructName(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = load i32, ptr @NK_STRUCT
  %t13 = icmp ne i32 %t11, %t12
  br i1 %t13, label %L0, label %L2
L0:
  ret void
L2:
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 3
  %t23 = load ptr, ptr %t22
  %t24 = alloca ptr
  store ptr %t23, ptr %t24
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %Analyzer, ptr %t25, i32 0, i32 2
  %t27 = load ptr, ptr %t26
  %t28 = load ptr, ptr %t24
  %t29 = call i32 @structIndexOf(ptr %t27, ptr %t28)
  %t30 = icmp sge i32 %t29, 0
  br i1 %t30, label %L3, label %L5
L3:
  %t31 = load ptr, ptr %t0
  %t32 = load i32, ptr %t1
  %t33 = load ptr, ptr %t24
  %t34 = call ptr @quoted(ptr @.str.409, ptr %t33, ptr @.str.410)
  call void @analyzerFail(ptr %t31, i32 %t32, ptr %t34)
  br label %L5
L5:
  %t35 = load ptr, ptr %t0
  %t36 = getelementptr inbounds %Analyzer, ptr %t35, i32 0, i32 2
  %t37 = load ptr, ptr %t36
  %t38 = load ptr, ptr %t24
  %t39 = call i32 @structTableAdd(ptr %t37, ptr %t38)
  ret void
}

define void @registerStructFields(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = load i32, ptr @NK_STRUCT
  %t13 = icmp ne i32 %t11, %t12
  br i1 %t13, label %L0, label %L2
L0:
  ret void
L2:
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 3
  %t23 = load ptr, ptr %t22
  %t24 = alloca ptr
  store ptr %t23, ptr %t24
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %Analyzer, ptr %t25, i32 0, i32 2
  %t27 = load ptr, ptr %t26
  %t28 = load ptr, ptr %t24
  %t29 = call i32 @structIndexOf(ptr %t27, ptr %t28)
  %t30 = alloca i32
  store i32 %t29, ptr %t30
  %t31 = alloca i32
  store i32 0, ptr %t31
  br label %L3
L3:
  %t32 = load i32, ptr %t31
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 10
  %t42 = load i32, ptr %t41
  %t43 = icmp slt i32 %t32, %t42
  br i1 %t43, label %L4, label %L5
L4:
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr inbounds %Analyzer, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = getelementptr inbounds %Ast, ptr %t46, i32 0, i32 0
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t1
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds %Node, ptr %t48, i64 %t50
  %t52 = getelementptr inbounds %Node, ptr %t51, i32 0, i32 9
  %t53 = load ptr, ptr %t52
  %t54 = load i32, ptr %t31
  %t55 = sext i32 %t54 to i64
  %t56 = getelementptr inbounds i32, ptr %t53, i64 %t55
  %t57 = load i32, ptr %t56
  %t58 = alloca i32
  store i32 %t57, ptr %t58
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Analyzer, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = getelementptr inbounds %Ast, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t58
  %t65 = sext i32 %t64 to i64
  %t66 = getelementptr inbounds %Node, ptr %t63, i64 %t65
  %t67 = getelementptr inbounds %Node, ptr %t66, i32 0, i32 3
  %t68 = load ptr, ptr %t67
  %t69 = alloca ptr
  store ptr %t68, ptr %t69
  %t70 = load ptr, ptr %t0
  %t71 = getelementptr inbounds %Analyzer, ptr %t70, i32 0, i32 2
  %t72 = load ptr, ptr %t71
  %t73 = load i32, ptr %t30
  %t74 = load ptr, ptr %t69
  %t75 = call i32 @structFieldIndex(ptr %t72, i32 %t73, ptr %t74)
  %t76 = icmp sge i32 %t75, 0
  br i1 %t76, label %L6, label %L8
L6:
  %t77 = call ptr @bufNew()
  %t78 = alloca ptr
  store ptr %t77, ptr %t78
  %t79 = load ptr, ptr %t78
  call void @bufAdd(ptr %t79, ptr @.str.411)
  %t80 = load ptr, ptr %t78
  %t81 = load ptr, ptr %t24
  call void @bufAdd(ptr %t80, ptr %t81)
  %t82 = load ptr, ptr %t78
  call void @bufAdd(ptr %t82, ptr @.str.412)
  %t83 = load ptr, ptr %t78
  %t84 = load ptr, ptr %t69
  call void @bufAdd(ptr %t83, ptr %t84)
  %t85 = load ptr, ptr %t78
  call void @bufAdd(ptr %t85, ptr @.str.413)
  %t86 = load ptr, ptr %t0
  %t87 = load i32, ptr %t1
  %t88 = load ptr, ptr %t78
  %t89 = getelementptr inbounds %Buf, ptr %t88, i32 0, i32 0
  %t90 = load ptr, ptr %t89
  call void @analyzerFail(ptr %t86, i32 %t87, ptr %t90)
  br label %L8
L8:
  %t91 = load ptr, ptr %t0
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr inbounds %Analyzer, ptr %t92, i32 0, i32 0
  %t94 = load ptr, ptr %t93
  %t95 = getelementptr inbounds %Ast, ptr %t94, i32 0, i32 0
  %t96 = load ptr, ptr %t95
  %t97 = load i32, ptr %t58
  %t98 = sext i32 %t97 to i64
  %t99 = getelementptr inbounds %Node, ptr %t96, i64 %t98
  %t100 = getelementptr inbounds %Node, ptr %t99, i32 0, i32 5
  %t101 = load i32, ptr %t100
  %t102 = call %Type @analyzerParseType(ptr %t91, i32 %t101)
  %t103 = alloca %Type
  store %Type %t102, ptr %t103
  %t104 = call ptr @bufNew()
  %t105 = alloca ptr
  store ptr %t104, ptr %t105
  %t106 = load ptr, ptr %t105
  call void @bufAdd(ptr %t106, ptr @.str.414)
  %t107 = load ptr, ptr %t105
  %t108 = load ptr, ptr %t69
  call void @bufAdd(ptr %t107, ptr %t108)
  %t109 = load ptr, ptr %t105
  call void @bufAdd(ptr %t109, ptr @.str.415)
  %t110 = load ptr, ptr %t105
  %t111 = load ptr, ptr %t24
  call void @bufAdd(ptr %t110, ptr %t111)
  %t112 = load ptr, ptr %t105
  call void @bufPush(ptr %t112, i8 39)
  %t113 = load ptr, ptr %t0
  %t114 = load i32, ptr %t1
  %t115 = load %Type, ptr %t103
  %t116 = load ptr, ptr %t105
  %t117 = getelementptr inbounds %Buf, ptr %t116, i32 0, i32 0
  %t118 = load ptr, ptr %t117
  call void @analyzerValidateType(ptr %t113, i32 %t114, %Type %t115, ptr %t118)
  %t119 = load %Type, ptr %t103
  %t120 = call i1 @typeIsVoid(%Type %t119)
  br i1 %t120, label %L9, label %L11
L9:
  %t121 = call ptr @bufNew()
  %t122 = alloca ptr
  store ptr %t121, ptr %t122
  %t123 = load ptr, ptr %t122
  call void @bufAdd(ptr %t123, ptr @.str.416)
  %t124 = load ptr, ptr %t122
  %t125 = load ptr, ptr %t69
  call void @bufAdd(ptr %t124, ptr %t125)
  %t126 = load ptr, ptr %t122
  call void @bufAdd(ptr %t126, ptr @.str.417)
  %t127 = load ptr, ptr %t122
  %t128 = load ptr, ptr %t24
  call void @bufAdd(ptr %t127, ptr %t128)
  %t129 = load ptr, ptr %t122
  call void @bufAdd(ptr %t129, ptr @.str.418)
  %t130 = load ptr, ptr %t0
  %t131 = load i32, ptr %t1
  %t132 = load ptr, ptr %t122
  %t133 = getelementptr inbounds %Buf, ptr %t132, i32 0, i32 0
  %t134 = load ptr, ptr %t133
  call void @analyzerFail(ptr %t130, i32 %t131, ptr %t134)
  br label %L11
L11:
  %t135 = load ptr, ptr %t0
  %t136 = getelementptr inbounds %Analyzer, ptr %t135, i32 0, i32 2
  %t137 = load ptr, ptr %t136
  %t138 = load i32, ptr %t30
  %t139 = load ptr, ptr %t69
  %t140 = load %Type, ptr %t103
  call void @structAddField(ptr %t137, i32 %t138, ptr %t139, %Type %t140)
  %t141 = load i32, ptr %t31
  %t142 = add i32 %t141, 1
  store i32 %t142, ptr %t31
  br label %L3
L5:
  ret void
}

define void @rejectStructCycles(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 2
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %StructTable, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = alloca i32
  store i32 %t6, ptr %t7
  %t8 = alloca i32
  store i32 0, ptr %t8
  br label %L0
L0:
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr %t7
  %t11 = icmp slt i32 %t9, %t10
  br i1 %t11, label %L1, label %L2
L1:
  %t12 = load i32, ptr %t7
  %t13 = sext i32 %t12 to i64
  %t14 = call ptr @malloc(i64 %t13)
  %t15 = alloca ptr
  store ptr %t14, ptr %t15
  %t16 = load i32, ptr %t7
  %t17 = sext i32 %t16 to i64
  %t18 = mul i64 4, %t17
  %t19 = call ptr @malloc(i64 %t18)
  %t20 = alloca ptr
  store ptr %t19, ptr %t20
  %t21 = alloca i32
  store i32 0, ptr %t21
  %t22 = alloca i32
  store i32 0, ptr %t22
  br label %L3
L3:
  %t23 = load i32, ptr %t22
  %t24 = load i32, ptr %t7
  %t25 = icmp slt i32 %t23, %t24
  br i1 %t25, label %L4, label %L5
L4:
  %t26 = trunc i32 0 to i8
  %t27 = load ptr, ptr %t15
  %t28 = load i32, ptr %t22
  %t29 = sext i32 %t28 to i64
  %t30 = getelementptr inbounds i8, ptr %t27, i64 %t29
  store i8 %t26, ptr %t30
  %t31 = load i32, ptr %t22
  %t32 = add i32 %t31, 1
  store i32 %t32, ptr %t22
  br label %L3
L5:
  %t33 = trunc i32 1 to i8
  %t34 = load ptr, ptr %t15
  %t35 = load i32, ptr %t8
  %t36 = sext i32 %t35 to i64
  %t37 = getelementptr inbounds i8, ptr %t34, i64 %t36
  store i8 %t33, ptr %t37
  %t38 = load i32, ptr %t8
  %t39 = load ptr, ptr %t20
  %t40 = load i32, ptr %t21
  %t41 = sext i32 %t40 to i64
  %t42 = getelementptr inbounds i32, ptr %t39, i64 %t41
  store i32 %t38, ptr %t42
  %t43 = load i32, ptr %t21
  %t44 = add i32 %t43, 1
  store i32 %t44, ptr %t21
  br label %L6
L6:
  %t45 = load i32, ptr %t21
  %t46 = icmp sgt i32 %t45, 0
  br i1 %t46, label %L7, label %L8
L7:
  %t47 = load i32, ptr %t21
  %t48 = sub i32 %t47, 1
  store i32 %t48, ptr %t21
  %t49 = load ptr, ptr %t20
  %t50 = load i32, ptr %t21
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds i32, ptr %t49, i64 %t51
  %t53 = load i32, ptr %t52
  %t54 = alloca i32
  store i32 %t53, ptr %t54
  %t55 = alloca i32
  store i32 0, ptr %t55
  br label %L9
L9:
  %t56 = load i32, ptr %t55
  %t57 = load ptr, ptr %t0
  %t58 = getelementptr inbounds %Analyzer, ptr %t57, i32 0, i32 2
  %t59 = load ptr, ptr %t58
  %t60 = getelementptr inbounds %StructTable, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = load i32, ptr %t54
  %t63 = sext i32 %t62 to i64
  %t64 = getelementptr inbounds %StructLayout, ptr %t61, i64 %t63
  %t65 = getelementptr inbounds %StructLayout, ptr %t64, i32 0, i32 2
  %t66 = load i32, ptr %t65
  %t67 = icmp slt i32 %t56, %t66
  br i1 %t67, label %L10, label %L11
L10:
  %t68 = load ptr, ptr %t0
  %t69 = getelementptr inbounds %Analyzer, ptr %t68, i32 0, i32 2
  %t70 = load ptr, ptr %t69
  %t71 = getelementptr inbounds %StructTable, ptr %t70, i32 0, i32 0
  %t72 = load ptr, ptr %t71
  %t73 = load i32, ptr %t54
  %t74 = sext i32 %t73 to i64
  %t75 = getelementptr inbounds %StructLayout, ptr %t72, i64 %t74
  %t76 = getelementptr inbounds %StructLayout, ptr %t75, i32 0, i32 1
  %t77 = load ptr, ptr %t76
  %t78 = load i32, ptr %t55
  %t79 = sext i32 %t78 to i64
  %t80 = getelementptr inbounds %FieldDef, ptr %t77, i64 %t79
  %t81 = getelementptr inbounds %FieldDef, ptr %t80, i32 0, i32 1
  %t82 = load %Type, ptr %t81
  %t83 = alloca %Type
  store %Type %t82, ptr %t83
  %t84 = load %Type, ptr %t83
  %t85 = call i1 @typeIsStruct(%Type %t84)
  br i1 %t85, label %L12, label %L14
L12:
  %t86 = getelementptr inbounds %Type, ptr %t83, i32 0, i32 2
  %t87 = load ptr, ptr %t86
  %t88 = load ptr, ptr %t0
  %t89 = getelementptr inbounds %Analyzer, ptr %t88, i32 0, i32 2
  %t90 = load ptr, ptr %t89
  %t91 = getelementptr inbounds %StructTable, ptr %t90, i32 0, i32 0
  %t92 = load ptr, ptr %t91
  %t93 = load i32, ptr %t8
  %t94 = sext i32 %t93 to i64
  %t95 = getelementptr inbounds %StructLayout, ptr %t92, i64 %t94
  %t96 = getelementptr inbounds %StructLayout, ptr %t95, i32 0, i32 0
  %t97 = load ptr, ptr %t96
  %t98 = call i1 @textEquals(ptr %t87, ptr %t97)
  br i1 %t98, label %L15, label %L17
L15:
  %t99 = load ptr, ptr %t0
  %t100 = load i32, ptr %t1
  %t101 = load ptr, ptr %t0
  %t102 = getelementptr inbounds %Analyzer, ptr %t101, i32 0, i32 2
  %t103 = load ptr, ptr %t102
  %t104 = getelementptr inbounds %StructTable, ptr %t103, i32 0, i32 0
  %t105 = load ptr, ptr %t104
  %t106 = load i32, ptr %t8
  %t107 = sext i32 %t106 to i64
  %t108 = getelementptr inbounds %StructLayout, ptr %t105, i64 %t107
  %t109 = getelementptr inbounds %StructLayout, ptr %t108, i32 0, i32 0
  %t110 = load ptr, ptr %t109
  %t111 = call ptr @quoted(ptr @.str.419, ptr %t110, ptr @.str.420)
  call void @analyzerFail2(ptr %t99, i32 %t100, ptr %t111, ptr @.str.421)
  br label %L17
L17:
  %t112 = load ptr, ptr %t0
  %t113 = getelementptr inbounds %Analyzer, ptr %t112, i32 0, i32 2
  %t114 = load ptr, ptr %t113
  %t115 = getelementptr inbounds %Type, ptr %t83, i32 0, i32 2
  %t116 = load ptr, ptr %t115
  %t117 = call i32 @structIndexOf(ptr %t114, ptr %t116)
  %t118 = alloca i32
  store i32 %t117, ptr %t118
  %t119 = alloca i1
  %t120 = load i32, ptr %t118
  %t121 = icmp sge i32 %t120, 0
  store i1 %t121, ptr %t119
  br i1 %t121, label %L18, label %L19
L18:
  %t122 = load ptr, ptr %t15
  %t123 = load i32, ptr %t118
  %t124 = sext i32 %t123 to i64
  %t125 = getelementptr inbounds i8, ptr %t122, i64 %t124
  %t126 = load i8, ptr %t125
  %t127 = trunc i32 0 to i8
  %t128 = icmp eq i8 %t126, %t127
  store i1 %t128, ptr %t119
  br label %L19
L19:
  %t129 = load i1, ptr %t119
  br i1 %t129, label %L20, label %L22
L20:
  %t130 = trunc i32 1 to i8
  %t131 = load ptr, ptr %t15
  %t132 = load i32, ptr %t118
  %t133 = sext i32 %t132 to i64
  %t134 = getelementptr inbounds i8, ptr %t131, i64 %t133
  store i8 %t130, ptr %t134
  %t135 = load i32, ptr %t118
  %t136 = load ptr, ptr %t20
  %t137 = load i32, ptr %t21
  %t138 = sext i32 %t137 to i64
  %t139 = getelementptr inbounds i32, ptr %t136, i64 %t138
  store i32 %t135, ptr %t139
  %t140 = load i32, ptr %t21
  %t141 = add i32 %t140, 1
  store i32 %t141, ptr %t21
  br label %L22
L22:
  br label %L14
L14:
  %t142 = load i32, ptr %t55
  %t143 = add i32 %t142, 1
  store i32 %t143, ptr %t55
  br label %L9
L11:
  br label %L6
L8:
  %t144 = load ptr, ptr %t15
  call void @free(ptr %t144)
  %t145 = load ptr, ptr %t20
  call void @free(ptr %t145)
  %t146 = load i32, ptr %t8
  %t147 = add i32 %t146, 1
  store i32 %t147, ptr %t8
  br label %L0
L2:
  ret void
}

define void @hoistGlobal(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = load i32, ptr @NK_VARDECL
  %t13 = icmp ne i32 %t11, %t12
  br i1 %t13, label %L0, label %L2
L0:
  ret void
L2:
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Analyzer, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = getelementptr inbounds %Ast, ptr %t16, i32 0, i32 0
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t1
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds %Node, ptr %t18, i64 %t20
  %t22 = getelementptr inbounds %Node, ptr %t21, i32 0, i32 3
  %t23 = load ptr, ptr %t22
  %t24 = alloca ptr
  store ptr %t23, ptr %t24
  %t25 = load ptr, ptr %t0
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Analyzer, ptr %t26, i32 0, i32 0
  %t28 = load ptr, ptr %t27
  %t29 = getelementptr inbounds %Ast, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = load i32, ptr %t1
  %t32 = sext i32 %t31 to i64
  %t33 = getelementptr inbounds %Node, ptr %t30, i64 %t32
  %t34 = getelementptr inbounds %Node, ptr %t33, i32 0, i32 5
  %t35 = load i32, ptr %t34
  %t36 = call %Type @analyzerParseType(ptr %t25, i32 %t35)
  %t37 = alloca %Type
  store %Type %t36, ptr %t37
  %t38 = load ptr, ptr %t0
  %t39 = load i32, ptr %t1
  %t40 = load %Type, ptr %t37
  %t41 = load ptr, ptr %t24
  %t42 = call ptr @quoted(ptr @.str.422, ptr %t41, ptr @.str.423)
  call void @analyzerValidateType(ptr %t38, i32 %t39, %Type %t40, ptr %t42)
  %t43 = load %Type, ptr %t37
  %t44 = call i1 @typeIsVoid(%Type %t43)
  br i1 %t44, label %L3, label %L5
L3:
  %t45 = load ptr, ptr %t0
  %t46 = load i32, ptr %t1
  %t47 = load ptr, ptr %t24
  %t48 = call ptr @quoted(ptr @.str.424, ptr %t47, ptr @.str.425)
  call void @analyzerFail(ptr %t45, i32 %t46, ptr %t48)
  br label %L5
L5:
  %t49 = trunc i32 1 to i8
  %t50 = load ptr, ptr %t0
  %t51 = getelementptr inbounds %Analyzer, ptr %t50, i32 0, i32 4
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t1
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds i8, ptr %t52, i64 %t54
  store i8 %t49, ptr %t55
  %t56 = load ptr, ptr %t0
  %t57 = load i32, ptr %t1
  %t58 = load ptr, ptr %t24
  %t59 = load i32, ptr @SYM_VAR
  %t60 = load %Type, ptr %t37
  %t61 = sext i32 0 to i64
  %t62 = inttoptr i64 %t61 to ptr
  call void @declareTopLevel(ptr %t56, i32 %t57, ptr %t58, i32 %t59, %Type %t60, ptr %t62, i32 0)
  ret void
}

define void @declareTopLevel(ptr %p0, i32 %p1, ptr %p2, i32 %p3, %Type %p4, ptr %p5, i32 %p6) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca i32
  store i32 %p3, ptr %t3
  %t4 = alloca %Type
  store %Type %p4, ptr %t4
  %t5 = alloca ptr
  store ptr %p5, ptr %t5
  %t6 = alloca i32
  store i32 %p6, ptr %t6
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Analyzer, ptr %t7, i32 0, i32 1
  %t9 = load ptr, ptr %t8
  %t10 = getelementptr inbounds %SymbolTable, ptr %t9, i32 0, i32 1
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Analyzer, ptr %t13, i32 0, i32 1
  %t15 = load ptr, ptr %t14
  %t16 = load ptr, ptr %t2
  %t17 = load i32, ptr %t3
  %t18 = load %Type, ptr %t4
  %t19 = load ptr, ptr %t5
  %t20 = load i32, ptr %t6
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Analyzer, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = getelementptr inbounds %Ast, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t1
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds %Node, ptr %t25, i64 %t27
  %t29 = getelementptr inbounds %Node, ptr %t28, i32 0, i32 1
  %t30 = load i32, ptr %t29
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Analyzer, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = getelementptr inbounds %Ast, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = load i32, ptr %t1
  %t37 = sext i32 %t36 to i64
  %t38 = getelementptr inbounds %Node, ptr %t35, i64 %t37
  %t39 = getelementptr inbounds %Node, ptr %t38, i32 0, i32 2
  %t40 = load i32, ptr %t39
  call void @symbolDeclare(ptr %t15, ptr %t16, i32 %t17, %Type %t18, ptr %t19, i32 %t20, i32 %t30, i32 %t40)
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Analyzer, ptr %t41, i32 0, i32 1
  %t43 = load ptr, ptr %t42
  %t44 = getelementptr inbounds %SymbolTable, ptr %t43, i32 0, i32 1
  %t45 = load i32, ptr %t44
  %t46 = load i32, ptr %t12
  %t47 = icmp sgt i32 %t45, %t46
  br i1 %t47, label %L0, label %L2
L0:
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Analyzer, ptr %t48, i32 0, i32 5
  %t50 = load ptr, ptr %t49
  %t51 = load i32, ptr %t1
  %t52 = sext i32 %t51 to i64
  %t53 = getelementptr inbounds ptr, ptr %t50, i64 %t52
  %t54 = load ptr, ptr %t53
  %t55 = load ptr, ptr %t0
  %t56 = getelementptr inbounds %Analyzer, ptr %t55, i32 0, i32 1
  %t57 = load ptr, ptr %t56
  %t58 = getelementptr inbounds %SymbolTable, ptr %t57, i32 0, i32 0
  %t59 = load ptr, ptr %t58
  %t60 = load i32, ptr %t12
  %t61 = sext i32 %t60 to i64
  %t62 = getelementptr inbounds %Symbol, ptr %t59, i64 %t61
  %t63 = getelementptr inbounds %Symbol, ptr %t62, i32 0, i32 5
  store ptr %t54, ptr %t63
  br label %L2
L2:
  ret void
}

define void @hoistSignature(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i1
  %t14 = load i32, ptr %t12
  %t15 = load i32, ptr @NK_FN
  %t16 = icmp ne i32 %t14, %t15
  store i1 %t16, ptr %t13
  br i1 %t16, label %L0, label %L1
L0:
  %t17 = load i32, ptr %t12
  %t18 = load i32, ptr @NK_EXTERN
  %t19 = icmp ne i32 %t17, %t18
  store i1 %t19, ptr %t13
  br label %L1
L1:
  %t20 = load i1, ptr %t13
  br i1 %t20, label %L2, label %L4
L2:
  ret void
L4:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Analyzer, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = getelementptr inbounds %Ast, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t1
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds %Node, ptr %t25, i64 %t27
  %t29 = getelementptr inbounds %Node, ptr %t28, i32 0, i32 3
  %t30 = load ptr, ptr %t29
  %t31 = alloca ptr
  store ptr %t30, ptr %t31
  %t32 = load ptr, ptr %t0
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Analyzer, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 5
  %t42 = load i32, ptr %t41
  %t43 = call %Type @analyzerParseType(ptr %t32, i32 %t42)
  %t44 = alloca %Type
  store %Type %t43, ptr %t44
  %t45 = alloca i32
  store i32 0, ptr %t45
  %t46 = load ptr, ptr %t0
  %t47 = load ptr, ptr %t0
  %t48 = getelementptr inbounds %Analyzer, ptr %t47, i32 0, i32 0
  %t49 = load ptr, ptr %t48
  %t50 = getelementptr inbounds %Ast, ptr %t49, i32 0, i32 0
  %t51 = load ptr, ptr %t50
  %t52 = load i32, ptr %t1
  %t53 = sext i32 %t52 to i64
  %t54 = getelementptr inbounds %Node, ptr %t51, i64 %t53
  %t55 = getelementptr inbounds %Node, ptr %t54, i32 0, i32 6
  %t56 = load i32, ptr %t55
  %t57 = call ptr @analyzerParamTypes(ptr %t46, i32 %t56, ptr %t45)
  %t58 = alloca ptr
  store ptr %t57, ptr %t58
  %t59 = alloca ptr
  store ptr @.str.426, ptr %t59
  %t60 = load i32, ptr %t12
  %t61 = load i32, ptr @NK_EXTERN
  %t62 = icmp eq i32 %t60, %t61
  br i1 %t62, label %L5, label %L7
L5:
  store ptr @.str.427, ptr %t59
  br label %L7
L7:
  %t63 = call ptr @bufNew()
  %t64 = alloca ptr
  store ptr %t63, ptr %t64
  %t65 = load ptr, ptr %t64
  %t66 = load ptr, ptr %t59
  call void @bufAdd(ptr %t65, ptr %t66)
  %t67 = load ptr, ptr %t64
  %t68 = load ptr, ptr %t31
  call void @bufAdd(ptr %t67, ptr %t68)
  %t69 = load ptr, ptr %t64
  call void @bufPush(ptr %t69, i8 39)
  %t70 = load ptr, ptr %t0
  %t71 = load i32, ptr %t1
  %t72 = load %Type, ptr %t44
  %t73 = load ptr, ptr %t64
  %t74 = getelementptr inbounds %Buf, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  call void @analyzerValidateType(ptr %t70, i32 %t71, %Type %t72, ptr %t75)
  %t76 = alloca i32
  store i32 0, ptr %t76
  br label %L8
L8:
  %t77 = load i32, ptr %t76
  %t78 = load i32, ptr %t45
  %t79 = icmp slt i32 %t77, %t78
  br i1 %t79, label %L9, label %L10
L9:
  %t80 = call ptr @bufNew()
  %t81 = alloca ptr
  store ptr %t80, ptr %t81
  %t82 = load i32, ptr %t12
  %t83 = load i32, ptr @NK_EXTERN
  %t84 = icmp eq i32 %t82, %t83
  br i1 %t84, label %L11, label %L12
L11:
  %t85 = load ptr, ptr %t81
  call void @bufAdd(ptr %t85, ptr @.str.428)
  br label %L13
L12:
  %t86 = load ptr, ptr %t81
  call void @bufAdd(ptr %t86, ptr @.str.429)
  br label %L13
L13:
  %t87 = load ptr, ptr %t81
  %t88 = load ptr, ptr %t31
  call void @bufAdd(ptr %t87, ptr %t88)
  %t89 = load ptr, ptr %t81
  call void @bufPush(ptr %t89, i8 39)
  %t90 = load ptr, ptr %t0
  %t91 = load i32, ptr %t1
  %t92 = load ptr, ptr %t58
  %t93 = load i32, ptr %t76
  %t94 = sext i32 %t93 to i64
  %t95 = getelementptr inbounds %Type, ptr %t92, i64 %t94
  %t96 = load %Type, ptr %t95
  %t97 = load ptr, ptr %t81
  %t98 = getelementptr inbounds %Buf, ptr %t97, i32 0, i32 0
  %t99 = load ptr, ptr %t98
  call void @analyzerValidateType(ptr %t90, i32 %t91, %Type %t96, ptr %t99)
  %t100 = load i32, ptr %t76
  %t101 = add i32 %t100, 1
  store i32 %t101, ptr %t76
  br label %L8
L10:
  %t102 = load i32, ptr %t12
  %t103 = load i32, ptr @NK_EXTERN
  %t104 = icmp eq i32 %t102, %t103
  br i1 %t104, label %L14, label %L16
L14:
  %t105 = load %Type, ptr %t44
  %t106 = call i1 @typeIsStruct(%Type %t105)
  br i1 %t106, label %L17, label %L19
L17:
  %t107 = load ptr, ptr %t0
  %t108 = load i32, ptr %t1
  %t109 = load ptr, ptr %t31
  %t110 = call ptr @quoted(ptr @.str.430, ptr %t109, ptr @.str.431)
  call void @analyzerFail2(ptr %t107, i32 %t108, ptr %t110, ptr @.str.432)
  br label %L19
L19:
  store i32 0, ptr %t76
  br label %L20
L20:
  %t111 = load i32, ptr %t76
  %t112 = load i32, ptr %t45
  %t113 = icmp slt i32 %t111, %t112
  br i1 %t113, label %L21, label %L22
L21:
  %t114 = load ptr, ptr %t58
  %t115 = load i32, ptr %t76
  %t116 = sext i32 %t115 to i64
  %t117 = getelementptr inbounds %Type, ptr %t114, i64 %t116
  %t118 = load %Type, ptr %t117
  %t119 = call i1 @typeIsStruct(%Type %t118)
  br i1 %t119, label %L23, label %L25
L23:
  %t120 = load ptr, ptr %t0
  %t121 = load i32, ptr %t1
  %t122 = load ptr, ptr %t31
  %t123 = call ptr @quoted(ptr @.str.433, ptr %t122, ptr @.str.434)
  call void @analyzerFail2(ptr %t120, i32 %t121, ptr %t123, ptr @.str.435)
  br label %L25
L25:
  %t124 = load i32, ptr %t76
  %t125 = add i32 %t124, 1
  store i32 %t125, ptr %t76
  br label %L20
L22:
  br label %L16
L16:
  %t126 = load ptr, ptr %t0
  %t127 = load i32, ptr %t1
  %t128 = load ptr, ptr %t31
  %t129 = load i32, ptr @SYM_FN
  %t130 = load %Type, ptr %t44
  %t131 = load ptr, ptr %t58
  %t132 = load i32, ptr %t45
  call void @declareTopLevel(ptr %t126, i32 %t127, ptr %t128, i32 %t129, %Type %t130, ptr %t131, i32 %t132)
  ret void
}

define i1 @itemInModule(ptr %p0, i32 %p1, i32 %p2, i32 %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca i32
  store i32 %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = getelementptr inbounds %Ast, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Analyzer, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = getelementptr inbounds %Ast, ptr %t11, i32 0, i32 0
  %t13 = load ptr, ptr %t12
  %t14 = load i32, ptr %t1
  %t15 = sext i32 %t14 to i64
  %t16 = getelementptr inbounds %Node, ptr %t13, i64 %t15
  %t17 = getelementptr inbounds %Node, ptr %t16, i32 0, i32 9
  %t18 = load ptr, ptr %t17
  %t19 = load i32, ptr %t2
  %t20 = sext i32 %t19 to i64
  %t21 = getelementptr inbounds i32, ptr %t18, i64 %t20
  %t22 = load i32, ptr %t21
  %t23 = sext i32 %t22 to i64
  %t24 = getelementptr inbounds %Node, ptr %t8, i64 %t23
  %t25 = getelementptr inbounds %Node, ptr %t24, i32 0, i32 12
  %t26 = load i32, ptr %t25
  %t27 = load i32, ptr %t3
  %t28 = icmp eq i32 %t26, %t27
  ret i1 %t28
}

define void @analyze(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Analyzer, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 10
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = load i32, ptr %t1
  call void @linkModules(ptr %t13, i32 %t14)
  %t15 = alloca i32
  store i32 0, ptr %t15
  br label %L0
L0:
  %t16 = load i32, ptr %t15
  %t17 = load i32, ptr %t12
  %t18 = icmp slt i32 %t16, %t17
  br i1 %t18, label %L1, label %L2
L1:
  %t19 = load ptr, ptr %t0
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Analyzer, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = getelementptr inbounds %Ast, ptr %t22, i32 0, i32 0
  %t24 = load ptr, ptr %t23
  %t25 = load i32, ptr %t1
  %t26 = sext i32 %t25 to i64
  %t27 = getelementptr inbounds %Node, ptr %t24, i64 %t26
  %t28 = getelementptr inbounds %Node, ptr %t27, i32 0, i32 9
  %t29 = load ptr, ptr %t28
  %t30 = load i32, ptr %t15
  %t31 = sext i32 %t30 to i64
  %t32 = getelementptr inbounds i32, ptr %t29, i64 %t31
  %t33 = load i32, ptr %t32
  call void @registerStructName(ptr %t19, i32 %t33)
  store i1 false, ptr @FAILED
  %t34 = load i32, ptr %t15
  %t35 = add i32 %t34, 1
  store i32 %t35, ptr %t15
  br label %L0
L2:
  store i32 0, ptr %t15
  br label %L3
L3:
  %t36 = load i32, ptr %t15
  %t37 = load i32, ptr %t12
  %t38 = icmp slt i32 %t36, %t37
  br i1 %t38, label %L4, label %L5
L4:
  %t39 = load ptr, ptr %t0
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr inbounds %Analyzer, ptr %t40, i32 0, i32 0
  %t42 = load ptr, ptr %t41
  %t43 = getelementptr inbounds %Ast, ptr %t42, i32 0, i32 0
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr %t1
  %t46 = sext i32 %t45 to i64
  %t47 = getelementptr inbounds %Node, ptr %t44, i64 %t46
  %t48 = getelementptr inbounds %Node, ptr %t47, i32 0, i32 9
  %t49 = load ptr, ptr %t48
  %t50 = load i32, ptr %t15
  %t51 = sext i32 %t50 to i64
  %t52 = getelementptr inbounds i32, ptr %t49, i64 %t51
  %t53 = load i32, ptr %t52
  call void @registerStructFields(ptr %t39, i32 %t53)
  store i1 false, ptr @FAILED
  %t54 = load i32, ptr %t15
  %t55 = add i32 %t54, 1
  store i32 %t55, ptr %t15
  br label %L3
L5:
  %t56 = load ptr, ptr %t0
  %t57 = load i32, ptr %t1
  call void @rejectStructCycles(ptr %t56, i32 %t57)
  store i1 false, ptr @FAILED
  %t58 = alloca i32
  store i32 0, ptr %t58
  br label %L6
L6:
  %t59 = load i32, ptr %t58
  %t60 = load i32, ptr @MODULE_COUNT
  %t61 = icmp slt i32 %t59, %t60
  br i1 %t61, label %L7, label %L8
L7:
  %t62 = load i32, ptr %t58
  %t63 = call ptr @modulePath(i32 %t62)
  store ptr %t63, ptr @SOURCE_PATH
  %t64 = load ptr, ptr %t0
  %t65 = getelementptr inbounds %Analyzer, ptr %t64, i32 0, i32 1
  %t66 = load ptr, ptr %t65
  call void @symbolEnterScope(ptr %t66)
  %t67 = load ptr, ptr %t0
  %t68 = getelementptr inbounds %Analyzer, ptr %t67, i32 0, i32 1
  %t69 = load ptr, ptr %t68
  %t70 = getelementptr inbounds %SymbolTable, ptr %t69, i32 0, i32 1
  %t71 = load i32, ptr %t70
  %t72 = alloca i32
  store i32 %t71, ptr %t72
  store i32 0, ptr %t15
  br label %L9
L9:
  %t73 = load i32, ptr %t15
  %t74 = load i32, ptr %t12
  %t75 = icmp slt i32 %t73, %t74
  br i1 %t75, label %L10, label %L11
L10:
  %t76 = load ptr, ptr %t0
  %t77 = load i32, ptr %t1
  %t78 = load i32, ptr %t15
  %t79 = load i32, ptr %t58
  %t80 = call i1 @itemInModule(ptr %t76, i32 %t77, i32 %t78, i32 %t79)
  br i1 %t80, label %L12, label %L14
L12:
  %t81 = load ptr, ptr %t0
  %t82 = load ptr, ptr %t0
  %t83 = getelementptr inbounds %Analyzer, ptr %t82, i32 0, i32 0
  %t84 = load ptr, ptr %t83
  %t85 = getelementptr inbounds %Ast, ptr %t84, i32 0, i32 0
  %t86 = load ptr, ptr %t85
  %t87 = load i32, ptr %t1
  %t88 = sext i32 %t87 to i64
  %t89 = getelementptr inbounds %Node, ptr %t86, i64 %t88
  %t90 = getelementptr inbounds %Node, ptr %t89, i32 0, i32 9
  %t91 = load ptr, ptr %t90
  %t92 = load i32, ptr %t15
  %t93 = sext i32 %t92 to i64
  %t94 = getelementptr inbounds i32, ptr %t91, i64 %t93
  %t95 = load i32, ptr %t94
  call void @hoistGlobal(ptr %t81, i32 %t95)
  store i1 false, ptr @FAILED
  br label %L14
L14:
  %t96 = load i32, ptr %t15
  %t97 = add i32 %t96, 1
  store i32 %t97, ptr %t15
  br label %L9
L11:
  store i32 0, ptr %t15
  br label %L15
L15:
  %t98 = load i32, ptr %t15
  %t99 = load i32, ptr %t12
  %t100 = icmp slt i32 %t98, %t99
  br i1 %t100, label %L16, label %L17
L16:
  %t101 = load ptr, ptr %t0
  %t102 = load i32, ptr %t1
  %t103 = load i32, ptr %t15
  %t104 = load i32, ptr %t58
  %t105 = call i1 @itemInModule(ptr %t101, i32 %t102, i32 %t103, i32 %t104)
  br i1 %t105, label %L18, label %L20
L18:
  %t106 = load ptr, ptr %t0
  %t107 = load ptr, ptr %t0
  %t108 = getelementptr inbounds %Analyzer, ptr %t107, i32 0, i32 0
  %t109 = load ptr, ptr %t108
  %t110 = getelementptr inbounds %Ast, ptr %t109, i32 0, i32 0
  %t111 = load ptr, ptr %t110
  %t112 = load i32, ptr %t1
  %t113 = sext i32 %t112 to i64
  %t114 = getelementptr inbounds %Node, ptr %t111, i64 %t113
  %t115 = getelementptr inbounds %Node, ptr %t114, i32 0, i32 9
  %t116 = load ptr, ptr %t115
  %t117 = load i32, ptr %t15
  %t118 = sext i32 %t117 to i64
  %t119 = getelementptr inbounds i32, ptr %t116, i64 %t118
  %t120 = load i32, ptr %t119
  call void @hoistSignature(ptr %t106, i32 %t120)
  store i1 false, ptr @FAILED
  br label %L20
L20:
  %t121 = load i32, ptr %t15
  %t122 = add i32 %t121, 1
  store i32 %t122, ptr %t15
  br label %L15
L17:
  %t123 = load ptr, ptr %t0
  %t124 = getelementptr inbounds %Analyzer, ptr %t123, i32 0, i32 1
  %t125 = load ptr, ptr %t124
  %t126 = load i32, ptr %t72
  %t127 = call %SymbolList @symbolListCopy(ptr %t125, i32 %t126)
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr inbounds %Analyzer, ptr %t128, i32 0, i32 6
  %t130 = load ptr, ptr %t129
  %t131 = load i32, ptr %t58
  %t132 = sext i32 %t131 to i64
  %t133 = getelementptr inbounds %SymbolList, ptr %t130, i64 %t132
  store %SymbolList %t127, ptr %t133
  %t134 = load ptr, ptr %t0
  %t135 = getelementptr inbounds %Analyzer, ptr %t134, i32 0, i32 1
  %t136 = load ptr, ptr %t135
  call void @symbolExitScope(ptr %t136)
  %t137 = load i32, ptr %t58
  %t138 = add i32 %t137, 1
  store i32 %t138, ptr %t58
  br label %L6
L8:
  store i32 0, ptr %t58
  br label %L21
L21:
  %t139 = load i32, ptr %t58
  %t140 = load i32, ptr @MODULE_COUNT
  %t141 = icmp slt i32 %t139, %t140
  br i1 %t141, label %L22, label %L23
L22:
  %t142 = load i32, ptr %t58
  %t143 = call ptr @modulePath(i32 %t142)
  store ptr %t143, ptr @SOURCE_PATH
  %t144 = load ptr, ptr %t0
  %t145 = getelementptr inbounds %Analyzer, ptr %t144, i32 0, i32 1
  %t146 = load ptr, ptr %t145
  call void @symbolEnterScope(ptr %t146)
  %t147 = load ptr, ptr %t0
  %t148 = getelementptr inbounds %Analyzer, ptr %t147, i32 0, i32 6
  %t149 = load ptr, ptr %t148
  %t150 = load i32, ptr %t58
  %t151 = sext i32 %t150 to i64
  %t152 = getelementptr inbounds %SymbolList, ptr %t149, i64 %t151
  %t153 = load %SymbolList, ptr %t152
  %t154 = alloca %SymbolList
  store %SymbolList %t153, ptr %t154
  %t155 = alloca i32
  store i32 0, ptr %t155
  br label %L24
L24:
  %t156 = load i32, ptr %t155
  %t157 = getelementptr inbounds %SymbolList, ptr %t154, i32 0, i32 1
  %t158 = load i32, ptr %t157
  %t159 = icmp slt i32 %t156, %t158
  br i1 %t159, label %L25, label %L26
L25:
  %t160 = load ptr, ptr %t0
  %t161 = getelementptr inbounds %Analyzer, ptr %t160, i32 0, i32 1
  %t162 = load ptr, ptr %t161
  %t163 = getelementptr inbounds %SymbolList, ptr %t154, i32 0, i32 0
  %t164 = load ptr, ptr %t163
  %t165 = load i32, ptr %t155
  %t166 = sext i32 %t165 to i64
  %t167 = getelementptr inbounds %Symbol, ptr %t164, i64 %t166
  %t168 = load %Symbol, ptr %t167
  call void @declareSymbolCopy(ptr %t162, %Symbol %t168)
  %t169 = load i32, ptr %t155
  %t170 = add i32 %t169, 1
  store i32 %t170, ptr %t155
  br label %L24
L26:
  %t171 = load ptr, ptr %t0
  %t172 = load i32, ptr %t1
  %t173 = load i32, ptr %t58
  call void @declareImports(ptr %t171, i32 %t172, i32 %t173)
  store i32 0, ptr %t15
  br label %L27
L27:
  %t174 = load i32, ptr %t15
  %t175 = load i32, ptr %t12
  %t176 = icmp slt i32 %t174, %t175
  br i1 %t176, label %L28, label %L29
L28:
  %t177 = load ptr, ptr %t0
  %t178 = load i32, ptr %t1
  %t179 = load i32, ptr %t15
  %t180 = load i32, ptr %t58
  %t181 = call i1 @itemInModule(ptr %t177, i32 %t178, i32 %t179, i32 %t180)
  br i1 %t181, label %L30, label %L32
L30:
  %t182 = load ptr, ptr %t0
  %t183 = load ptr, ptr %t0
  %t184 = getelementptr inbounds %Analyzer, ptr %t183, i32 0, i32 0
  %t185 = load ptr, ptr %t184
  %t186 = getelementptr inbounds %Ast, ptr %t185, i32 0, i32 0
  %t187 = load ptr, ptr %t186
  %t188 = load i32, ptr %t1
  %t189 = sext i32 %t188 to i64
  %t190 = getelementptr inbounds %Node, ptr %t187, i64 %t189
  %t191 = getelementptr inbounds %Node, ptr %t190, i32 0, i32 9
  %t192 = load ptr, ptr %t191
  %t193 = load i32, ptr %t15
  %t194 = sext i32 %t193 to i64
  %t195 = getelementptr inbounds i32, ptr %t192, i64 %t194
  %t196 = load i32, ptr %t195
  call void @analyzeRecovering(ptr %t182, i32 %t196)
  br label %L32
L32:
  %t197 = load i32, ptr %t15
  %t198 = add i32 %t197, 1
  store i32 %t198, ptr %t15
  br label %L27
L29:
  %t199 = load ptr, ptr %t0
  %t200 = getelementptr inbounds %Analyzer, ptr %t199, i32 0, i32 1
  %t201 = load ptr, ptr %t200
  call void @symbolExitScope(ptr %t201)
  %t202 = load i32, ptr %t58
  %t203 = add i32 %t202, 1
  store i32 %t203, ptr %t58
  br label %L21
L23:
  %t204 = call ptr @modulePath(i32 0)
  store ptr %t204, ptr @SOURCE_PATH
  %t205 = load ptr, ptr %t0
  %t206 = getelementptr inbounds %Analyzer, ptr %t205, i32 0, i32 6
  %t207 = load ptr, ptr %t206
  %t208 = sext i32 0 to i64
  %t209 = getelementptr inbounds %SymbolList, ptr %t207, i64 %t208
  %t210 = load %SymbolList, ptr %t209
  %t211 = call i32 @symbolListFind(%SymbolList %t210, ptr @.str.436)
  %t212 = icmp slt i32 %t211, 0
  br i1 %t212, label %L33, label %L35
L33:
  call void @report(i32 0, i32 0, ptr @.str.437)
  br label %L35
L35:
  ret void
}

define ptr @emitterNew(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = call ptr @malloc(i64 104)
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = load ptr, ptr %t3
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 0
  store ptr %t4, ptr %t6
  %t7 = load ptr, ptr %t1
  %t8 = load ptr, ptr %t3
  %t9 = getelementptr inbounds %Emitter, ptr %t8, i32 0, i32 1
  store ptr %t7, ptr %t9
  %t10 = call ptr @bufNew()
  %t11 = load ptr, ptr %t3
  %t12 = getelementptr inbounds %Emitter, ptr %t11, i32 0, i32 2
  store ptr %t10, ptr %t12
  %t13 = call ptr @bufNew()
  %t14 = load ptr, ptr %t3
  %t15 = getelementptr inbounds %Emitter, ptr %t14, i32 0, i32 3
  store ptr %t13, ptr %t15
  %t16 = load ptr, ptr %t3
  %t17 = getelementptr inbounds %Emitter, ptr %t16, i32 0, i32 4
  store i32 0, ptr %t17
  %t18 = load ptr, ptr %t3
  %t19 = getelementptr inbounds %Emitter, ptr %t18, i32 0, i32 5
  store i32 0, ptr %t19
  %t20 = load ptr, ptr %t3
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 6
  store i32 0, ptr %t21
  %t22 = load ptr, ptr %t3
  %t23 = getelementptr inbounds %Emitter, ptr %t22, i32 0, i32 7
  store i1 false, ptr %t23
  %t24 = load ptr, ptr %t3
  %t25 = getelementptr inbounds %Emitter, ptr %t24, i32 0, i32 10
  store i32 64, ptr %t25
  %t26 = load ptr, ptr %t3
  %t27 = getelementptr inbounds %Emitter, ptr %t26, i32 0, i32 9
  store i32 0, ptr %t27
  %t28 = load ptr, ptr %t3
  %t29 = getelementptr inbounds %Emitter, ptr %t28, i32 0, i32 10
  %t30 = load i32, ptr %t29
  %t31 = sext i32 %t30 to i64
  %t32 = mul i64 32, %t31
  %t33 = call ptr @malloc(i64 %t32)
  %t34 = load ptr, ptr %t3
  %t35 = getelementptr inbounds %Emitter, ptr %t34, i32 0, i32 8
  store ptr %t33, ptr %t35
  %t36 = load ptr, ptr %t3
  %t37 = getelementptr inbounds %Emitter, ptr %t36, i32 0, i32 13
  store i32 32, ptr %t37
  %t38 = load ptr, ptr %t3
  %t39 = getelementptr inbounds %Emitter, ptr %t38, i32 0, i32 12
  store i32 0, ptr %t39
  %t40 = load ptr, ptr %t3
  %t41 = getelementptr inbounds %Emitter, ptr %t40, i32 0, i32 13
  %t42 = load i32, ptr %t41
  %t43 = sext i32 %t42 to i64
  %t44 = mul i64 4, %t43
  %t45 = call ptr @malloc(i64 %t44)
  %t46 = load ptr, ptr %t3
  %t47 = getelementptr inbounds %Emitter, ptr %t46, i32 0, i32 11
  store ptr %t45, ptr %t47
  %t48 = load ptr, ptr %t3
  %t49 = getelementptr inbounds %Emitter, ptr %t48, i32 0, i32 17
  store i32 16, ptr %t49
  %t50 = load ptr, ptr %t3
  %t51 = getelementptr inbounds %Emitter, ptr %t50, i32 0, i32 16
  store i32 0, ptr %t51
  %t52 = load ptr, ptr %t3
  %t53 = getelementptr inbounds %Emitter, ptr %t52, i32 0, i32 17
  %t54 = load i32, ptr %t53
  %t55 = sext i32 %t54 to i64
  %t56 = mul i64 8, %t55
  %t57 = call ptr @malloc(i64 %t56)
  %t58 = load ptr, ptr %t3
  %t59 = getelementptr inbounds %Emitter, ptr %t58, i32 0, i32 14
  store ptr %t57, ptr %t59
  %t60 = load ptr, ptr %t3
  %t61 = getelementptr inbounds %Emitter, ptr %t60, i32 0, i32 17
  %t62 = load i32, ptr %t61
  %t63 = sext i32 %t62 to i64
  %t64 = mul i64 8, %t63
  %t65 = call ptr @malloc(i64 %t64)
  %t66 = load ptr, ptr %t3
  %t67 = getelementptr inbounds %Emitter, ptr %t66, i32 0, i32 15
  store ptr %t65, ptr %t67
  %t68 = load ptr, ptr %t3
  ret ptr %t68
}

define ptr @freshTemp(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t2
  call void @bufAdd(ptr %t3, ptr @.str.438)
  %t4 = load ptr, ptr %t2
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 4
  %t7 = load i32, ptr %t6
  %t8 = sext i32 %t7 to i64
  call void @bufAddInt(ptr %t4, i64 %t8)
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Emitter, ptr %t9, i32 0, i32 4
  %t11 = load i32, ptr %t10
  %t12 = add i32 %t11, 1
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Emitter, ptr %t13, i32 0, i32 4
  store i32 %t12, ptr %t14
  %t15 = load ptr, ptr %t2
  %t16 = call ptr @bufTake(ptr %t15)
  ret ptr %t16
}

define ptr @freshLabel(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = call ptr @bufNew()
  %t2 = alloca ptr
  store ptr %t1, ptr %t2
  %t3 = load ptr, ptr %t2
  call void @bufAdd(ptr %t3, ptr @.str.439)
  %t4 = load ptr, ptr %t2
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 5
  %t7 = load i32, ptr %t6
  %t8 = sext i32 %t7 to i64
  call void @bufAddInt(ptr %t4, i64 %t8)
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Emitter, ptr %t9, i32 0, i32 5
  %t11 = load i32, ptr %t10
  %t12 = add i32 %t11, 1
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Emitter, ptr %t13, i32 0, i32 5
  store i32 %t12, ptr %t14
  %t15 = load ptr, ptr %t2
  %t16 = call ptr @bufTake(ptr %t15)
  ret ptr %t16
}

define void @emitLine(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 3
  %t4 = load ptr, ptr %t3
  call void @bufAdd(ptr %t4, ptr @.str.440)
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 3
  %t7 = load ptr, ptr %t6
  %t8 = load ptr, ptr %t1
  call void @bufAdd(ptr %t7, ptr %t8)
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Emitter, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  call void @bufPush(ptr %t11, i8 10)
  ret void
}

define void @emitLabel(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 3
  %t4 = load ptr, ptr %t3
  %t5 = load ptr, ptr %t1
  call void @bufAdd(ptr %t4, ptr %t5)
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Emitter, ptr %t6, i32 0, i32 3
  %t8 = load ptr, ptr %t7
  call void @bufAdd(ptr %t8, ptr @.str.441)
  %t9 = load ptr, ptr %t0
  %t10 = getelementptr inbounds %Emitter, ptr %t9, i32 0, i32 7
  store i1 false, ptr %t10
  ret void
}

define void @emitBranch(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 7
  %t4 = load i1, ptr %t3
  br i1 %t4, label %L0, label %L2
L0:
  ret void
L2:
  %t5 = call ptr @bufNew()
  %t6 = alloca ptr
  store ptr %t5, ptr %t6
  %t7 = load ptr, ptr %t6
  call void @bufAdd(ptr %t7, ptr @.str.442)
  %t8 = load ptr, ptr %t6
  %t9 = load ptr, ptr %t1
  call void @bufAdd(ptr %t8, ptr %t9)
  %t10 = load ptr, ptr %t0
  %t11 = load ptr, ptr %t6
  %t12 = getelementptr inbounds %Buf, ptr %t11, i32 0, i32 0
  %t13 = load ptr, ptr %t12
  call void @emitLine(ptr %t10, ptr %t13)
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Emitter, ptr %t14, i32 0, i32 7
  store i1 true, ptr %t15
  ret void
}

define void @emitCondBranch(ptr %p0, ptr %p1, ptr %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Emitter, ptr %t4, i32 0, i32 7
  %t6 = load i1, ptr %t5
  br i1 %t6, label %L0, label %L2
L0:
  ret void
L2:
  %t7 = call ptr @bufNew()
  %t8 = alloca ptr
  store ptr %t7, ptr %t8
  %t9 = load ptr, ptr %t8
  call void @bufAdd(ptr %t9, ptr @.str.443)
  %t10 = load ptr, ptr %t8
  %t11 = load ptr, ptr %t1
  call void @bufAdd(ptr %t10, ptr %t11)
  %t12 = load ptr, ptr %t8
  call void @bufAdd(ptr %t12, ptr @.str.444)
  %t13 = load ptr, ptr %t8
  %t14 = load ptr, ptr %t2
  call void @bufAdd(ptr %t13, ptr %t14)
  %t15 = load ptr, ptr %t8
  call void @bufAdd(ptr %t15, ptr @.str.445)
  %t16 = load ptr, ptr %t8
  %t17 = load ptr, ptr %t3
  call void @bufAdd(ptr %t16, ptr %t17)
  %t18 = load ptr, ptr %t0
  %t19 = load ptr, ptr %t8
  %t20 = getelementptr inbounds %Buf, ptr %t19, i32 0, i32 0
  %t21 = load ptr, ptr %t20
  call void @emitLine(ptr %t18, ptr %t21)
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Emitter, ptr %t22, i32 0, i32 7
  store i1 true, ptr %t23
  ret void
}

define ptr @llvmTypeName(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsPointer(%Type %t1)
  br i1 %t2, label %L0, label %L2
L0:
  ret ptr @.str.446
L2:
  %t3 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t4 = load i32, ptr %t3
  %t5 = load i32, ptr @TY_STRUCT
  %t6 = icmp eq i32 %t4, %t5
  br i1 %t6, label %L3, label %L5
L3:
  %t7 = call ptr @bufNew()
  %t8 = alloca ptr
  store ptr %t7, ptr %t8
  %t9 = load ptr, ptr %t8
  call void @bufPush(ptr %t9, i8 37)
  %t10 = load ptr, ptr %t8
  %t11 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 2
  %t12 = load ptr, ptr %t11
  call void @bufAdd(ptr %t10, ptr %t12)
  %t13 = load ptr, ptr %t8
  %t14 = call ptr @bufTake(ptr %t13)
  ret ptr %t14
L5:
  %t15 = alloca i1
  %t16 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t17 = load i32, ptr %t16
  %t18 = load i32, ptr @TY_I8
  %t19 = icmp eq i32 %t17, %t18
  store i1 %t19, ptr %t15
  br i1 %t19, label %L7, label %L6
L6:
  %t20 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t21 = load i32, ptr %t20
  %t22 = load i32, ptr @TY_U8
  %t23 = icmp eq i32 %t21, %t22
  store i1 %t23, ptr %t15
  br label %L7
L7:
  %t24 = load i1, ptr %t15
  br i1 %t24, label %L8, label %L10
L8:
  ret ptr @.str.447
L10:
  %t25 = alloca i1
  %t26 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t27 = load i32, ptr %t26
  %t28 = load i32, ptr @TY_I16
  %t29 = icmp eq i32 %t27, %t28
  store i1 %t29, ptr %t25
  br i1 %t29, label %L12, label %L11
L11:
  %t30 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t31 = load i32, ptr %t30
  %t32 = load i32, ptr @TY_U16
  %t33 = icmp eq i32 %t31, %t32
  store i1 %t33, ptr %t25
  br label %L12
L12:
  %t34 = load i1, ptr %t25
  br i1 %t34, label %L13, label %L15
L13:
  ret ptr @.str.448
L15:
  %t35 = alloca i1
  %t36 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t37 = load i32, ptr %t36
  %t38 = load i32, ptr @TY_I32
  %t39 = icmp eq i32 %t37, %t38
  store i1 %t39, ptr %t35
  br i1 %t39, label %L17, label %L16
L16:
  %t40 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t41 = load i32, ptr %t40
  %t42 = load i32, ptr @TY_U32
  %t43 = icmp eq i32 %t41, %t42
  store i1 %t43, ptr %t35
  br label %L17
L17:
  %t44 = load i1, ptr %t35
  br i1 %t44, label %L18, label %L20
L18:
  ret ptr @.str.449
L20:
  %t45 = alloca i1
  %t46 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t47 = load i32, ptr %t46
  %t48 = load i32, ptr @TY_I64
  %t49 = icmp eq i32 %t47, %t48
  store i1 %t49, ptr %t45
  br i1 %t49, label %L22, label %L21
L21:
  %t50 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t51 = load i32, ptr %t50
  %t52 = load i32, ptr @TY_U64
  %t53 = icmp eq i32 %t51, %t52
  store i1 %t53, ptr %t45
  br label %L22
L22:
  %t54 = load i1, ptr %t45
  br i1 %t54, label %L23, label %L25
L23:
  ret ptr @.str.450
L25:
  %t55 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t56 = load i32, ptr %t55
  %t57 = load i32, ptr @TY_F32
  %t58 = icmp eq i32 %t56, %t57
  br i1 %t58, label %L26, label %L28
L26:
  ret ptr @.str.451
L28:
  %t59 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t60 = load i32, ptr %t59
  %t61 = load i32, ptr @TY_F64
  %t62 = icmp eq i32 %t60, %t61
  br i1 %t62, label %L29, label %L31
L29:
  ret ptr @.str.452
L31:
  %t63 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t64 = load i32, ptr %t63
  %t65 = load i32, ptr @TY_BOOL
  %t66 = icmp eq i32 %t64, %t65
  br i1 %t66, label %L32, label %L34
L32:
  ret ptr @.str.453
L34:
  %t67 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t68 = load i32, ptr %t67
  %t69 = load i32, ptr @TY_VOID
  %t70 = icmp eq i32 %t68, %t69
  br i1 %t70, label %L35, label %L37
L35:
  ret ptr @.str.454
L37:
  ret ptr @.str.455
}

define i32 @alignOfType(ptr %p0, %Type %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = load %Type, ptr %t1
  %t3 = call i1 @typeIsPointer(%Type %t2)
  br i1 %t3, label %L0, label %L2
L0:
  ret i32 8
L2:
  %t4 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_STRUCT
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L3, label %L5
L3:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Emitter, ptr %t8, i32 0, i32 1
  %t10 = load ptr, ptr %t9
  %t11 = getelementptr inbounds %Analyzer, ptr %t10, i32 0, i32 2
  %t12 = load ptr, ptr %t11
  %t13 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 2
  %t14 = load ptr, ptr %t13
  %t15 = call i32 @structIndexOf(ptr %t12, ptr %t14)
  %t16 = alloca i32
  store i32 %t15, ptr %t16
  %t17 = alloca i32
  store i32 1, ptr %t17
  %t18 = alloca i32
  store i32 0, ptr %t18
  br label %L6
L6:
  %t19 = load i32, ptr %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 1
  %t22 = load ptr, ptr %t21
  %t23 = getelementptr inbounds %Analyzer, ptr %t22, i32 0, i32 2
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %StructTable, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t16
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %StructLayout, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %StructLayout, ptr %t29, i32 0, i32 2
  %t31 = load i32, ptr %t30
  %t32 = icmp slt i32 %t19, %t31
  br i1 %t32, label %L7, label %L8
L7:
  %t33 = load ptr, ptr %t0
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Emitter, ptr %t34, i32 0, i32 1
  %t36 = load ptr, ptr %t35
  %t37 = getelementptr inbounds %Analyzer, ptr %t36, i32 0, i32 2
  %t38 = load ptr, ptr %t37
  %t39 = getelementptr inbounds %StructTable, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t16
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %StructLayout, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %StructLayout, ptr %t43, i32 0, i32 1
  %t45 = load ptr, ptr %t44
  %t46 = load i32, ptr %t18
  %t47 = sext i32 %t46 to i64
  %t48 = getelementptr inbounds %FieldDef, ptr %t45, i64 %t47
  %t49 = getelementptr inbounds %FieldDef, ptr %t48, i32 0, i32 1
  %t50 = load %Type, ptr %t49
  %t51 = call i32 @alignOfType(ptr %t33, %Type %t50)
  %t52 = alloca i32
  store i32 %t51, ptr %t52
  %t53 = load i32, ptr %t52
  %t54 = load i32, ptr %t17
  %t55 = icmp sgt i32 %t53, %t54
  br i1 %t55, label %L9, label %L11
L9:
  %t56 = load i32, ptr %t52
  store i32 %t56, ptr %t17
  br label %L11
L11:
  %t57 = load i32, ptr %t18
  %t58 = add i32 %t57, 1
  store i32 %t58, ptr %t18
  br label %L6
L8:
  %t59 = load i32, ptr %t17
  ret i32 %t59
L5:
  %t60 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t61 = load i32, ptr %t60
  %t62 = load i32, ptr @TY_BOOL
  %t63 = icmp eq i32 %t61, %t62
  br i1 %t63, label %L12, label %L14
L12:
  ret i32 1
L14:
  %t64 = load %Type, ptr %t1
  %t65 = call i32 @typeBitWidth(%Type %t64)
  %t66 = alloca i32
  store i32 %t65, ptr %t66
  %t67 = load i32, ptr %t66
  %t68 = icmp eq i32 %t67, 0
  br i1 %t68, label %L15, label %L17
L15:
  ret i32 1
L17:
  %t69 = load i32, ptr %t66
  %t70 = sdiv i32 %t69, 8
  ret i32 %t70
}

define i32 @alignUp(i32 %p0, i32 %p1) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load i32, ptr %t0
  %t3 = load i32, ptr %t1
  %t4 = srem i32 %t2, %t3
  %t5 = alloca i32
  store i32 %t4, ptr %t5
  %t6 = load i32, ptr %t5
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = load i32, ptr %t0
  ret i32 %t8
L2:
  %t9 = load i32, ptr %t0
  %t10 = load i32, ptr %t1
  %t11 = add i32 %t9, %t10
  %t12 = load i32, ptr %t5
  %t13 = sub i32 %t11, %t12
  ret i32 %t13
}

define i32 @sizeOfType(ptr %p0, %Type %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = load %Type, ptr %t1
  %t3 = call i1 @typeIsPointer(%Type %t2)
  br i1 %t3, label %L0, label %L2
L0:
  ret i32 8
L2:
  %t4 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_STRUCT
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L3, label %L5
L3:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Emitter, ptr %t8, i32 0, i32 1
  %t10 = load ptr, ptr %t9
  %t11 = getelementptr inbounds %Analyzer, ptr %t10, i32 0, i32 2
  %t12 = load ptr, ptr %t11
  %t13 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 2
  %t14 = load ptr, ptr %t13
  %t15 = call i32 @structIndexOf(ptr %t12, ptr %t14)
  %t16 = alloca i32
  store i32 %t15, ptr %t16
  %t17 = alloca i32
  store i32 0, ptr %t17
  %t18 = alloca i32
  store i32 0, ptr %t18
  br label %L6
L6:
  %t19 = load i32, ptr %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 1
  %t22 = load ptr, ptr %t21
  %t23 = getelementptr inbounds %Analyzer, ptr %t22, i32 0, i32 2
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %StructTable, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t16
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %StructLayout, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %StructLayout, ptr %t29, i32 0, i32 2
  %t31 = load i32, ptr %t30
  %t32 = icmp slt i32 %t19, %t31
  br i1 %t32, label %L7, label %L8
L7:
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Emitter, ptr %t33, i32 0, i32 1
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Analyzer, ptr %t35, i32 0, i32 2
  %t37 = load ptr, ptr %t36
  %t38 = getelementptr inbounds %StructTable, ptr %t37, i32 0, i32 0
  %t39 = load ptr, ptr %t38
  %t40 = load i32, ptr %t16
  %t41 = sext i32 %t40 to i64
  %t42 = getelementptr inbounds %StructLayout, ptr %t39, i64 %t41
  %t43 = getelementptr inbounds %StructLayout, ptr %t42, i32 0, i32 1
  %t44 = load ptr, ptr %t43
  %t45 = load i32, ptr %t18
  %t46 = sext i32 %t45 to i64
  %t47 = getelementptr inbounds %FieldDef, ptr %t44, i64 %t46
  %t48 = getelementptr inbounds %FieldDef, ptr %t47, i32 0, i32 1
  %t49 = load %Type, ptr %t48
  %t50 = alloca %Type
  store %Type %t49, ptr %t50
  %t51 = load i32, ptr %t17
  %t52 = load ptr, ptr %t0
  %t53 = load %Type, ptr %t50
  %t54 = call i32 @alignOfType(ptr %t52, %Type %t53)
  %t55 = call i32 @alignUp(i32 %t51, i32 %t54)
  store i32 %t55, ptr %t17
  %t56 = load i32, ptr %t17
  %t57 = load ptr, ptr %t0
  %t58 = load %Type, ptr %t50
  %t59 = call i32 @sizeOfType(ptr %t57, %Type %t58)
  %t60 = add i32 %t56, %t59
  store i32 %t60, ptr %t17
  %t61 = load i32, ptr %t18
  %t62 = add i32 %t61, 1
  store i32 %t62, ptr %t18
  br label %L6
L8:
  %t63 = load i32, ptr %t17
  %t64 = load ptr, ptr %t0
  %t65 = load %Type, ptr %t1
  %t66 = call i32 @alignOfType(ptr %t64, %Type %t65)
  %t67 = call i32 @alignUp(i32 %t63, i32 %t66)
  ret i32 %t67
L5:
  %t68 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t69 = load i32, ptr %t68
  %t70 = load i32, ptr @TY_BOOL
  %t71 = icmp eq i32 %t69, %t70
  br i1 %t71, label %L9, label %L11
L9:
  ret i32 1
L11:
  %t72 = getelementptr inbounds %Type, ptr %t1, i32 0, i32 0
  %t73 = load i32, ptr %t72
  %t74 = load i32, ptr @TY_VOID
  %t75 = icmp eq i32 %t73, %t74
  br i1 %t75, label %L12, label %L14
L12:
  ret i32 0
L14:
  %t76 = load %Type, ptr %t1
  %t77 = call i32 @typeBitWidth(%Type %t76)
  %t78 = sdiv i32 %t77, 8
  ret i32 %t78
}

define ptr @zeroValue(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsPointer(%Type %t1)
  br i1 %t2, label %L0, label %L2
L0:
  ret ptr @.str.456
L2:
  %t3 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t4 = load i32, ptr %t3
  %t5 = load i32, ptr @TY_STRUCT
  %t6 = icmp eq i32 %t4, %t5
  br i1 %t6, label %L3, label %L5
L3:
  ret ptr @.str.457
L5:
  %t7 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t8 = load i32, ptr %t7
  %t9 = load i32, ptr @TY_BOOL
  %t10 = icmp eq i32 %t8, %t9
  br i1 %t10, label %L6, label %L8
L6:
  ret ptr @.str.458
L8:
  %t11 = alloca i1
  %t12 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @TY_F32
  %t15 = icmp eq i32 %t13, %t14
  store i1 %t15, ptr %t11
  br i1 %t15, label %L10, label %L9
L9:
  %t16 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t17 = load i32, ptr %t16
  %t18 = load i32, ptr @TY_F64
  %t19 = icmp eq i32 %t17, %t18
  store i1 %t19, ptr %t11
  br label %L10
L10:
  %t20 = load i1, ptr %t11
  br i1 %t20, label %L11, label %L13
L11:
  ret ptr @.str.459
L13:
  ret ptr @.str.460
}

define void @emitterEnterScope(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Emitter, ptr %t1, i32 0, i32 12
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Emitter, ptr %t4, i32 0, i32 13
  %t6 = load i32, ptr %t5
  %t7 = icmp eq i32 %t3, %t6
  br i1 %t7, label %L0, label %L2
L0:
  %t8 = load ptr, ptr %t0
  %t9 = getelementptr inbounds %Emitter, ptr %t8, i32 0, i32 13
  %t10 = load i32, ptr %t9
  %t11 = mul i32 %t10, 2
  %t12 = load ptr, ptr %t0
  %t13 = getelementptr inbounds %Emitter, ptr %t12, i32 0, i32 13
  store i32 %t11, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Emitter, ptr %t14, i32 0, i32 11
  %t16 = load ptr, ptr %t15
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Emitter, ptr %t17, i32 0, i32 13
  %t19 = load i32, ptr %t18
  %t20 = sext i32 %t19 to i64
  %t21 = mul i64 4, %t20
  %t22 = call ptr @realloc(ptr %t16, i64 %t21)
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Emitter, ptr %t23, i32 0, i32 11
  store ptr %t22, ptr %t24
  br label %L2
L2:
  %t25 = load ptr, ptr %t0
  %t26 = getelementptr inbounds %Emitter, ptr %t25, i32 0, i32 9
  %t27 = load i32, ptr %t26
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Emitter, ptr %t28, i32 0, i32 11
  %t30 = load ptr, ptr %t29
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Emitter, ptr %t31, i32 0, i32 12
  %t33 = load i32, ptr %t32
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds i32, ptr %t30, i64 %t34
  store i32 %t27, ptr %t35
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %Emitter, ptr %t36, i32 0, i32 12
  %t38 = load i32, ptr %t37
  %t39 = add i32 %t38, 1
  %t40 = load ptr, ptr %t0
  %t41 = getelementptr inbounds %Emitter, ptr %t40, i32 0, i32 12
  store i32 %t39, ptr %t41
  ret void
}

define void @emitterExitScope(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = getelementptr inbounds %Emitter, ptr %t1, i32 0, i32 12
  %t3 = load i32, ptr %t2
  %t4 = sub i32 %t3, 1
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 12
  store i32 %t4, ptr %t6
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Emitter, ptr %t7, i32 0, i32 11
  %t9 = load ptr, ptr %t8
  %t10 = load ptr, ptr %t0
  %t11 = getelementptr inbounds %Emitter, ptr %t10, i32 0, i32 12
  %t12 = load i32, ptr %t11
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds i32, ptr %t9, i64 %t13
  %t15 = load i32, ptr %t14
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Emitter, ptr %t16, i32 0, i32 9
  store i32 %t15, ptr %t17
  ret void
}

define void @declareLocal(ptr %p0, ptr %p1, ptr %p2, %Type %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca %Type
  store %Type %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Emitter, ptr %t4, i32 0, i32 9
  %t6 = load i32, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Emitter, ptr %t7, i32 0, i32 10
  %t9 = load i32, ptr %t8
  %t10 = icmp eq i32 %t6, %t9
  br i1 %t10, label %L0, label %L2
L0:
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Emitter, ptr %t11, i32 0, i32 10
  %t13 = load i32, ptr %t12
  %t14 = mul i32 %t13, 2
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Emitter, ptr %t15, i32 0, i32 10
  store i32 %t14, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Emitter, ptr %t17, i32 0, i32 8
  %t19 = load ptr, ptr %t18
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 10
  %t22 = load i32, ptr %t21
  %t23 = sext i32 %t22 to i64
  %t24 = mul i64 32, %t23
  %t25 = call ptr @realloc(ptr %t19, i64 %t24)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Emitter, ptr %t26, i32 0, i32 8
  store ptr %t25, ptr %t27
  br label %L2
L2:
  %t28 = load ptr, ptr %t1
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Emitter, ptr %t29, i32 0, i32 8
  %t31 = load ptr, ptr %t30
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Emitter, ptr %t32, i32 0, i32 9
  %t34 = load i32, ptr %t33
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %Local, ptr %t31, i64 %t35
  %t37 = getelementptr inbounds %Local, ptr %t36, i32 0, i32 0
  store ptr %t28, ptr %t37
  %t38 = load ptr, ptr %t2
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Emitter, ptr %t39, i32 0, i32 8
  %t41 = load ptr, ptr %t40
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Emitter, ptr %t42, i32 0, i32 9
  %t44 = load i32, ptr %t43
  %t45 = sext i32 %t44 to i64
  %t46 = getelementptr inbounds %Local, ptr %t41, i64 %t45
  %t47 = getelementptr inbounds %Local, ptr %t46, i32 0, i32 1
  store ptr %t38, ptr %t47
  %t48 = load %Type, ptr %t3
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr inbounds %Emitter, ptr %t49, i32 0, i32 8
  %t51 = load ptr, ptr %t50
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Emitter, ptr %t52, i32 0, i32 9
  %t54 = load i32, ptr %t53
  %t55 = sext i32 %t54 to i64
  %t56 = getelementptr inbounds %Local, ptr %t51, i64 %t55
  %t57 = getelementptr inbounds %Local, ptr %t56, i32 0, i32 2
  store %Type %t48, ptr %t57
  %t58 = load ptr, ptr %t0
  %t59 = getelementptr inbounds %Emitter, ptr %t58, i32 0, i32 9
  %t60 = load i32, ptr %t59
  %t61 = add i32 %t60, 1
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Emitter, ptr %t62, i32 0, i32 9
  store i32 %t61, ptr %t63
  ret void
}

define ptr @variableAddress(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Emitter, ptr %t13, i32 0, i32 9
  %t15 = load i32, ptr %t14
  %t16 = sub i32 %t15, 1
  %t17 = alloca i32
  store i32 %t16, ptr %t17
  br label %L0
L0:
  %t18 = load i32, ptr %t17
  %t19 = icmp sge i32 %t18, 0
  br i1 %t19, label %L1, label %L2
L1:
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 8
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t17
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Local, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Local, ptr %t25, i32 0, i32 0
  %t27 = load ptr, ptr %t26
  %t28 = load ptr, ptr %t12
  %t29 = call i1 @textEquals(ptr %t27, ptr %t28)
  br i1 %t29, label %L3, label %L5
L3:
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Emitter, ptr %t30, i32 0, i32 8
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t17
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %Local, ptr %t32, i64 %t34
  %t36 = getelementptr inbounds %Local, ptr %t35, i32 0, i32 1
  %t37 = load ptr, ptr %t36
  ret ptr %t37
L5:
  %t38 = load i32, ptr %t17
  %t39 = sub i32 %t38, 1
  store i32 %t39, ptr %t17
  br label %L0
L2:
  %t40 = call ptr @bufNew()
  %t41 = alloca ptr
  store ptr %t40, ptr %t41
  %t42 = load ptr, ptr %t41
  call void @bufPush(ptr %t42, i8 64)
  %t43 = load ptr, ptr %t41
  %t44 = load ptr, ptr %t0
  %t45 = getelementptr inbounds %Emitter, ptr %t44, i32 0, i32 1
  %t46 = load ptr, ptr %t45
  %t47 = getelementptr inbounds %Analyzer, ptr %t46, i32 0, i32 5
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t1
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds ptr, ptr %t48, i64 %t50
  %t52 = load ptr, ptr %t51
  call void @bufAdd(ptr %t43, ptr %t52)
  %t53 = load ptr, ptr %t41
  %t54 = call ptr @bufTake(ptr %t53)
  ret ptr %t54
}

define void @emitIRByte(ptr %p0, i8 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i8
  store i8 %p1, ptr %t1
  %t2 = load i8, ptr %t1
  %t3 = sext i8 %t2 to i32
  %t4 = alloca i32
  store i32 %t3, ptr %t4
  %t5 = load i32, ptr %t4
  %t6 = icmp slt i32 %t5, 0
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load i32, ptr %t4
  %t8 = add i32 %t7, 256
  store i32 %t8, ptr %t4
  br label %L2
L2:
  %t9 = alloca i1
  %t10 = alloca i1
  %t11 = alloca i1
  %t12 = load i32, ptr %t4
  %t13 = icmp sge i32 %t12, 32
  store i1 %t13, ptr %t11
  br i1 %t13, label %L3, label %L4
L3:
  %t14 = load i32, ptr %t4
  %t15 = icmp slt i32 %t14, 127
  store i1 %t15, ptr %t11
  br label %L4
L4:
  %t16 = load i1, ptr %t11
  store i1 %t16, ptr %t10
  br i1 %t16, label %L5, label %L6
L5:
  %t17 = load i8, ptr %t1
  %t18 = icmp ne i8 %t17, 34
  store i1 %t18, ptr %t10
  br label %L6
L6:
  %t19 = load i1, ptr %t10
  store i1 %t19, ptr %t9
  br i1 %t19, label %L7, label %L8
L7:
  %t20 = load i8, ptr %t1
  %t21 = icmp ne i8 %t20, 92
  store i1 %t21, ptr %t9
  br label %L8
L8:
  %t22 = load i1, ptr %t9
  br i1 %t22, label %L9, label %L11
L9:
  %t23 = load ptr, ptr %t0
  %t24 = load i8, ptr %t1
  call void @bufPush(ptr %t23, i8 %t24)
  ret void
L11:
  %t25 = load ptr, ptr %t0
  call void @bufPush(ptr %t25, i8 92)
  %t26 = load ptr, ptr %t0
  %t27 = load i32, ptr %t4
  %t28 = sdiv i32 %t27, 16
  %t29 = call i8 @hexDigit(i32 %t28)
  call void @bufPush(ptr %t26, i8 %t29)
  %t30 = load ptr, ptr %t0
  %t31 = load i32, ptr %t4
  %t32 = srem i32 %t31, 16
  %t33 = call i8 @hexDigit(i32 %t32)
  call void @bufPush(ptr %t30, i8 %t33)
  ret void
}

define i8 @hexDigit(i32 %p0) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = load i32, ptr %t0
  %t2 = icmp slt i32 %t1, 10
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = sext i8 48 to i32
  %t4 = load i32, ptr %t0
  %t5 = add i32 %t3, %t4
  %t6 = trunc i32 %t5 to i8
  ret i8 %t6
L2:
  %t7 = sext i8 65 to i32
  %t8 = load i32, ptr %t0
  %t9 = add i32 %t7, %t8
  %t10 = sub i32 %t9, 10
  %t11 = trunc i32 %t10 to i8
  ret i8 %t11
}

define ptr @internString(ptr %p0, ptr %p1, i64 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i64
  store i64 %p2, ptr %t2
  %t3 = call ptr @bufNew()
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t4
  call void @bufAdd(ptr %t5, ptr @.str.461)
  %t6 = load ptr, ptr %t4
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Emitter, ptr %t7, i32 0, i32 6
  %t9 = load i32, ptr %t8
  %t10 = sext i32 %t9 to i64
  call void @bufAddInt(ptr %t6, i64 %t10)
  %t11 = load ptr, ptr %t0
  %t12 = getelementptr inbounds %Emitter, ptr %t11, i32 0, i32 6
  %t13 = load i32, ptr %t12
  %t14 = add i32 %t13, 1
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Emitter, ptr %t15, i32 0, i32 6
  store i32 %t14, ptr %t16
  %t17 = load ptr, ptr %t4
  %t18 = call ptr @bufTake(ptr %t17)
  %t19 = alloca ptr
  store ptr %t18, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = getelementptr inbounds %Emitter, ptr %t20, i32 0, i32 2
  %t22 = load ptr, ptr %t21
  %t23 = load ptr, ptr %t19
  call void @bufAdd(ptr %t22, ptr %t23)
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Emitter, ptr %t24, i32 0, i32 2
  %t26 = load ptr, ptr %t25
  call void @bufAdd(ptr %t26, ptr @.str.462)
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Emitter, ptr %t27, i32 0, i32 2
  %t29 = load ptr, ptr %t28
  %t30 = load i64, ptr %t2
  %t31 = sext i32 1 to i64
  %t32 = add i64 %t30, %t31
  call void @bufAddInt(ptr %t29, i64 %t32)
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Emitter, ptr %t33, i32 0, i32 2
  %t35 = load ptr, ptr %t34
  call void @bufAdd(ptr %t35, ptr @.str.463)
  %t36 = sext i32 0 to i64
  %t37 = alloca i64
  store i64 %t36, ptr %t37
  br label %L0
L0:
  %t38 = load i64, ptr %t37
  %t39 = load i64, ptr %t2
  %t40 = icmp slt i64 %t38, %t39
  br i1 %t40, label %L1, label %L2
L1:
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Emitter, ptr %t41, i32 0, i32 2
  %t43 = load ptr, ptr %t42
  %t44 = load ptr, ptr %t1
  %t45 = load i64, ptr %t37
  %t46 = getelementptr inbounds i8, ptr %t44, i64 %t45
  %t47 = load i8, ptr %t46
  call void @emitIRByte(ptr %t43, i8 %t47)
  %t48 = load i64, ptr %t37
  %t49 = sext i32 1 to i64
  %t50 = add i64 %t48, %t49
  store i64 %t50, ptr %t37
  br label %L0
L2:
  %t51 = load ptr, ptr %t0
  %t52 = getelementptr inbounds %Emitter, ptr %t51, i32 0, i32 2
  %t53 = load ptr, ptr %t52
  call void @bufAdd(ptr %t53, ptr @.str.464)
  %t54 = load ptr, ptr %t19
  ret ptr %t54
}

define %Type @typeOfNode(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 1
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Analyzer, ptr %t4, i32 0, i32 3
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Type, ptr %t6, i64 %t8
  %t10 = load %Type, ptr %t9
  ret %Type %t10
}

define ptr @emitAssign(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = call ptr @freshTemp(ptr %t2)
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = call ptr @bufNew()
  %t6 = alloca ptr
  store ptr %t5, ptr %t6
  %t7 = load ptr, ptr %t6
  %t8 = load ptr, ptr %t4
  call void @bufAdd(ptr %t7, ptr %t8)
  %t9 = load ptr, ptr %t6
  call void @bufAdd(ptr %t9, ptr @.str.465)
  %t10 = load ptr, ptr %t6
  %t11 = load ptr, ptr %t1
  call void @bufAdd(ptr %t10, ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t6
  %t14 = getelementptr inbounds %Buf, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  call void @emitLine(ptr %t12, ptr %t15)
  %t16 = load ptr, ptr %t4
  ret ptr %t16
}

define ptr @emitLoad(ptr %p0, %Type %p1, ptr %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = call ptr @bufNew()
  %t4 = alloca ptr
  store ptr %t3, ptr %t4
  %t5 = load ptr, ptr %t4
  call void @bufAdd(ptr %t5, ptr @.str.466)
  %t6 = load ptr, ptr %t4
  %t7 = load %Type, ptr %t1
  %t8 = call ptr @llvmTypeName(%Type %t7)
  call void @bufAdd(ptr %t6, ptr %t8)
  %t9 = load ptr, ptr %t4
  call void @bufAdd(ptr %t9, ptr @.str.467)
  %t10 = load ptr, ptr %t4
  %t11 = load ptr, ptr %t2
  call void @bufAdd(ptr %t10, ptr %t11)
  %t12 = load ptr, ptr %t0
  %t13 = load ptr, ptr %t4
  %t14 = getelementptr inbounds %Buf, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  %t16 = call ptr @emitAssign(ptr %t12, ptr %t15)
  ret ptr %t16
}

define void @emitStore(ptr %p0, %Type %p1, ptr %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = call ptr @bufNew()
  %t5 = alloca ptr
  store ptr %t4, ptr %t5
  %t6 = load ptr, ptr %t5
  call void @bufAdd(ptr %t6, ptr @.str.468)
  %t7 = load ptr, ptr %t5
  %t8 = load %Type, ptr %t1
  %t9 = call ptr @llvmTypeName(%Type %t8)
  call void @bufAdd(ptr %t7, ptr %t9)
  %t10 = load ptr, ptr %t5
  call void @bufPush(ptr %t10, i8 32)
  %t11 = load ptr, ptr %t5
  %t12 = load ptr, ptr %t2
  call void @bufAdd(ptr %t11, ptr %t12)
  %t13 = load ptr, ptr %t5
  call void @bufAdd(ptr %t13, ptr @.str.469)
  %t14 = load ptr, ptr %t5
  %t15 = load ptr, ptr %t3
  call void @bufAdd(ptr %t14, ptr %t15)
  %t16 = load ptr, ptr %t0
  %t17 = load ptr, ptr %t5
  %t18 = getelementptr inbounds %Buf, ptr %t17, i32 0, i32 0
  %t19 = load ptr, ptr %t18
  call void @emitLine(ptr %t16, ptr %t19)
  ret void
}

define ptr @emitCast(ptr %p0, ptr %p1, %Type %p2, %Type %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = alloca %Type
  store %Type %p3, ptr %t3
  %t4 = load %Type, ptr %t2
  %t5 = load %Type, ptr %t3
  %t6 = call i1 @typeEquals(%Type %t4, %Type %t5)
  br i1 %t6, label %L0, label %L2
L0:
  %t7 = load ptr, ptr %t1
  ret ptr %t7
L2:
  %t8 = load %Type, ptr %t3
  %t9 = call ptr @llvmTypeName(%Type %t8)
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = load %Type, ptr %t2
  %t12 = call ptr @llvmTypeName(%Type %t11)
  %t13 = alloca ptr
  store ptr %t12, ptr %t13
  %t14 = alloca i1
  %t15 = load %Type, ptr %t2
  %t16 = call i1 @typeIsPointer(%Type %t15)
  store i1 %t16, ptr %t14
  br i1 %t16, label %L3, label %L4
L3:
  %t17 = load %Type, ptr %t3
  %t18 = call i1 @typeIsPointer(%Type %t17)
  store i1 %t18, ptr %t14
  br label %L4
L4:
  %t19 = load i1, ptr %t14
  br i1 %t19, label %L5, label %L7
L5:
  %t20 = load ptr, ptr %t1
  ret ptr %t20
L7:
  %t21 = call ptr @nullText()
  %t22 = alloca ptr
  store ptr %t21, ptr %t22
  %t23 = alloca i1
  %t24 = load %Type, ptr %t2
  %t25 = call i1 @typeIsPointer(%Type %t24)
  store i1 %t25, ptr %t23
  br i1 %t25, label %L8, label %L9
L8:
  %t26 = load %Type, ptr %t3
  %t27 = call i1 @typeIsInteger(%Type %t26)
  store i1 %t27, ptr %t23
  br label %L9
L9:
  %t28 = load i1, ptr %t23
  br i1 %t28, label %L10, label %L11
L10:
  store ptr @.str.470, ptr %t22
  br label %L12
L11:
  %t29 = alloca i1
  %t30 = load %Type, ptr %t2
  %t31 = call i1 @typeIsInteger(%Type %t30)
  store i1 %t31, ptr %t29
  br i1 %t31, label %L13, label %L14
L13:
  %t32 = load %Type, ptr %t3
  %t33 = call i1 @typeIsPointer(%Type %t32)
  store i1 %t33, ptr %t29
  br label %L14
L14:
  %t34 = load i1, ptr %t29
  br i1 %t34, label %L15, label %L16
L15:
  store ptr @.str.471, ptr %t22
  br label %L17
L16:
  %t35 = load %Type, ptr %t2
  %t36 = call i1 @typeIsBool(%Type %t35)
  br i1 %t36, label %L18, label %L19
L18:
  store ptr @.str.472, ptr %t22
  br label %L20
L19:
  %t37 = load %Type, ptr %t3
  %t38 = call i1 @typeIsBool(%Type %t37)
  br i1 %t38, label %L21, label %L22
L21:
  %t39 = call ptr @bufNew()
  %t40 = alloca ptr
  store ptr %t39, ptr %t40
  %t41 = load ptr, ptr %t40
  call void @bufAdd(ptr %t41, ptr @.str.473)
  %t42 = load ptr, ptr %t40
  %t43 = load ptr, ptr %t13
  call void @bufAdd(ptr %t42, ptr %t43)
  %t44 = load ptr, ptr %t40
  call void @bufPush(ptr %t44, i8 32)
  %t45 = load ptr, ptr %t40
  %t46 = load ptr, ptr %t1
  call void @bufAdd(ptr %t45, ptr %t46)
  %t47 = load ptr, ptr %t40
  call void @bufAdd(ptr %t47, ptr @.str.474)
  %t48 = load ptr, ptr %t40
  %t49 = load %Type, ptr %t2
  %t50 = call ptr @zeroValue(%Type %t49)
  call void @bufAdd(ptr %t48, ptr %t50)
  %t51 = load ptr, ptr %t0
  %t52 = load ptr, ptr %t40
  %t53 = getelementptr inbounds %Buf, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = call ptr @emitAssign(ptr %t51, ptr %t54)
  ret ptr %t55
L22:
  %t56 = alloca i1
  %t57 = load %Type, ptr %t2
  %t58 = call i1 @typeIsInteger(%Type %t57)
  store i1 %t58, ptr %t56
  br i1 %t58, label %L24, label %L25
L24:
  %t59 = load %Type, ptr %t3
  %t60 = call i1 @typeIsInteger(%Type %t59)
  store i1 %t60, ptr %t56
  br label %L25
L25:
  %t61 = load i1, ptr %t56
  br i1 %t61, label %L26, label %L27
L26:
  %t62 = load %Type, ptr %t3
  %t63 = call i32 @typeBitWidth(%Type %t62)
  %t64 = load %Type, ptr %t2
  %t65 = call i32 @typeBitWidth(%Type %t64)
  %t66 = icmp eq i32 %t63, %t65
  br i1 %t66, label %L29, label %L31
L29:
  %t67 = load ptr, ptr %t1
  ret ptr %t67
L31:
  %t68 = load %Type, ptr %t3
  %t69 = call i32 @typeBitWidth(%Type %t68)
  %t70 = load %Type, ptr %t2
  %t71 = call i32 @typeBitWidth(%Type %t70)
  %t72 = icmp slt i32 %t69, %t71
  br i1 %t72, label %L32, label %L33
L32:
  store ptr @.str.475, ptr %t22
  br label %L34
L33:
  %t73 = load %Type, ptr %t2
  %t74 = call i1 @typeIsSigned(%Type %t73)
  br i1 %t74, label %L35, label %L36
L35:
  store ptr @.str.476, ptr %t22
  br label %L37
L36:
  store ptr @.str.477, ptr %t22
  br label %L37
L37:
  br label %L34
L34:
  br label %L28
L27:
  %t75 = alloca i1
  %t76 = load %Type, ptr %t2
  %t77 = call i1 @typeIsInteger(%Type %t76)
  store i1 %t77, ptr %t75
  br i1 %t77, label %L38, label %L39
L38:
  %t78 = load %Type, ptr %t3
  %t79 = call i1 @typeIsFloat(%Type %t78)
  store i1 %t79, ptr %t75
  br label %L39
L39:
  %t80 = load i1, ptr %t75
  br i1 %t80, label %L40, label %L41
L40:
  %t81 = load %Type, ptr %t2
  %t82 = call i1 @typeIsSigned(%Type %t81)
  br i1 %t82, label %L43, label %L44
L43:
  store ptr @.str.478, ptr %t22
  br label %L45
L44:
  store ptr @.str.479, ptr %t22
  br label %L45
L45:
  br label %L42
L41:
  %t83 = alloca i1
  %t84 = load %Type, ptr %t2
  %t85 = call i1 @typeIsFloat(%Type %t84)
  store i1 %t85, ptr %t83
  br i1 %t85, label %L46, label %L47
L46:
  %t86 = load %Type, ptr %t3
  %t87 = call i1 @typeIsInteger(%Type %t86)
  store i1 %t87, ptr %t83
  br label %L47
L47:
  %t88 = load i1, ptr %t83
  br i1 %t88, label %L48, label %L49
L48:
  %t89 = load %Type, ptr %t3
  %t90 = call i1 @typeIsSigned(%Type %t89)
  br i1 %t90, label %L51, label %L52
L51:
  store ptr @.str.480, ptr %t22
  br label %L53
L52:
  store ptr @.str.481, ptr %t22
  br label %L53
L53:
  br label %L50
L49:
  %t91 = alloca i1
  %t92 = load %Type, ptr %t2
  %t93 = call i1 @typeIsFloat(%Type %t92)
  store i1 %t93, ptr %t91
  br i1 %t93, label %L54, label %L55
L54:
  %t94 = load %Type, ptr %t3
  %t95 = call i1 @typeIsFloat(%Type %t94)
  store i1 %t95, ptr %t91
  br label %L55
L55:
  %t96 = load i1, ptr %t91
  br i1 %t96, label %L56, label %L57
L56:
  %t97 = load %Type, ptr %t3
  %t98 = call i32 @typeBitWidth(%Type %t97)
  %t99 = load %Type, ptr %t2
  %t100 = call i32 @typeBitWidth(%Type %t99)
  %t101 = icmp sgt i32 %t98, %t100
  br i1 %t101, label %L59, label %L60
L59:
  store ptr @.str.482, ptr %t22
  br label %L61
L60:
  store ptr @.str.483, ptr %t22
  br label %L61
L61:
  br label %L58
L57:
  call void @failAt(i32 0, i32 0, ptr @.str.484)
  br label %L58
L58:
  br label %L50
L50:
  br label %L42
L42:
  br label %L28
L28:
  br label %L23
L23:
  br label %L20
L20:
  br label %L17
L17:
  br label %L12
L12:
  %t102 = call ptr @bufNew()
  %t103 = alloca ptr
  store ptr %t102, ptr %t103
  %t104 = load ptr, ptr %t103
  %t105 = load ptr, ptr %t22
  call void @bufAdd(ptr %t104, ptr %t105)
  %t106 = load ptr, ptr %t103
  call void @bufPush(ptr %t106, i8 32)
  %t107 = load ptr, ptr %t103
  %t108 = load ptr, ptr %t13
  call void @bufAdd(ptr %t107, ptr %t108)
  %t109 = load ptr, ptr %t103
  call void @bufPush(ptr %t109, i8 32)
  %t110 = load ptr, ptr %t103
  %t111 = load ptr, ptr %t1
  call void @bufAdd(ptr %t110, ptr %t111)
  %t112 = load ptr, ptr %t103
  call void @bufAdd(ptr %t112, ptr @.str.485)
  %t113 = load ptr, ptr %t103
  %t114 = load ptr, ptr %t10
  call void @bufAdd(ptr %t113, ptr %t114)
  %t115 = load ptr, ptr %t0
  %t116 = load ptr, ptr %t103
  %t117 = getelementptr inbounds %Buf, ptr %t116, i32 0, i32 0
  %t118 = load ptr, ptr %t117
  %t119 = call ptr @emitAssign(ptr %t115, ptr %t118)
  ret ptr %t119
}

define i1 @isAddressable(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i1
  %t14 = alloca i1
  %t15 = load i32, ptr %t12
  %t16 = load i32, ptr @NK_IDENT
  %t17 = icmp eq i32 %t15, %t16
  store i1 %t17, ptr %t14
  br i1 %t17, label %L1, label %L0
L0:
  %t18 = load i32, ptr %t12
  %t19 = load i32, ptr @NK_FIELDACCESS
  %t20 = icmp eq i32 %t18, %t19
  store i1 %t20, ptr %t14
  br label %L1
L1:
  %t21 = load i1, ptr %t14
  store i1 %t21, ptr %t13
  br i1 %t21, label %L3, label %L2
L2:
  %t22 = load i32, ptr %t12
  %t23 = load i32, ptr @NK_INDEX
  %t24 = icmp eq i32 %t22, %t23
  store i1 %t24, ptr %t13
  br label %L3
L3:
  %t25 = load i1, ptr %t13
  br i1 %t25, label %L4, label %L6
L4:
  ret i1 true
L6:
  %t26 = load i32, ptr %t12
  %t27 = load i32, ptr @NK_UNARY
  %t28 = icmp eq i32 %t26, %t27
  br i1 %t28, label %L7, label %L9
L7:
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Emitter, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = getelementptr inbounds %Ast, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t1
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %Node, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %Node, ptr %t36, i32 0, i32 3
  %t38 = load ptr, ptr %t37
  %t39 = call i1 @textEquals(ptr %t38, ptr @.str.486)
  ret i1 %t39
L9:
  ret i1 false
}

define ptr @genAddress(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @NK_IDENT
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L0, label %L2
L0:
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr %t1
  %t18 = call ptr @variableAddress(ptr %t16, i32 %t17)
  ret ptr %t18
L2:
  %t19 = load i32, ptr %t12
  %t20 = load i32, ptr @NK_FIELDACCESS
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L3, label %L5
L3:
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Emitter, ptr %t22, i32 0, i32 0
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %Ast, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Node, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Node, ptr %t29, i32 0, i32 5
  %t31 = load i32, ptr %t30
  %t32 = alloca i32
  store i32 %t31, ptr %t32
  %t33 = load ptr, ptr %t0
  %t34 = load i32, ptr %t32
  %t35 = call %Type @typeOfNode(ptr %t33, i32 %t34)
  %t36 = alloca %Type
  store %Type %t35, ptr %t36
  %t37 = call ptr @nullText()
  %t38 = alloca ptr
  store ptr %t37, ptr %t38
  %t39 = load %Type, ptr %t36
  %t40 = alloca %Type
  store %Type %t39, ptr %t40
  %t41 = load %Type, ptr %t36
  %t42 = call i1 @typeIsPointer(%Type %t41)
  br i1 %t42, label %L6, label %L7
L6:
  %t43 = load ptr, ptr %t0
  %t44 = load i32, ptr %t32
  %t45 = call ptr @genExpr(ptr %t43, i32 %t44)
  store ptr %t45, ptr %t38
  %t46 = load %Type, ptr %t36
  %t47 = call %Type @typePointee(%Type %t46)
  store %Type %t47, ptr %t40
  br label %L8
L7:
  %t48 = load ptr, ptr %t0
  %t49 = load i32, ptr %t32
  %t50 = call ptr @genAddress(ptr %t48, i32 %t49)
  store ptr %t50, ptr %t38
  br label %L8
L8:
  %t51 = load ptr, ptr %t0
  %t52 = getelementptr inbounds %Emitter, ptr %t51, i32 0, i32 1
  %t53 = load ptr, ptr %t52
  %t54 = getelementptr inbounds %Analyzer, ptr %t53, i32 0, i32 2
  %t55 = load ptr, ptr %t54
  %t56 = getelementptr inbounds %Type, ptr %t40, i32 0, i32 2
  %t57 = load ptr, ptr %t56
  %t58 = call i32 @structIndexOf(ptr %t55, ptr %t57)
  %t59 = alloca i32
  store i32 %t58, ptr %t59
  %t60 = load ptr, ptr %t0
  %t61 = getelementptr inbounds %Emitter, ptr %t60, i32 0, i32 1
  %t62 = load ptr, ptr %t61
  %t63 = getelementptr inbounds %Analyzer, ptr %t62, i32 0, i32 2
  %t64 = load ptr, ptr %t63
  %t65 = load i32, ptr %t59
  %t66 = load ptr, ptr %t0
  %t67 = getelementptr inbounds %Emitter, ptr %t66, i32 0, i32 0
  %t68 = load ptr, ptr %t67
  %t69 = getelementptr inbounds %Ast, ptr %t68, i32 0, i32 0
  %t70 = load ptr, ptr %t69
  %t71 = load i32, ptr %t1
  %t72 = sext i32 %t71 to i64
  %t73 = getelementptr inbounds %Node, ptr %t70, i64 %t72
  %t74 = getelementptr inbounds %Node, ptr %t73, i32 0, i32 3
  %t75 = load ptr, ptr %t74
  %t76 = call i32 @structFieldIndex(ptr %t64, i32 %t65, ptr %t75)
  %t77 = alloca i32
  store i32 %t76, ptr %t77
  %t78 = call ptr @bufNew()
  %t79 = alloca ptr
  store ptr %t78, ptr %t79
  %t80 = load ptr, ptr %t79
  call void @bufAdd(ptr %t80, ptr @.str.487)
  %t81 = load ptr, ptr %t79
  %t82 = load %Type, ptr %t40
  %t83 = call ptr @llvmTypeName(%Type %t82)
  call void @bufAdd(ptr %t81, ptr %t83)
  %t84 = load ptr, ptr %t79
  call void @bufAdd(ptr %t84, ptr @.str.488)
  %t85 = load ptr, ptr %t79
  %t86 = load ptr, ptr %t38
  call void @bufAdd(ptr %t85, ptr %t86)
  %t87 = load ptr, ptr %t79
  call void @bufAdd(ptr %t87, ptr @.str.489)
  %t88 = load ptr, ptr %t79
  %t89 = load i32, ptr %t77
  %t90 = sext i32 %t89 to i64
  call void @bufAddInt(ptr %t88, i64 %t90)
  %t91 = load ptr, ptr %t0
  %t92 = load ptr, ptr %t79
  %t93 = getelementptr inbounds %Buf, ptr %t92, i32 0, i32 0
  %t94 = load ptr, ptr %t93
  %t95 = call ptr @emitAssign(ptr %t91, ptr %t94)
  ret ptr %t95
L5:
  %t96 = load i32, ptr %t12
  %t97 = load i32, ptr @NK_INDEX
  %t98 = icmp eq i32 %t96, %t97
  br i1 %t98, label %L9, label %L11
L9:
  %t99 = load ptr, ptr %t0
  %t100 = getelementptr inbounds %Emitter, ptr %t99, i32 0, i32 0
  %t101 = load ptr, ptr %t100
  %t102 = getelementptr inbounds %Ast, ptr %t101, i32 0, i32 0
  %t103 = load ptr, ptr %t102
  %t104 = load i32, ptr %t1
  %t105 = sext i32 %t104 to i64
  %t106 = getelementptr inbounds %Node, ptr %t103, i64 %t105
  %t107 = getelementptr inbounds %Node, ptr %t106, i32 0, i32 5
  %t108 = load i32, ptr %t107
  %t109 = alloca i32
  store i32 %t108, ptr %t109
  %t110 = load ptr, ptr %t0
  %t111 = load i32, ptr %t109
  %t112 = call %Type @typeOfNode(ptr %t110, i32 %t111)
  %t113 = alloca %Type
  store %Type %t112, ptr %t113
  %t114 = load ptr, ptr %t0
  %t115 = load i32, ptr %t109
  %t116 = call ptr @genExpr(ptr %t114, i32 %t115)
  %t117 = alloca ptr
  store ptr %t116, ptr %t117
  %t118 = load ptr, ptr %t0
  %t119 = getelementptr inbounds %Emitter, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = getelementptr inbounds %Ast, ptr %t120, i32 0, i32 0
  %t122 = load ptr, ptr %t121
  %t123 = load i32, ptr %t1
  %t124 = sext i32 %t123 to i64
  %t125 = getelementptr inbounds %Node, ptr %t122, i64 %t124
  %t126 = getelementptr inbounds %Node, ptr %t125, i32 0, i32 6
  %t127 = load i32, ptr %t126
  %t128 = alloca i32
  store i32 %t127, ptr %t128
  %t129 = load ptr, ptr %t0
  %t130 = load ptr, ptr %t0
  %t131 = load i32, ptr %t128
  %t132 = call ptr @genExpr(ptr %t130, i32 %t131)
  %t133 = load ptr, ptr %t0
  %t134 = load i32, ptr %t128
  %t135 = call %Type @typeOfNode(ptr %t133, i32 %t134)
  %t136 = load i32, ptr @TY_I64
  %t137 = call %Type @typeMake(i32 %t136, i32 0)
  %t138 = call ptr @emitCast(ptr %t129, ptr %t132, %Type %t135, %Type %t137)
  %t139 = alloca ptr
  store ptr %t138, ptr %t139
  %t140 = call ptr @bufNew()
  %t141 = alloca ptr
  store ptr %t140, ptr %t141
  %t142 = load ptr, ptr %t141
  call void @bufAdd(ptr %t142, ptr @.str.490)
  %t143 = load ptr, ptr %t141
  %t144 = load %Type, ptr %t113
  %t145 = call %Type @typePointee(%Type %t144)
  %t146 = call ptr @llvmTypeName(%Type %t145)
  call void @bufAdd(ptr %t143, ptr %t146)
  %t147 = load ptr, ptr %t141
  call void @bufAdd(ptr %t147, ptr @.str.491)
  %t148 = load ptr, ptr %t141
  %t149 = load ptr, ptr %t117
  call void @bufAdd(ptr %t148, ptr %t149)
  %t150 = load ptr, ptr %t141
  call void @bufAdd(ptr %t150, ptr @.str.492)
  %t151 = load ptr, ptr %t141
  %t152 = load ptr, ptr %t139
  call void @bufAdd(ptr %t151, ptr %t152)
  %t153 = load ptr, ptr %t0
  %t154 = load ptr, ptr %t141
  %t155 = getelementptr inbounds %Buf, ptr %t154, i32 0, i32 0
  %t156 = load ptr, ptr %t155
  %t157 = call ptr @emitAssign(ptr %t153, ptr %t156)
  ret ptr %t157
L11:
  %t158 = load i32, ptr %t12
  %t159 = load i32, ptr @NK_UNARY
  %t160 = icmp eq i32 %t158, %t159
  br i1 %t160, label %L12, label %L14
L12:
  %t161 = load ptr, ptr %t0
  %t162 = load ptr, ptr %t0
  %t163 = getelementptr inbounds %Emitter, ptr %t162, i32 0, i32 0
  %t164 = load ptr, ptr %t163
  %t165 = getelementptr inbounds %Ast, ptr %t164, i32 0, i32 0
  %t166 = load ptr, ptr %t165
  %t167 = load i32, ptr %t1
  %t168 = sext i32 %t167 to i64
  %t169 = getelementptr inbounds %Node, ptr %t166, i64 %t168
  %t170 = getelementptr inbounds %Node, ptr %t169, i32 0, i32 5
  %t171 = load i32, ptr %t170
  %t172 = call ptr @genExpr(ptr %t161, i32 %t171)
  ret ptr %t172
L14:
  %t173 = load ptr, ptr %t0
  %t174 = getelementptr inbounds %Emitter, ptr %t173, i32 0, i32 0
  %t175 = load ptr, ptr %t174
  %t176 = getelementptr inbounds %Ast, ptr %t175, i32 0, i32 0
  %t177 = load ptr, ptr %t176
  %t178 = load i32, ptr %t1
  %t179 = sext i32 %t178 to i64
  %t180 = getelementptr inbounds %Node, ptr %t177, i64 %t179
  %t181 = getelementptr inbounds %Node, ptr %t180, i32 0, i32 1
  %t182 = load i32, ptr %t181
  %t183 = load ptr, ptr %t0
  %t184 = getelementptr inbounds %Emitter, ptr %t183, i32 0, i32 0
  %t185 = load ptr, ptr %t184
  %t186 = getelementptr inbounds %Ast, ptr %t185, i32 0, i32 0
  %t187 = load ptr, ptr %t186
  %t188 = load i32, ptr %t1
  %t189 = sext i32 %t188 to i64
  %t190 = getelementptr inbounds %Node, ptr %t187, i64 %t189
  %t191 = getelementptr inbounds %Node, ptr %t190, i32 0, i32 2
  %t192 = load i32, ptr %t191
  call void @failAt(i32 %t182, i32 %t192, ptr @.str.493)
  %t193 = call ptr @nullText()
  ret ptr %t193
}

define ptr @genShortCircuit(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = call i1 @textEquals(ptr %t11, ptr @.str.494)
  %t13 = alloca i1
  store i1 %t12, ptr %t13
  %t14 = load ptr, ptr %t0
  %t15 = call ptr @emitAssign(ptr %t14, ptr @.str.495)
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %Emitter, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t1
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 5
  %t27 = load i32, ptr %t26
  %t28 = call ptr @genExpr(ptr %t17, i32 %t27)
  %t29 = alloca ptr
  store ptr %t28, ptr %t29
  %t30 = load ptr, ptr %t0
  %t31 = load i32, ptr @TY_BOOL
  %t32 = call %Type @typeMake(i32 %t31, i32 0)
  %t33 = load ptr, ptr %t29
  %t34 = load ptr, ptr %t16
  call void @emitStore(ptr %t30, %Type %t32, ptr %t33, ptr %t34)
  %t35 = load ptr, ptr %t0
  %t36 = call ptr @freshLabel(ptr %t35)
  %t37 = alloca ptr
  store ptr %t36, ptr %t37
  %t38 = load ptr, ptr %t0
  %t39 = call ptr @freshLabel(ptr %t38)
  %t40 = alloca ptr
  store ptr %t39, ptr %t40
  %t41 = load i1, ptr %t13
  br i1 %t41, label %L0, label %L1
L0:
  %t42 = load ptr, ptr %t0
  %t43 = load ptr, ptr %t29
  %t44 = load ptr, ptr %t37
  %t45 = load ptr, ptr %t40
  call void @emitCondBranch(ptr %t42, ptr %t43, ptr %t44, ptr %t45)
  br label %L2
L1:
  %t46 = load ptr, ptr %t0
  %t47 = load ptr, ptr %t29
  %t48 = load ptr, ptr %t40
  %t49 = load ptr, ptr %t37
  call void @emitCondBranch(ptr %t46, ptr %t47, ptr %t48, ptr %t49)
  br label %L2
L2:
  %t50 = load ptr, ptr %t0
  %t51 = load ptr, ptr %t37
  call void @emitLabel(ptr %t50, ptr %t51)
  %t52 = load ptr, ptr %t0
  %t53 = load ptr, ptr %t0
  %t54 = getelementptr inbounds %Emitter, ptr %t53, i32 0, i32 0
  %t55 = load ptr, ptr %t54
  %t56 = getelementptr inbounds %Ast, ptr %t55, i32 0, i32 0
  %t57 = load ptr, ptr %t56
  %t58 = load i32, ptr %t1
  %t59 = sext i32 %t58 to i64
  %t60 = getelementptr inbounds %Node, ptr %t57, i64 %t59
  %t61 = getelementptr inbounds %Node, ptr %t60, i32 0, i32 6
  %t62 = load i32, ptr %t61
  %t63 = call ptr @genExpr(ptr %t52, i32 %t62)
  %t64 = alloca ptr
  store ptr %t63, ptr %t64
  %t65 = load ptr, ptr %t0
  %t66 = load i32, ptr @TY_BOOL
  %t67 = call %Type @typeMake(i32 %t66, i32 0)
  %t68 = load ptr, ptr %t64
  %t69 = load ptr, ptr %t16
  call void @emitStore(ptr %t65, %Type %t67, ptr %t68, ptr %t69)
  %t70 = load ptr, ptr %t0
  %t71 = load ptr, ptr %t40
  call void @emitBranch(ptr %t70, ptr %t71)
  %t72 = load ptr, ptr %t0
  %t73 = load ptr, ptr %t40
  call void @emitLabel(ptr %t72, ptr %t73)
  %t74 = load ptr, ptr %t0
  %t75 = load i32, ptr @TY_BOOL
  %t76 = call %Type @typeMake(i32 %t75, i32 0)
  %t77 = load ptr, ptr %t16
  %t78 = call ptr @emitLoad(ptr %t74, %Type %t76, ptr %t77)
  ret ptr %t78
}

define ptr @genPointerArithmetic(ptr %p0, i32 %p1, ptr %p2, ptr %p3, %Type %p4, %Type %p5) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = alloca %Type
  store %Type %p4, ptr %t4
  %t5 = alloca %Type
  store %Type %p5, ptr %t5
  %t6 = load i32, ptr @TY_I64
  %t7 = call %Type @typeMake(i32 %t6, i32 0)
  %t8 = alloca %Type
  store %Type %t7, ptr %t8
  %t9 = alloca i1
  %t10 = load %Type, ptr %t4
  %t11 = call i1 @typeIsPointer(%Type %t10)
  store i1 %t11, ptr %t9
  br i1 %t11, label %L0, label %L1
L0:
  %t12 = load %Type, ptr %t5
  %t13 = call i1 @typeIsPointer(%Type %t12)
  store i1 %t13, ptr %t9
  br label %L1
L1:
  %t14 = load i1, ptr %t9
  br i1 %t14, label %L2, label %L4
L2:
  %t15 = load ptr, ptr %t0
  %t16 = load ptr, ptr %t2
  %t17 = load %Type, ptr %t4
  %t18 = load %Type, ptr %t8
  %t19 = call ptr @emitCast(ptr %t15, ptr %t16, %Type %t17, %Type %t18)
  %t20 = alloca ptr
  store ptr %t19, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = load ptr, ptr %t3
  %t23 = load %Type, ptr %t5
  %t24 = load %Type, ptr %t8
  %t25 = call ptr @emitCast(ptr %t21, ptr %t22, %Type %t23, %Type %t24)
  %t26 = alloca ptr
  store ptr %t25, ptr %t26
  %t27 = call ptr @bufNew()
  %t28 = alloca ptr
  store ptr %t27, ptr %t28
  %t29 = load ptr, ptr %t28
  call void @bufAdd(ptr %t29, ptr @.str.496)
  %t30 = load ptr, ptr %t28
  %t31 = load ptr, ptr %t20
  call void @bufAdd(ptr %t30, ptr %t31)
  %t32 = load ptr, ptr %t28
  call void @bufAdd(ptr %t32, ptr @.str.497)
  %t33 = load ptr, ptr %t28
  %t34 = load ptr, ptr %t26
  call void @bufAdd(ptr %t33, ptr %t34)
  %t35 = load ptr, ptr %t0
  %t36 = load ptr, ptr %t28
  %t37 = getelementptr inbounds %Buf, ptr %t36, i32 0, i32 0
  %t38 = load ptr, ptr %t37
  %t39 = call ptr @emitAssign(ptr %t35, ptr %t38)
  %t40 = alloca ptr
  store ptr %t39, ptr %t40
  %t41 = load ptr, ptr %t0
  %t42 = load %Type, ptr %t4
  %t43 = call %Type @typePointee(%Type %t42)
  %t44 = call i32 @sizeOfType(ptr %t41, %Type %t43)
  %t45 = alloca i32
  store i32 %t44, ptr %t45
  %t46 = load i32, ptr %t45
  %t47 = icmp sle i32 %t46, 1
  br i1 %t47, label %L5, label %L7
L5:
  %t48 = load ptr, ptr %t40
  ret ptr %t48
L7:
  %t49 = call ptr @bufNew()
  %t50 = alloca ptr
  store ptr %t49, ptr %t50
  %t51 = load ptr, ptr %t50
  call void @bufAdd(ptr %t51, ptr @.str.498)
  %t52 = load ptr, ptr %t50
  %t53 = load ptr, ptr %t40
  call void @bufAdd(ptr %t52, ptr %t53)
  %t54 = load ptr, ptr %t50
  call void @bufAdd(ptr %t54, ptr @.str.499)
  %t55 = load ptr, ptr %t50
  %t56 = load i32, ptr %t45
  %t57 = sext i32 %t56 to i64
  call void @bufAddInt(ptr %t55, i64 %t57)
  %t58 = load ptr, ptr %t0
  %t59 = load ptr, ptr %t50
  %t60 = getelementptr inbounds %Buf, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = call ptr @emitAssign(ptr %t58, ptr %t61)
  ret ptr %t62
L4:
  %t63 = load ptr, ptr %t2
  %t64 = alloca ptr
  store ptr %t63, ptr %t64
  %t65 = load ptr, ptr %t3
  %t66 = alloca ptr
  store ptr %t65, ptr %t66
  %t67 = load %Type, ptr %t4
  %t68 = alloca %Type
  store %Type %t67, ptr %t68
  %t69 = load %Type, ptr %t5
  %t70 = alloca %Type
  store %Type %t69, ptr %t70
  %t71 = load %Type, ptr %t4
  %t72 = call i1 @typeIsPointer(%Type %t71)
  %t73 = xor i1 %t72, true
  br i1 %t73, label %L8, label %L10
L8:
  %t74 = load ptr, ptr %t3
  store ptr %t74, ptr %t64
  %t75 = load ptr, ptr %t2
  store ptr %t75, ptr %t66
  %t76 = load %Type, ptr %t5
  store %Type %t76, ptr %t68
  %t77 = load %Type, ptr %t4
  store %Type %t77, ptr %t70
  br label %L10
L10:
  %t78 = load ptr, ptr %t0
  %t79 = load ptr, ptr %t66
  %t80 = load %Type, ptr %t70
  %t81 = load %Type, ptr %t8
  %t82 = call ptr @emitCast(ptr %t78, ptr %t79, %Type %t80, %Type %t81)
  store ptr %t82, ptr %t66
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr inbounds %Emitter, ptr %t83, i32 0, i32 0
  %t85 = load ptr, ptr %t84
  %t86 = getelementptr inbounds %Ast, ptr %t85, i32 0, i32 0
  %t87 = load ptr, ptr %t86
  %t88 = load i32, ptr %t1
  %t89 = sext i32 %t88 to i64
  %t90 = getelementptr inbounds %Node, ptr %t87, i64 %t89
  %t91 = getelementptr inbounds %Node, ptr %t90, i32 0, i32 3
  %t92 = load ptr, ptr %t91
  %t93 = call i1 @textEquals(ptr %t92, ptr @.str.500)
  br i1 %t93, label %L11, label %L13
L11:
  %t94 = call ptr @bufNew()
  %t95 = alloca ptr
  store ptr %t94, ptr %t95
  %t96 = load ptr, ptr %t95
  call void @bufAdd(ptr %t96, ptr @.str.501)
  %t97 = load ptr, ptr %t95
  %t98 = load ptr, ptr %t66
  call void @bufAdd(ptr %t97, ptr %t98)
  %t99 = load ptr, ptr %t0
  %t100 = load ptr, ptr %t95
  %t101 = getelementptr inbounds %Buf, ptr %t100, i32 0, i32 0
  %t102 = load ptr, ptr %t101
  %t103 = call ptr @emitAssign(ptr %t99, ptr %t102)
  store ptr %t103, ptr %t66
  br label %L13
L13:
  %t104 = call ptr @bufNew()
  %t105 = alloca ptr
  store ptr %t104, ptr %t105
  %t106 = load ptr, ptr %t105
  call void @bufAdd(ptr %t106, ptr @.str.502)
  %t107 = load ptr, ptr %t105
  %t108 = load %Type, ptr %t68
  %t109 = call %Type @typePointee(%Type %t108)
  %t110 = call ptr @llvmTypeName(%Type %t109)
  call void @bufAdd(ptr %t107, ptr %t110)
  %t111 = load ptr, ptr %t105
  call void @bufAdd(ptr %t111, ptr @.str.503)
  %t112 = load ptr, ptr %t105
  %t113 = load ptr, ptr %t64
  call void @bufAdd(ptr %t112, ptr %t113)
  %t114 = load ptr, ptr %t105
  call void @bufAdd(ptr %t114, ptr @.str.504)
  %t115 = load ptr, ptr %t105
  %t116 = load ptr, ptr %t66
  call void @bufAdd(ptr %t115, ptr %t116)
  %t117 = load ptr, ptr %t0
  %t118 = load ptr, ptr %t105
  %t119 = getelementptr inbounds %Buf, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = call ptr @emitAssign(ptr %t117, ptr %t120)
  ret ptr %t121
}

define ptr @binaryOpcode(ptr %p0, %Type %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca %Type
  store %Type %p1, ptr %t1
  %t2 = load %Type, ptr %t1
  %t3 = call i1 @typeIsFloat(%Type %t2)
  %t4 = alloca i1
  store i1 %t3, ptr %t4
  %t5 = load %Type, ptr %t1
  %t6 = call i1 @typeIsSigned(%Type %t5)
  %t7 = alloca i1
  store i1 %t6, ptr %t7
  %t8 = load ptr, ptr %t0
  %t9 = call i1 @textEquals(ptr %t8, ptr @.str.505)
  br i1 %t9, label %L0, label %L2
L0:
  %t10 = load i1, ptr %t4
  br i1 %t10, label %L3, label %L5
L3:
  ret ptr @.str.506
L5:
  ret ptr @.str.507
L2:
  %t11 = load ptr, ptr %t0
  %t12 = call i1 @textEquals(ptr %t11, ptr @.str.508)
  br i1 %t12, label %L6, label %L8
L6:
  %t13 = load i1, ptr %t4
  br i1 %t13, label %L9, label %L11
L9:
  ret ptr @.str.509
L11:
  ret ptr @.str.510
L8:
  %t14 = load ptr, ptr %t0
  %t15 = call i1 @textEquals(ptr %t14, ptr @.str.511)
  br i1 %t15, label %L12, label %L14
L12:
  %t16 = load i1, ptr %t4
  br i1 %t16, label %L15, label %L17
L15:
  ret ptr @.str.512
L17:
  ret ptr @.str.513
L14:
  %t17 = load ptr, ptr %t0
  %t18 = call i1 @textEquals(ptr %t17, ptr @.str.514)
  br i1 %t18, label %L18, label %L20
L18:
  %t19 = load i1, ptr %t4
  br i1 %t19, label %L21, label %L23
L21:
  ret ptr @.str.515
L23:
  %t20 = load i1, ptr %t7
  br i1 %t20, label %L24, label %L26
L24:
  ret ptr @.str.516
L26:
  ret ptr @.str.517
L20:
  %t21 = load ptr, ptr %t0
  %t22 = call i1 @textEquals(ptr %t21, ptr @.str.518)
  br i1 %t22, label %L27, label %L29
L27:
  %t23 = load i1, ptr %t7
  br i1 %t23, label %L30, label %L32
L30:
  ret ptr @.str.519
L32:
  ret ptr @.str.520
L29:
  %t24 = load ptr, ptr %t0
  %t25 = call i1 @textEquals(ptr %t24, ptr @.str.521)
  br i1 %t25, label %L33, label %L35
L33:
  ret ptr @.str.522
L35:
  %t26 = load ptr, ptr %t0
  %t27 = call i1 @textEquals(ptr %t26, ptr @.str.523)
  br i1 %t27, label %L36, label %L38
L36:
  ret ptr @.str.524
L38:
  %t28 = load ptr, ptr %t0
  %t29 = call i1 @textEquals(ptr %t28, ptr @.str.525)
  br i1 %t29, label %L39, label %L41
L39:
  ret ptr @.str.526
L41:
  %t30 = load ptr, ptr %t0
  %t31 = call i1 @textEquals(ptr %t30, ptr @.str.527)
  br i1 %t31, label %L42, label %L44
L42:
  ret ptr @.str.528
L44:
  %t32 = load ptr, ptr %t0
  %t33 = call i1 @textEquals(ptr %t32, ptr @.str.529)
  br i1 %t33, label %L45, label %L47
L45:
  %t34 = load i1, ptr %t7
  br i1 %t34, label %L48, label %L50
L48:
  ret ptr @.str.530
L50:
  ret ptr @.str.531
L47:
  %t35 = load ptr, ptr %t0
  %t36 = call i1 @textEquals(ptr %t35, ptr @.str.532)
  br i1 %t36, label %L51, label %L53
L51:
  %t37 = load i1, ptr %t4
  br i1 %t37, label %L54, label %L56
L54:
  ret ptr @.str.533
L56:
  ret ptr @.str.534
L53:
  %t38 = load ptr, ptr %t0
  %t39 = call i1 @textEquals(ptr %t38, ptr @.str.535)
  br i1 %t39, label %L57, label %L59
L57:
  %t40 = load i1, ptr %t4
  br i1 %t40, label %L60, label %L62
L60:
  ret ptr @.str.536
L62:
  ret ptr @.str.537
L59:
  %t41 = load ptr, ptr %t0
  %t42 = call i1 @textEquals(ptr %t41, ptr @.str.538)
  br i1 %t42, label %L63, label %L65
L63:
  %t43 = load i1, ptr %t4
  br i1 %t43, label %L66, label %L68
L66:
  ret ptr @.str.539
L68:
  %t44 = load i1, ptr %t7
  br i1 %t44, label %L69, label %L71
L69:
  ret ptr @.str.540
L71:
  ret ptr @.str.541
L65:
  %t45 = load ptr, ptr %t0
  %t46 = call i1 @textEquals(ptr %t45, ptr @.str.542)
  br i1 %t46, label %L72, label %L74
L72:
  %t47 = load i1, ptr %t4
  br i1 %t47, label %L75, label %L77
L75:
  ret ptr @.str.543
L77:
  %t48 = load i1, ptr %t7
  br i1 %t48, label %L78, label %L80
L78:
  ret ptr @.str.544
L80:
  ret ptr @.str.545
L74:
  %t49 = load ptr, ptr %t0
  %t50 = call i1 @textEquals(ptr %t49, ptr @.str.546)
  br i1 %t50, label %L81, label %L83
L81:
  %t51 = load i1, ptr %t4
  br i1 %t51, label %L84, label %L86
L84:
  ret ptr @.str.547
L86:
  %t52 = load i1, ptr %t7
  br i1 %t52, label %L87, label %L89
L87:
  ret ptr @.str.548
L89:
  ret ptr @.str.549
L83:
  %t53 = load ptr, ptr %t0
  %t54 = call i1 @textEquals(ptr %t53, ptr @.str.550)
  br i1 %t54, label %L90, label %L92
L90:
  %t55 = load i1, ptr %t4
  br i1 %t55, label %L93, label %L95
L93:
  ret ptr @.str.551
L95:
  %t56 = load i1, ptr %t7
  br i1 %t56, label %L96, label %L98
L96:
  ret ptr @.str.552
L98:
  ret ptr @.str.553
L92:
  ret ptr @.str.554
}

define ptr @genBinary(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = alloca i1
  %t14 = load ptr, ptr %t12
  %t15 = call i1 @textEquals(ptr %t14, ptr @.str.555)
  store i1 %t15, ptr %t13
  br i1 %t15, label %L1, label %L0
L0:
  %t16 = load ptr, ptr %t12
  %t17 = call i1 @textEquals(ptr %t16, ptr @.str.556)
  store i1 %t17, ptr %t13
  br label %L1
L1:
  %t18 = load i1, ptr %t13
  br i1 %t18, label %L2, label %L4
L2:
  %t19 = load ptr, ptr %t0
  %t20 = load i32, ptr %t1
  %t21 = call ptr @genShortCircuit(ptr %t19, i32 %t20)
  ret ptr %t21
L4:
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Emitter, ptr %t22, i32 0, i32 0
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %Ast, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Node, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Node, ptr %t29, i32 0, i32 5
  %t31 = load i32, ptr %t30
  %t32 = alloca i32
  store i32 %t31, ptr %t32
  %t33 = load ptr, ptr %t0
  %t34 = getelementptr inbounds %Emitter, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = getelementptr inbounds %Ast, ptr %t35, i32 0, i32 0
  %t37 = load ptr, ptr %t36
  %t38 = load i32, ptr %t1
  %t39 = sext i32 %t38 to i64
  %t40 = getelementptr inbounds %Node, ptr %t37, i64 %t39
  %t41 = getelementptr inbounds %Node, ptr %t40, i32 0, i32 6
  %t42 = load i32, ptr %t41
  %t43 = alloca i32
  store i32 %t42, ptr %t43
  %t44 = load ptr, ptr %t0
  %t45 = load i32, ptr %t32
  %t46 = call %Type @typeOfNode(ptr %t44, i32 %t45)
  %t47 = alloca %Type
  store %Type %t46, ptr %t47
  %t48 = load ptr, ptr %t0
  %t49 = load i32, ptr %t43
  %t50 = call %Type @typeOfNode(ptr %t48, i32 %t49)
  %t51 = alloca %Type
  store %Type %t50, ptr %t51
  %t52 = load ptr, ptr %t0
  %t53 = load i32, ptr %t32
  %t54 = call ptr @genExpr(ptr %t52, i32 %t53)
  %t55 = alloca ptr
  store ptr %t54, ptr %t55
  %t56 = load ptr, ptr %t0
  %t57 = load i32, ptr %t43
  %t58 = call ptr @genExpr(ptr %t56, i32 %t57)
  %t59 = alloca ptr
  store ptr %t58, ptr %t59
  %t60 = alloca i1
  %t61 = load %Type, ptr %t47
  %t62 = call i1 @typeIsPointer(%Type %t61)
  store i1 %t62, ptr %t60
  br i1 %t62, label %L6, label %L5
L5:
  %t63 = load %Type, ptr %t51
  %t64 = call i1 @typeIsPointer(%Type %t63)
  store i1 %t64, ptr %t60
  br label %L6
L6:
  %t65 = load i1, ptr %t60
  br i1 %t65, label %L7, label %L9
L7:
  %t66 = alloca i1
  %t67 = alloca i1
  %t68 = alloca i1
  %t69 = alloca i1
  %t70 = alloca i1
  %t71 = load ptr, ptr %t12
  %t72 = call i1 @textEquals(ptr %t71, ptr @.str.557)
  %t73 = xor i1 %t72, true
  store i1 %t73, ptr %t70
  br i1 %t73, label %L10, label %L11
L10:
  %t74 = load ptr, ptr %t12
  %t75 = call i1 @textEquals(ptr %t74, ptr @.str.558)
  %t76 = xor i1 %t75, true
  store i1 %t76, ptr %t70
  br label %L11
L11:
  %t77 = load i1, ptr %t70
  store i1 %t77, ptr %t69
  br i1 %t77, label %L12, label %L13
L12:
  %t78 = load ptr, ptr %t12
  %t79 = call i1 @textEquals(ptr %t78, ptr @.str.559)
  %t80 = xor i1 %t79, true
  store i1 %t80, ptr %t69
  br label %L13
L13:
  %t81 = load i1, ptr %t69
  store i1 %t81, ptr %t68
  br i1 %t81, label %L14, label %L15
L14:
  %t82 = load ptr, ptr %t12
  %t83 = call i1 @textEquals(ptr %t82, ptr @.str.560)
  %t84 = xor i1 %t83, true
  store i1 %t84, ptr %t68
  br label %L15
L15:
  %t85 = load i1, ptr %t68
  store i1 %t85, ptr %t67
  br i1 %t85, label %L16, label %L17
L16:
  %t86 = load ptr, ptr %t12
  %t87 = call i1 @textEquals(ptr %t86, ptr @.str.561)
  %t88 = xor i1 %t87, true
  store i1 %t88, ptr %t67
  br label %L17
L17:
  %t89 = load i1, ptr %t67
  store i1 %t89, ptr %t66
  br i1 %t89, label %L18, label %L19
L18:
  %t90 = load ptr, ptr %t12
  %t91 = call i1 @textEquals(ptr %t90, ptr @.str.562)
  %t92 = xor i1 %t91, true
  store i1 %t92, ptr %t66
  br label %L19
L19:
  %t93 = load i1, ptr %t66
  br i1 %t93, label %L20, label %L22
L20:
  %t94 = load ptr, ptr %t0
  %t95 = load i32, ptr %t1
  %t96 = load ptr, ptr %t55
  %t97 = load ptr, ptr %t59
  %t98 = load %Type, ptr %t47
  %t99 = load %Type, ptr %t51
  %t100 = call ptr @genPointerArithmetic(ptr %t94, i32 %t95, ptr %t96, ptr %t97, %Type %t98, %Type %t99)
  ret ptr %t100
L22:
  br label %L9
L9:
  %t101 = call ptr @bufNew()
  %t102 = alloca ptr
  store ptr %t101, ptr %t102
  %t103 = load ptr, ptr %t102
  %t104 = load ptr, ptr %t12
  %t105 = load %Type, ptr %t47
  %t106 = call ptr @binaryOpcode(ptr %t104, %Type %t105)
  call void @bufAdd(ptr %t103, ptr %t106)
  %t107 = load ptr, ptr %t102
  call void @bufPush(ptr %t107, i8 32)
  %t108 = load ptr, ptr %t102
  %t109 = load %Type, ptr %t47
  %t110 = call ptr @llvmTypeName(%Type %t109)
  call void @bufAdd(ptr %t108, ptr %t110)
  %t111 = load ptr, ptr %t102
  call void @bufPush(ptr %t111, i8 32)
  %t112 = load ptr, ptr %t102
  %t113 = load ptr, ptr %t55
  call void @bufAdd(ptr %t112, ptr %t113)
  %t114 = load ptr, ptr %t102
  call void @bufAdd(ptr %t114, ptr @.str.563)
  %t115 = load ptr, ptr %t102
  %t116 = load ptr, ptr %t59
  call void @bufAdd(ptr %t115, ptr %t116)
  %t117 = load ptr, ptr %t0
  %t118 = load ptr, ptr %t102
  %t119 = getelementptr inbounds %Buf, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = call ptr @emitAssign(ptr %t117, ptr %t120)
  ret ptr %t121
}

define ptr @genUnary(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = getelementptr inbounds %Emitter, ptr %t13, i32 0, i32 0
  %t15 = load ptr, ptr %t14
  %t16 = getelementptr inbounds %Ast, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load i32, ptr %t1
  %t19 = sext i32 %t18 to i64
  %t20 = getelementptr inbounds %Node, ptr %t17, i64 %t19
  %t21 = getelementptr inbounds %Node, ptr %t20, i32 0, i32 5
  %t22 = load i32, ptr %t21
  %t23 = alloca i32
  store i32 %t22, ptr %t23
  %t24 = load ptr, ptr %t12
  %t25 = call i1 @textEquals(ptr %t24, ptr @.str.564)
  br i1 %t25, label %L0, label %L2
L0:
  %t26 = load ptr, ptr %t0
  %t27 = load i32, ptr %t23
  %t28 = call ptr @genAddress(ptr %t26, i32 %t27)
  ret ptr %t28
L2:
  %t29 = load ptr, ptr %t12
  %t30 = call i1 @textEquals(ptr %t29, ptr @.str.565)
  br i1 %t30, label %L3, label %L5
L3:
  %t31 = load ptr, ptr %t0
  %t32 = load ptr, ptr %t0
  %t33 = load i32, ptr %t1
  %t34 = call %Type @typeOfNode(ptr %t32, i32 %t33)
  %t35 = load ptr, ptr %t0
  %t36 = load i32, ptr %t23
  %t37 = call ptr @genExpr(ptr %t35, i32 %t36)
  %t38 = call ptr @emitLoad(ptr %t31, %Type %t34, ptr %t37)
  ret ptr %t38
L5:
  %t39 = load ptr, ptr %t0
  %t40 = load i32, ptr %t23
  %t41 = call %Type @typeOfNode(ptr %t39, i32 %t40)
  %t42 = alloca %Type
  store %Type %t41, ptr %t42
  %t43 = load ptr, ptr %t0
  %t44 = load i32, ptr %t23
  %t45 = call ptr @genExpr(ptr %t43, i32 %t44)
  %t46 = alloca ptr
  store ptr %t45, ptr %t46
  %t47 = load ptr, ptr %t12
  %t48 = call i1 @textEquals(ptr %t47, ptr @.str.566)
  br i1 %t48, label %L6, label %L8
L6:
  %t49 = load ptr, ptr %t46
  ret ptr %t49
L8:
  %t50 = load ptr, ptr %t12
  %t51 = call i1 @textEquals(ptr %t50, ptr @.str.567)
  br i1 %t51, label %L9, label %L11
L9:
  %t52 = call ptr @bufNew()
  %t53 = alloca ptr
  store ptr %t52, ptr %t53
  %t54 = load %Type, ptr %t42
  %t55 = call i1 @typeIsFloat(%Type %t54)
  br i1 %t55, label %L12, label %L13
L12:
  %t56 = load ptr, ptr %t53
  call void @bufAdd(ptr %t56, ptr @.str.568)
  %t57 = load ptr, ptr %t53
  %t58 = load %Type, ptr %t42
  %t59 = call ptr @llvmTypeName(%Type %t58)
  call void @bufAdd(ptr %t57, ptr %t59)
  %t60 = load ptr, ptr %t53
  call void @bufPush(ptr %t60, i8 32)
  %t61 = load ptr, ptr %t53
  %t62 = load ptr, ptr %t46
  call void @bufAdd(ptr %t61, ptr %t62)
  br label %L14
L13:
  %t63 = load ptr, ptr %t53
  call void @bufAdd(ptr %t63, ptr @.str.569)
  %t64 = load ptr, ptr %t53
  %t65 = load %Type, ptr %t42
  %t66 = call ptr @llvmTypeName(%Type %t65)
  call void @bufAdd(ptr %t64, ptr %t66)
  %t67 = load ptr, ptr %t53
  call void @bufAdd(ptr %t67, ptr @.str.570)
  %t68 = load ptr, ptr %t53
  %t69 = load ptr, ptr %t46
  call void @bufAdd(ptr %t68, ptr %t69)
  br label %L14
L14:
  %t70 = load ptr, ptr %t0
  %t71 = load ptr, ptr %t53
  %t72 = getelementptr inbounds %Buf, ptr %t71, i32 0, i32 0
  %t73 = load ptr, ptr %t72
  %t74 = call ptr @emitAssign(ptr %t70, ptr %t73)
  ret ptr %t74
L11:
  %t75 = call ptr @bufNew()
  %t76 = alloca ptr
  store ptr %t75, ptr %t76
  %t77 = load ptr, ptr %t76
  call void @bufAdd(ptr %t77, ptr @.str.571)
  %t78 = load ptr, ptr %t76
  %t79 = load ptr, ptr %t46
  call void @bufAdd(ptr %t78, ptr %t79)
  %t80 = load ptr, ptr %t76
  call void @bufAdd(ptr %t80, ptr @.str.572)
  %t81 = load ptr, ptr %t0
  %t82 = load ptr, ptr %t76
  %t83 = getelementptr inbounds %Buf, ptr %t82, i32 0, i32 0
  %t84 = load ptr, ptr %t83
  %t85 = call ptr @emitAssign(ptr %t81, ptr %t84)
  ret ptr %t85
}

define ptr @genCall(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load i32, ptr %t1
  %t4 = call %Type @typeOfNode(ptr %t2, i32 %t3)
  %t5 = alloca %Type
  store %Type %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Emitter, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = getelementptr inbounds %Ast, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t1
  %t12 = sext i32 %t11 to i64
  %t13 = getelementptr inbounds %Node, ptr %t10, i64 %t12
  %t14 = getelementptr inbounds %Node, ptr %t13, i32 0, i32 5
  %t15 = load i32, ptr %t14
  %t16 = alloca i32
  store i32 %t15, ptr %t16
  %t17 = alloca i32
  store i32 0, ptr %t17
  %t18 = load i32, ptr %t16
  %t19 = load i32, ptr @NO_NODE
  %t20 = icmp ne i32 %t18, %t19
  br i1 %t20, label %L0, label %L2
L0:
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Emitter, ptr %t21, i32 0, i32 0
  %t23 = load ptr, ptr %t22
  %t24 = getelementptr inbounds %Ast, ptr %t23, i32 0, i32 0
  %t25 = load ptr, ptr %t24
  %t26 = load i32, ptr %t16
  %t27 = sext i32 %t26 to i64
  %t28 = getelementptr inbounds %Node, ptr %t25, i64 %t27
  %t29 = getelementptr inbounds %Node, ptr %t28, i32 0, i32 10
  %t30 = load i32, ptr %t29
  store i32 %t30, ptr %t17
  br label %L2
L2:
  %t31 = load i32, ptr %t17
  %t32 = add i32 %t31, 1
  %t33 = sext i32 %t32 to i64
  %t34 = mul i64 8, %t33
  %t35 = call ptr @malloc(i64 %t34)
  %t36 = alloca ptr
  store ptr %t35, ptr %t36
  %t37 = alloca i32
  store i32 0, ptr %t37
  br label %L3
L3:
  %t38 = load i32, ptr %t37
  %t39 = load i32, ptr %t17
  %t40 = icmp slt i32 %t38, %t39
  br i1 %t40, label %L4, label %L5
L4:
  %t41 = load ptr, ptr %t0
  %t42 = load ptr, ptr %t0
  %t43 = getelementptr inbounds %Emitter, ptr %t42, i32 0, i32 0
  %t44 = load ptr, ptr %t43
  %t45 = getelementptr inbounds %Ast, ptr %t44, i32 0, i32 0
  %t46 = load ptr, ptr %t45
  %t47 = load i32, ptr %t16
  %t48 = sext i32 %t47 to i64
  %t49 = getelementptr inbounds %Node, ptr %t46, i64 %t48
  %t50 = getelementptr inbounds %Node, ptr %t49, i32 0, i32 9
  %t51 = load ptr, ptr %t50
  %t52 = load i32, ptr %t37
  %t53 = sext i32 %t52 to i64
  %t54 = getelementptr inbounds i32, ptr %t51, i64 %t53
  %t55 = load i32, ptr %t54
  %t56 = call ptr @genExpr(ptr %t41, i32 %t55)
  %t57 = load ptr, ptr %t36
  %t58 = load i32, ptr %t37
  %t59 = sext i32 %t58 to i64
  %t60 = getelementptr inbounds ptr, ptr %t57, i64 %t59
  store ptr %t56, ptr %t60
  %t61 = load i32, ptr %t37
  %t62 = add i32 %t61, 1
  store i32 %t62, ptr %t37
  br label %L3
L5:
  %t63 = call ptr @bufNew()
  %t64 = alloca ptr
  store ptr %t63, ptr %t64
  %t65 = load ptr, ptr %t64
  call void @bufAdd(ptr %t65, ptr @.str.573)
  %t66 = load ptr, ptr %t64
  %t67 = load %Type, ptr %t5
  %t68 = call ptr @llvmTypeName(%Type %t67)
  call void @bufAdd(ptr %t66, ptr %t68)
  %t69 = load ptr, ptr %t64
  call void @bufAdd(ptr %t69, ptr @.str.574)
  %t70 = load ptr, ptr %t64
  %t71 = load ptr, ptr %t0
  %t72 = getelementptr inbounds %Emitter, ptr %t71, i32 0, i32 1
  %t73 = load ptr, ptr %t72
  %t74 = getelementptr inbounds %Analyzer, ptr %t73, i32 0, i32 5
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr %t1
  %t77 = sext i32 %t76 to i64
  %t78 = getelementptr inbounds ptr, ptr %t75, i64 %t77
  %t79 = load ptr, ptr %t78
  call void @bufAdd(ptr %t70, ptr %t79)
  %t80 = load ptr, ptr %t64
  call void @bufPush(ptr %t80, i8 40)
  store i32 0, ptr %t37
  br label %L6
L6:
  %t81 = load i32, ptr %t37
  %t82 = load i32, ptr %t17
  %t83 = icmp slt i32 %t81, %t82
  br i1 %t83, label %L7, label %L8
L7:
  %t84 = load i32, ptr %t37
  %t85 = icmp sgt i32 %t84, 0
  br i1 %t85, label %L9, label %L11
L9:
  %t86 = load ptr, ptr %t64
  call void @bufAdd(ptr %t86, ptr @.str.575)
  br label %L11
L11:
  %t87 = load ptr, ptr %t64
  %t88 = load ptr, ptr %t0
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr inbounds %Emitter, ptr %t89, i32 0, i32 0
  %t91 = load ptr, ptr %t90
  %t92 = getelementptr inbounds %Ast, ptr %t91, i32 0, i32 0
  %t93 = load ptr, ptr %t92
  %t94 = load i32, ptr %t16
  %t95 = sext i32 %t94 to i64
  %t96 = getelementptr inbounds %Node, ptr %t93, i64 %t95
  %t97 = getelementptr inbounds %Node, ptr %t96, i32 0, i32 9
  %t98 = load ptr, ptr %t97
  %t99 = load i32, ptr %t37
  %t100 = sext i32 %t99 to i64
  %t101 = getelementptr inbounds i32, ptr %t98, i64 %t100
  %t102 = load i32, ptr %t101
  %t103 = call %Type @typeOfNode(ptr %t88, i32 %t102)
  %t104 = call ptr @llvmTypeName(%Type %t103)
  call void @bufAdd(ptr %t87, ptr %t104)
  %t105 = load ptr, ptr %t64
  call void @bufPush(ptr %t105, i8 32)
  %t106 = load ptr, ptr %t64
  %t107 = load ptr, ptr %t36
  %t108 = load i32, ptr %t37
  %t109 = sext i32 %t108 to i64
  %t110 = getelementptr inbounds ptr, ptr %t107, i64 %t109
  %t111 = load ptr, ptr %t110
  call void @bufAdd(ptr %t106, ptr %t111)
  %t112 = load i32, ptr %t37
  %t113 = add i32 %t112, 1
  store i32 %t113, ptr %t37
  br label %L6
L8:
  %t114 = load ptr, ptr %t64
  call void @bufPush(ptr %t114, i8 41)
  %t115 = load %Type, ptr %t5
  %t116 = call i1 @typeIsVoid(%Type %t115)
  br i1 %t116, label %L12, label %L14
L12:
  %t117 = load ptr, ptr %t0
  %t118 = load ptr, ptr %t64
  %t119 = getelementptr inbounds %Buf, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  call void @emitLine(ptr %t117, ptr %t120)
  ret ptr @.str.576
L14:
  %t121 = load ptr, ptr %t0
  %t122 = load ptr, ptr %t64
  %t123 = getelementptr inbounds %Buf, ptr %t122, i32 0, i32 0
  %t124 = load ptr, ptr %t123
  %t125 = call ptr @emitAssign(ptr %t121, ptr %t124)
  ret ptr %t125
}

define ptr @genStructLiteral(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 3
  %t11 = load ptr, ptr %t10
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t12
  %t14 = call %Type @typeStruct(ptr %t13, i32 0)
  %t15 = alloca %Type
  store %Type %t14, ptr %t15
  %t16 = load ptr, ptr %t0
  %t17 = getelementptr inbounds %Emitter, ptr %t16, i32 0, i32 1
  %t18 = load ptr, ptr %t17
  %t19 = getelementptr inbounds %Analyzer, ptr %t18, i32 0, i32 2
  %t20 = load ptr, ptr %t19
  %t21 = load ptr, ptr %t12
  %t22 = call i32 @structIndexOf(ptr %t20, ptr %t21)
  %t23 = alloca i32
  store i32 %t22, ptr %t23
  %t24 = load %Type, ptr %t15
  %t25 = call ptr @llvmTypeName(%Type %t24)
  %t26 = alloca ptr
  store ptr %t25, ptr %t26
  %t27 = alloca ptr
  store ptr @.str.577, ptr %t27
  %t28 = alloca i32
  store i32 0, ptr %t28
  br label %L0
L0:
  %t29 = load i32, ptr %t28
  %t30 = load ptr, ptr %t0
  %t31 = getelementptr inbounds %Emitter, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = getelementptr inbounds %Ast, ptr %t32, i32 0, i32 0
  %t34 = load ptr, ptr %t33
  %t35 = load i32, ptr %t1
  %t36 = sext i32 %t35 to i64
  %t37 = getelementptr inbounds %Node, ptr %t34, i64 %t36
  %t38 = getelementptr inbounds %Node, ptr %t37, i32 0, i32 10
  %t39 = load i32, ptr %t38
  %t40 = icmp slt i32 %t29, %t39
  br i1 %t40, label %L1, label %L2
L1:
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Emitter, ptr %t41, i32 0, i32 0
  %t43 = load ptr, ptr %t42
  %t44 = getelementptr inbounds %Ast, ptr %t43, i32 0, i32 0
  %t45 = load ptr, ptr %t44
  %t46 = load i32, ptr %t1
  %t47 = sext i32 %t46 to i64
  %t48 = getelementptr inbounds %Node, ptr %t45, i64 %t47
  %t49 = getelementptr inbounds %Node, ptr %t48, i32 0, i32 9
  %t50 = load ptr, ptr %t49
  %t51 = load i32, ptr %t28
  %t52 = sext i32 %t51 to i64
  %t53 = getelementptr inbounds i32, ptr %t50, i64 %t52
  %t54 = load i32, ptr %t53
  %t55 = alloca i32
  store i32 %t54, ptr %t55
  %t56 = load ptr, ptr %t0
  %t57 = getelementptr inbounds %Emitter, ptr %t56, i32 0, i32 1
  %t58 = load ptr, ptr %t57
  %t59 = getelementptr inbounds %Analyzer, ptr %t58, i32 0, i32 2
  %t60 = load ptr, ptr %t59
  %t61 = load i32, ptr %t23
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Emitter, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = getelementptr inbounds %Ast, ptr %t64, i32 0, i32 0
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t55
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds %Node, ptr %t66, i64 %t68
  %t70 = getelementptr inbounds %Node, ptr %t69, i32 0, i32 3
  %t71 = load ptr, ptr %t70
  %t72 = call i32 @structFieldIndex(ptr %t60, i32 %t61, ptr %t71)
  %t73 = alloca i32
  store i32 %t72, ptr %t73
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %Emitter, ptr %t74, i32 0, i32 1
  %t76 = load ptr, ptr %t75
  %t77 = getelementptr inbounds %Analyzer, ptr %t76, i32 0, i32 2
  %t78 = load ptr, ptr %t77
  %t79 = getelementptr inbounds %StructTable, ptr %t78, i32 0, i32 0
  %t80 = load ptr, ptr %t79
  %t81 = load i32, ptr %t23
  %t82 = sext i32 %t81 to i64
  %t83 = getelementptr inbounds %StructLayout, ptr %t80, i64 %t82
  %t84 = getelementptr inbounds %StructLayout, ptr %t83, i32 0, i32 1
  %t85 = load ptr, ptr %t84
  %t86 = load i32, ptr %t73
  %t87 = sext i32 %t86 to i64
  %t88 = getelementptr inbounds %FieldDef, ptr %t85, i64 %t87
  %t89 = getelementptr inbounds %FieldDef, ptr %t88, i32 0, i32 1
  %t90 = load %Type, ptr %t89
  %t91 = alloca %Type
  store %Type %t90, ptr %t91
  %t92 = load ptr, ptr %t0
  %t93 = load ptr, ptr %t0
  %t94 = getelementptr inbounds %Emitter, ptr %t93, i32 0, i32 0
  %t95 = load ptr, ptr %t94
  %t96 = getelementptr inbounds %Ast, ptr %t95, i32 0, i32 0
  %t97 = load ptr, ptr %t96
  %t98 = load i32, ptr %t55
  %t99 = sext i32 %t98 to i64
  %t100 = getelementptr inbounds %Node, ptr %t97, i64 %t99
  %t101 = getelementptr inbounds %Node, ptr %t100, i32 0, i32 5
  %t102 = load i32, ptr %t101
  %t103 = call ptr @genExpr(ptr %t92, i32 %t102)
  %t104 = alloca ptr
  store ptr %t103, ptr %t104
  %t105 = call ptr @bufNew()
  %t106 = alloca ptr
  store ptr %t105, ptr %t106
  %t107 = load ptr, ptr %t106
  call void @bufAdd(ptr %t107, ptr @.str.578)
  %t108 = load ptr, ptr %t106
  %t109 = load ptr, ptr %t26
  call void @bufAdd(ptr %t108, ptr %t109)
  %t110 = load ptr, ptr %t106
  call void @bufPush(ptr %t110, i8 32)
  %t111 = load ptr, ptr %t106
  %t112 = load ptr, ptr %t27
  call void @bufAdd(ptr %t111, ptr %t112)
  %t113 = load ptr, ptr %t106
  call void @bufAdd(ptr %t113, ptr @.str.579)
  %t114 = load ptr, ptr %t106
  %t115 = load %Type, ptr %t91
  %t116 = call ptr @llvmTypeName(%Type %t115)
  call void @bufAdd(ptr %t114, ptr %t116)
  %t117 = load ptr, ptr %t106
  call void @bufPush(ptr %t117, i8 32)
  %t118 = load ptr, ptr %t106
  %t119 = load ptr, ptr %t104
  call void @bufAdd(ptr %t118, ptr %t119)
  %t120 = load ptr, ptr %t106
  call void @bufAdd(ptr %t120, ptr @.str.580)
  %t121 = load ptr, ptr %t106
  %t122 = load i32, ptr %t73
  %t123 = sext i32 %t122 to i64
  call void @bufAddInt(ptr %t121, i64 %t123)
  %t124 = load ptr, ptr %t0
  %t125 = load ptr, ptr %t106
  %t126 = getelementptr inbounds %Buf, ptr %t125, i32 0, i32 0
  %t127 = load ptr, ptr %t126
  %t128 = call ptr @emitAssign(ptr %t124, ptr %t127)
  store ptr %t128, ptr %t27
  %t129 = load i32, ptr %t28
  %t130 = add i32 %t129, 1
  store i32 %t130, ptr %t28
  br label %L0
L2:
  %t131 = load ptr, ptr %t27
  ret ptr %t131
}

define ptr @genNumberLiteral(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = load i32, ptr %t1
  %t4 = call %Type @typeOfNode(ptr %t2, i32 %t3)
  %t5 = alloca %Type
  store %Type %t4, ptr %t5
  %t6 = load ptr, ptr %t0
  %t7 = getelementptr inbounds %Emitter, ptr %t6, i32 0, i32 0
  %t8 = load ptr, ptr %t7
  %t9 = getelementptr inbounds %Ast, ptr %t8, i32 0, i32 0
  %t10 = load ptr, ptr %t9
  %t11 = load i32, ptr %t1
  %t12 = sext i32 %t11 to i64
  %t13 = getelementptr inbounds %Node, ptr %t10, i64 %t12
  %t14 = getelementptr inbounds %Node, ptr %t13, i32 0, i32 3
  %t15 = load ptr, ptr %t14
  %t16 = alloca ptr
  store ptr %t15, ptr %t16
  %t17 = load %Type, ptr %t5
  %t18 = call i1 @typeIsFloat(%Type %t17)
  br i1 %t18, label %L0, label %L2
L0:
  %t19 = load ptr, ptr %t16
  %t20 = load ptr, ptr %t16
  %t21 = call i64 @strlen(ptr %t20)
  %t22 = call i1 @textHasDot(ptr %t19, i64 %t21)
  %t23 = xor i1 %t22, true
  br i1 %t23, label %L3, label %L5
L3:
  %t24 = call ptr @bufNew()
  %t25 = alloca ptr
  store ptr %t24, ptr %t25
  %t26 = load ptr, ptr %t25
  %t27 = load ptr, ptr %t16
  call void @bufAdd(ptr %t26, ptr %t27)
  %t28 = load ptr, ptr %t25
  call void @bufAdd(ptr %t28, ptr @.str.581)
  %t29 = load ptr, ptr %t25
  %t30 = call ptr @bufTake(ptr %t29)
  ret ptr %t30
L5:
  %t31 = load ptr, ptr %t16
  ret ptr %t31
L2:
  %t32 = load ptr, ptr %t16
  ret ptr %t32
}

define ptr @genExpr(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load i32, ptr %t12
  %t14 = load i32, ptr @NK_NUMBER
  %t15 = icmp eq i32 %t13, %t14
  br i1 %t15, label %L0, label %L2
L0:
  %t16 = load ptr, ptr %t0
  %t17 = load i32, ptr %t1
  %t18 = call ptr @genNumberLiteral(ptr %t16, i32 %t17)
  ret ptr %t18
L2:
  %t19 = load i32, ptr %t12
  %t20 = load i32, ptr @NK_BOOL
  %t21 = icmp eq i32 %t19, %t20
  br i1 %t21, label %L3, label %L5
L3:
  %t22 = load ptr, ptr %t0
  %t23 = getelementptr inbounds %Emitter, ptr %t22, i32 0, i32 0
  %t24 = load ptr, ptr %t23
  %t25 = getelementptr inbounds %Ast, ptr %t24, i32 0, i32 0
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  %t28 = sext i32 %t27 to i64
  %t29 = getelementptr inbounds %Node, ptr %t26, i64 %t28
  %t30 = getelementptr inbounds %Node, ptr %t29, i32 0, i32 3
  %t31 = load ptr, ptr %t30
  %t32 = call i1 @textEquals(ptr %t31, ptr @.str.582)
  br i1 %t32, label %L6, label %L8
L6:
  ret ptr @.str.583
L8:
  ret ptr @.str.584
L5:
  %t33 = load i32, ptr %t12
  %t34 = load i32, ptr @NK_CHAR
  %t35 = icmp eq i32 %t33, %t34
  br i1 %t35, label %L9, label %L11
L9:
  %t36 = load ptr, ptr %t0
  %t37 = getelementptr inbounds %Emitter, ptr %t36, i32 0, i32 0
  %t38 = load ptr, ptr %t37
  %t39 = getelementptr inbounds %Ast, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  %t41 = load i32, ptr %t1
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds %Node, ptr %t40, i64 %t42
  %t44 = getelementptr inbounds %Node, ptr %t43, i32 0, i32 3
  %t45 = load ptr, ptr %t44
  %t46 = sext i32 0 to i64
  %t47 = getelementptr inbounds i8, ptr %t45, i64 %t46
  %t48 = load i8, ptr %t47
  %t49 = sext i8 %t48 to i32
  %t50 = alloca i32
  store i32 %t49, ptr %t50
  %t51 = load i32, ptr %t50
  %t52 = icmp slt i32 %t51, 0
  br i1 %t52, label %L12, label %L14
L12:
  %t53 = load i32, ptr %t50
  %t54 = add i32 %t53, 256
  store i32 %t54, ptr %t50
  br label %L14
L14:
  %t55 = load i32, ptr %t50
  %t56 = icmp sgt i32 %t55, 127
  br i1 %t56, label %L15, label %L17
L15:
  %t57 = load i32, ptr %t50
  %t58 = sub i32 %t57, 256
  store i32 %t58, ptr %t50
  br label %L17
L17:
  %t59 = load i32, ptr %t50
  %t60 = sext i32 %t59 to i64
  %t61 = call ptr @intToText(i64 %t60)
  ret ptr %t61
L11:
  %t62 = load i32, ptr %t12
  %t63 = load i32, ptr @NK_STRING
  %t64 = icmp eq i32 %t62, %t63
  br i1 %t64, label %L18, label %L20
L18:
  %t65 = load ptr, ptr %t0
  %t66 = load ptr, ptr %t0
  %t67 = getelementptr inbounds %Emitter, ptr %t66, i32 0, i32 0
  %t68 = load ptr, ptr %t67
  %t69 = getelementptr inbounds %Ast, ptr %t68, i32 0, i32 0
  %t70 = load ptr, ptr %t69
  %t71 = load i32, ptr %t1
  %t72 = sext i32 %t71 to i64
  %t73 = getelementptr inbounds %Node, ptr %t70, i64 %t72
  %t74 = getelementptr inbounds %Node, ptr %t73, i32 0, i32 3
  %t75 = load ptr, ptr %t74
  %t76 = load ptr, ptr %t0
  %t77 = getelementptr inbounds %Emitter, ptr %t76, i32 0, i32 0
  %t78 = load ptr, ptr %t77
  %t79 = getelementptr inbounds %Ast, ptr %t78, i32 0, i32 0
  %t80 = load ptr, ptr %t79
  %t81 = load i32, ptr %t1
  %t82 = sext i32 %t81 to i64
  %t83 = getelementptr inbounds %Node, ptr %t80, i64 %t82
  %t84 = getelementptr inbounds %Node, ptr %t83, i32 0, i32 4
  %t85 = load i64, ptr %t84
  %t86 = call ptr @internString(ptr %t65, ptr %t75, i64 %t85)
  ret ptr %t86
L20:
  %t87 = load i32, ptr %t12
  %t88 = load i32, ptr @NK_IDENT
  %t89 = icmp eq i32 %t87, %t88
  br i1 %t89, label %L21, label %L23
L21:
  %t90 = load ptr, ptr %t0
  %t91 = load ptr, ptr %t0
  %t92 = load i32, ptr %t1
  %t93 = call %Type @typeOfNode(ptr %t91, i32 %t92)
  %t94 = load ptr, ptr %t0
  %t95 = load i32, ptr %t1
  %t96 = call ptr @variableAddress(ptr %t94, i32 %t95)
  %t97 = call ptr @emitLoad(ptr %t90, %Type %t93, ptr %t96)
  ret ptr %t97
L23:
  %t98 = load i32, ptr %t12
  %t99 = load i32, ptr @NK_BINARY
  %t100 = icmp eq i32 %t98, %t99
  br i1 %t100, label %L24, label %L26
L24:
  %t101 = load ptr, ptr %t0
  %t102 = load i32, ptr %t1
  %t103 = call ptr @genBinary(ptr %t101, i32 %t102)
  ret ptr %t103
L26:
  %t104 = load i32, ptr %t12
  %t105 = load i32, ptr @NK_UNARY
  %t106 = icmp eq i32 %t104, %t105
  br i1 %t106, label %L27, label %L29
L27:
  %t107 = load ptr, ptr %t0
  %t108 = load i32, ptr %t1
  %t109 = call ptr @genUnary(ptr %t107, i32 %t108)
  ret ptr %t109
L29:
  %t110 = load i32, ptr %t12
  %t111 = load i32, ptr @NK_CALL
  %t112 = icmp eq i32 %t110, %t111
  br i1 %t112, label %L30, label %L32
L30:
  %t113 = load ptr, ptr %t0
  %t114 = load i32, ptr %t1
  %t115 = call ptr @genCall(ptr %t113, i32 %t114)
  ret ptr %t115
L32:
  %t116 = load i32, ptr %t12
  %t117 = load i32, ptr @NK_STRUCTLIT
  %t118 = icmp eq i32 %t116, %t117
  br i1 %t118, label %L33, label %L35
L33:
  %t119 = load ptr, ptr %t0
  %t120 = load i32, ptr %t1
  %t121 = call ptr @genStructLiteral(ptr %t119, i32 %t120)
  ret ptr %t121
L35:
  %t122 = load i32, ptr %t12
  %t123 = load i32, ptr @NK_CAST
  %t124 = icmp eq i32 %t122, %t123
  br i1 %t124, label %L36, label %L38
L36:
  %t125 = load ptr, ptr %t0
  %t126 = load ptr, ptr %t0
  %t127 = getelementptr inbounds %Emitter, ptr %t126, i32 0, i32 0
  %t128 = load ptr, ptr %t127
  %t129 = getelementptr inbounds %Ast, ptr %t128, i32 0, i32 0
  %t130 = load ptr, ptr %t129
  %t131 = load i32, ptr %t1
  %t132 = sext i32 %t131 to i64
  %t133 = getelementptr inbounds %Node, ptr %t130, i64 %t132
  %t134 = getelementptr inbounds %Node, ptr %t133, i32 0, i32 5
  %t135 = load i32, ptr %t134
  %t136 = call %Type @typeOfNode(ptr %t125, i32 %t135)
  %t137 = alloca %Type
  store %Type %t136, ptr %t137
  %t138 = load ptr, ptr %t0
  %t139 = load i32, ptr %t1
  %t140 = call %Type @typeOfNode(ptr %t138, i32 %t139)
  %t141 = alloca %Type
  store %Type %t140, ptr %t141
  %t142 = load ptr, ptr %t0
  %t143 = load ptr, ptr %t0
  %t144 = load ptr, ptr %t0
  %t145 = getelementptr inbounds %Emitter, ptr %t144, i32 0, i32 0
  %t146 = load ptr, ptr %t145
  %t147 = getelementptr inbounds %Ast, ptr %t146, i32 0, i32 0
  %t148 = load ptr, ptr %t147
  %t149 = load i32, ptr %t1
  %t150 = sext i32 %t149 to i64
  %t151 = getelementptr inbounds %Node, ptr %t148, i64 %t150
  %t152 = getelementptr inbounds %Node, ptr %t151, i32 0, i32 5
  %t153 = load i32, ptr %t152
  %t154 = call ptr @genExpr(ptr %t143, i32 %t153)
  %t155 = load %Type, ptr %t137
  %t156 = load %Type, ptr %t141
  %t157 = call ptr @emitCast(ptr %t142, ptr %t154, %Type %t155, %Type %t156)
  ret ptr %t157
L38:
  %t158 = load i32, ptr %t12
  %t159 = load i32, ptr @NK_SIZEOF
  %t160 = icmp eq i32 %t158, %t159
  br i1 %t160, label %L39, label %L41
L39:
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr inbounds %Emitter, ptr %t161, i32 0, i32 1
  %t163 = load ptr, ptr %t162
  %t164 = load ptr, ptr %t0
  %t165 = getelementptr inbounds %Emitter, ptr %t164, i32 0, i32 0
  %t166 = load ptr, ptr %t165
  %t167 = getelementptr inbounds %Ast, ptr %t166, i32 0, i32 0
  %t168 = load ptr, ptr %t167
  %t169 = load i32, ptr %t1
  %t170 = sext i32 %t169 to i64
  %t171 = getelementptr inbounds %Node, ptr %t168, i64 %t170
  %t172 = getelementptr inbounds %Node, ptr %t171, i32 0, i32 5
  %t173 = load i32, ptr %t172
  %t174 = call %Type @analyzerParseType(ptr %t163, i32 %t173)
  %t175 = alloca %Type
  store %Type %t174, ptr %t175
  %t176 = load ptr, ptr %t0
  %t177 = load %Type, ptr %t175
  %t178 = call i32 @sizeOfType(ptr %t176, %Type %t177)
  %t179 = sext i32 %t178 to i64
  %t180 = call ptr @intToText(i64 %t179)
  ret ptr %t180
L41:
  %t181 = load i32, ptr %t12
  %t182 = load i32, ptr @NK_FIELDACCESS
  %t183 = icmp eq i32 %t181, %t182
  br i1 %t183, label %L42, label %L44
L42:
  %t184 = load ptr, ptr %t0
  %t185 = getelementptr inbounds %Emitter, ptr %t184, i32 0, i32 0
  %t186 = load ptr, ptr %t185
  %t187 = getelementptr inbounds %Ast, ptr %t186, i32 0, i32 0
  %t188 = load ptr, ptr %t187
  %t189 = load i32, ptr %t1
  %t190 = sext i32 %t189 to i64
  %t191 = getelementptr inbounds %Node, ptr %t188, i64 %t190
  %t192 = getelementptr inbounds %Node, ptr %t191, i32 0, i32 5
  %t193 = load i32, ptr %t192
  %t194 = alloca i32
  store i32 %t193, ptr %t194
  %t195 = load ptr, ptr %t0
  %t196 = load i32, ptr %t194
  %t197 = call %Type @typeOfNode(ptr %t195, i32 %t196)
  %t198 = alloca %Type
  store %Type %t197, ptr %t198
  %t199 = alloca i1
  %t200 = load %Type, ptr %t198
  %t201 = call i1 @typeIsPointer(%Type %t200)
  %t202 = xor i1 %t201, true
  store i1 %t202, ptr %t199
  br i1 %t202, label %L45, label %L46
L45:
  %t203 = load ptr, ptr %t0
  %t204 = load i32, ptr %t194
  %t205 = call i1 @isAddressable(ptr %t203, i32 %t204)
  %t206 = xor i1 %t205, true
  store i1 %t206, ptr %t199
  br label %L46
L46:
  %t207 = load i1, ptr %t199
  br i1 %t207, label %L47, label %L49
L47:
  %t208 = load ptr, ptr %t0
  %t209 = getelementptr inbounds %Emitter, ptr %t208, i32 0, i32 1
  %t210 = load ptr, ptr %t209
  %t211 = getelementptr inbounds %Analyzer, ptr %t210, i32 0, i32 2
  %t212 = load ptr, ptr %t211
  %t213 = getelementptr inbounds %Type, ptr %t198, i32 0, i32 2
  %t214 = load ptr, ptr %t213
  %t215 = call i32 @structIndexOf(ptr %t212, ptr %t214)
  %t216 = alloca i32
  store i32 %t215, ptr %t216
  %t217 = load ptr, ptr %t0
  %t218 = getelementptr inbounds %Emitter, ptr %t217, i32 0, i32 1
  %t219 = load ptr, ptr %t218
  %t220 = getelementptr inbounds %Analyzer, ptr %t219, i32 0, i32 2
  %t221 = load ptr, ptr %t220
  %t222 = load i32, ptr %t216
  %t223 = load ptr, ptr %t0
  %t224 = getelementptr inbounds %Emitter, ptr %t223, i32 0, i32 0
  %t225 = load ptr, ptr %t224
  %t226 = getelementptr inbounds %Ast, ptr %t225, i32 0, i32 0
  %t227 = load ptr, ptr %t226
  %t228 = load i32, ptr %t1
  %t229 = sext i32 %t228 to i64
  %t230 = getelementptr inbounds %Node, ptr %t227, i64 %t229
  %t231 = getelementptr inbounds %Node, ptr %t230, i32 0, i32 3
  %t232 = load ptr, ptr %t231
  %t233 = call i32 @structFieldIndex(ptr %t221, i32 %t222, ptr %t232)
  %t234 = alloca i32
  store i32 %t233, ptr %t234
  %t235 = call ptr @bufNew()
  %t236 = alloca ptr
  store ptr %t235, ptr %t236
  %t237 = load ptr, ptr %t236
  call void @bufAdd(ptr %t237, ptr @.str.585)
  %t238 = load ptr, ptr %t236
  %t239 = load %Type, ptr %t198
  %t240 = call ptr @llvmTypeName(%Type %t239)
  call void @bufAdd(ptr %t238, ptr %t240)
  %t241 = load ptr, ptr %t236
  call void @bufPush(ptr %t241, i8 32)
  %t242 = load ptr, ptr %t236
  %t243 = load ptr, ptr %t0
  %t244 = load i32, ptr %t194
  %t245 = call ptr @genExpr(ptr %t243, i32 %t244)
  call void @bufAdd(ptr %t242, ptr %t245)
  %t246 = load ptr, ptr %t236
  call void @bufAdd(ptr %t246, ptr @.str.586)
  %t247 = load ptr, ptr %t236
  %t248 = load i32, ptr %t234
  %t249 = sext i32 %t248 to i64
  call void @bufAddInt(ptr %t247, i64 %t249)
  %t250 = load ptr, ptr %t0
  %t251 = load ptr, ptr %t236
  %t252 = getelementptr inbounds %Buf, ptr %t251, i32 0, i32 0
  %t253 = load ptr, ptr %t252
  %t254 = call ptr @emitAssign(ptr %t250, ptr %t253)
  ret ptr %t254
L49:
  %t255 = load ptr, ptr %t0
  %t256 = load ptr, ptr %t0
  %t257 = load i32, ptr %t1
  %t258 = call %Type @typeOfNode(ptr %t256, i32 %t257)
  %t259 = load ptr, ptr %t0
  %t260 = load i32, ptr %t1
  %t261 = call ptr @genAddress(ptr %t259, i32 %t260)
  %t262 = call ptr @emitLoad(ptr %t255, %Type %t258, ptr %t261)
  ret ptr %t262
L44:
  %t263 = load i32, ptr %t12
  %t264 = load i32, ptr @NK_INDEX
  %t265 = icmp eq i32 %t263, %t264
  br i1 %t265, label %L50, label %L52
L50:
  %t266 = load ptr, ptr %t0
  %t267 = load ptr, ptr %t0
  %t268 = load i32, ptr %t1
  %t269 = call %Type @typeOfNode(ptr %t267, i32 %t268)
  %t270 = load ptr, ptr %t0
  %t271 = load i32, ptr %t1
  %t272 = call ptr @genAddress(ptr %t270, i32 %t271)
  %t273 = call ptr @emitLoad(ptr %t266, %Type %t269, ptr %t272)
  ret ptr %t273
L52:
  %t274 = load ptr, ptr %t0
  %t275 = getelementptr inbounds %Emitter, ptr %t274, i32 0, i32 0
  %t276 = load ptr, ptr %t275
  %t277 = getelementptr inbounds %Ast, ptr %t276, i32 0, i32 0
  %t278 = load ptr, ptr %t277
  %t279 = load i32, ptr %t1
  %t280 = sext i32 %t279 to i64
  %t281 = getelementptr inbounds %Node, ptr %t278, i64 %t280
  %t282 = getelementptr inbounds %Node, ptr %t281, i32 0, i32 1
  %t283 = load i32, ptr %t282
  %t284 = load ptr, ptr %t0
  %t285 = getelementptr inbounds %Emitter, ptr %t284, i32 0, i32 0
  %t286 = load ptr, ptr %t285
  %t287 = getelementptr inbounds %Ast, ptr %t286, i32 0, i32 0
  %t288 = load ptr, ptr %t287
  %t289 = load i32, ptr %t1
  %t290 = sext i32 %t289 to i64
  %t291 = getelementptr inbounds %Node, ptr %t288, i64 %t290
  %t292 = getelementptr inbounds %Node, ptr %t291, i32 0, i32 2
  %t293 = load i32, ptr %t292
  call void @failAt(i32 %t283, i32 %t293, ptr @.str.587)
  %t294 = call ptr @nullText()
  ret ptr %t294
}

define ptr @printFormat(%Type %p0) {
entry:
  %t0 = alloca %Type
  store %Type %p0, ptr %t0
  %t1 = load %Type, ptr %t0
  %t2 = call i1 @typeIsPointer(%Type %t1)
  br i1 %t2, label %L0, label %L2
L0:
  %t3 = alloca i1
  %t4 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t5 = load i32, ptr %t4
  %t6 = load i32, ptr @TY_I8
  %t7 = icmp eq i32 %t5, %t6
  store i1 %t7, ptr %t3
  br i1 %t7, label %L3, label %L4
L3:
  %t8 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 1
  %t9 = load i32, ptr %t8
  %t10 = icmp eq i32 %t9, 1
  store i1 %t10, ptr %t3
  br label %L4
L4:
  %t11 = load i1, ptr %t3
  br i1 %t11, label %L5, label %L7
L5:
  ret ptr @.str.588
L7:
  ret ptr @.str.589
L2:
  %t12 = alloca i1
  %t13 = alloca i1
  %t14 = alloca i1
  %t15 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t16 = load i32, ptr %t15
  %t17 = load i32, ptr @TY_BOOL
  %t18 = icmp eq i32 %t16, %t17
  store i1 %t18, ptr %t14
  br i1 %t18, label %L9, label %L8
L8:
  %t19 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t20 = load i32, ptr %t19
  %t21 = load i32, ptr @TY_I8
  %t22 = icmp eq i32 %t20, %t21
  store i1 %t22, ptr %t14
  br label %L9
L9:
  %t23 = load i1, ptr %t14
  store i1 %t23, ptr %t13
  br i1 %t23, label %L11, label %L10
L10:
  %t24 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t25 = load i32, ptr %t24
  %t26 = load i32, ptr @TY_I16
  %t27 = icmp eq i32 %t25, %t26
  store i1 %t27, ptr %t13
  br label %L11
L11:
  %t28 = load i1, ptr %t13
  store i1 %t28, ptr %t12
  br i1 %t28, label %L13, label %L12
L12:
  %t29 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t30 = load i32, ptr %t29
  %t31 = load i32, ptr @TY_I32
  %t32 = icmp eq i32 %t30, %t31
  store i1 %t32, ptr %t12
  br label %L13
L13:
  %t33 = load i1, ptr %t12
  br i1 %t33, label %L14, label %L16
L14:
  ret ptr @.str.590
L16:
  %t34 = alloca i1
  %t35 = alloca i1
  %t36 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t37 = load i32, ptr %t36
  %t38 = load i32, ptr @TY_U8
  %t39 = icmp eq i32 %t37, %t38
  store i1 %t39, ptr %t35
  br i1 %t39, label %L18, label %L17
L17:
  %t40 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t41 = load i32, ptr %t40
  %t42 = load i32, ptr @TY_U16
  %t43 = icmp eq i32 %t41, %t42
  store i1 %t43, ptr %t35
  br label %L18
L18:
  %t44 = load i1, ptr %t35
  store i1 %t44, ptr %t34
  br i1 %t44, label %L20, label %L19
L19:
  %t45 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t46 = load i32, ptr %t45
  %t47 = load i32, ptr @TY_U32
  %t48 = icmp eq i32 %t46, %t47
  store i1 %t48, ptr %t34
  br label %L20
L20:
  %t49 = load i1, ptr %t34
  br i1 %t49, label %L21, label %L23
L21:
  ret ptr @.str.591
L23:
  %t50 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t51 = load i32, ptr %t50
  %t52 = load i32, ptr @TY_I64
  %t53 = icmp eq i32 %t51, %t52
  br i1 %t53, label %L24, label %L26
L24:
  ret ptr @.str.592
L26:
  %t54 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t55 = load i32, ptr %t54
  %t56 = load i32, ptr @TY_U64
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L27, label %L29
L27:
  ret ptr @.str.593
L29:
  %t58 = alloca i1
  %t59 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t60 = load i32, ptr %t59
  %t61 = load i32, ptr @TY_F32
  %t62 = icmp eq i32 %t60, %t61
  store i1 %t62, ptr %t58
  br i1 %t62, label %L31, label %L30
L30:
  %t63 = getelementptr inbounds %Type, ptr %t0, i32 0, i32 0
  %t64 = load i32, ptr %t63
  %t65 = load i32, ptr @TY_F64
  %t66 = icmp eq i32 %t64, %t65
  store i1 %t66, ptr %t58
  br label %L31
L31:
  %t67 = load i1, ptr %t58
  br i1 %t67, label %L32, label %L34
L32:
  ret ptr @.str.594
L34:
  call void @failAt(i32 0, i32 0, ptr @.str.595)
  ret ptr @.str.596
}

define void @genPrint(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 5
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = load ptr, ptr %t0
  %t14 = load i32, ptr %t12
  %t15 = call %Type @typeOfNode(ptr %t13, i32 %t14)
  %t16 = alloca %Type
  store %Type %t15, ptr %t16
  %t17 = load %Type, ptr %t16
  %t18 = call ptr @printFormat(%Type %t17)
  %t19 = alloca ptr
  store ptr %t18, ptr %t19
  %t20 = load ptr, ptr %t0
  %t21 = load i32, ptr %t12
  %t22 = call ptr @genExpr(ptr %t20, i32 %t21)
  %t23 = alloca ptr
  store ptr %t22, ptr %t23
  %t24 = load %Type, ptr %t16
  %t25 = alloca %Type
  store %Type %t24, ptr %t25
  %t26 = load %Type, ptr %t16
  %t27 = call i1 @typeIsPointer(%Type %t26)
  %t28 = xor i1 %t27, true
  br i1 %t28, label %L0, label %L2
L0:
  %t29 = alloca i1
  %t30 = load %Type, ptr %t16
  %t31 = call i1 @typeIsBool(%Type %t30)
  store i1 %t31, ptr %t29
  br i1 %t31, label %L4, label %L3
L3:
  %t32 = alloca i1
  %t33 = load %Type, ptr %t16
  %t34 = call i1 @typeIsInteger(%Type %t33)
  store i1 %t34, ptr %t32
  br i1 %t34, label %L5, label %L6
L5:
  %t35 = load %Type, ptr %t16
  %t36 = call i32 @typeBitWidth(%Type %t35)
  %t37 = icmp slt i32 %t36, 32
  store i1 %t37, ptr %t32
  br label %L6
L6:
  %t38 = load i1, ptr %t32
  store i1 %t38, ptr %t29
  br label %L4
L4:
  %t39 = load i1, ptr %t29
  br i1 %t39, label %L7, label %L8
L7:
  %t40 = load i32, ptr @TY_I32
  %t41 = call %Type @typeMake(i32 %t40, i32 0)
  store %Type %t41, ptr %t25
  %t42 = load ptr, ptr %t0
  %t43 = load ptr, ptr %t23
  %t44 = load %Type, ptr %t16
  %t45 = load %Type, ptr %t25
  %t46 = call ptr @emitCast(ptr %t42, ptr %t43, %Type %t44, %Type %t45)
  store ptr %t46, ptr %t23
  br label %L9
L8:
  %t47 = getelementptr inbounds %Type, ptr %t16, i32 0, i32 0
  %t48 = load i32, ptr %t47
  %t49 = load i32, ptr @TY_F32
  %t50 = icmp eq i32 %t48, %t49
  br i1 %t50, label %L10, label %L12
L10:
  %t51 = load i32, ptr @TY_F64
  %t52 = call %Type @typeMake(i32 %t51, i32 0)
  store %Type %t52, ptr %t25
  %t53 = load ptr, ptr %t0
  %t54 = load ptr, ptr %t23
  %t55 = load %Type, ptr %t16
  %t56 = load %Type, ptr %t25
  %t57 = call ptr @emitCast(ptr %t53, ptr %t54, %Type %t55, %Type %t56)
  store ptr %t57, ptr %t23
  br label %L12
L12:
  br label %L9
L9:
  br label %L2
L2:
  %t58 = load ptr, ptr %t0
  %t59 = load ptr, ptr %t19
  %t60 = load ptr, ptr %t19
  %t61 = call i64 @strlen(ptr %t60)
  %t62 = call ptr @internString(ptr %t58, ptr %t59, i64 %t61)
  %t63 = alloca ptr
  store ptr %t62, ptr %t63
  %t64 = call ptr @bufNew()
  %t65 = alloca ptr
  store ptr %t64, ptr %t65
  %t66 = load ptr, ptr %t65
  call void @bufAdd(ptr %t66, ptr @.str.597)
  %t67 = load ptr, ptr %t65
  %t68 = load ptr, ptr %t63
  call void @bufAdd(ptr %t67, ptr %t68)
  %t69 = load ptr, ptr %t65
  call void @bufAdd(ptr %t69, ptr @.str.598)
  %t70 = load ptr, ptr %t65
  %t71 = load %Type, ptr %t25
  %t72 = call ptr @llvmTypeName(%Type %t71)
  call void @bufAdd(ptr %t70, ptr %t72)
  %t73 = load ptr, ptr %t65
  call void @bufPush(ptr %t73, i8 32)
  %t74 = load ptr, ptr %t65
  %t75 = load ptr, ptr %t23
  call void @bufAdd(ptr %t74, ptr %t75)
  %t76 = load ptr, ptr %t65
  call void @bufPush(ptr %t76, i8 41)
  %t77 = load ptr, ptr %t0
  %t78 = load ptr, ptr %t65
  %t79 = getelementptr inbounds %Buf, ptr %t78, i32 0, i32 0
  %t80 = load ptr, ptr %t79
  %t81 = call ptr @emitAssign(ptr %t77, ptr %t80)
  ret void
}

define void @genStatement(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 0
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i1
  %t14 = load i32, ptr %t12
  %t15 = load i32, ptr @NK_STRUCT
  %t16 = icmp eq i32 %t14, %t15
  store i1 %t16, ptr %t13
  br i1 %t16, label %L1, label %L0
L0:
  %t17 = load i32, ptr %t12
  %t18 = load i32, ptr @NK_EXTERN
  %t19 = icmp eq i32 %t17, %t18
  store i1 %t19, ptr %t13
  br label %L1
L1:
  %t20 = load i1, ptr %t13
  br i1 %t20, label %L2, label %L4
L2:
  ret void
L4:
  %t21 = load i32, ptr %t12
  %t22 = load i32, ptr @NK_BLOCK
  %t23 = icmp eq i32 %t21, %t22
  br i1 %t23, label %L5, label %L7
L5:
  %t24 = load ptr, ptr %t0
  call void @emitterEnterScope(ptr %t24)
  %t25 = alloca i32
  store i32 0, ptr %t25
  br label %L8
L8:
  %t26 = load i32, ptr %t25
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Emitter, ptr %t27, i32 0, i32 0
  %t29 = load ptr, ptr %t28
  %t30 = getelementptr inbounds %Ast, ptr %t29, i32 0, i32 0
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t1
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds %Node, ptr %t31, i64 %t33
  %t35 = getelementptr inbounds %Node, ptr %t34, i32 0, i32 10
  %t36 = load i32, ptr %t35
  %t37 = icmp slt i32 %t26, %t36
  br i1 %t37, label %L9, label %L10
L9:
  %t38 = load ptr, ptr %t0
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Emitter, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = getelementptr inbounds %Ast, ptr %t41, i32 0, i32 0
  %t43 = load ptr, ptr %t42
  %t44 = load i32, ptr %t1
  %t45 = sext i32 %t44 to i64
  %t46 = getelementptr inbounds %Node, ptr %t43, i64 %t45
  %t47 = getelementptr inbounds %Node, ptr %t46, i32 0, i32 9
  %t48 = load ptr, ptr %t47
  %t49 = load i32, ptr %t25
  %t50 = sext i32 %t49 to i64
  %t51 = getelementptr inbounds i32, ptr %t48, i64 %t50
  %t52 = load i32, ptr %t51
  call void @genStatement(ptr %t38, i32 %t52)
  %t53 = load i32, ptr %t25
  %t54 = add i32 %t53, 1
  store i32 %t54, ptr %t25
  br label %L8
L10:
  %t55 = load ptr, ptr %t0
  call void @emitterExitScope(ptr %t55)
  ret void
L7:
  %t56 = load i32, ptr %t12
  %t57 = load i32, ptr @NK_VARDECL
  %t58 = icmp eq i32 %t56, %t57
  br i1 %t58, label %L11, label %L13
L11:
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Emitter, ptr %t59, i32 0, i32 1
  %t61 = load ptr, ptr %t60
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Emitter, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = getelementptr inbounds %Ast, ptr %t64, i32 0, i32 0
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t1
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds %Node, ptr %t66, i64 %t68
  %t70 = getelementptr inbounds %Node, ptr %t69, i32 0, i32 5
  %t71 = load i32, ptr %t70
  %t72 = call %Type @analyzerParseType(ptr %t61, i32 %t71)
  %t73 = alloca %Type
  store %Type %t72, ptr %t73
  %t74 = load ptr, ptr %t0
  %t75 = load ptr, ptr %t0
  %t76 = getelementptr inbounds %Emitter, ptr %t75, i32 0, i32 0
  %t77 = load ptr, ptr %t76
  %t78 = getelementptr inbounds %Ast, ptr %t77, i32 0, i32 0
  %t79 = load ptr, ptr %t78
  %t80 = load i32, ptr %t1
  %t81 = sext i32 %t80 to i64
  %t82 = getelementptr inbounds %Node, ptr %t79, i64 %t81
  %t83 = getelementptr inbounds %Node, ptr %t82, i32 0, i32 6
  %t84 = load i32, ptr %t83
  %t85 = call ptr @genExpr(ptr %t74, i32 %t84)
  %t86 = alloca ptr
  store ptr %t85, ptr %t86
  %t87 = call ptr @bufNew()
  %t88 = alloca ptr
  store ptr %t87, ptr %t88
  %t89 = load ptr, ptr %t88
  call void @bufAdd(ptr %t89, ptr @.str.599)
  %t90 = load ptr, ptr %t88
  %t91 = load %Type, ptr %t73
  %t92 = call ptr @llvmTypeName(%Type %t91)
  call void @bufAdd(ptr %t90, ptr %t92)
  %t93 = load ptr, ptr %t0
  %t94 = load ptr, ptr %t88
  %t95 = getelementptr inbounds %Buf, ptr %t94, i32 0, i32 0
  %t96 = load ptr, ptr %t95
  %t97 = call ptr @emitAssign(ptr %t93, ptr %t96)
  %t98 = alloca ptr
  store ptr %t97, ptr %t98
  %t99 = load ptr, ptr %t0
  %t100 = load %Type, ptr %t73
  %t101 = load ptr, ptr %t86
  %t102 = load ptr, ptr %t98
  call void @emitStore(ptr %t99, %Type %t100, ptr %t101, ptr %t102)
  %t103 = load ptr, ptr %t0
  %t104 = load ptr, ptr %t0
  %t105 = getelementptr inbounds %Emitter, ptr %t104, i32 0, i32 0
  %t106 = load ptr, ptr %t105
  %t107 = getelementptr inbounds %Ast, ptr %t106, i32 0, i32 0
  %t108 = load ptr, ptr %t107
  %t109 = load i32, ptr %t1
  %t110 = sext i32 %t109 to i64
  %t111 = getelementptr inbounds %Node, ptr %t108, i64 %t110
  %t112 = getelementptr inbounds %Node, ptr %t111, i32 0, i32 3
  %t113 = load ptr, ptr %t112
  %t114 = load ptr, ptr %t98
  %t115 = load %Type, ptr %t73
  call void @declareLocal(ptr %t103, ptr %t113, ptr %t114, %Type %t115)
  ret void
L13:
  %t116 = load i32, ptr %t12
  %t117 = load i32, ptr @NK_ASSIGN
  %t118 = icmp eq i32 %t116, %t117
  br i1 %t118, label %L14, label %L16
L14:
  %t119 = load ptr, ptr %t0
  %t120 = getelementptr inbounds %Emitter, ptr %t119, i32 0, i32 0
  %t121 = load ptr, ptr %t120
  %t122 = getelementptr inbounds %Ast, ptr %t121, i32 0, i32 0
  %t123 = load ptr, ptr %t122
  %t124 = load i32, ptr %t1
  %t125 = sext i32 %t124 to i64
  %t126 = getelementptr inbounds %Node, ptr %t123, i64 %t125
  %t127 = getelementptr inbounds %Node, ptr %t126, i32 0, i32 5
  %t128 = load i32, ptr %t127
  %t129 = alloca i32
  store i32 %t128, ptr %t129
  %t130 = load ptr, ptr %t0
  %t131 = load i32, ptr %t129
  %t132 = call %Type @typeOfNode(ptr %t130, i32 %t131)
  %t133 = alloca %Type
  store %Type %t132, ptr %t133
  %t134 = load ptr, ptr %t0
  %t135 = load ptr, ptr %t0
  %t136 = getelementptr inbounds %Emitter, ptr %t135, i32 0, i32 0
  %t137 = load ptr, ptr %t136
  %t138 = getelementptr inbounds %Ast, ptr %t137, i32 0, i32 0
  %t139 = load ptr, ptr %t138
  %t140 = load i32, ptr %t1
  %t141 = sext i32 %t140 to i64
  %t142 = getelementptr inbounds %Node, ptr %t139, i64 %t141
  %t143 = getelementptr inbounds %Node, ptr %t142, i32 0, i32 6
  %t144 = load i32, ptr %t143
  %t145 = call ptr @genExpr(ptr %t134, i32 %t144)
  %t146 = alloca ptr
  store ptr %t145, ptr %t146
  %t147 = load ptr, ptr %t0
  %t148 = load %Type, ptr %t133
  %t149 = load ptr, ptr %t146
  %t150 = load ptr, ptr %t0
  %t151 = load i32, ptr %t129
  %t152 = call ptr @genAddress(ptr %t150, i32 %t151)
  call void @emitStore(ptr %t147, %Type %t148, ptr %t149, ptr %t152)
  ret void
L16:
  %t153 = load i32, ptr %t12
  %t154 = load i32, ptr @NK_EXPRSTMT
  %t155 = icmp eq i32 %t153, %t154
  br i1 %t155, label %L17, label %L19
L17:
  %t156 = load ptr, ptr %t0
  %t157 = load ptr, ptr %t0
  %t158 = getelementptr inbounds %Emitter, ptr %t157, i32 0, i32 0
  %t159 = load ptr, ptr %t158
  %t160 = getelementptr inbounds %Ast, ptr %t159, i32 0, i32 0
  %t161 = load ptr, ptr %t160
  %t162 = load i32, ptr %t1
  %t163 = sext i32 %t162 to i64
  %t164 = getelementptr inbounds %Node, ptr %t161, i64 %t163
  %t165 = getelementptr inbounds %Node, ptr %t164, i32 0, i32 5
  %t166 = load i32, ptr %t165
  %t167 = call ptr @genExpr(ptr %t156, i32 %t166)
  ret void
L19:
  %t168 = load i32, ptr %t12
  %t169 = load i32, ptr @NK_PRINT
  %t170 = icmp eq i32 %t168, %t169
  br i1 %t170, label %L20, label %L22
L20:
  %t171 = load ptr, ptr %t0
  %t172 = load i32, ptr %t1
  call void @genPrint(ptr %t171, i32 %t172)
  ret void
L22:
  %t173 = load i32, ptr %t12
  %t174 = load i32, ptr @NK_RETURN
  %t175 = icmp eq i32 %t173, %t174
  br i1 %t175, label %L23, label %L25
L23:
  %t176 = load ptr, ptr %t0
  %t177 = getelementptr inbounds %Emitter, ptr %t176, i32 0, i32 0
  %t178 = load ptr, ptr %t177
  %t179 = getelementptr inbounds %Ast, ptr %t178, i32 0, i32 0
  %t180 = load ptr, ptr %t179
  %t181 = load i32, ptr %t1
  %t182 = sext i32 %t181 to i64
  %t183 = getelementptr inbounds %Node, ptr %t180, i64 %t182
  %t184 = getelementptr inbounds %Node, ptr %t183, i32 0, i32 5
  %t185 = load i32, ptr %t184
  %t186 = load i32, ptr @NO_NODE
  %t187 = icmp eq i32 %t185, %t186
  br i1 %t187, label %L26, label %L27
L26:
  %t188 = load ptr, ptr %t0
  call void @emitLine(ptr %t188, ptr @.str.600)
  br label %L28
L27:
  %t189 = load ptr, ptr %t0
  %t190 = load ptr, ptr %t0
  %t191 = getelementptr inbounds %Emitter, ptr %t190, i32 0, i32 0
  %t192 = load ptr, ptr %t191
  %t193 = getelementptr inbounds %Ast, ptr %t192, i32 0, i32 0
  %t194 = load ptr, ptr %t193
  %t195 = load i32, ptr %t1
  %t196 = sext i32 %t195 to i64
  %t197 = getelementptr inbounds %Node, ptr %t194, i64 %t196
  %t198 = getelementptr inbounds %Node, ptr %t197, i32 0, i32 5
  %t199 = load i32, ptr %t198
  %t200 = call %Type @typeOfNode(ptr %t189, i32 %t199)
  %t201 = alloca %Type
  store %Type %t200, ptr %t201
  %t202 = load ptr, ptr %t0
  %t203 = load ptr, ptr %t0
  %t204 = getelementptr inbounds %Emitter, ptr %t203, i32 0, i32 0
  %t205 = load ptr, ptr %t204
  %t206 = getelementptr inbounds %Ast, ptr %t205, i32 0, i32 0
  %t207 = load ptr, ptr %t206
  %t208 = load i32, ptr %t1
  %t209 = sext i32 %t208 to i64
  %t210 = getelementptr inbounds %Node, ptr %t207, i64 %t209
  %t211 = getelementptr inbounds %Node, ptr %t210, i32 0, i32 5
  %t212 = load i32, ptr %t211
  %t213 = call ptr @genExpr(ptr %t202, i32 %t212)
  %t214 = alloca ptr
  store ptr %t213, ptr %t214
  %t215 = call ptr @bufNew()
  %t216 = alloca ptr
  store ptr %t215, ptr %t216
  %t217 = load ptr, ptr %t216
  call void @bufAdd(ptr %t217, ptr @.str.601)
  %t218 = load ptr, ptr %t216
  %t219 = load %Type, ptr %t201
  %t220 = call ptr @llvmTypeName(%Type %t219)
  call void @bufAdd(ptr %t218, ptr %t220)
  %t221 = load ptr, ptr %t216
  call void @bufPush(ptr %t221, i8 32)
  %t222 = load ptr, ptr %t216
  %t223 = load ptr, ptr %t214
  call void @bufAdd(ptr %t222, ptr %t223)
  %t224 = load ptr, ptr %t0
  %t225 = load ptr, ptr %t216
  %t226 = getelementptr inbounds %Buf, ptr %t225, i32 0, i32 0
  %t227 = load ptr, ptr %t226
  call void @emitLine(ptr %t224, ptr %t227)
  br label %L28
L28:
  %t228 = load ptr, ptr %t0
  %t229 = getelementptr inbounds %Emitter, ptr %t228, i32 0, i32 7
  store i1 true, ptr %t229
  ret void
L25:
  %t230 = load i32, ptr %t12
  %t231 = load i32, ptr @NK_IF
  %t232 = icmp eq i32 %t230, %t231
  br i1 %t232, label %L29, label %L31
L29:
  %t233 = load ptr, ptr %t0
  %t234 = load ptr, ptr %t0
  %t235 = getelementptr inbounds %Emitter, ptr %t234, i32 0, i32 0
  %t236 = load ptr, ptr %t235
  %t237 = getelementptr inbounds %Ast, ptr %t236, i32 0, i32 0
  %t238 = load ptr, ptr %t237
  %t239 = load i32, ptr %t1
  %t240 = sext i32 %t239 to i64
  %t241 = getelementptr inbounds %Node, ptr %t238, i64 %t240
  %t242 = getelementptr inbounds %Node, ptr %t241, i32 0, i32 5
  %t243 = load i32, ptr %t242
  %t244 = call ptr @genExpr(ptr %t233, i32 %t243)
  %t245 = alloca ptr
  store ptr %t244, ptr %t245
  %t246 = load ptr, ptr %t0
  %t247 = call ptr @freshLabel(ptr %t246)
  %t248 = alloca ptr
  store ptr %t247, ptr %t248
  %t249 = load ptr, ptr %t0
  %t250 = call ptr @freshLabel(ptr %t249)
  %t251 = alloca ptr
  store ptr %t250, ptr %t251
  %t252 = load ptr, ptr %t0
  %t253 = call ptr @freshLabel(ptr %t252)
  %t254 = alloca ptr
  store ptr %t253, ptr %t254
  %t255 = load ptr, ptr %t0
  %t256 = getelementptr inbounds %Emitter, ptr %t255, i32 0, i32 0
  %t257 = load ptr, ptr %t256
  %t258 = getelementptr inbounds %Ast, ptr %t257, i32 0, i32 0
  %t259 = load ptr, ptr %t258
  %t260 = load i32, ptr %t1
  %t261 = sext i32 %t260 to i64
  %t262 = getelementptr inbounds %Node, ptr %t259, i64 %t261
  %t263 = getelementptr inbounds %Node, ptr %t262, i32 0, i32 7
  %t264 = load i32, ptr %t263
  %t265 = load i32, ptr @NO_NODE
  %t266 = icmp eq i32 %t264, %t265
  br i1 %t266, label %L32, label %L33
L32:
  %t267 = load ptr, ptr %t0
  %t268 = load ptr, ptr %t245
  %t269 = load ptr, ptr %t248
  %t270 = load ptr, ptr %t254
  call void @emitCondBranch(ptr %t267, ptr %t268, ptr %t269, ptr %t270)
  br label %L34
L33:
  %t271 = load ptr, ptr %t0
  %t272 = load ptr, ptr %t245
  %t273 = load ptr, ptr %t248
  %t274 = load ptr, ptr %t251
  call void @emitCondBranch(ptr %t271, ptr %t272, ptr %t273, ptr %t274)
  br label %L34
L34:
  %t275 = load ptr, ptr %t0
  %t276 = load ptr, ptr %t248
  call void @emitLabel(ptr %t275, ptr %t276)
  %t277 = load ptr, ptr %t0
  %t278 = load ptr, ptr %t0
  %t279 = getelementptr inbounds %Emitter, ptr %t278, i32 0, i32 0
  %t280 = load ptr, ptr %t279
  %t281 = getelementptr inbounds %Ast, ptr %t280, i32 0, i32 0
  %t282 = load ptr, ptr %t281
  %t283 = load i32, ptr %t1
  %t284 = sext i32 %t283 to i64
  %t285 = getelementptr inbounds %Node, ptr %t282, i64 %t284
  %t286 = getelementptr inbounds %Node, ptr %t285, i32 0, i32 6
  %t287 = load i32, ptr %t286
  call void @genStatement(ptr %t277, i32 %t287)
  %t288 = load ptr, ptr %t0
  %t289 = load ptr, ptr %t254
  call void @emitBranch(ptr %t288, ptr %t289)
  %t290 = load ptr, ptr %t0
  %t291 = getelementptr inbounds %Emitter, ptr %t290, i32 0, i32 0
  %t292 = load ptr, ptr %t291
  %t293 = getelementptr inbounds %Ast, ptr %t292, i32 0, i32 0
  %t294 = load ptr, ptr %t293
  %t295 = load i32, ptr %t1
  %t296 = sext i32 %t295 to i64
  %t297 = getelementptr inbounds %Node, ptr %t294, i64 %t296
  %t298 = getelementptr inbounds %Node, ptr %t297, i32 0, i32 7
  %t299 = load i32, ptr %t298
  %t300 = load i32, ptr @NO_NODE
  %t301 = icmp ne i32 %t299, %t300
  br i1 %t301, label %L35, label %L37
L35:
  %t302 = load ptr, ptr %t0
  %t303 = load ptr, ptr %t251
  call void @emitLabel(ptr %t302, ptr %t303)
  %t304 = load ptr, ptr %t0
  %t305 = load ptr, ptr %t0
  %t306 = getelementptr inbounds %Emitter, ptr %t305, i32 0, i32 0
  %t307 = load ptr, ptr %t306
  %t308 = getelementptr inbounds %Ast, ptr %t307, i32 0, i32 0
  %t309 = load ptr, ptr %t308
  %t310 = load i32, ptr %t1
  %t311 = sext i32 %t310 to i64
  %t312 = getelementptr inbounds %Node, ptr %t309, i64 %t311
  %t313 = getelementptr inbounds %Node, ptr %t312, i32 0, i32 7
  %t314 = load i32, ptr %t313
  call void @genStatement(ptr %t304, i32 %t314)
  %t315 = load ptr, ptr %t0
  %t316 = load ptr, ptr %t254
  call void @emitBranch(ptr %t315, ptr %t316)
  br label %L37
L37:
  %t317 = load ptr, ptr %t0
  %t318 = load ptr, ptr %t254
  call void @emitLabel(ptr %t317, ptr %t318)
  ret void
L31:
  %t319 = load i32, ptr %t12
  %t320 = load i32, ptr @NK_WHILE
  %t321 = icmp eq i32 %t319, %t320
  br i1 %t321, label %L38, label %L40
L38:
  %t322 = load ptr, ptr %t0
  %t323 = call ptr @freshLabel(ptr %t322)
  %t324 = alloca ptr
  store ptr %t323, ptr %t324
  %t325 = load ptr, ptr %t0
  %t326 = call ptr @freshLabel(ptr %t325)
  %t327 = alloca ptr
  store ptr %t326, ptr %t327
  %t328 = load ptr, ptr %t0
  %t329 = call ptr @freshLabel(ptr %t328)
  %t330 = alloca ptr
  store ptr %t329, ptr %t330
  %t331 = load ptr, ptr %t0
  %t332 = load ptr, ptr %t324
  call void @emitBranch(ptr %t331, ptr %t332)
  %t333 = load ptr, ptr %t0
  %t334 = load ptr, ptr %t324
  call void @emitLabel(ptr %t333, ptr %t334)
  %t335 = load ptr, ptr %t0
  %t336 = load ptr, ptr %t0
  %t337 = getelementptr inbounds %Emitter, ptr %t336, i32 0, i32 0
  %t338 = load ptr, ptr %t337
  %t339 = getelementptr inbounds %Ast, ptr %t338, i32 0, i32 0
  %t340 = load ptr, ptr %t339
  %t341 = load i32, ptr %t1
  %t342 = sext i32 %t341 to i64
  %t343 = getelementptr inbounds %Node, ptr %t340, i64 %t342
  %t344 = getelementptr inbounds %Node, ptr %t343, i32 0, i32 5
  %t345 = load i32, ptr %t344
  %t346 = call ptr @genExpr(ptr %t335, i32 %t345)
  %t347 = alloca ptr
  store ptr %t346, ptr %t347
  %t348 = load ptr, ptr %t0
  %t349 = load ptr, ptr %t347
  %t350 = load ptr, ptr %t327
  %t351 = load ptr, ptr %t330
  call void @emitCondBranch(ptr %t348, ptr %t349, ptr %t350, ptr %t351)
  %t352 = load ptr, ptr %t0
  %t353 = getelementptr inbounds %Emitter, ptr %t352, i32 0, i32 16
  %t354 = load i32, ptr %t353
  %t355 = load ptr, ptr %t0
  %t356 = getelementptr inbounds %Emitter, ptr %t355, i32 0, i32 17
  %t357 = load i32, ptr %t356
  %t358 = icmp eq i32 %t354, %t357
  br i1 %t358, label %L41, label %L43
L41:
  %t359 = load ptr, ptr %t0
  %t360 = getelementptr inbounds %Emitter, ptr %t359, i32 0, i32 17
  %t361 = load i32, ptr %t360
  %t362 = mul i32 %t361, 2
  %t363 = load ptr, ptr %t0
  %t364 = getelementptr inbounds %Emitter, ptr %t363, i32 0, i32 17
  store i32 %t362, ptr %t364
  %t365 = load ptr, ptr %t0
  %t366 = getelementptr inbounds %Emitter, ptr %t365, i32 0, i32 14
  %t367 = load ptr, ptr %t366
  %t368 = load ptr, ptr %t0
  %t369 = getelementptr inbounds %Emitter, ptr %t368, i32 0, i32 17
  %t370 = load i32, ptr %t369
  %t371 = sext i32 %t370 to i64
  %t372 = mul i64 8, %t371
  %t373 = call ptr @realloc(ptr %t367, i64 %t372)
  %t374 = load ptr, ptr %t0
  %t375 = getelementptr inbounds %Emitter, ptr %t374, i32 0, i32 14
  store ptr %t373, ptr %t375
  %t376 = load ptr, ptr %t0
  %t377 = getelementptr inbounds %Emitter, ptr %t376, i32 0, i32 15
  %t378 = load ptr, ptr %t377
  %t379 = load ptr, ptr %t0
  %t380 = getelementptr inbounds %Emitter, ptr %t379, i32 0, i32 17
  %t381 = load i32, ptr %t380
  %t382 = sext i32 %t381 to i64
  %t383 = mul i64 8, %t382
  %t384 = call ptr @realloc(ptr %t378, i64 %t383)
  %t385 = load ptr, ptr %t0
  %t386 = getelementptr inbounds %Emitter, ptr %t385, i32 0, i32 15
  store ptr %t384, ptr %t386
  br label %L43
L43:
  %t387 = load ptr, ptr %t324
  %t388 = load ptr, ptr %t0
  %t389 = getelementptr inbounds %Emitter, ptr %t388, i32 0, i32 14
  %t390 = load ptr, ptr %t389
  %t391 = load ptr, ptr %t0
  %t392 = getelementptr inbounds %Emitter, ptr %t391, i32 0, i32 16
  %t393 = load i32, ptr %t392
  %t394 = sext i32 %t393 to i64
  %t395 = getelementptr inbounds ptr, ptr %t390, i64 %t394
  store ptr %t387, ptr %t395
  %t396 = load ptr, ptr %t330
  %t397 = load ptr, ptr %t0
  %t398 = getelementptr inbounds %Emitter, ptr %t397, i32 0, i32 15
  %t399 = load ptr, ptr %t398
  %t400 = load ptr, ptr %t0
  %t401 = getelementptr inbounds %Emitter, ptr %t400, i32 0, i32 16
  %t402 = load i32, ptr %t401
  %t403 = sext i32 %t402 to i64
  %t404 = getelementptr inbounds ptr, ptr %t399, i64 %t403
  store ptr %t396, ptr %t404
  %t405 = load ptr, ptr %t0
  %t406 = getelementptr inbounds %Emitter, ptr %t405, i32 0, i32 16
  %t407 = load i32, ptr %t406
  %t408 = add i32 %t407, 1
  %t409 = load ptr, ptr %t0
  %t410 = getelementptr inbounds %Emitter, ptr %t409, i32 0, i32 16
  store i32 %t408, ptr %t410
  %t411 = load ptr, ptr %t0
  %t412 = load ptr, ptr %t327
  call void @emitLabel(ptr %t411, ptr %t412)
  %t413 = load ptr, ptr %t0
  %t414 = load ptr, ptr %t0
  %t415 = getelementptr inbounds %Emitter, ptr %t414, i32 0, i32 0
  %t416 = load ptr, ptr %t415
  %t417 = getelementptr inbounds %Ast, ptr %t416, i32 0, i32 0
  %t418 = load ptr, ptr %t417
  %t419 = load i32, ptr %t1
  %t420 = sext i32 %t419 to i64
  %t421 = getelementptr inbounds %Node, ptr %t418, i64 %t420
  %t422 = getelementptr inbounds %Node, ptr %t421, i32 0, i32 6
  %t423 = load i32, ptr %t422
  call void @genStatement(ptr %t413, i32 %t423)
  %t424 = load ptr, ptr %t0
  %t425 = load ptr, ptr %t324
  call void @emitBranch(ptr %t424, ptr %t425)
  %t426 = load ptr, ptr %t0
  %t427 = getelementptr inbounds %Emitter, ptr %t426, i32 0, i32 16
  %t428 = load i32, ptr %t427
  %t429 = sub i32 %t428, 1
  %t430 = load ptr, ptr %t0
  %t431 = getelementptr inbounds %Emitter, ptr %t430, i32 0, i32 16
  store i32 %t429, ptr %t431
  %t432 = load ptr, ptr %t0
  %t433 = load ptr, ptr %t330
  call void @emitLabel(ptr %t432, ptr %t433)
  ret void
L40:
  %t434 = load i32, ptr %t12
  %t435 = load i32, ptr @NK_BREAK
  %t436 = icmp eq i32 %t434, %t435
  br i1 %t436, label %L44, label %L46
L44:
  %t437 = load ptr, ptr %t0
  %t438 = load ptr, ptr %t0
  %t439 = getelementptr inbounds %Emitter, ptr %t438, i32 0, i32 15
  %t440 = load ptr, ptr %t439
  %t441 = load ptr, ptr %t0
  %t442 = getelementptr inbounds %Emitter, ptr %t441, i32 0, i32 16
  %t443 = load i32, ptr %t442
  %t444 = sub i32 %t443, 1
  %t445 = sext i32 %t444 to i64
  %t446 = getelementptr inbounds ptr, ptr %t440, i64 %t445
  %t447 = load ptr, ptr %t446
  call void @emitBranch(ptr %t437, ptr %t447)
  %t448 = load ptr, ptr %t0
  %t449 = load ptr, ptr %t0
  %t450 = call ptr @freshLabel(ptr %t449)
  call void @emitLabel(ptr %t448, ptr %t450)
  ret void
L46:
  %t451 = load i32, ptr %t12
  %t452 = load i32, ptr @NK_CONTINUE
  %t453 = icmp eq i32 %t451, %t452
  br i1 %t453, label %L47, label %L49
L47:
  %t454 = load ptr, ptr %t0
  %t455 = load ptr, ptr %t0
  %t456 = getelementptr inbounds %Emitter, ptr %t455, i32 0, i32 14
  %t457 = load ptr, ptr %t456
  %t458 = load ptr, ptr %t0
  %t459 = getelementptr inbounds %Emitter, ptr %t458, i32 0, i32 16
  %t460 = load i32, ptr %t459
  %t461 = sub i32 %t460, 1
  %t462 = sext i32 %t461 to i64
  %t463 = getelementptr inbounds ptr, ptr %t457, i64 %t462
  %t464 = load ptr, ptr %t463
  call void @emitBranch(ptr %t454, ptr %t464)
  %t465 = load ptr, ptr %t0
  %t466 = load ptr, ptr %t0
  %t467 = call ptr @freshLabel(ptr %t466)
  call void @emitLabel(ptr %t465, ptr %t467)
  ret void
L49:
  %t468 = load ptr, ptr %t0
  %t469 = getelementptr inbounds %Emitter, ptr %t468, i32 0, i32 0
  %t470 = load ptr, ptr %t469
  %t471 = getelementptr inbounds %Ast, ptr %t470, i32 0, i32 0
  %t472 = load ptr, ptr %t471
  %t473 = load i32, ptr %t1
  %t474 = sext i32 %t473 to i64
  %t475 = getelementptr inbounds %Node, ptr %t472, i64 %t474
  %t476 = getelementptr inbounds %Node, ptr %t475, i32 0, i32 1
  %t477 = load i32, ptr %t476
  %t478 = load ptr, ptr %t0
  %t479 = getelementptr inbounds %Emitter, ptr %t478, i32 0, i32 0
  %t480 = load ptr, ptr %t479
  %t481 = getelementptr inbounds %Ast, ptr %t480, i32 0, i32 0
  %t482 = load ptr, ptr %t481
  %t483 = load i32, ptr %t1
  %t484 = sext i32 %t483 to i64
  %t485 = getelementptr inbounds %Node, ptr %t482, i64 %t484
  %t486 = getelementptr inbounds %Node, ptr %t485, i32 0, i32 2
  %t487 = load i32, ptr %t486
  call void @failAt(i32 %t477, i32 %t487, ptr @.str.602)
  ret void
}

define void @emitSignature(ptr %p0, ptr %p1, i32 %p2, ptr %p3) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %Emitter, ptr %t4, i32 0, i32 1
  %t6 = load ptr, ptr %t5
  %t7 = load ptr, ptr %t0
  %t8 = getelementptr inbounds %Emitter, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = getelementptr inbounds %Ast, ptr %t9, i32 0, i32 0
  %t11 = load ptr, ptr %t10
  %t12 = load i32, ptr %t2
  %t13 = sext i32 %t12 to i64
  %t14 = getelementptr inbounds %Node, ptr %t11, i64 %t13
  %t15 = getelementptr inbounds %Node, ptr %t14, i32 0, i32 5
  %t16 = load i32, ptr %t15
  %t17 = call %Type @analyzerParseType(ptr %t6, i32 %t16)
  %t18 = alloca %Type
  store %Type %t17, ptr %t18
  %t19 = load ptr, ptr %t1
  %t20 = load ptr, ptr %t3
  call void @bufAdd(ptr %t19, ptr %t20)
  %t21 = load ptr, ptr %t1
  call void @bufPush(ptr %t21, i8 32)
  %t22 = load ptr, ptr %t1
  %t23 = load %Type, ptr %t18
  %t24 = call ptr @llvmTypeName(%Type %t23)
  call void @bufAdd(ptr %t22, ptr %t24)
  %t25 = load ptr, ptr %t1
  call void @bufAdd(ptr %t25, ptr @.str.603)
  %t26 = load ptr, ptr %t1
  %t27 = load ptr, ptr %t0
  %t28 = getelementptr inbounds %Emitter, ptr %t27, i32 0, i32 1
  %t29 = load ptr, ptr %t28
  %t30 = getelementptr inbounds %Analyzer, ptr %t29, i32 0, i32 5
  %t31 = load ptr, ptr %t30
  %t32 = load i32, ptr %t2
  %t33 = sext i32 %t32 to i64
  %t34 = getelementptr inbounds ptr, ptr %t31, i64 %t33
  %t35 = load ptr, ptr %t34
  call void @bufAdd(ptr %t26, ptr %t35)
  %t36 = load ptr, ptr %t1
  call void @bufPush(ptr %t36, i8 40)
  %t37 = load ptr, ptr %t0
  %t38 = getelementptr inbounds %Emitter, ptr %t37, i32 0, i32 0
  %t39 = load ptr, ptr %t38
  %t40 = getelementptr inbounds %Ast, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t2
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds %Node, ptr %t41, i64 %t43
  %t45 = getelementptr inbounds %Node, ptr %t44, i32 0, i32 6
  %t46 = load i32, ptr %t45
  %t47 = alloca i32
  store i32 %t46, ptr %t47
  %t48 = alloca i32
  store i32 0, ptr %t48
  %t49 = load i32, ptr %t47
  %t50 = load i32, ptr @NO_NODE
  %t51 = icmp ne i32 %t49, %t50
  br i1 %t51, label %L0, label %L2
L0:
  %t52 = load ptr, ptr %t0
  %t53 = getelementptr inbounds %Emitter, ptr %t52, i32 0, i32 0
  %t54 = load ptr, ptr %t53
  %t55 = getelementptr inbounds %Ast, ptr %t54, i32 0, i32 0
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t47
  %t58 = sext i32 %t57 to i64
  %t59 = getelementptr inbounds %Node, ptr %t56, i64 %t58
  %t60 = getelementptr inbounds %Node, ptr %t59, i32 0, i32 10
  %t61 = load i32, ptr %t60
  store i32 %t61, ptr %t48
  br label %L2
L2:
  %t62 = alloca i32
  store i32 0, ptr %t62
  br label %L3
L3:
  %t63 = load i32, ptr %t62
  %t64 = load i32, ptr %t48
  %t65 = icmp slt i32 %t63, %t64
  br i1 %t65, label %L4, label %L5
L4:
  %t66 = load i32, ptr %t62
  %t67 = icmp sgt i32 %t66, 0
  br i1 %t67, label %L6, label %L8
L6:
  %t68 = load ptr, ptr %t1
  call void @bufAdd(ptr %t68, ptr @.str.604)
  br label %L8
L8:
  %t69 = load ptr, ptr %t0
  %t70 = getelementptr inbounds %Emitter, ptr %t69, i32 0, i32 0
  %t71 = load ptr, ptr %t70
  %t72 = getelementptr inbounds %Ast, ptr %t71, i32 0, i32 0
  %t73 = load ptr, ptr %t72
  %t74 = load i32, ptr %t47
  %t75 = sext i32 %t74 to i64
  %t76 = getelementptr inbounds %Node, ptr %t73, i64 %t75
  %t77 = getelementptr inbounds %Node, ptr %t76, i32 0, i32 9
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr %t62
  %t80 = sext i32 %t79 to i64
  %t81 = getelementptr inbounds i32, ptr %t78, i64 %t80
  %t82 = load i32, ptr %t81
  %t83 = alloca i32
  store i32 %t82, ptr %t83
  %t84 = load ptr, ptr %t1
  %t85 = load ptr, ptr %t0
  %t86 = getelementptr inbounds %Emitter, ptr %t85, i32 0, i32 1
  %t87 = load ptr, ptr %t86
  %t88 = load ptr, ptr %t0
  %t89 = getelementptr inbounds %Emitter, ptr %t88, i32 0, i32 0
  %t90 = load ptr, ptr %t89
  %t91 = getelementptr inbounds %Ast, ptr %t90, i32 0, i32 0
  %t92 = load ptr, ptr %t91
  %t93 = load i32, ptr %t83
  %t94 = sext i32 %t93 to i64
  %t95 = getelementptr inbounds %Node, ptr %t92, i64 %t94
  %t96 = getelementptr inbounds %Node, ptr %t95, i32 0, i32 5
  %t97 = load i32, ptr %t96
  %t98 = call %Type @analyzerParseType(ptr %t87, i32 %t97)
  %t99 = call ptr @llvmTypeName(%Type %t98)
  call void @bufAdd(ptr %t84, ptr %t99)
  %t100 = load ptr, ptr %t3
  %t101 = call i1 @textEquals(ptr %t100, ptr @.str.605)
  br i1 %t101, label %L9, label %L11
L9:
  %t102 = load ptr, ptr %t1
  call void @bufAdd(ptr %t102, ptr @.str.606)
  %t103 = load ptr, ptr %t1
  %t104 = load i32, ptr %t62
  %t105 = sext i32 %t104 to i64
  call void @bufAddInt(ptr %t103, i64 %t105)
  br label %L11
L11:
  %t106 = load i32, ptr %t62
  %t107 = add i32 %t106, 1
  store i32 %t107, ptr %t62
  br label %L3
L5:
  %t108 = load ptr, ptr %t1
  call void @bufPush(ptr %t108, i8 41)
  ret void
}

define void @genFunction(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 1
  %t4 = load ptr, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = getelementptr inbounds %Ast, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr %t1
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr inbounds %Node, ptr %t9, i64 %t11
  %t13 = getelementptr inbounds %Node, ptr %t12, i32 0, i32 5
  %t14 = load i32, ptr %t13
  %t15 = call %Type @analyzerParseType(ptr %t4, i32 %t14)
  %t16 = alloca %Type
  store %Type %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = getelementptr inbounds %Emitter, ptr %t17, i32 0, i32 4
  store i32 0, ptr %t18
  %t19 = load ptr, ptr %t0
  %t20 = getelementptr inbounds %Emitter, ptr %t19, i32 0, i32 5
  store i32 0, ptr %t20
  %t21 = load ptr, ptr %t0
  %t22 = getelementptr inbounds %Emitter, ptr %t21, i32 0, i32 7
  store i1 false, ptr %t22
  %t23 = load ptr, ptr %t0
  %t24 = load ptr, ptr %t0
  %t25 = getelementptr inbounds %Emitter, ptr %t24, i32 0, i32 3
  %t26 = load ptr, ptr %t25
  %t27 = load i32, ptr %t1
  call void @emitSignature(ptr %t23, ptr %t26, i32 %t27, ptr @.str.607)
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Emitter, ptr %t28, i32 0, i32 3
  %t30 = load ptr, ptr %t29
  call void @bufAdd(ptr %t30, ptr @.str.608)
  %t31 = load ptr, ptr %t0
  call void @emitterEnterScope(ptr %t31)
  %t32 = load ptr, ptr %t0
  %t33 = getelementptr inbounds %Emitter, ptr %t32, i32 0, i32 0
  %t34 = load ptr, ptr %t33
  %t35 = getelementptr inbounds %Ast, ptr %t34, i32 0, i32 0
  %t36 = load ptr, ptr %t35
  %t37 = load i32, ptr %t1
  %t38 = sext i32 %t37 to i64
  %t39 = getelementptr inbounds %Node, ptr %t36, i64 %t38
  %t40 = getelementptr inbounds %Node, ptr %t39, i32 0, i32 6
  %t41 = load i32, ptr %t40
  %t42 = alloca i32
  store i32 %t41, ptr %t42
  %t43 = load i32, ptr %t42
  %t44 = load i32, ptr @NO_NODE
  %t45 = icmp ne i32 %t43, %t44
  br i1 %t45, label %L0, label %L2
L0:
  %t46 = alloca i32
  store i32 0, ptr %t46
  br label %L3
L3:
  %t47 = load i32, ptr %t46
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Emitter, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %Ast, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t42
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %Node, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %Node, ptr %t55, i32 0, i32 10
  %t57 = load i32, ptr %t56
  %t58 = icmp slt i32 %t47, %t57
  br i1 %t58, label %L4, label %L5
L4:
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Emitter, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = getelementptr inbounds %Ast, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t42
  %t65 = sext i32 %t64 to i64
  %t66 = getelementptr inbounds %Node, ptr %t63, i64 %t65
  %t67 = getelementptr inbounds %Node, ptr %t66, i32 0, i32 9
  %t68 = load ptr, ptr %t67
  %t69 = load i32, ptr %t46
  %t70 = sext i32 %t69 to i64
  %t71 = getelementptr inbounds i32, ptr %t68, i64 %t70
  %t72 = load i32, ptr %t71
  %t73 = alloca i32
  store i32 %t72, ptr %t73
  %t74 = load ptr, ptr %t0
  %t75 = getelementptr inbounds %Emitter, ptr %t74, i32 0, i32 1
  %t76 = load ptr, ptr %t75
  %t77 = load ptr, ptr %t0
  %t78 = getelementptr inbounds %Emitter, ptr %t77, i32 0, i32 0
  %t79 = load ptr, ptr %t78
  %t80 = getelementptr inbounds %Ast, ptr %t79, i32 0, i32 0
  %t81 = load ptr, ptr %t80
  %t82 = load i32, ptr %t73
  %t83 = sext i32 %t82 to i64
  %t84 = getelementptr inbounds %Node, ptr %t81, i64 %t83
  %t85 = getelementptr inbounds %Node, ptr %t84, i32 0, i32 5
  %t86 = load i32, ptr %t85
  %t87 = call %Type @analyzerParseType(ptr %t76, i32 %t86)
  %t88 = alloca %Type
  store %Type %t87, ptr %t88
  %t89 = call ptr @bufNew()
  %t90 = alloca ptr
  store ptr %t89, ptr %t90
  %t91 = load ptr, ptr %t90
  call void @bufAdd(ptr %t91, ptr @.str.609)
  %t92 = load ptr, ptr %t90
  %t93 = load %Type, ptr %t88
  %t94 = call ptr @llvmTypeName(%Type %t93)
  call void @bufAdd(ptr %t92, ptr %t94)
  %t95 = load ptr, ptr %t0
  %t96 = load ptr, ptr %t90
  %t97 = getelementptr inbounds %Buf, ptr %t96, i32 0, i32 0
  %t98 = load ptr, ptr %t97
  %t99 = call ptr @emitAssign(ptr %t95, ptr %t98)
  %t100 = alloca ptr
  store ptr %t99, ptr %t100
  %t101 = call ptr @bufNew()
  %t102 = alloca ptr
  store ptr %t101, ptr %t102
  %t103 = load ptr, ptr %t102
  call void @bufAdd(ptr %t103, ptr @.str.610)
  %t104 = load ptr, ptr %t102
  %t105 = load i32, ptr %t46
  %t106 = sext i32 %t105 to i64
  call void @bufAddInt(ptr %t104, i64 %t106)
  %t107 = load ptr, ptr %t0
  %t108 = load %Type, ptr %t88
  %t109 = load ptr, ptr %t102
  %t110 = getelementptr inbounds %Buf, ptr %t109, i32 0, i32 0
  %t111 = load ptr, ptr %t110
  %t112 = load ptr, ptr %t100
  call void @emitStore(ptr %t107, %Type %t108, ptr %t111, ptr %t112)
  %t113 = load ptr, ptr %t0
  %t114 = load ptr, ptr %t0
  %t115 = getelementptr inbounds %Emitter, ptr %t114, i32 0, i32 0
  %t116 = load ptr, ptr %t115
  %t117 = getelementptr inbounds %Ast, ptr %t116, i32 0, i32 0
  %t118 = load ptr, ptr %t117
  %t119 = load i32, ptr %t73
  %t120 = sext i32 %t119 to i64
  %t121 = getelementptr inbounds %Node, ptr %t118, i64 %t120
  %t122 = getelementptr inbounds %Node, ptr %t121, i32 0, i32 3
  %t123 = load ptr, ptr %t122
  %t124 = load ptr, ptr %t100
  %t125 = load %Type, ptr %t88
  call void @declareLocal(ptr %t113, ptr %t123, ptr %t124, %Type %t125)
  %t126 = load i32, ptr %t46
  %t127 = add i32 %t126, 1
  store i32 %t127, ptr %t46
  br label %L3
L5:
  br label %L2
L2:
  %t128 = load ptr, ptr %t0
  %t129 = load ptr, ptr %t0
  %t130 = getelementptr inbounds %Emitter, ptr %t129, i32 0, i32 0
  %t131 = load ptr, ptr %t130
  %t132 = getelementptr inbounds %Ast, ptr %t131, i32 0, i32 0
  %t133 = load ptr, ptr %t132
  %t134 = load i32, ptr %t1
  %t135 = sext i32 %t134 to i64
  %t136 = getelementptr inbounds %Node, ptr %t133, i64 %t135
  %t137 = getelementptr inbounds %Node, ptr %t136, i32 0, i32 7
  %t138 = load i32, ptr %t137
  call void @genStatement(ptr %t128, i32 %t138)
  %t139 = load ptr, ptr %t0
  %t140 = getelementptr inbounds %Emitter, ptr %t139, i32 0, i32 7
  %t141 = load i1, ptr %t140
  %t142 = xor i1 %t141, true
  br i1 %t142, label %L6, label %L8
L6:
  %t143 = load %Type, ptr %t16
  %t144 = call i1 @typeIsVoid(%Type %t143)
  br i1 %t144, label %L9, label %L10
L9:
  %t145 = load ptr, ptr %t0
  call void @emitLine(ptr %t145, ptr @.str.611)
  br label %L11
L10:
  %t146 = call ptr @bufNew()
  %t147 = alloca ptr
  store ptr %t146, ptr %t147
  %t148 = load ptr, ptr %t147
  call void @bufAdd(ptr %t148, ptr @.str.612)
  %t149 = load ptr, ptr %t147
  %t150 = load %Type, ptr %t16
  %t151 = call ptr @llvmTypeName(%Type %t150)
  call void @bufAdd(ptr %t149, ptr %t151)
  %t152 = load ptr, ptr %t147
  call void @bufPush(ptr %t152, i8 32)
  %t153 = load ptr, ptr %t147
  %t154 = load %Type, ptr %t16
  %t155 = call ptr @zeroValue(%Type %t154)
  call void @bufAdd(ptr %t153, ptr %t155)
  %t156 = load ptr, ptr %t0
  %t157 = load ptr, ptr %t147
  %t158 = getelementptr inbounds %Buf, ptr %t157, i32 0, i32 0
  %t159 = load ptr, ptr %t158
  call void @emitLine(ptr %t156, ptr %t159)
  br label %L11
L11:
  br label %L8
L8:
  %t160 = load ptr, ptr %t0
  call void @emitterExitScope(ptr %t160)
  %t161 = load ptr, ptr %t0
  %t162 = getelementptr inbounds %Emitter, ptr %t161, i32 0, i32 3
  %t163 = load ptr, ptr %t162
  call void @bufAdd(ptr %t163, ptr @.str.613)
  ret void
}

define ptr @genConstant(ptr %p0, i32 %p1, %Type %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca %Type
  store %Type %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Emitter, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = getelementptr inbounds %Ast, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = load i32, ptr %t1
  %t9 = sext i32 %t8 to i64
  %t10 = getelementptr inbounds %Node, ptr %t7, i64 %t9
  %t11 = getelementptr inbounds %Node, ptr %t10, i32 0, i32 0
  %t12 = load i32, ptr %t11
  %t13 = alloca i32
  store i32 %t12, ptr %t13
  %t14 = load i32, ptr %t13
  %t15 = load i32, ptr @NK_STRING
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L0, label %L2
L0:
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %Emitter, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t1
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 3
  %t27 = load ptr, ptr %t26
  %t28 = load ptr, ptr %t0
  %t29 = getelementptr inbounds %Emitter, ptr %t28, i32 0, i32 0
  %t30 = load ptr, ptr %t29
  %t31 = getelementptr inbounds %Ast, ptr %t30, i32 0, i32 0
  %t32 = load ptr, ptr %t31
  %t33 = load i32, ptr %t1
  %t34 = sext i32 %t33 to i64
  %t35 = getelementptr inbounds %Node, ptr %t32, i64 %t34
  %t36 = getelementptr inbounds %Node, ptr %t35, i32 0, i32 4
  %t37 = load i64, ptr %t36
  %t38 = call ptr @internString(ptr %t17, ptr %t27, i64 %t37)
  ret ptr %t38
L2:
  %t39 = load i32, ptr %t13
  %t40 = load i32, ptr @NK_CAST
  %t41 = icmp eq i32 %t39, %t40
  br i1 %t41, label %L3, label %L5
L3:
  %t42 = load ptr, ptr %t0
  %t43 = load ptr, ptr %t0
  %t44 = getelementptr inbounds %Emitter, ptr %t43, i32 0, i32 0
  %t45 = load ptr, ptr %t44
  %t46 = getelementptr inbounds %Ast, ptr %t45, i32 0, i32 0
  %t47 = load ptr, ptr %t46
  %t48 = load i32, ptr %t1
  %t49 = sext i32 %t48 to i64
  %t50 = getelementptr inbounds %Node, ptr %t47, i64 %t49
  %t51 = getelementptr inbounds %Node, ptr %t50, i32 0, i32 5
  %t52 = load i32, ptr %t51
  %t53 = load %Type, ptr %t2
  %t54 = call ptr @genConstant(ptr %t42, i32 %t52, %Type %t53)
  ret ptr %t54
L5:
  %t55 = load i32, ptr %t13
  %t56 = load i32, ptr @NK_UNARY
  %t57 = icmp eq i32 %t55, %t56
  br i1 %t57, label %L6, label %L8
L6:
  %t58 = load ptr, ptr %t0
  %t59 = load ptr, ptr %t0
  %t60 = getelementptr inbounds %Emitter, ptr %t59, i32 0, i32 0
  %t61 = load ptr, ptr %t60
  %t62 = getelementptr inbounds %Ast, ptr %t61, i32 0, i32 0
  %t63 = load ptr, ptr %t62
  %t64 = load i32, ptr %t1
  %t65 = sext i32 %t64 to i64
  %t66 = getelementptr inbounds %Node, ptr %t63, i64 %t65
  %t67 = getelementptr inbounds %Node, ptr %t66, i32 0, i32 5
  %t68 = load i32, ptr %t67
  %t69 = load %Type, ptr %t2
  %t70 = call ptr @genConstant(ptr %t58, i32 %t68, %Type %t69)
  %t71 = alloca ptr
  store ptr %t70, ptr %t71
  %t72 = call ptr @bufNew()
  %t73 = alloca ptr
  store ptr %t72, ptr %t73
  %t74 = load ptr, ptr %t73
  call void @bufPush(ptr %t74, i8 45)
  %t75 = load ptr, ptr %t73
  %t76 = load ptr, ptr %t71
  call void @bufAdd(ptr %t75, ptr %t76)
  %t77 = load ptr, ptr %t73
  %t78 = call ptr @bufTake(ptr %t77)
  ret ptr %t78
L8:
  %t79 = load i32, ptr %t13
  %t80 = load i32, ptr @NK_SIZEOF
  %t81 = icmp eq i32 %t79, %t80
  br i1 %t81, label %L9, label %L11
L9:
  %t82 = load ptr, ptr %t0
  %t83 = load ptr, ptr %t0
  %t84 = getelementptr inbounds %Emitter, ptr %t83, i32 0, i32 1
  %t85 = load ptr, ptr %t84
  %t86 = load ptr, ptr %t0
  %t87 = getelementptr inbounds %Emitter, ptr %t86, i32 0, i32 0
  %t88 = load ptr, ptr %t87
  %t89 = getelementptr inbounds %Ast, ptr %t88, i32 0, i32 0
  %t90 = load ptr, ptr %t89
  %t91 = load i32, ptr %t1
  %t92 = sext i32 %t91 to i64
  %t93 = getelementptr inbounds %Node, ptr %t90, i64 %t92
  %t94 = getelementptr inbounds %Node, ptr %t93, i32 0, i32 5
  %t95 = load i32, ptr %t94
  %t96 = call %Type @analyzerParseType(ptr %t85, i32 %t95)
  %t97 = call i32 @sizeOfType(ptr %t82, %Type %t96)
  %t98 = sext i32 %t97 to i64
  %t99 = call ptr @intToText(i64 %t98)
  ret ptr %t99
L11:
  %t100 = load i32, ptr %t13
  %t101 = load i32, ptr @NK_BOOL
  %t102 = icmp eq i32 %t100, %t101
  br i1 %t102, label %L12, label %L14
L12:
  %t103 = load ptr, ptr %t0
  %t104 = getelementptr inbounds %Emitter, ptr %t103, i32 0, i32 0
  %t105 = load ptr, ptr %t104
  %t106 = getelementptr inbounds %Ast, ptr %t105, i32 0, i32 0
  %t107 = load ptr, ptr %t106
  %t108 = load i32, ptr %t1
  %t109 = sext i32 %t108 to i64
  %t110 = getelementptr inbounds %Node, ptr %t107, i64 %t109
  %t111 = getelementptr inbounds %Node, ptr %t110, i32 0, i32 3
  %t112 = load ptr, ptr %t111
  %t113 = call i1 @textEquals(ptr %t112, ptr @.str.614)
  br i1 %t113, label %L15, label %L17
L15:
  ret ptr @.str.615
L17:
  ret ptr @.str.616
L14:
  %t114 = load i32, ptr %t13
  %t115 = load i32, ptr @NK_CHAR
  %t116 = icmp eq i32 %t114, %t115
  br i1 %t116, label %L18, label %L20
L18:
  %t117 = load ptr, ptr %t0
  %t118 = getelementptr inbounds %Emitter, ptr %t117, i32 0, i32 0
  %t119 = load ptr, ptr %t118
  %t120 = getelementptr inbounds %Ast, ptr %t119, i32 0, i32 0
  %t121 = load ptr, ptr %t120
  %t122 = load i32, ptr %t1
  %t123 = sext i32 %t122 to i64
  %t124 = getelementptr inbounds %Node, ptr %t121, i64 %t123
  %t125 = getelementptr inbounds %Node, ptr %t124, i32 0, i32 3
  %t126 = load ptr, ptr %t125
  %t127 = sext i32 0 to i64
  %t128 = getelementptr inbounds i8, ptr %t126, i64 %t127
  %t129 = load i8, ptr %t128
  %t130 = sext i8 %t129 to i32
  %t131 = alloca i32
  store i32 %t130, ptr %t131
  %t132 = load i32, ptr %t131
  %t133 = icmp slt i32 %t132, 0
  br i1 %t133, label %L21, label %L23
L21:
  %t134 = load i32, ptr %t131
  %t135 = add i32 %t134, 256
  store i32 %t135, ptr %t131
  br label %L23
L23:
  %t136 = load i32, ptr %t131
  %t137 = icmp sgt i32 %t136, 127
  br i1 %t137, label %L24, label %L26
L24:
  %t138 = load i32, ptr %t131
  %t139 = sub i32 %t138, 256
  store i32 %t139, ptr %t131
  br label %L26
L26:
  %t140 = load i32, ptr %t131
  %t141 = sext i32 %t140 to i64
  %t142 = call ptr @intToText(i64 %t141)
  ret ptr %t142
L20:
  %t143 = load %Type, ptr %t2
  %t144 = call i1 @typeIsPointer(%Type %t143)
  br i1 %t144, label %L27, label %L29
L27:
  %t145 = load ptr, ptr %t0
  %t146 = load i32, ptr %t1
  %t147 = call ptr @genNumberLiteral(ptr %t145, i32 %t146)
  %t148 = alloca ptr
  store ptr %t147, ptr %t148
  %t149 = load ptr, ptr %t148
  %t150 = call i1 @textEquals(ptr %t149, ptr @.str.617)
  br i1 %t150, label %L30, label %L32
L30:
  ret ptr @.str.618
L32:
  %t151 = call ptr @bufNew()
  %t152 = alloca ptr
  store ptr %t151, ptr %t152
  %t153 = load ptr, ptr %t152
  call void @bufAdd(ptr %t153, ptr @.str.619)
  %t154 = load ptr, ptr %t152
  %t155 = load ptr, ptr %t148
  call void @bufAdd(ptr %t154, ptr %t155)
  %t156 = load ptr, ptr %t152
  call void @bufAdd(ptr %t156, ptr @.str.620)
  %t157 = load ptr, ptr %t152
  %t158 = call ptr @bufTake(ptr %t157)
  ret ptr %t158
L29:
  %t159 = load ptr, ptr %t0
  %t160 = load i32, ptr %t1
  %t161 = call ptr @genNumberLiteral(ptr %t159, i32 %t160)
  ret ptr %t161
}

define void @genGlobal(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 1
  %t4 = load ptr, ptr %t3
  %t5 = load ptr, ptr %t0
  %t6 = getelementptr inbounds %Emitter, ptr %t5, i32 0, i32 0
  %t7 = load ptr, ptr %t6
  %t8 = getelementptr inbounds %Ast, ptr %t7, i32 0, i32 0
  %t9 = load ptr, ptr %t8
  %t10 = load i32, ptr %t1
  %t11 = sext i32 %t10 to i64
  %t12 = getelementptr inbounds %Node, ptr %t9, i64 %t11
  %t13 = getelementptr inbounds %Node, ptr %t12, i32 0, i32 5
  %t14 = load i32, ptr %t13
  %t15 = call %Type @analyzerParseType(ptr %t4, i32 %t14)
  %t16 = alloca %Type
  store %Type %t15, ptr %t16
  %t17 = load ptr, ptr %t0
  %t18 = load ptr, ptr %t0
  %t19 = getelementptr inbounds %Emitter, ptr %t18, i32 0, i32 0
  %t20 = load ptr, ptr %t19
  %t21 = getelementptr inbounds %Ast, ptr %t20, i32 0, i32 0
  %t22 = load ptr, ptr %t21
  %t23 = load i32, ptr %t1
  %t24 = sext i32 %t23 to i64
  %t25 = getelementptr inbounds %Node, ptr %t22, i64 %t24
  %t26 = getelementptr inbounds %Node, ptr %t25, i32 0, i32 6
  %t27 = load i32, ptr %t26
  %t28 = load %Type, ptr %t16
  %t29 = call ptr @genConstant(ptr %t17, i32 %t27, %Type %t28)
  %t30 = alloca ptr
  store ptr %t29, ptr %t30
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Emitter, ptr %t31, i32 0, i32 2
  %t33 = load ptr, ptr %t32
  call void @bufPush(ptr %t33, i8 64)
  %t34 = load ptr, ptr %t0
  %t35 = getelementptr inbounds %Emitter, ptr %t34, i32 0, i32 2
  %t36 = load ptr, ptr %t35
  %t37 = load ptr, ptr %t0
  %t38 = getelementptr inbounds %Emitter, ptr %t37, i32 0, i32 1
  %t39 = load ptr, ptr %t38
  %t40 = getelementptr inbounds %Analyzer, ptr %t39, i32 0, i32 5
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t1
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds ptr, ptr %t41, i64 %t43
  %t45 = load ptr, ptr %t44
  call void @bufAdd(ptr %t36, ptr %t45)
  %t46 = load ptr, ptr %t0
  %t47 = getelementptr inbounds %Emitter, ptr %t46, i32 0, i32 2
  %t48 = load ptr, ptr %t47
  call void @bufAdd(ptr %t48, ptr @.str.621)
  %t49 = load ptr, ptr %t0
  %t50 = getelementptr inbounds %Emitter, ptr %t49, i32 0, i32 2
  %t51 = load ptr, ptr %t50
  %t52 = load %Type, ptr %t16
  %t53 = call ptr @llvmTypeName(%Type %t52)
  call void @bufAdd(ptr %t51, ptr %t53)
  %t54 = load ptr, ptr %t0
  %t55 = getelementptr inbounds %Emitter, ptr %t54, i32 0, i32 2
  %t56 = load ptr, ptr %t55
  call void @bufPush(ptr %t56, i8 32)
  %t57 = load ptr, ptr %t0
  %t58 = getelementptr inbounds %Emitter, ptr %t57, i32 0, i32 2
  %t59 = load ptr, ptr %t58
  %t60 = load ptr, ptr %t30
  call void @bufAdd(ptr %t59, ptr %t60)
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Emitter, ptr %t61, i32 0, i32 2
  %t63 = load ptr, ptr %t62
  call void @bufPush(ptr %t63, i8 10)
  ret void
}

define ptr @genProgram(ptr %p0, i32 %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = load ptr, ptr %t0
  %t3 = getelementptr inbounds %Emitter, ptr %t2, i32 0, i32 0
  %t4 = load ptr, ptr %t3
  %t5 = getelementptr inbounds %Ast, ptr %t4, i32 0, i32 0
  %t6 = load ptr, ptr %t5
  %t7 = load i32, ptr %t1
  %t8 = sext i32 %t7 to i64
  %t9 = getelementptr inbounds %Node, ptr %t6, i64 %t8
  %t10 = getelementptr inbounds %Node, ptr %t9, i32 0, i32 10
  %t11 = load i32, ptr %t10
  %t12 = alloca i32
  store i32 %t11, ptr %t12
  %t13 = alloca i32
  store i32 0, ptr %t13
  br label %L0
L0:
  %t14 = load i32, ptr %t13
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Emitter, ptr %t15, i32 0, i32 1
  %t17 = load ptr, ptr %t16
  %t18 = getelementptr inbounds %Analyzer, ptr %t17, i32 0, i32 2
  %t19 = load ptr, ptr %t18
  %t20 = getelementptr inbounds %StructTable, ptr %t19, i32 0, i32 1
  %t21 = load i32, ptr %t20
  %t22 = icmp slt i32 %t14, %t21
  br i1 %t22, label %L1, label %L2
L1:
  %t23 = load ptr, ptr %t0
  %t24 = getelementptr inbounds %Emitter, ptr %t23, i32 0, i32 2
  %t25 = load ptr, ptr %t24
  call void @bufPush(ptr %t25, i8 37)
  %t26 = load ptr, ptr %t0
  %t27 = getelementptr inbounds %Emitter, ptr %t26, i32 0, i32 2
  %t28 = load ptr, ptr %t27
  %t29 = load ptr, ptr %t0
  %t30 = getelementptr inbounds %Emitter, ptr %t29, i32 0, i32 1
  %t31 = load ptr, ptr %t30
  %t32 = getelementptr inbounds %Analyzer, ptr %t31, i32 0, i32 2
  %t33 = load ptr, ptr %t32
  %t34 = getelementptr inbounds %StructTable, ptr %t33, i32 0, i32 0
  %t35 = load ptr, ptr %t34
  %t36 = load i32, ptr %t13
  %t37 = sext i32 %t36 to i64
  %t38 = getelementptr inbounds %StructLayout, ptr %t35, i64 %t37
  %t39 = getelementptr inbounds %StructLayout, ptr %t38, i32 0, i32 0
  %t40 = load ptr, ptr %t39
  call void @bufAdd(ptr %t28, ptr %t40)
  %t41 = load ptr, ptr %t0
  %t42 = getelementptr inbounds %Emitter, ptr %t41, i32 0, i32 2
  %t43 = load ptr, ptr %t42
  call void @bufAdd(ptr %t43, ptr @.str.622)
  %t44 = alloca i32
  store i32 0, ptr %t44
  br label %L3
L3:
  %t45 = load i32, ptr %t44
  %t46 = load ptr, ptr %t0
  %t47 = getelementptr inbounds %Emitter, ptr %t46, i32 0, i32 1
  %t48 = load ptr, ptr %t47
  %t49 = getelementptr inbounds %Analyzer, ptr %t48, i32 0, i32 2
  %t50 = load ptr, ptr %t49
  %t51 = getelementptr inbounds %StructTable, ptr %t50, i32 0, i32 0
  %t52 = load ptr, ptr %t51
  %t53 = load i32, ptr %t13
  %t54 = sext i32 %t53 to i64
  %t55 = getelementptr inbounds %StructLayout, ptr %t52, i64 %t54
  %t56 = getelementptr inbounds %StructLayout, ptr %t55, i32 0, i32 2
  %t57 = load i32, ptr %t56
  %t58 = icmp slt i32 %t45, %t57
  br i1 %t58, label %L4, label %L5
L4:
  %t59 = load i32, ptr %t44
  %t60 = icmp sgt i32 %t59, 0
  br i1 %t60, label %L6, label %L8
L6:
  %t61 = load ptr, ptr %t0
  %t62 = getelementptr inbounds %Emitter, ptr %t61, i32 0, i32 2
  %t63 = load ptr, ptr %t62
  call void @bufAdd(ptr %t63, ptr @.str.623)
  br label %L8
L8:
  %t64 = load ptr, ptr %t0
  %t65 = getelementptr inbounds %Emitter, ptr %t64, i32 0, i32 2
  %t66 = load ptr, ptr %t65
  %t67 = load ptr, ptr %t0
  %t68 = getelementptr inbounds %Emitter, ptr %t67, i32 0, i32 1
  %t69 = load ptr, ptr %t68
  %t70 = getelementptr inbounds %Analyzer, ptr %t69, i32 0, i32 2
  %t71 = load ptr, ptr %t70
  %t72 = getelementptr inbounds %StructTable, ptr %t71, i32 0, i32 0
  %t73 = load ptr, ptr %t72
  %t74 = load i32, ptr %t13
  %t75 = sext i32 %t74 to i64
  %t76 = getelementptr inbounds %StructLayout, ptr %t73, i64 %t75
  %t77 = getelementptr inbounds %StructLayout, ptr %t76, i32 0, i32 1
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr %t44
  %t80 = sext i32 %t79 to i64
  %t81 = getelementptr inbounds %FieldDef, ptr %t78, i64 %t80
  %t82 = getelementptr inbounds %FieldDef, ptr %t81, i32 0, i32 1
  %t83 = load %Type, ptr %t82
  %t84 = call ptr @llvmTypeName(%Type %t83)
  call void @bufAdd(ptr %t66, ptr %t84)
  %t85 = load i32, ptr %t44
  %t86 = add i32 %t85, 1
  store i32 %t86, ptr %t44
  br label %L3
L5:
  %t87 = load ptr, ptr %t0
  %t88 = getelementptr inbounds %Emitter, ptr %t87, i32 0, i32 2
  %t89 = load ptr, ptr %t88
  call void @bufAdd(ptr %t89, ptr @.str.624)
  %t90 = load i32, ptr %t13
  %t91 = add i32 %t90, 1
  store i32 %t91, ptr %t13
  br label %L0
L2:
  %t92 = load ptr, ptr %t0
  %t93 = getelementptr inbounds %Emitter, ptr %t92, i32 0, i32 2
  %t94 = load ptr, ptr %t93
  call void @bufAdd(ptr %t94, ptr @.str.625)
  %t95 = call ptr @nameSetNew()
  %t96 = alloca ptr
  store ptr %t95, ptr %t96
  store i32 0, ptr %t13
  br label %L9
L9:
  %t97 = load i32, ptr %t13
  %t98 = load i32, ptr %t12
  %t99 = icmp slt i32 %t97, %t98
  br i1 %t99, label %L10, label %L11
L10:
  %t100 = load ptr, ptr %t0
  %t101 = getelementptr inbounds %Emitter, ptr %t100, i32 0, i32 0
  %t102 = load ptr, ptr %t101
  %t103 = getelementptr inbounds %Ast, ptr %t102, i32 0, i32 0
  %t104 = load ptr, ptr %t103
  %t105 = load i32, ptr %t1
  %t106 = sext i32 %t105 to i64
  %t107 = getelementptr inbounds %Node, ptr %t104, i64 %t106
  %t108 = getelementptr inbounds %Node, ptr %t107, i32 0, i32 9
  %t109 = load ptr, ptr %t108
  %t110 = load i32, ptr %t13
  %t111 = sext i32 %t110 to i64
  %t112 = getelementptr inbounds i32, ptr %t109, i64 %t111
  %t113 = load i32, ptr %t112
  %t114 = alloca i32
  store i32 %t113, ptr %t114
  %t115 = alloca i1
  %t116 = load ptr, ptr %t0
  %t117 = getelementptr inbounds %Emitter, ptr %t116, i32 0, i32 0
  %t118 = load ptr, ptr %t117
  %t119 = getelementptr inbounds %Ast, ptr %t118, i32 0, i32 0
  %t120 = load ptr, ptr %t119
  %t121 = load i32, ptr %t114
  %t122 = sext i32 %t121 to i64
  %t123 = getelementptr inbounds %Node, ptr %t120, i64 %t122
  %t124 = getelementptr inbounds %Node, ptr %t123, i32 0, i32 0
  %t125 = load i32, ptr %t124
  %t126 = load i32, ptr @NK_EXTERN
  %t127 = icmp eq i32 %t125, %t126
  store i1 %t127, ptr %t115
  br i1 %t127, label %L12, label %L13
L12:
  %t128 = load ptr, ptr %t96
  %t129 = load ptr, ptr %t0
  %t130 = getelementptr inbounds %Emitter, ptr %t129, i32 0, i32 1
  %t131 = load ptr, ptr %t130
  %t132 = getelementptr inbounds %Analyzer, ptr %t131, i32 0, i32 5
  %t133 = load ptr, ptr %t132
  %t134 = load i32, ptr %t114
  %t135 = sext i32 %t134 to i64
  %t136 = getelementptr inbounds ptr, ptr %t133, i64 %t135
  %t137 = load ptr, ptr %t136
  %t138 = call i1 @nameSetHas(ptr %t128, ptr %t137)
  %t139 = xor i1 %t138, true
  store i1 %t139, ptr %t115
  br label %L13
L13:
  %t140 = load i1, ptr %t115
  br i1 %t140, label %L14, label %L16
L14:
  %t141 = load ptr, ptr %t96
  %t142 = load ptr, ptr %t0
  %t143 = getelementptr inbounds %Emitter, ptr %t142, i32 0, i32 1
  %t144 = load ptr, ptr %t143
  %t145 = getelementptr inbounds %Analyzer, ptr %t144, i32 0, i32 5
  %t146 = load ptr, ptr %t145
  %t147 = load i32, ptr %t114
  %t148 = sext i32 %t147 to i64
  %t149 = getelementptr inbounds ptr, ptr %t146, i64 %t148
  %t150 = load ptr, ptr %t149
  call void @nameSetAdd(ptr %t141, ptr %t150)
  %t151 = load ptr, ptr %t0
  %t152 = load ptr, ptr %t0
  %t153 = getelementptr inbounds %Emitter, ptr %t152, i32 0, i32 2
  %t154 = load ptr, ptr %t153
  %t155 = load i32, ptr %t114
  call void @emitSignature(ptr %t151, ptr %t154, i32 %t155, ptr @.str.626)
  %t156 = load ptr, ptr %t0
  %t157 = getelementptr inbounds %Emitter, ptr %t156, i32 0, i32 2
  %t158 = load ptr, ptr %t157
  call void @bufPush(ptr %t158, i8 10)
  br label %L16
L16:
  %t159 = load i32, ptr %t13
  %t160 = add i32 %t159, 1
  store i32 %t160, ptr %t13
  br label %L9
L11:
  store i32 0, ptr %t13
  br label %L17
L17:
  %t161 = load i32, ptr %t13
  %t162 = load i32, ptr %t12
  %t163 = icmp slt i32 %t161, %t162
  br i1 %t163, label %L18, label %L19
L18:
  %t164 = load ptr, ptr %t0
  %t165 = getelementptr inbounds %Emitter, ptr %t164, i32 0, i32 0
  %t166 = load ptr, ptr %t165
  %t167 = getelementptr inbounds %Ast, ptr %t166, i32 0, i32 0
  %t168 = load ptr, ptr %t167
  %t169 = load i32, ptr %t1
  %t170 = sext i32 %t169 to i64
  %t171 = getelementptr inbounds %Node, ptr %t168, i64 %t170
  %t172 = getelementptr inbounds %Node, ptr %t171, i32 0, i32 9
  %t173 = load ptr, ptr %t172
  %t174 = load i32, ptr %t13
  %t175 = sext i32 %t174 to i64
  %t176 = getelementptr inbounds i32, ptr %t173, i64 %t175
  %t177 = load i32, ptr %t176
  %t178 = alloca i32
  store i32 %t177, ptr %t178
  %t179 = load ptr, ptr %t0
  %t180 = getelementptr inbounds %Emitter, ptr %t179, i32 0, i32 0
  %t181 = load ptr, ptr %t180
  %t182 = getelementptr inbounds %Ast, ptr %t181, i32 0, i32 0
  %t183 = load ptr, ptr %t182
  %t184 = load i32, ptr %t178
  %t185 = sext i32 %t184 to i64
  %t186 = getelementptr inbounds %Node, ptr %t183, i64 %t185
  %t187 = getelementptr inbounds %Node, ptr %t186, i32 0, i32 0
  %t188 = load i32, ptr %t187
  %t189 = load i32, ptr @NK_VARDECL
  %t190 = icmp eq i32 %t188, %t189
  br i1 %t190, label %L20, label %L22
L20:
  %t191 = load ptr, ptr %t0
  %t192 = load i32, ptr %t178
  call void @genGlobal(ptr %t191, i32 %t192)
  br label %L22
L22:
  %t193 = load i32, ptr %t13
  %t194 = add i32 %t193, 1
  store i32 %t194, ptr %t13
  br label %L17
L19:
  store i32 0, ptr %t13
  br label %L23
L23:
  %t195 = load i32, ptr %t13
  %t196 = load i32, ptr %t12
  %t197 = icmp slt i32 %t195, %t196
  br i1 %t197, label %L24, label %L25
L24:
  %t198 = load ptr, ptr %t0
  %t199 = getelementptr inbounds %Emitter, ptr %t198, i32 0, i32 0
  %t200 = load ptr, ptr %t199
  %t201 = getelementptr inbounds %Ast, ptr %t200, i32 0, i32 0
  %t202 = load ptr, ptr %t201
  %t203 = load i32, ptr %t1
  %t204 = sext i32 %t203 to i64
  %t205 = getelementptr inbounds %Node, ptr %t202, i64 %t204
  %t206 = getelementptr inbounds %Node, ptr %t205, i32 0, i32 9
  %t207 = load ptr, ptr %t206
  %t208 = load i32, ptr %t13
  %t209 = sext i32 %t208 to i64
  %t210 = getelementptr inbounds i32, ptr %t207, i64 %t209
  %t211 = load i32, ptr %t210
  %t212 = alloca i32
  store i32 %t211, ptr %t212
  %t213 = load ptr, ptr %t0
  %t214 = getelementptr inbounds %Emitter, ptr %t213, i32 0, i32 0
  %t215 = load ptr, ptr %t214
  %t216 = getelementptr inbounds %Ast, ptr %t215, i32 0, i32 0
  %t217 = load ptr, ptr %t216
  %t218 = load i32, ptr %t212
  %t219 = sext i32 %t218 to i64
  %t220 = getelementptr inbounds %Node, ptr %t217, i64 %t219
  %t221 = getelementptr inbounds %Node, ptr %t220, i32 0, i32 0
  %t222 = load i32, ptr %t221
  %t223 = load i32, ptr @NK_FN
  %t224 = icmp eq i32 %t222, %t223
  br i1 %t224, label %L26, label %L28
L26:
  %t225 = load ptr, ptr %t0
  %t226 = load i32, ptr %t212
  call void @genFunction(ptr %t225, i32 %t226)
  br label %L28
L28:
  %t227 = load i32, ptr %t13
  %t228 = add i32 %t227, 1
  store i32 %t228, ptr %t13
  br label %L23
L25:
  %t229 = call ptr @bufNew()
  %t230 = alloca ptr
  store ptr %t229, ptr %t230
  %t231 = load ptr, ptr %t230
  %t232 = load ptr, ptr %t0
  %t233 = getelementptr inbounds %Emitter, ptr %t232, i32 0, i32 2
  %t234 = load ptr, ptr %t233
  %t235 = getelementptr inbounds %Buf, ptr %t234, i32 0, i32 0
  %t236 = load ptr, ptr %t235
  %t237 = load ptr, ptr %t0
  %t238 = getelementptr inbounds %Emitter, ptr %t237, i32 0, i32 2
  %t239 = load ptr, ptr %t238
  %t240 = getelementptr inbounds %Buf, ptr %t239, i32 0, i32 1
  %t241 = load i64, ptr %t240
  call void @bufAddBytes(ptr %t231, ptr %t236, i64 %t241)
  %t242 = load ptr, ptr %t230
  call void @bufPush(ptr %t242, i8 10)
  %t243 = load ptr, ptr %t230
  %t244 = load ptr, ptr %t0
  %t245 = getelementptr inbounds %Emitter, ptr %t244, i32 0, i32 3
  %t246 = load ptr, ptr %t245
  %t247 = getelementptr inbounds %Buf, ptr %t246, i32 0, i32 0
  %t248 = load ptr, ptr %t247
  %t249 = load ptr, ptr %t0
  %t250 = getelementptr inbounds %Emitter, ptr %t249, i32 0, i32 3
  %t251 = load ptr, ptr %t250
  %t252 = getelementptr inbounds %Buf, ptr %t251, i32 0, i32 1
  %t253 = load i64, ptr %t252
  call void @bufAddBytes(ptr %t243, ptr %t248, i64 %t253)
  %t254 = load ptr, ptr %t230
  %t255 = call ptr @bufTake(ptr %t254)
  ret ptr %t255
}

define void @dumpEscaped(ptr %p0, ptr %p1, i64 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i64
  store i64 %p2, ptr %t2
  %t3 = sext i32 0 to i64
  %t4 = alloca i64
  store i64 %t3, ptr %t4
  br label %L0
L0:
  %t5 = load i64, ptr %t4
  %t6 = load i64, ptr %t2
  %t7 = icmp slt i64 %t5, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t1
  %t9 = load i64, ptr %t4
  %t10 = getelementptr inbounds i8, ptr %t8, i64 %t9
  %t11 = load i8, ptr %t10
  %t12 = alloca i8
  store i8 %t11, ptr %t12
  %t13 = load i8, ptr %t12
  %t14 = icmp eq i8 %t13, 92
  br i1 %t14, label %L3, label %L4
L3:
  %t15 = load ptr, ptr %t0
  call void @bufAdd(ptr %t15, ptr @.str.627)
  br label %L5
L4:
  %t16 = load i8, ptr %t12
  %t17 = icmp eq i8 %t16, 10
  br i1 %t17, label %L6, label %L7
L6:
  %t18 = load ptr, ptr %t0
  call void @bufAdd(ptr %t18, ptr @.str.628)
  br label %L8
L7:
  %t19 = load i8, ptr %t12
  %t20 = icmp eq i8 %t19, 9
  br i1 %t20, label %L9, label %L10
L9:
  %t21 = load ptr, ptr %t0
  call void @bufAdd(ptr %t21, ptr @.str.629)
  br label %L11
L10:
  %t22 = load i8, ptr %t12
  %t23 = icmp eq i8 %t22, 13
  br i1 %t23, label %L12, label %L13
L12:
  %t24 = load ptr, ptr %t0
  call void @bufAdd(ptr %t24, ptr @.str.630)
  br label %L14
L13:
  %t25 = load i8, ptr %t12
  %t26 = icmp eq i8 %t25, 39
  br i1 %t26, label %L15, label %L16
L15:
  %t27 = load ptr, ptr %t0
  call void @bufAdd(ptr %t27, ptr @.str.631)
  br label %L17
L16:
  %t28 = load i8, ptr %t12
  %t29 = trunc i32 0 to i8
  %t30 = icmp eq i8 %t28, %t29
  br i1 %t30, label %L18, label %L19
L18:
  %t31 = load ptr, ptr %t0
  call void @bufAdd(ptr %t31, ptr @.str.632)
  br label %L20
L19:
  %t32 = load ptr, ptr %t0
  %t33 = load i8, ptr %t12
  call void @bufPush(ptr %t32, i8 %t33)
  br label %L20
L20:
  br label %L17
L17:
  br label %L14
L14:
  br label %L11
L11:
  br label %L8
L8:
  br label %L5
L5:
  %t34 = load i64, ptr %t4
  %t35 = sext i32 1 to i64
  %t36 = add i64 %t34, %t35
  store i64 %t36, ptr %t4
  br label %L0
L2:
  ret void
}

define void @dumpTokens(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 0, ptr %t2
  br label %L0
L0:
  %t3 = load i32, ptr %t2
  %t4 = load ptr, ptr %t0
  %t5 = getelementptr inbounds %TokenList, ptr %t4, i32 0, i32 1
  %t6 = load i32, ptr %t5
  %t7 = icmp slt i32 %t3, %t6
  br i1 %t7, label %L1, label %L2
L1:
  %t8 = load ptr, ptr %t0
  %t9 = load i32, ptr %t2
  %t10 = call ptr @tokenAt(ptr %t8, i32 %t9)
  %t11 = alloca ptr
  store ptr %t10, ptr %t11
  %t12 = load ptr, ptr %t11
  %t13 = getelementptr inbounds %Token, ptr %t12, i32 0, i32 0
  %t14 = load i32, ptr %t13
  %t15 = load i32, ptr @TK_END
  %t16 = icmp eq i32 %t14, %t15
  br i1 %t16, label %L3, label %L5
L3:
  %t17 = load i32, ptr %t2
  %t18 = add i32 %t17, 1
  store i32 %t18, ptr %t2
  br label %L0
L6:
  br label %L5
L5:
  %t19 = load ptr, ptr %t1
  %t20 = load ptr, ptr %t11
  %t21 = getelementptr inbounds %Token, ptr %t20, i32 0, i32 3
  %t22 = load i32, ptr %t21
  %t23 = sext i32 %t22 to i64
  call void @bufAddInt(ptr %t19, i64 %t23)
  %t24 = load ptr, ptr %t1
  call void @bufPush(ptr %t24, i8 58)
  %t25 = load ptr, ptr %t1
  %t26 = load ptr, ptr %t11
  %t27 = getelementptr inbounds %Token, ptr %t26, i32 0, i32 4
  %t28 = load i32, ptr %t27
  %t29 = sext i32 %t28 to i64
  call void @bufAddInt(ptr %t25, i64 %t29)
  %t30 = load ptr, ptr %t1
  call void @bufPush(ptr %t30, i8 32)
  %t31 = load ptr, ptr %t1
  %t32 = load ptr, ptr %t11
  %t33 = getelementptr inbounds %Token, ptr %t32, i32 0, i32 0
  %t34 = load i32, ptr %t33
  %t35 = call ptr @kindName(i32 %t34)
  call void @bufAdd(ptr %t31, ptr %t35)
  %t36 = alloca i1
  %t37 = alloca i1
  %t38 = alloca i1
  %t39 = alloca i1
  %t40 = alloca i1
  %t41 = load ptr, ptr %t11
  %t42 = getelementptr inbounds %Token, ptr %t41, i32 0, i32 0
  %t43 = load i32, ptr %t42
  %t44 = load i32, ptr @TK_IDENT
  %t45 = icmp eq i32 %t43, %t44
  store i1 %t45, ptr %t40
  br i1 %t45, label %L8, label %L7
L7:
  %t46 = load ptr, ptr %t11
  %t47 = getelementptr inbounds %Token, ptr %t46, i32 0, i32 0
  %t48 = load i32, ptr %t47
  %t49 = load i32, ptr @TK_NUMBER
  %t50 = icmp eq i32 %t48, %t49
  store i1 %t50, ptr %t40
  br label %L8
L8:
  %t51 = load i1, ptr %t40
  store i1 %t51, ptr %t39
  br i1 %t51, label %L10, label %L9
L9:
  %t52 = load ptr, ptr %t11
  %t53 = getelementptr inbounds %Token, ptr %t52, i32 0, i32 0
  %t54 = load i32, ptr %t53
  %t55 = load i32, ptr @TK_STRING
  %t56 = icmp eq i32 %t54, %t55
  store i1 %t56, ptr %t39
  br label %L10
L10:
  %t57 = load i1, ptr %t39
  store i1 %t57, ptr %t38
  br i1 %t57, label %L12, label %L11
L11:
  %t58 = load ptr, ptr %t11
  %t59 = getelementptr inbounds %Token, ptr %t58, i32 0, i32 0
  %t60 = load i32, ptr %t59
  %t61 = load i32, ptr @TK_CHAR
  %t62 = icmp eq i32 %t60, %t61
  store i1 %t62, ptr %t38
  br label %L12
L12:
  %t63 = load i1, ptr %t38
  store i1 %t63, ptr %t37
  br i1 %t63, label %L14, label %L13
L13:
  %t64 = load ptr, ptr %t11
  %t65 = getelementptr inbounds %Token, ptr %t64, i32 0, i32 0
  %t66 = load i32, ptr %t65
  %t67 = load i32, ptr @TK_BOOL
  %t68 = icmp eq i32 %t66, %t67
  store i1 %t68, ptr %t37
  br label %L14
L14:
  %t69 = load i1, ptr %t37
  store i1 %t69, ptr %t36
  br i1 %t69, label %L16, label %L15
L15:
  %t70 = load ptr, ptr %t11
  %t71 = getelementptr inbounds %Token, ptr %t70, i32 0, i32 0
  %t72 = load i32, ptr %t71
  %t73 = load i32, ptr @TK_TYPE
  %t74 = icmp eq i32 %t72, %t73
  store i1 %t74, ptr %t36
  br label %L16
L16:
  %t75 = load i1, ptr %t36
  br i1 %t75, label %L17, label %L19
L17:
  %t76 = load ptr, ptr %t1
  call void @bufAdd(ptr %t76, ptr @.str.633)
  %t77 = load ptr, ptr %t1
  %t78 = load ptr, ptr %t11
  %t79 = getelementptr inbounds %Token, ptr %t78, i32 0, i32 1
  %t80 = load ptr, ptr %t79
  %t81 = load ptr, ptr %t11
  %t82 = getelementptr inbounds %Token, ptr %t81, i32 0, i32 2
  %t83 = load i64, ptr %t82
  call void @bufAddBytes(ptr %t77, ptr %t80, i64 %t83)
  %t84 = load ptr, ptr %t1
  call void @bufPush(ptr %t84, i8 39)
  br label %L19
L19:
  %t85 = load ptr, ptr %t1
  call void @bufPush(ptr %t85, i8 10)
  %t86 = load i32, ptr %t2
  %t87 = add i32 %t86, 1
  store i32 %t87, ptr %t2
  br label %L0
L2:
  ret void
}

define ptr @nullTypes() {
entry:
  %t0 = sext i32 0 to i64
  %t1 = inttoptr i64 %t0 to ptr
  ret ptr %t1
}

define void @dumpNode(ptr %p0, ptr %p1, i32 %p2, i32 %p3, ptr %p4) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = alloca i32
  store i32 %p3, ptr %t3
  %t4 = alloca ptr
  store ptr %p4, ptr %t4
  %t5 = load i32, ptr %t2
  %t6 = load i32, ptr @NO_NODE
  %t7 = icmp eq i32 %t5, %t6
  br i1 %t7, label %L0, label %L2
L0:
  ret void
L2:
  %t8 = alloca i32
  store i32 0, ptr %t8
  br label %L3
L3:
  %t9 = load i32, ptr %t8
  %t10 = load i32, ptr %t3
  %t11 = icmp slt i32 %t9, %t10
  br i1 %t11, label %L4, label %L5
L4:
  %t12 = load ptr, ptr %t4
  call void @bufAdd(ptr %t12, ptr @.str.634)
  %t13 = load i32, ptr %t8
  %t14 = add i32 %t13, 1
  store i32 %t14, ptr %t8
  br label %L3
L5:
  %t15 = load ptr, ptr %t0
  %t16 = getelementptr inbounds %Ast, ptr %t15, i32 0, i32 0
  %t17 = load ptr, ptr %t16
  %t18 = load i32, ptr %t2
  %t19 = sext i32 %t18 to i64
  %t20 = getelementptr inbounds %Node, ptr %t17, i64 %t19
  %t21 = getelementptr inbounds %Node, ptr %t20, i32 0, i32 0
  %t22 = load i32, ptr %t21
  %t23 = alloca i32
  store i32 %t22, ptr %t23
  %t24 = load ptr, ptr %t4
  %t25 = load i32, ptr %t23
  %t26 = call ptr @nodeKindName(i32 %t25)
  call void @bufAdd(ptr %t24, ptr %t26)
  %t27 = load i32, ptr %t23
  %t28 = call i1 @nodeCarriesText(i32 %t27)
  br i1 %t28, label %L6, label %L8
L6:
  %t29 = load ptr, ptr %t4
  call void @bufAdd(ptr %t29, ptr @.str.635)
  %t30 = load ptr, ptr %t4
  %t31 = load ptr, ptr %t0
  %t32 = getelementptr inbounds %Ast, ptr %t31, i32 0, i32 0
  %t33 = load ptr, ptr %t32
  %t34 = load i32, ptr %t2
  %t35 = sext i32 %t34 to i64
  %t36 = getelementptr inbounds %Node, ptr %t33, i64 %t35
  %t37 = getelementptr inbounds %Node, ptr %t36, i32 0, i32 3
  %t38 = load ptr, ptr %t37
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Ast, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t2
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds %Node, ptr %t41, i64 %t43
  %t45 = getelementptr inbounds %Node, ptr %t44, i32 0, i32 4
  %t46 = load i64, ptr %t45
  call void @dumpEscaped(ptr %t30, ptr %t38, i64 %t46)
  %t47 = load ptr, ptr %t4
  call void @bufPush(ptr %t47, i8 39)
  br label %L8
L8:
  %t48 = load ptr, ptr %t0
  %t49 = getelementptr inbounds %Ast, ptr %t48, i32 0, i32 0
  %t50 = load ptr, ptr %t49
  %t51 = load i32, ptr %t2
  %t52 = sext i32 %t51 to i64
  %t53 = getelementptr inbounds %Node, ptr %t50, i64 %t52
  %t54 = getelementptr inbounds %Node, ptr %t53, i32 0, i32 13
  %t55 = load i1, ptr %t54
  br i1 %t55, label %L9, label %L11
L9:
  %t56 = load ptr, ptr %t4
  call void @bufAdd(ptr %t56, ptr @.str.636)
  br label %L11
L11:
  %t57 = load i32, ptr %t23
  %t58 = load i32, ptr @NK_TYPE
  %t59 = icmp eq i32 %t57, %t58
  br i1 %t59, label %L12, label %L14
L12:
  %t60 = load ptr, ptr %t4
  call void @bufAdd(ptr %t60, ptr @.str.637)
  %t61 = load ptr, ptr %t4
  %t62 = load ptr, ptr %t0
  %t63 = getelementptr inbounds %Ast, ptr %t62, i32 0, i32 0
  %t64 = load ptr, ptr %t63
  %t65 = load i32, ptr %t2
  %t66 = sext i32 %t65 to i64
  %t67 = getelementptr inbounds %Node, ptr %t64, i64 %t66
  %t68 = getelementptr inbounds %Node, ptr %t67, i32 0, i32 8
  %t69 = load i32, ptr %t68
  %t70 = sext i32 %t69 to i64
  call void @bufAddInt(ptr %t61, i64 %t70)
  br label %L14
L14:
  %t71 = load ptr, ptr %t4
  call void @bufPush(ptr %t71, i8 32)
  %t72 = load ptr, ptr %t4
  %t73 = load ptr, ptr %t0
  %t74 = getelementptr inbounds %Ast, ptr %t73, i32 0, i32 0
  %t75 = load ptr, ptr %t74
  %t76 = load i32, ptr %t2
  %t77 = sext i32 %t76 to i64
  %t78 = getelementptr inbounds %Node, ptr %t75, i64 %t77
  %t79 = getelementptr inbounds %Node, ptr %t78, i32 0, i32 1
  %t80 = load i32, ptr %t79
  %t81 = sext i32 %t80 to i64
  call void @bufAddInt(ptr %t72, i64 %t81)
  %t82 = load ptr, ptr %t4
  call void @bufPush(ptr %t82, i8 58)
  %t83 = load ptr, ptr %t4
  %t84 = load ptr, ptr %t0
  %t85 = getelementptr inbounds %Ast, ptr %t84, i32 0, i32 0
  %t86 = load ptr, ptr %t85
  %t87 = load i32, ptr %t2
  %t88 = sext i32 %t87 to i64
  %t89 = getelementptr inbounds %Node, ptr %t86, i64 %t88
  %t90 = getelementptr inbounds %Node, ptr %t89, i32 0, i32 2
  %t91 = load i32, ptr %t90
  %t92 = sext i32 %t91 to i64
  call void @bufAddInt(ptr %t83, i64 %t92)
  %t93 = load ptr, ptr %t1
  %t94 = call ptr @nullTypes()
  %t95 = icmp ne ptr %t93, %t94
  br i1 %t95, label %L15, label %L17
L15:
  %t96 = load ptr, ptr %t1
  %t97 = load i32, ptr %t2
  %t98 = sext i32 %t97 to i64
  %t99 = getelementptr inbounds %Type, ptr %t96, i64 %t98
  %t100 = getelementptr inbounds %Type, ptr %t99, i32 0, i32 0
  %t101 = load i32, ptr %t100
  %t102 = load i32, ptr @TY_NONE
  %t103 = icmp ne i32 %t101, %t102
  br i1 %t103, label %L18, label %L20
L18:
  %t104 = load ptr, ptr %t4
  call void @bufAdd(ptr %t104, ptr @.str.638)
  %t105 = load ptr, ptr %t4
  %t106 = load ptr, ptr %t1
  %t107 = load i32, ptr %t2
  %t108 = sext i32 %t107 to i64
  %t109 = getelementptr inbounds %Type, ptr %t106, i64 %t108
  %t110 = load %Type, ptr %t109
  %t111 = call ptr @typeToText(%Type %t110)
  call void @bufAdd(ptr %t105, ptr %t111)
  br label %L20
L20:
  br label %L17
L17:
  %t112 = load ptr, ptr %t4
  call void @bufPush(ptr %t112, i8 10)
  %t113 = load ptr, ptr %t0
  %t114 = load ptr, ptr %t1
  %t115 = load ptr, ptr %t0
  %t116 = getelementptr inbounds %Ast, ptr %t115, i32 0, i32 0
  %t117 = load ptr, ptr %t116
  %t118 = load i32, ptr %t2
  %t119 = sext i32 %t118 to i64
  %t120 = getelementptr inbounds %Node, ptr %t117, i64 %t119
  %t121 = getelementptr inbounds %Node, ptr %t120, i32 0, i32 5
  %t122 = load i32, ptr %t121
  %t123 = load i32, ptr %t3
  %t124 = add i32 %t123, 1
  %t125 = load ptr, ptr %t4
  call void @dumpNode(ptr %t113, ptr %t114, i32 %t122, i32 %t124, ptr %t125)
  %t126 = load ptr, ptr %t0
  %t127 = load ptr, ptr %t1
  %t128 = load ptr, ptr %t0
  %t129 = getelementptr inbounds %Ast, ptr %t128, i32 0, i32 0
  %t130 = load ptr, ptr %t129
  %t131 = load i32, ptr %t2
  %t132 = sext i32 %t131 to i64
  %t133 = getelementptr inbounds %Node, ptr %t130, i64 %t132
  %t134 = getelementptr inbounds %Node, ptr %t133, i32 0, i32 6
  %t135 = load i32, ptr %t134
  %t136 = load i32, ptr %t3
  %t137 = add i32 %t136, 1
  %t138 = load ptr, ptr %t4
  call void @dumpNode(ptr %t126, ptr %t127, i32 %t135, i32 %t137, ptr %t138)
  %t139 = load ptr, ptr %t0
  %t140 = load ptr, ptr %t1
  %t141 = load ptr, ptr %t0
  %t142 = getelementptr inbounds %Ast, ptr %t141, i32 0, i32 0
  %t143 = load ptr, ptr %t142
  %t144 = load i32, ptr %t2
  %t145 = sext i32 %t144 to i64
  %t146 = getelementptr inbounds %Node, ptr %t143, i64 %t145
  %t147 = getelementptr inbounds %Node, ptr %t146, i32 0, i32 7
  %t148 = load i32, ptr %t147
  %t149 = load i32, ptr %t3
  %t150 = add i32 %t149, 1
  %t151 = load ptr, ptr %t4
  call void @dumpNode(ptr %t139, ptr %t140, i32 %t148, i32 %t150, ptr %t151)
  %t152 = alloca i32
  store i32 0, ptr %t152
  br label %L21
L21:
  %t153 = load i32, ptr %t152
  %t154 = load ptr, ptr %t0
  %t155 = getelementptr inbounds %Ast, ptr %t154, i32 0, i32 0
  %t156 = load ptr, ptr %t155
  %t157 = load i32, ptr %t2
  %t158 = sext i32 %t157 to i64
  %t159 = getelementptr inbounds %Node, ptr %t156, i64 %t158
  %t160 = getelementptr inbounds %Node, ptr %t159, i32 0, i32 10
  %t161 = load i32, ptr %t160
  %t162 = icmp slt i32 %t153, %t161
  br i1 %t162, label %L22, label %L23
L22:
  %t163 = load ptr, ptr %t0
  %t164 = load ptr, ptr %t1
  %t165 = load ptr, ptr %t0
  %t166 = getelementptr inbounds %Ast, ptr %t165, i32 0, i32 0
  %t167 = load ptr, ptr %t166
  %t168 = load i32, ptr %t2
  %t169 = sext i32 %t168 to i64
  %t170 = getelementptr inbounds %Node, ptr %t167, i64 %t169
  %t171 = getelementptr inbounds %Node, ptr %t170, i32 0, i32 9
  %t172 = load ptr, ptr %t171
  %t173 = load i32, ptr %t152
  %t174 = sext i32 %t173 to i64
  %t175 = getelementptr inbounds i32, ptr %t172, i64 %t174
  %t176 = load i32, ptr %t175
  %t177 = load i32, ptr %t3
  %t178 = add i32 %t177, 1
  %t179 = load ptr, ptr %t4
  call void @dumpNode(ptr %t163, ptr %t164, i32 %t176, i32 %t178, ptr %t179)
  %t180 = load i32, ptr %t152
  %t181 = add i32 %t180, 1
  store i32 %t181, ptr %t152
  br label %L21
L23:
  ret void
}

define ptr @stemOf(ptr %p0) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = load ptr, ptr %t0
  %t2 = call i64 @strlen(ptr %t1)
  %t3 = alloca i64
  store i64 %t2, ptr %t3
  %t4 = sext i32 0 to i64
  %t5 = alloca i64
  store i64 %t4, ptr %t5
  %t6 = load i64, ptr %t3
  %t7 = alloca i64
  store i64 %t6, ptr %t7
  %t8 = sext i32 0 to i64
  %t9 = alloca i64
  store i64 %t8, ptr %t9
  br label %L0
L0:
  %t10 = load i64, ptr %t9
  %t11 = load i64, ptr %t3
  %t12 = icmp slt i64 %t10, %t11
  br i1 %t12, label %L1, label %L2
L1:
  %t13 = load ptr, ptr %t0
  %t14 = load i64, ptr %t9
  %t15 = getelementptr inbounds i8, ptr %t13, i64 %t14
  %t16 = load i8, ptr %t15
  %t17 = icmp eq i8 %t16, 47
  br i1 %t17, label %L3, label %L5
L3:
  %t18 = load i64, ptr %t9
  %t19 = sext i32 1 to i64
  %t20 = add i64 %t18, %t19
  store i64 %t20, ptr %t5
  br label %L5
L5:
  %t21 = load ptr, ptr %t0
  %t22 = load i64, ptr %t9
  %t23 = getelementptr inbounds i8, ptr %t21, i64 %t22
  %t24 = load i8, ptr %t23
  %t25 = icmp eq i8 %t24, 46
  br i1 %t25, label %L6, label %L8
L6:
  %t26 = load i64, ptr %t9
  store i64 %t26, ptr %t7
  br label %L8
L8:
  %t27 = load i64, ptr %t9
  %t28 = sext i32 1 to i64
  %t29 = add i64 %t27, %t28
  store i64 %t29, ptr %t9
  br label %L0
L2:
  %t30 = load i64, ptr %t7
  %t31 = load i64, ptr %t5
  %t32 = icmp sle i64 %t30, %t31
  br i1 %t32, label %L9, label %L11
L9:
  %t33 = load i64, ptr %t3
  store i64 %t33, ptr %t7
  br label %L11
L11:
  %t34 = load ptr, ptr %t0
  %t35 = load i64, ptr %t5
  %t36 = load i64, ptr %t7
  %t37 = load i64, ptr %t5
  %t38 = sub i64 %t36, %t37
  %t39 = call ptr @textSlice(ptr %t34, i64 %t35, i64 %t38)
  ret ptr %t39
}

define i32 @loadModule(ptr %p0, i32 %p1, ptr %p2, ptr %p3, ptr %p4) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca ptr
  store ptr %p2, ptr %t2
  %t3 = alloca ptr
  store ptr %p3, ptr %t3
  %t4 = alloca ptr
  store ptr %p4, ptr %t4
  %t5 = load ptr, ptr %t2
  %t6 = load ptr, ptr %t3
  %t7 = call i32 @moduleAdd(ptr %t5, ptr %t6)
  %t8 = alloca i32
  store i32 %t7, ptr %t8
  %t9 = load ptr, ptr %t2
  store ptr %t9, ptr @SOURCE_PATH
  %t10 = load ptr, ptr %t4
  %t11 = call ptr @tokenize(ptr %t10)
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load i32, ptr %t8
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Ast, ptr %t14, i32 0, i32 3
  store i32 %t13, ptr %t15
  %t16 = load ptr, ptr %t12
  %t17 = load ptr, ptr %t0
  %t18 = call ptr @parserNew(ptr %t16, ptr %t17)
  %t19 = load i32, ptr %t1
  call void @parseModuleInto(ptr %t18, i32 %t19)
  %t20 = load i32, ptr %t8
  ret i32 %t20
}

define void @loadImport(ptr %p0, i32 %p1, i32 %p2) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca i32
  store i32 %p1, ptr %t1
  %t2 = alloca i32
  store i32 %p2, ptr %t2
  %t3 = load ptr, ptr %t0
  %t4 = getelementptr inbounds %Ast, ptr %t3, i32 0, i32 0
  %t5 = load ptr, ptr %t4
  %t6 = load i32, ptr %t2
  %t7 = sext i32 %t6 to i64
  %t8 = getelementptr inbounds %Node, ptr %t5, i64 %t7
  %t9 = getelementptr inbounds %Node, ptr %t8, i32 0, i32 12
  %t10 = load i32, ptr %t9
  %t11 = call ptr @modulePath(i32 %t10)
  %t12 = alloca ptr
  store ptr %t11, ptr %t12
  %t13 = load ptr, ptr %t12
  %t14 = load ptr, ptr %t0
  %t15 = getelementptr inbounds %Ast, ptr %t14, i32 0, i32 0
  %t16 = load ptr, ptr %t15
  %t17 = load i32, ptr %t2
  %t18 = sext i32 %t17 to i64
  %t19 = getelementptr inbounds %Node, ptr %t16, i64 %t18
  %t20 = getelementptr inbounds %Node, ptr %t19, i32 0, i32 3
  %t21 = load ptr, ptr %t20
  %t22 = call ptr @resolveImportPath(ptr %t13, ptr %t21)
  %t23 = alloca ptr
  store ptr %t22, ptr %t23
  %t24 = load ptr, ptr %t23
  %t25 = call ptr @nullText()
  %t26 = call ptr @realpath(ptr %t24, ptr %t25)
  %t27 = alloca ptr
  store ptr %t26, ptr %t27
  %t28 = call ptr @nullText()
  %t29 = alloca ptr
  store ptr %t28, ptr %t29
  %t30 = load ptr, ptr %t27
  %t31 = call i1 @isNullText(ptr %t30)
  %t32 = xor i1 %t31, true
  br i1 %t32, label %L0, label %L2
L0:
  %t33 = load ptr, ptr %t27
  %t34 = call i32 @moduleFind(ptr %t33)
  %t35 = alloca i32
  store i32 %t34, ptr %t35
  %t36 = load i32, ptr %t35
  %t37 = icmp sge i32 %t36, 0
  br i1 %t37, label %L3, label %L5
L3:
  %t38 = load i32, ptr %t35
  %t39 = load ptr, ptr %t0
  %t40 = getelementptr inbounds %Ast, ptr %t39, i32 0, i32 0
  %t41 = load ptr, ptr %t40
  %t42 = load i32, ptr %t2
  %t43 = sext i32 %t42 to i64
  %t44 = getelementptr inbounds %Node, ptr %t41, i64 %t43
  %t45 = getelementptr inbounds %Node, ptr %t44, i32 0, i32 8
  store i32 %t38, ptr %t45
  ret void
L5:
  %t46 = load ptr, ptr %t23
  %t47 = call ptr @readFile(ptr %t46)
  store ptr %t47, ptr %t29
  br label %L2
L2:
  %t48 = load ptr, ptr %t29
  %t49 = call i1 @isNullText(ptr %t48)
  br i1 %t49, label %L6, label %L8
L6:
  %t50 = call ptr @bufNew()
  %t51 = alloca ptr
  store ptr %t50, ptr %t51
  %t52 = load ptr, ptr %t51
  call void @bufAdd(ptr %t52, ptr @.str.639)
  %t53 = load ptr, ptr %t51
  %t54 = load ptr, ptr %t0
  %t55 = getelementptr inbounds %Ast, ptr %t54, i32 0, i32 0
  %t56 = load ptr, ptr %t55
  %t57 = load i32, ptr %t2
  %t58 = sext i32 %t57 to i64
  %t59 = getelementptr inbounds %Node, ptr %t56, i64 %t58
  %t60 = getelementptr inbounds %Node, ptr %t59, i32 0, i32 3
  %t61 = load ptr, ptr %t60
  call void @bufAdd(ptr %t53, ptr %t61)
  %t62 = load ptr, ptr %t51
  call void @bufPush(ptr %t62, i8 39)
  %t63 = load ptr, ptr %t12
  store ptr %t63, ptr @SOURCE_PATH
  %t64 = load ptr, ptr %t0
  %t65 = getelementptr inbounds %Ast, ptr %t64, i32 0, i32 0
  %t66 = load ptr, ptr %t65
  %t67 = load i32, ptr %t2
  %t68 = sext i32 %t67 to i64
  %t69 = getelementptr inbounds %Node, ptr %t66, i64 %t68
  %t70 = getelementptr inbounds %Node, ptr %t69, i32 0, i32 1
  %t71 = load i32, ptr %t70
  %t72 = load ptr, ptr %t0
  %t73 = getelementptr inbounds %Ast, ptr %t72, i32 0, i32 0
  %t74 = load ptr, ptr %t73
  %t75 = load i32, ptr %t2
  %t76 = sext i32 %t75 to i64
  %t77 = getelementptr inbounds %Node, ptr %t74, i64 %t76
  %t78 = getelementptr inbounds %Node, ptr %t77, i32 0, i32 2
  %t79 = load i32, ptr %t78
  %t80 = load ptr, ptr %t51
  %t81 = getelementptr inbounds %Buf, ptr %t80, i32 0, i32 0
  %t82 = load ptr, ptr %t81
  call void @report(i32 %t71, i32 %t79, ptr %t82)
  store i1 false, ptr @FAILED
  ret void
L8:
  %t83 = load ptr, ptr %t0
  %t84 = load i32, ptr %t1
  %t85 = load ptr, ptr %t23
  %t86 = load ptr, ptr %t27
  %t87 = load ptr, ptr %t29
  %t88 = call i32 @loadModule(ptr %t83, i32 %t84, ptr %t85, ptr %t86, ptr %t87)
  %t89 = load ptr, ptr %t0
  %t90 = getelementptr inbounds %Ast, ptr %t89, i32 0, i32 0
  %t91 = load ptr, ptr %t90
  %t92 = load i32, ptr %t2
  %t93 = sext i32 %t92 to i64
  %t94 = getelementptr inbounds %Node, ptr %t91, i64 %t93
  %t95 = getelementptr inbounds %Node, ptr %t94, i32 0, i32 8
  store i32 %t88, ptr %t95
  ret void
}

define ptr @withSuffix(ptr %p0, ptr %p1) {
entry:
  %t0 = alloca ptr
  store ptr %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = call ptr @bufNew()
  %t3 = alloca ptr
  store ptr %t2, ptr %t3
  %t4 = load ptr, ptr %t3
  %t5 = load ptr, ptr %t0
  call void @bufAdd(ptr %t4, ptr %t5)
  %t6 = load ptr, ptr %t3
  %t7 = load ptr, ptr %t1
  call void @bufAdd(ptr %t6, ptr %t7)
  %t8 = load ptr, ptr %t3
  %t9 = call ptr @bufTake(ptr %t8)
  ret ptr %t9
}

define i32 @main(i32 %p0, ptr %p1) {
entry:
  %t0 = alloca i32
  store i32 %p0, ptr %t0
  %t1 = alloca ptr
  store ptr %p1, ptr %t1
  %t2 = alloca i1
  store i1 false, ptr %t2
  %t3 = alloca i1
  store i1 false, ptr %t3
  %t4 = alloca i1
  store i1 false, ptr %t4
  %t5 = alloca i1
  store i1 false, ptr %t5
  %t6 = alloca i1
  store i1 true, ptr %t6
  %t7 = call ptr @nullText()
  %t8 = alloca ptr
  store ptr %t7, ptr %t8
  %t9 = call ptr @nullText()
  %t10 = alloca ptr
  store ptr %t9, ptr %t10
  %t11 = alloca i32
  store i32 1, ptr %t11
  br label %L0
L0:
  %t12 = load i32, ptr %t11
  %t13 = load i32, ptr %t0
  %t14 = icmp slt i32 %t12, %t13
  br i1 %t14, label %L1, label %L2
L1:
  %t15 = load ptr, ptr %t1
  %t16 = load i32, ptr %t11
  %t17 = sext i32 %t16 to i64
  %t18 = getelementptr inbounds ptr, ptr %t15, i64 %t17
  %t19 = load ptr, ptr %t18
  %t20 = alloca ptr
  store ptr %t19, ptr %t20
  %t21 = load ptr, ptr %t20
  %t22 = call i1 @textEquals(ptr %t21, ptr @.str.640)
  br i1 %t22, label %L3, label %L4
L3:
  store i1 true, ptr %t2
  br label %L5
L4:
  %t23 = load ptr, ptr %t20
  %t24 = call i1 @textEquals(ptr %t23, ptr @.str.641)
  br i1 %t24, label %L6, label %L7
L6:
  store i1 true, ptr %t3
  br label %L8
L7:
  %t25 = load ptr, ptr %t20
  %t26 = call i1 @textEquals(ptr %t25, ptr @.str.642)
  br i1 %t26, label %L9, label %L10
L9:
  store i1 true, ptr %t4
  br label %L11
L10:
  %t27 = load ptr, ptr %t20
  %t28 = call i1 @textEquals(ptr %t27, ptr @.str.643)
  br i1 %t28, label %L12, label %L13
L12:
  store i1 true, ptr %t5
  br label %L14
L13:
  %t29 = load ptr, ptr %t20
  %t30 = call i1 @textEquals(ptr %t29, ptr @.str.644)
  br i1 %t30, label %L15, label %L16
L15:
  store i1 false, ptr %t6
  br label %L17
L16:
  %t31 = load ptr, ptr %t20
  %t32 = call i1 @textEquals(ptr %t31, ptr @.str.645)
  br i1 %t32, label %L18, label %L19
L18:
  %t33 = load i32, ptr %t11
  %t34 = add i32 %t33, 1
  store i32 %t34, ptr %t11
  %t35 = load i32, ptr %t11
  %t36 = load i32, ptr %t0
  %t37 = icmp sge i32 %t35, %t36
  br i1 %t37, label %L21, label %L23
L21:
  %t38 = load i32, ptr @STDERR
  %t39 = load ptr, ptr @USAGE
  call void @writeText(i32 %t38, ptr %t39)
  ret i32 2
L23:
  %t40 = load ptr, ptr %t1
  %t41 = load i32, ptr %t11
  %t42 = sext i32 %t41 to i64
  %t43 = getelementptr inbounds ptr, ptr %t40, i64 %t42
  %t44 = load ptr, ptr %t43
  store ptr %t44, ptr %t10
  br label %L20
L19:
  %t45 = load ptr, ptr %t20
  %t46 = sext i32 0 to i64
  %t47 = getelementptr inbounds i8, ptr %t45, i64 %t46
  %t48 = load i8, ptr %t47
  %t49 = icmp eq i8 %t48, 45
  br i1 %t49, label %L24, label %L25
L24:
  %t50 = load i32, ptr @STDERR
  %t51 = load ptr, ptr @USAGE
  call void @writeText(i32 %t50, ptr %t51)
  ret i32 2
L25:
  %t52 = load ptr, ptr %t20
  store ptr %t52, ptr %t8
  br label %L26
L26:
  br label %L20
L20:
  br label %L17
L17:
  br label %L14
L14:
  br label %L11
L11:
  br label %L8
L8:
  br label %L5
L5:
  %t53 = load i32, ptr %t11
  %t54 = add i32 %t53, 1
  store i32 %t54, ptr %t11
  br label %L0
L2:
  %t55 = load ptr, ptr %t8
  %t56 = call i1 @isNullText(ptr %t55)
  br i1 %t56, label %L27, label %L29
L27:
  %t57 = load i32, ptr @STDERR
  %t58 = load ptr, ptr @USAGE
  call void @writeText(i32 %t57, ptr %t58)
  ret i32 2
L29:
  %t59 = load ptr, ptr %t8
  store ptr %t59, ptr @SOURCE_PATH
  %t60 = call ptr @diagnosticsNew()
  store ptr %t60, ptr @DIAGS
  %t61 = load ptr, ptr %t8
  %t62 = call ptr @readFile(ptr %t61)
  %t63 = alloca ptr
  store ptr %t62, ptr %t63
  %t64 = load ptr, ptr %t63
  %t65 = call i1 @isNullText(ptr %t64)
  br i1 %t65, label %L30, label %L32
L30:
  call void @fail(ptr @.str.646)
  br label %L32
L32:
  %t66 = load ptr, ptr %t63
  %t67 = call ptr @tokenize(ptr %t66)
  %t68 = alloca ptr
  store ptr %t67, ptr %t68
  %t69 = call ptr @bufNew()
  %t70 = alloca ptr
  store ptr %t69, ptr %t70
  %t71 = load i1, ptr %t2
  br i1 %t71, label %L33, label %L35
L33:
  %t72 = load ptr, ptr %t68
  %t73 = load ptr, ptr %t70
  call void @dumpTokens(ptr %t72, ptr %t73)
  %t74 = load i32, ptr @STDOUT
  %t75 = load ptr, ptr %t70
  call void @writeBuf(i32 %t74, ptr %t75)
  ret i32 0
L35:
  %t76 = call ptr @astNew()
  %t77 = alloca ptr
  store ptr %t76, ptr %t77
  %t78 = load ptr, ptr %t77
  %t79 = load i32, ptr @NK_PROGRAM
  %t80 = call i32 @astAdd(ptr %t78, i32 %t79, i32 0, i32 0)
  %t81 = alloca i32
  store i32 %t80, ptr %t81
  %t82 = load ptr, ptr %t8
  %t83 = call ptr @nullText()
  %t84 = call ptr @realpath(ptr %t82, ptr %t83)
  %t85 = alloca ptr
  store ptr %t84, ptr %t85
  %t86 = load ptr, ptr %t85
  %t87 = call i1 @isNullText(ptr %t86)
  br i1 %t87, label %L36, label %L38
L36:
  %t88 = load ptr, ptr %t8
  store ptr %t88, ptr %t85
  br label %L38
L38:
  %t89 = load ptr, ptr %t8
  %t90 = load ptr, ptr %t85
  %t91 = call i32 @moduleAdd(ptr %t89, ptr %t90)
  %t92 = load ptr, ptr %t68
  %t93 = load ptr, ptr %t77
  %t94 = call ptr @parserNew(ptr %t92, ptr %t93)
  %t95 = load i32, ptr %t81
  call void @parseModuleInto(ptr %t94, i32 %t95)
  %t96 = alloca i32
  store i32 0, ptr %t96
  br label %L39
L39:
  %t97 = load i32, ptr %t96
  %t98 = load ptr, ptr %t77
  %t99 = getelementptr inbounds %Ast, ptr %t98, i32 0, i32 0
  %t100 = load ptr, ptr %t99
  %t101 = load i32, ptr %t81
  %t102 = sext i32 %t101 to i64
  %t103 = getelementptr inbounds %Node, ptr %t100, i64 %t102
  %t104 = getelementptr inbounds %Node, ptr %t103, i32 0, i32 10
  %t105 = load i32, ptr %t104
  %t106 = icmp slt i32 %t97, %t105
  br i1 %t106, label %L40, label %L41
L40:
  %t107 = load ptr, ptr %t77
  %t108 = getelementptr inbounds %Ast, ptr %t107, i32 0, i32 0
  %t109 = load ptr, ptr %t108
  %t110 = load i32, ptr %t81
  %t111 = sext i32 %t110 to i64
  %t112 = getelementptr inbounds %Node, ptr %t109, i64 %t111
  %t113 = getelementptr inbounds %Node, ptr %t112, i32 0, i32 9
  %t114 = load ptr, ptr %t113
  %t115 = load i32, ptr %t96
  %t116 = sext i32 %t115 to i64
  %t117 = getelementptr inbounds i32, ptr %t114, i64 %t116
  %t118 = load i32, ptr %t117
  %t119 = alloca i32
  store i32 %t118, ptr %t119
  %t120 = load ptr, ptr %t77
  %t121 = getelementptr inbounds %Ast, ptr %t120, i32 0, i32 0
  %t122 = load ptr, ptr %t121
  %t123 = load i32, ptr %t119
  %t124 = sext i32 %t123 to i64
  %t125 = getelementptr inbounds %Node, ptr %t122, i64 %t124
  %t126 = getelementptr inbounds %Node, ptr %t125, i32 0, i32 0
  %t127 = load i32, ptr %t126
  %t128 = load i32, ptr @NK_IMPORT
  %t129 = icmp eq i32 %t127, %t128
  br i1 %t129, label %L42, label %L44
L42:
  %t130 = load ptr, ptr %t77
  %t131 = load i32, ptr %t81
  %t132 = load i32, ptr %t119
  call void @loadImport(ptr %t130, i32 %t131, i32 %t132)
  br label %L44
L44:
  %t133 = load i32, ptr %t96
  %t134 = add i32 %t133, 1
  store i32 %t134, ptr %t96
  br label %L39
L41:
  %t135 = load ptr, ptr %t8
  store ptr %t135, ptr @SOURCE_PATH
  %t136 = call i1 @hasErrors()
  br i1 %t136, label %L45, label %L47
L45:
  call void @printDiagnostics()
  ret i32 1
L47:
  %t137 = load i1, ptr %t3
  br i1 %t137, label %L48, label %L50
L48:
  %t138 = load ptr, ptr %t77
  %t139 = call ptr @nullTypes()
  %t140 = load i32, ptr %t81
  %t141 = load ptr, ptr %t70
  call void @dumpNode(ptr %t138, ptr %t139, i32 %t140, i32 0, ptr %t141)
  %t142 = load i32, ptr @STDOUT
  %t143 = load ptr, ptr %t70
  call void @writeBuf(i32 %t142, ptr %t143)
  ret i32 0
L50:
  %t144 = load ptr, ptr %t77
  %t145 = call ptr @analyzerNew(ptr %t144)
  %t146 = alloca ptr
  store ptr %t145, ptr %t146
  %t147 = load ptr, ptr %t146
  %t148 = load i32, ptr %t81
  call void @analyze(ptr %t147, i32 %t148)
  %t149 = call i1 @hasErrors()
  br i1 %t149, label %L51, label %L53
L51:
  call void @printDiagnostics()
  ret i32 1
L53:
  %t150 = load i1, ptr %t4
  br i1 %t150, label %L54, label %L56
L54:
  %t151 = load ptr, ptr %t77
  %t152 = load ptr, ptr %t146
  %t153 = getelementptr inbounds %Analyzer, ptr %t152, i32 0, i32 3
  %t154 = load ptr, ptr %t153
  %t155 = load i32, ptr %t81
  %t156 = load ptr, ptr %t70
  call void @dumpNode(ptr %t151, ptr %t154, i32 %t155, i32 0, ptr %t156)
  %t157 = load i32, ptr @STDOUT
  %t158 = load ptr, ptr %t70
  call void @writeBuf(i32 %t157, ptr %t158)
  ret i32 0
L56:
  %t159 = load ptr, ptr %t77
  %t160 = load ptr, ptr %t146
  %t161 = call ptr @emitterNew(ptr %t159, ptr %t160)
  %t162 = alloca ptr
  store ptr %t161, ptr %t162
  %t163 = load ptr, ptr %t162
  %t164 = load i32, ptr %t81
  %t165 = call ptr @genProgram(ptr %t163, i32 %t164)
  %t166 = alloca ptr
  store ptr %t165, ptr %t166
  %t167 = load i1, ptr %t5
  br i1 %t167, label %L57, label %L59
L57:
  %t168 = load i32, ptr @STDOUT
  %t169 = load ptr, ptr %t166
  call void @writeText(i32 %t168, ptr %t169)
  ret i32 0
L59:
  %t170 = load ptr, ptr %t10
  %t171 = call i1 @isNullText(ptr %t170)
  br i1 %t171, label %L60, label %L62
L60:
  %t172 = load ptr, ptr %t8
  %t173 = call ptr @stemOf(ptr %t172)
  store ptr %t173, ptr %t10
  br label %L62
L62:
  %t174 = load ptr, ptr %t10
  %t175 = call ptr @withSuffix(ptr %t174, ptr @.str.647)
  %t176 = alloca ptr
  store ptr %t175, ptr %t176
  %t177 = load ptr, ptr %t176
  %t178 = load ptr, ptr %t166
  %t179 = call i1 @writeFile(ptr %t177, ptr %t178)
  %t180 = xor i1 %t179, true
  br i1 %t180, label %L63, label %L65
L63:
  call void @fail(ptr @.str.648)
  br label %L65
L65:
  %t181 = load ptr, ptr %t10
  %t182 = call ptr @withSuffix(ptr %t181, ptr @.str.649)
  %t183 = alloca ptr
  store ptr %t182, ptr %t183
  %t184 = sext i32 7 to i64
  %t185 = mul i64 8, %t184
  %t186 = call ptr @malloc(i64 %t185)
  %t187 = alloca ptr
  store ptr %t186, ptr %t187
  %t188 = load ptr, ptr %t187
  %t189 = sext i32 0 to i64
  %t190 = getelementptr inbounds ptr, ptr %t188, i64 %t189
  store ptr @.str.650, ptr %t190
  %t191 = load ptr, ptr %t187
  %t192 = sext i32 1 to i64
  %t193 = getelementptr inbounds ptr, ptr %t191, i64 %t192
  store ptr @.str.651, ptr %t193
  %t194 = load ptr, ptr %t176
  %t195 = load ptr, ptr %t187
  %t196 = sext i32 2 to i64
  %t197 = getelementptr inbounds ptr, ptr %t195, i64 %t196
  store ptr %t194, ptr %t197
  %t198 = load ptr, ptr %t187
  %t199 = sext i32 3 to i64
  %t200 = getelementptr inbounds ptr, ptr %t198, i64 %t199
  store ptr @.str.652, ptr %t200
  %t201 = load ptr, ptr %t183
  %t202 = load ptr, ptr %t187
  %t203 = sext i32 4 to i64
  %t204 = getelementptr inbounds ptr, ptr %t202, i64 %t203
  store ptr %t201, ptr %t204
  %t205 = load ptr, ptr %t187
  %t206 = sext i32 5 to i64
  %t207 = getelementptr inbounds ptr, ptr %t205, i64 %t206
  store ptr @.str.653, ptr %t207
  %t208 = sext i32 0 to i64
  %t209 = inttoptr i64 %t208 to ptr
  %t210 = load ptr, ptr %t187
  %t211 = sext i32 6 to i64
  %t212 = getelementptr inbounds ptr, ptr %t210, i64 %t211
  store ptr %t209, ptr %t212
  %t213 = load ptr, ptr %t187
  %t214 = call i32 @runProgram(ptr %t213)
  %t215 = icmp ne i32 %t214, 0
  br i1 %t215, label %L66, label %L68
L66:
  call void @fail(ptr @.str.654)
  br label %L68
L68:
  %t216 = sext i32 5 to i64
  %t217 = mul i64 8, %t216
  %t218 = call ptr @malloc(i64 %t217)
  %t219 = alloca ptr
  store ptr %t218, ptr %t219
  %t220 = load ptr, ptr %t219
  %t221 = sext i32 0 to i64
  %t222 = getelementptr inbounds ptr, ptr %t220, i64 %t221
  store ptr @.str.655, ptr %t222
  %t223 = load ptr, ptr %t183
  %t224 = load ptr, ptr %t219
  %t225 = sext i32 1 to i64
  %t226 = getelementptr inbounds ptr, ptr %t224, i64 %t225
  store ptr %t223, ptr %t226
  %t227 = load ptr, ptr %t219
  %t228 = sext i32 2 to i64
  %t229 = getelementptr inbounds ptr, ptr %t227, i64 %t228
  store ptr @.str.656, ptr %t229
  %t230 = load ptr, ptr %t10
  %t231 = load ptr, ptr %t219
  %t232 = sext i32 3 to i64
  %t233 = getelementptr inbounds ptr, ptr %t231, i64 %t232
  store ptr %t230, ptr %t233
  %t234 = sext i32 0 to i64
  %t235 = inttoptr i64 %t234 to ptr
  %t236 = load ptr, ptr %t219
  %t237 = sext i32 4 to i64
  %t238 = getelementptr inbounds ptr, ptr %t236, i64 %t237
  store ptr %t235, ptr %t238
  %t239 = load ptr, ptr %t219
  %t240 = call i32 @runProgram(ptr %t239)
  %t241 = icmp ne i32 %t240, 0
  br i1 %t241, label %L69, label %L71
L69:
  call void @fail(ptr @.str.657)
  br label %L71
L71:
  %t242 = load i1, ptr %t6
  %t243 = xor i1 %t242, true
  br i1 %t243, label %L72, label %L74
L72:
  %t244 = load ptr, ptr %t176
  %t245 = call i32 @remove(ptr %t244)
  %t246 = load ptr, ptr %t183
  %t247 = call i32 @remove(ptr %t246)
  br label %L74
L74:
  ret i32 0
}

