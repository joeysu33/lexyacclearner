#pragma once  

#include <iostream>  
#include <string>  
#include <vector>  
#include <algorithm>  
#include <iterator>   

对于每一个项目最好都用一个独立的数据结构来保存相应的信息        
struct Include           
{                                   
  std::string headerfile;       记录头文件全名（包括路径)
  bool is_quotation;            是否是双引号""括起来的头文件 
  bool is_angle;                是否是尖括号<>括起来的头文件

  void  clear();                设置Include的初始值                                                          
  //下面的这个函数仅仅是用来输出到C++流而准备的
  friend std::ostream& operator <<(std::ostream &s,const Include& I);                                                                        
};

std::ostream&operator<<(std::ostream&s,    const     Include&I);   

//下面的这个宏定义用来取消 Lex 和 Yacc 默认的 YYSTYPE 定义，因为默认的 YYSTYPE 定义         
//仅仅只能够记录整数信息，因此要保存额外的信息必须这样定义宏，可以参见Yacc               
//自动生成的标记头文件     frame.tab.h。                    

#define YYSTYPE Include 


