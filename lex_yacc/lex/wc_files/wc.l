%{
#include <stdio.h>
#include <assert.h>

/*!
flex处理多个输入文件 yylex
*/
int yywrap();

static int g_chars = 0, g_lines = 0, g_words = 0;
static int g_filecount = 0;
static int g_currentfile = 0;
static char **g_filename = NULL;
static FILE *g_oldstdin = NULL;
%}

word [^ \t\n]+
eof \n

%%
{word} { g_words++; g_chars += yyleng; }
{eof} {g_lines++; g_chars++;}
. {g_chars++;}

%%
void show(const char* source) {
  static int times = 0;
  //fprintf(stdout, "call show %d times\n", ++times);
  fprintf(stdout, "file:%s lines:%-8d words:%-8d chars:%-8d\n", source,g_lines, g_words, g_chars);
}

void closefile() {
  static int ntimes = 0;
  //fprintf(stdout, "call close file:%d times\n", ++ntimes);
  if(yyin && yyin != g_oldstdin) {
    fclose(yyin);
    yyin = g_oldstdin;
  }
  g_lines = 0;
  g_words = 0;
  g_chars = 0;
}

int main(int argc, char *argv[]) {
  if(argc < 2 ) {
    /*!文件数据来自stdin*/
    yylex();
    show("stdin");
    return 0;
  }

  g_currentfile = 0;
  g_filecount = argc - 1;
  g_filename = &argv[1];
  g_oldstdin = yyin;

  //yydebug仅在yacc中可以使用
  //yydebug = 1;
  /*if(yyout != stdout) {
    yyout = stdout;
    printf("switch to stdout\n");
  }*/

  fprintf(stdout,"start to executed yywrap\n");
  /*!指向第一个文件*/
  yywrap();
  yylex();

  /*!关闭并打印最后一个文件信息*/
  //printf("call XXXXXX\n");
  //show(g_filename[g_currentfile]);
  //closefile();

  return 0;
}

int yywrap() {
  static int times = 0;
  //fprintf(stdout, "call yywrap %d times\n", ++times);

  for(; g_filecount > 0; g_filecount--) {
    if(!g_filename[g_currentfile]) {
      g_currentfile++;
      continue;
    }

    FILE *f = fopen(g_filename[g_currentfile],"r");
    if(!f) {
      g_currentfile++;
      continue;
    }

    /*
    打印上一次的信息，并关闭上次打开的文件
    */
    {
      if(yyin != g_oldstdin) 
        show(g_filename[g_currentfile]);
      closefile();
    }

    yyin = f;
    printf("file open success: %s\n", g_filename[g_currentfile]);
    g_filecount--;
    g_currentfile++;
    return 0;
  }

  if(yyin != g_oldstdin && g_currentfile > 0) 
    show(g_filename[g_currentfile-1]);
  closefile();

  return 1;
}


