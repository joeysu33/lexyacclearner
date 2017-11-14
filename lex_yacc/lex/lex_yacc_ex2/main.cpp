#include "main.hpp"   

//初始化所有的 Include 信息，避免前后关联        
void Include::clear()           
{                     
  headerfile.clear();                                       
  is_quotation = false;
  is_angle = false;
}

//为了能够方便输出，在这里直接准备好了一个流输出函数
std::ostream& operator<<(std::ostream&s,const Include&I)
{ 
  if(I.is_angle)
    s <<"采用尖括号的";

  if(I.is_quotation)
    s <<"采用双引号的";
    s <<"头文件：[" << I.headerfile << "]";

  return s;    
}

