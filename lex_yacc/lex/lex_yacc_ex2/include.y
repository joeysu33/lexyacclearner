%{ 
  #include <iostream> 
  #include "main.hpp" 
  #define YYDEBUG 0 // 将这个变量设置为1则表示启动Yacc的调试功能 
  extern "C" { 
  void yyerror(const char *s); 
  extern int yylex(void); } 

  std::vector<Include> g_Includes;// 用来记录所有的包含声明 
  Include             *g_pInclude;// 用来保存新增的包含声明信息的指针 

  //#define YYDEBUG
%} 

%token INCLUDE 
%token HEADERFILE 

%% 
program:
  /* empty */ | 
  program include_preprocess /*用这种递归的方式从有限的标记表达出无限的内容*/
  ;

include_preprocess:           
                  INCLUDE '<'  HEADERFILE '>'         
                  {                 
                    // 注意这里的$3，实际上就是上面的标记的第三个的意思               
                    // 因为yylval被声明为Include结构，参见main.hpp文件               
                    // 因而每个标记都是Include结构类型。               
                    g_Includes.push_back(Include());               
                    g_pInclude = &g_Includes.back();               
                    g_pInclude->clear();// 初始化               
                    g_pInclude->headerfile   = $3.headerfile;// 可以证明$3的类型就是Include类型               
                    g_pInclude->is_angle     = true;// 是尖括号               
                    g_pInclude->is_quotation = false;// 不是双引号         
                  } | 
                  INCLUDE '\"' HEADERFILE '\"'         
                  {                 
                    // 值得说明的是：上面的include_preprocess用$表示，               
                    // 而不是用$0表示。从左向右依次为：               
                    // include_preprocess        $               
                    // INCLUDE                   $1               
                    // '\"'                      $2               
                    // HEADERFILE                $3               
                    // '\"'                      $4               
                    g_Includes.push_back(Include());               
                    g_pInclude = &g_Includes.back();               
                    g_pInclude->clear();// 初始化               
                    g_pInclude->headerfile   = $3.headerfile;               
                    g_pInclude->is_angle     = false;// 不是尖括号               
                    g_pInclude->is_quotation = true;// 是双引号         
                  }          
                  ;

%% 
void yyerror(const char *s) 
{         
  std::cerr<< s << std::endl; 
} 

int main() { 
#if YYDEBUG         
    yydebug = 1; 
#endif//YYDEBUG         

  yyparse();// 进行语法分析，这个函数是Yacc自动生成的         
  // 下面的这行代码仅仅使用了STL的输出算法到标准输出         
  std::copy(g_Includes.begin(),g_Includes.end(),std::ostream_iterator<Include>(std::cout,"\n"));         
  return 0; 
}


