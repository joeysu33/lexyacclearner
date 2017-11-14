%{
#include <stdio.h>
%}

%%

[ ] printf("space\n");
[\t] printf("tab\n");
[\n] printf("newline\n");
[0-9]+  printf("Int : %s\n", yytext);
[0-9]*\.[0-9]+ printf("Float :%s\n", yytext);
[a-zA-Z_][a-zA-Z0-9_]* printf("Identifer :%s\n", yytext);

"+" printf("Plus\n");
"-" printf("Mius\n");
"*" printf("Multipy\n");
"/" printf("Divide\n");

. printf("Unknow :%c\n", yytext[0]);

%%

