%{
#include <stdio.h>
static int g_words = 0;
static int g_chars = 0;
static int g_lines = 0;

int yywrap();
%}

word [^ \t\n]+ 
eof \n

%%

{word} { g_words++; g_chars += yyleng; }
{eof} { g_lines++; g_chars++;}
. {g_chars++;}

%%

int main() {
  yylex();
  printf("chars:%d words:%d lines:%d\n", g_chars, g_words, g_lines);
}

