%{  // definitions section
#include <stdlib.h> // needed for atoi function
#include "y.tab.h"  // the parser file's header
void yyerror(char *);
%}

NEWLINE         [\n]
WHITESPACE      [\t ]
OPERATORS       [\(\)+\-*/%<>=]
NUMBER          [0-9]+

%%  // rules section

{NUMBER}        { yylval = atoi(yytext);
                    return INT;
                }
{OPERATORS}     return *yytext;
{NEWLINE}       return '\n';
{WHITESPACE}    ;
.               yyerror("illegal character!");

%%  // user code section

int yywrap(void) {return 1;} // we return 1 when we reach end of file to end lexical analysis when \n is not provided
