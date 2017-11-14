%{ 
#include <stdio.h>
int yywrap(void); 
/*!
lex中的空格不是\s ?????
*/
%} 

%% 
"#"[ \t]*"include"" "+[\"<][^\">]+[\">] {
  printf("find match include: %s\n", yytext);
}

[ \t\n]       ;// 对于额外的空白都不处理直接扔掉
. ;

%%
int yywrap(void) {
  return 1;// 只处理一个输入文件
}

