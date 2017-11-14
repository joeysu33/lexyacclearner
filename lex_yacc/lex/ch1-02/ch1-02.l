%{
#include <stdio.h>

/*
这个例子演示了，关键
词的匹配
*/
%}

%%

[ \t]+ /*忽略空格和制表符*/;
is |
am |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go { printf("%s :is a verb.\n",yytext); }

[a-zA-Z]+ { printf("%s: is not verb.\n", yytext); }
.|\n  { printf("Unkown: %c\n", yytext[0]); /*默认打印*/ }

%%

void main() {
  yylex();
}

int yywrap() {
  return 1;
}

