%{
/*!
带符号表的单词识别程序,基于行来定义的单词属性
默认无法识别和处理的单词都会执行ECHO进行输出
注意:ECHO是大写
例如： noun dog cat mouse 
*/

#include <stdio.h>
#include <assert.h>
#include <string.h>
enum {
  LOOKUP = 0, /*!默认-查找而不是定义*/
  VERB,
  ADJ,
  ADV,
  NOUN,
  PREP,
  PRON,
  CONJ,
  LAST,
};

/*!
使用一个链表来存储词表
*/
typedef struct Word{
  int m_type;
  char* m_word;
  struct Word* m_next;
} Word, *PWord;

int state;
int add_word(int type, char* word);
int lookup_word(char *word);

static Word* g_tbl = NULL;
/*!C函数不支持默认值 wtf*/
static Word* newWord(char *word ) ;
static void clean();

%}

%%

[ \t] ; /*ignore this*/
\n {state = LOOKUP; } /*行结束，返回到默认状态*/
^verb {state = VERB; }
^adj {state = ADJ; }
^noun {state = NOUN; }
^prep {state = PREP; }
^pron {state = PRON; }
^conj {state = CONJ; }
. ; /* ignore this*/

[a-zA-Z]+ {
  /*!一个标准的单词，定义它或者查找它*/
  if(state != LOOKUP) {
    /*!学习过程，将单词加入单词表*/
    if(add_word(state, yytext)) {
      printf("add_word error, state=%d, text=%s !!!\n", state, yytext);
    }
  } else {
    /*!使用之前定义的单词表来查找单词*/
    switch(lookup_word(yytext)) {
      case VERB: printf("%s: is verb\n", yytext); break;
      case ADJ: printf("%s: is adj\n", yytext); break;
      case ADV: printf("%s: is adv\n", yytext); break;
      case NOUN: printf("%s: is noun\n",yytext); break;
      case PREP: printf("%s: is prep\n", yytext); break;
      case PRON: printf("%s: is pron\n", yytext); break;
      case CONJ: printf("%s: is conj\n", yytext); break;
      //default: printf("Unknown words!!!\n");break;
    }
  }
}

%%
int main() {
  yylex();
  clean();
  printf("finish this parse\n");
  return 0;
}

Word* newWord(char *word ) {
  Word* p = (Word*)malloc(sizeof(Word));
  if(!p) {
    printf("Memory is out of range!!!\n");
    assert(p);
    return (Word*)NULL;

  } else {
    p->m_type = LOOKUP;
    /*!strdup新建字符串分配内存*/
    p->m_word = strdup(word);
    p->m_next = NULL;

    if(!p->m_word) {
      printf("Memory out of range!!!\n");
      free((void*)p);
      return (Word*)NULL;
    }
  }
  return p;
}

int add_word(int type, char* word) {
  Word *p = NULL;
  printf("call add_word,type=%d word=%s\n",type, word);
  if(!word || type <= 0 || type >= LAST) {
    return 1;
  }

  if(!g_tbl) {
    g_tbl = newWord(word);
    return 0;
  }

  p = g_tbl;
  while(p->m_next) {
    p=p->m_next;
  }
  p->m_next = newWord(word);

  return 0;
}

/*!链表的线性搜索算法*/
int lookup_word(char *word) {
  Word* p = g_tbl;
  while(p) {
    if(!strcmp(p->m_word, word)) {
      printf("call lookup_word, word=%s, found!\n",word);
      return p->m_type;
    }

    p = p->m_next;
  }

  printf("call lookup_word, word=%s, not found!\n",word);
  return LOOKUP;
}

void clean(){
  Word* p = NULL;
  while(g_tbl) {
    p = g_tbl;
    g_tbl = g_tbl->m_next;
    free((void*)p->m_word);
    free((void*)p);
  }
}

int yywrap() {
  return 1;
}

