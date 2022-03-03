%{  // definitions section
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token INT

%start EVAL
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%nonassoc '<' '>' '='

%%  // rules section

EVAL:
        EVAL E '\n' { printf("Result= %d\n\n", $2); }
        | EVAL '\n' { return 0; }
        |
        ;
E:
        INT { $$ = $1; }
        | E '+' E { $$ = $1 + $3; }
        | E '-' E { $$ = $1 - $3; }
        | E '*' E { $$ = $1 * $3; }
        | E '/' E { $$ = $1 / $3; }
        | E '%' E { $$ = $1 % $3; }
        | E '>' E { $$ = $1 > $3; }
        | E '<' E { $$ = $1 < $3; }
        | E '=' E { $$ = $1 == $3; }
        | '(' E ')' { $$ = $2; }
        ;

%%  // user code section

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Enter Expression:\n");
    yyparse();
    return 0;
}