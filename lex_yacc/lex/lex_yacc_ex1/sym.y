%{
/*!用来解释词法*/
/*第二段是规则段，通过词性来定义规则段*/

#include <stdio.h>
void yyerror(const char* s);
%}

%token NOUN PRONOUN VERB PREPOSITION ADJECTIVE ADVERB CONJUNCTION DECLARE 

%%

complicated_sentence: setence|
                    complicated_sentence setence 
                    {printf("complicated_sentence!\n");}

setence: subject VERB object |
       simple_declare |
       complicated_declare 
       { printf("Sentence is valid!!!\n"); } 
       ;

subject: NOUN | 
       PRONOUN 
       ;
object: NOUN
      ;
complicated_declare: simple_declare words |
                   complicated_declare words
                   {printf("Find complicated_declare sentence.\n");}
                   ;
simple_declare: declare words
              {printf("Find simple_declare sentence.\n");}
              ;
declare: DECLARE
       ;
words: NOUN | 
     PRONOUN |
     VERB |
     PREPOSITION |
     ADJECTIVE |
     ADVERB |
     CONJUNCTION 
     ;

%%

extern FILE *yyin;

int main() {
  //yydebug = 1;
  do{
    yyparse();
  }while(!feof(yyin));

  return 0;
}

/*!难道不应该是先char *s*/
/*yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n", s);
}
*/

void yyerror(const char *s) {
  fprintf(stderr, "error msg:%s \n", s);
}

