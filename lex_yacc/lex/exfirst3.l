%{
#include <stdio.h>
int linenum = 0;
void showtitle();
%}

%%
[ \t] ;
title showtitle();
[\n] linenum++;
[0-9]+ printf("Int: %s\n", yytext);
[0-9]*\.[0-9]+ printf("Float: %s\n", yytext);
[a-zA-Z_][a-zA-Z0-9_]* printf("Identifier: %s\n",yytext);
[\+\-\*\/%] printf("Op: %s\n", yytext);
"=" printf("Eq\n");
\/\/.*\n printf("It's one line comment:%s\n", yytext);
\/\*(.|\n)*\*\/ printf("It's comment:%s\n", yytext);
. printf("Unkndow symbols: %c\n", yytext[0]);
%%

void showtitle() {
  printf("------Lex Example--------\n");
}

int main() {
  linenum=0;
  yylex(); /*!进行分析*/
  printf("line count:%d", linenum);
  return 0;
}

int yywrap() {
  return 1;
}


