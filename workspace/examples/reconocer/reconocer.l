%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line = 1;
int position = 1;

void print_token(const char* type, const char* value) {
    printf("Token(%s, '%s', line=%d)\n", type, value, line);
}
%}

%%

[ \t]+                { position += yyleng; }
\n                    { line++; position = 1; }

"//".*                { }

"/*"([^*]|(\*+[^*/]))*\*+"/"   { }

0[xX][0-9a-fA-F]+     { print_token("HEX_INTEGER", yytext); }

[0-9]+(\.[0-9]+)?[eE][+-]?[0-9]+  { print_token("SCIENTIFIC", yytext); }

[0-9]+"."[0-9]+       { print_token("FLOAT", yytext); }

[0-9]+                { print_token("INTEGER", yytext); }

\"([^\\\"]|\\.)*\"    { print_token("STRING", yytext); }

"=="                  { print_token("EQ", yytext); }
"!="                  { print_token("NEQ", yytext); }
"<="                  { print_token("LE", yytext); }
">="                  { print_token("GE", yytext); }
"&&"                  { print_token("AND", yytext); }
"||"                  { print_token("OR", yytext); }

"+"                   { print_token("PLUS", yytext); }
"-"                   { print_token("MINUS", yytext); }
"*"                   { print_token("MULT", yytext); }
"/"                   { print_token("DIV", yytext); }
"<"                   { print_token("LT", yytext); }
">"                   { print_token("GT", yytext); }
"!"                   { print_token("NOT", yytext); }

[A-Za-z_][A-Za-z0-9_]*   { print_token("IDENTIFIER", yytext); }

.                     { printf("Lexical error at line %d: %s\n", line, yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char** argv) {
    if (argc > 1) {
        FILE* file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening file");
            return 1;
        }
        yyin = file;
    }
    yylex();
    return 0;
}

