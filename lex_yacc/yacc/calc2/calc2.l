%{
#include <stdlib.h>
#include "calc2.h"
#include "calc2.tab.h"

extern void yyerror(char *);
%}

var [a-z]
num [0-9]+
term [-()<>=+*/;{}.] 
ws [\t\n ]

%%
 /*! symbols*/
{var} { yylval.sIndex = *yytext - 'a'; return VARIABLE; }
{num} { yylval.iValue = atoi(yytext); return INTEGER; }
{term} { return *yytext; }

 /*! compare key words */
">=" return GE;
"<=" return LE;
"==" return EQ;
"!=" return NE;

 /*! key words*/
"while" return WHILE;
"if" return IF;
"else" return ELSE;
"print" return PRINT;

 /*! other words */
{ws} ; /*! ignore white space */
. {yyerror("Unknown character."); }

%%

int yywrap() { return 1; }



