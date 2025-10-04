- [X] Fix Parser Ambiguity: First, address the issue in parseStatement to correctly distinguish between an assignment (x = 1;) and a function call statement
      (foo();). This is a critical bug in the parser.
- [] Implement Function Analysis: Flesh out the Analyzer by implementing validation for FuncDecl and FuncCall. This will require extending your symbol table to
      handle function symbols.
- [] Implement `return` statement validation: Ensure that the type of a return statement's expression matches the enclosing function's return type.
- [] (Optional) Refactor Analyzer Traversal: Consider refactoring the Analyzer's traversal to a more traditional visitor pattern. This will improve its structure
      but is less critical than the other points.
