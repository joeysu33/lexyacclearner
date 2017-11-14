%{
#include <stdio.h>
/*!第一部分*/
%}

%%

[ \t] {printf("space ...\n");} 
this {printf("find this;\n"); }  
.|\n+ {printf("ignore:%s", yytext);}

%%
/*!函数部分*/
int main() {
  yylex();
  printf("complete token parser!!!!\n");
  return 0;
}

int yywrap() {
  return 1;
}



