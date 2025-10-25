# Ode

Ode is a simple imperative programming language, built for educational purposes. This repository contains the source code for the Ode compiler, which is written in C++ and uses LLVM for code generation.

## Building the Compiler

To build the `ode` compiler, you need to have `cmake` and `llvm` installed on your system.

```bash
cmake -B build -S .
cmake --build ./build
```

This will create the `ode` executable in the `build` directory.

## Running the Compiler

To compile an Ode source file, you can run the following command:

```bash
./build/ode <source_file.ode>
```

This will generate an object file named `output.o`. You can then link this object file to create an executable.

## The Ode Language

### "Hello, World!" Example

While the language doesn't have a standard library for I/O, a simple program looks like this:

```rust
fn main(): i32 {
    let x: i32 = 10;
    return x;
}
```

### Grammar

The grammar of the Ode language is as follows:

```
Program     → Statement*
Statement   → VarDecl | Assign | IfStmt | WhileStmt | FuncDecl | ReturnStmt | ExprStmt
VarDecl     → `let` IDENT `:` Type `=` Expr `;`
Assign      → IDENT `=` Expr `;`
IfStmt      → `if` `(` Expr `)` Block (`else` Block)?
WhileStmt   → `while` `(` Expr `)` Block
FuncDecl    → `fn` IDENT `(` ParamList? `)` `:` Type Block
ParamList   → Param (`,` Param)*
Param       → IDENT `:` Type
FuncCall    → IDENT `(` ArgList? `)`
ArgList     → Expr (`,` Expr)*
ReturnStmt  → `return` Expr `;`
ExprStmt    → Expr `;`
Block       → `{` Statement* `}`
Expr        → LogicOr
LogicOr     → LogicAnd (`||` LogicAnd)*
LogicAnd    → Equality (`&&` Equality)*
Equality    → Comparison ((`==` | `!=`) Comparison)*
Comparison  → Term ((`<` | `<=` | `>` | `>=`) Term)*
Term        → Factor ((`+` | `-`) Factor)*
Factor      → Primary ((`*` | `/`) Primary)*
Primary     → NUMBER | IDENT | BOOLEAN | `(` Expr `)`
Type        → i32 | bool
```