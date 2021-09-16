# html_parser 
HTML5 parser using bison (yacc) and flex (lex) utils.

## Build
- bison -d parser.y
- flex lexer.l
- Then compile with new y.tab.c and parser.tab.c files.

## Run
- parser.exe input.html
