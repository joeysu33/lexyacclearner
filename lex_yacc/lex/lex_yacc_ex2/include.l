%{ 
#include "include.tab.hh" //由Yacc自动生成的所有标记声明，实际上都是C宏 
#include "main.hpp"      //在其中保存了记录头文件所需要的所有数据结构 

extern "C"{ 
  int yywrap(void); 
  int yylex(void); 
} 
%} 

/*增加标记状态*/
%x _INCLUDE_ 
%x _INCLUDE_FILE_

%% 
"#"[ \t]*"include"      
{                                 
  BEGIN _INCLUDE_;//进入_INCLUDE_状态                                 
  yylval.clear(); //需要将所有的Include值初始化                                 
  return INCLUDE; //返回INCLUDE标记                         
} 

<_INCLUDE_>[\"|<]       
{                                 
  BEGIN _INCLUDE_FILE_;// 进入_INCLUDE_FILE_状态                                 
  return *yytext;      // 返回引号或者尖括号                         
} 

<_INCLUDE_FILE_>[^\">]* {                                 
  yylval.headerfile+=yytext;// 记录头文件字符串                                 
  return HEADERFILE;        // 返回头文件标记                         
} 

<_INCLUDE_FILE_>[\"|>]  {                                 
  BEGIN INITIAL;          //恢复到初始状态，默认状态                                 
  return *yytext;         //返回引号或者尖括号                         
} 

[ \t\n]       ;// 对于额外的空白都不处理直接扔掉 

%% 
int yywrap(void) {         
  return 1;// 只处理一个输入文件 
}  

