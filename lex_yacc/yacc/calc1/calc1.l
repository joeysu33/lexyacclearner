%{
#include "calc1.tab.h"

extern int yylval;
%}

termsym [\n\-+*/()=]
num [0-9]+
var [a-z]

%%
{termsym} {return *yytext; }
{num} {yylval = atoi(yytext); return NUM;}
{var} {yylval = *yytext - 'a'; return VAR; }
[ \t] ;
. {fprintf(stderr, "%s%c", "invalid symbol:", yytext[0]); }


