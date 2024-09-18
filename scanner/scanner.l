%{
#include <stdio.h>
int line_number = 1;
%}

%%

\n              { line_number++; }

"define-fun"    { printf("Line %d: function definition keyword: %s\n", line_number, yytext); }
"get-int"       { printf("Line %d: predefined function: %s\n", line_number, yytext); }
"if"            { printf("Line %d: conditional operator: %s\n", line_number, yytext); }
"print"         { printf("Line %d: program entry: %s\n", line_number, yytext); }
"<="|">="|"=="|">"|"<" { printf("Line %d: arithmetic comparison: %s\n", line_number, yytext); }

[+\-*]              { printf("Line %d: arithmetic operation: %s\n", line_number, yytext ); }

[0-9]+          { printf("Line %d: arithmetic/int constant: %s\n", line_number, yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("Line %d: variable/function: %s\n", line_number, yytext); }

"\("            { printf("Line %d: left parenthesis: %s\n", line_number, yytext); }
"\)"            { printf("Line %d: right parenthesis: %s\n", line_number, yytext); }

[ \t\n]+        { /* Skip whitespace, tabs, newlines */ }

.               { printf("Error on line %d: Unrecognized token '%s'\n", line_number, yytext); exit(1); }


%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            printf("Error: Cannot open file %s\n", argv[1]);
            return 1;
        }
        yyin = file;
    }
    yylex();
    return 0;
}
