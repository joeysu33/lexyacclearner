%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

#include "calc2.h"

/* prototypes */
NodeType *opr(int oper, int nops, ...);
NodeType *id (int i);
NodeType *con(int value);

NodeType *newNode();
void freeNode(NodeType* p);

int ex(NodeType * p);
extern int yylex(void);
void yyerror(char *s);

int sym[26]; /*symbol table */
%}

%union {
  int iValue; /* integer value */
  char sIndex; /* symble 'identifier' */
  NodeType *nPtr; /*Node pointer */
};

%token <iValue> INTEGER
%token <sIndex> VARIABLE
%token WHILE IF PRINT

%nonassoc IFX
%nonassoc ELSE

/*! compare operator */
%left GE LE EQ NE '>' '<'
/*! plus minus multipy divide operator*/
%left '+' '-'
%left '*' '/'

/*! unary minus */
%nonassoc UMINUS

/*! non-terminal identifier*/
%type <nPtr> stmt expr stmt_list

%%

program: function {exit(0);}
        ;

function: function stmt { ex($2); freeNode($2); }
        | /*! NULL */
        ;

stmt : ';' { $$ = opr(';', 2, NULL, NULL); }
     | expr ';' {$$ = $1;}
     | PRINT expr ';' { $$ = opr(PRINT, 1, $2); }
     | VARIABLE '=' expr ';' { $$ = opr('=', 2, id($1), $3); }
     | WHILE '(' expr ')' stmt { $$ = opr(WHILE, 2, $3, $5); }
     | IF '(' expr ')' stmt %prec IFX { $$ = opr(IF, 2, $3, $5); }
     | IF '(' expr ')' stmt ELSE stmt { $$ = opr(IF, 3, $3, $5, $7); }
     | '{' stmt_list '}' {$$ = $2; }
     ;

stmt_list: stmt {$$ = $1; }
         | stmt_list stmt { $$ = opr(';', 2, $1, $2); }
         ;

expr: INTEGER {$$ = con($1); }
    | VARIABLE {$$ = id($1); }
    | '-' expr %prec UMINUS { $$ = opr(UMINUS, 1, $2); }
    | expr '+' expr { $$ = opr('+', 2, $1, $3); }
    | expr '-' expr { $$ = opr('-', 2, $1, $3); }
    | expr '*' expr { $$ = opr('*', 2, $1, $3); }
    | expr '/' expr { $$ = opr('/', 2, $1, $3); } /*! should checker */
    | expr '<' expr { $$ = opr('<', 2, $1, $3); }
    | expr '>' expr { $$ = opr('>', 2, $1, $3); }
    | expr GE  expr { $$ = opr(GE, 2, $1, $3); }
    | expr LE  expr { $$ = opr(LE, 2, $1, $3); }
    | expr NE  expr { $$ = opr(NE, 2, $1, $3); }
    | expr EQ  expr { $$ = opr(EQ, 2, $1, $3); }
    | '(' expr ')' {$$ = $2; }
    ;

%%

/* TODO fix it*/
//#define SIZEOF_NODETYPE 

NodeType *con (int value) {
  NodeType *p = newNode();
  p->type = TypeCon;
  p->con.value = value;
  return p;
}

NodeType* id(int i) {
  NodeType *p = newNode();
  p->type = TypeId;
  p->id.i = i;
  return p;
}

NodeType* newNode() {
  NodeType* p = (NodeType*)malloc(sizeof(NodeType));
  if(!p) {
    yyerror("Out of memory!!!");
    exit(10);
  }

  return p;
}

NodeType* opr(int oper, int nops,...) {
  int i=0;
  va_list ap;
  NodeType *p = newNode();
  p->type = TypeOpr;
  p->opr.oper = oper;
  p->opr.nops = nops;
  
  va_start(ap, nops);
  for(i=0; i<nops; ++i) {
    p->opr.op[i] = va_arg(ap, NodeType*);
  }
  va_end(ap);

  return p;
}

void freeNode(NodeType* p) {
  int i;
  if(!p) return;

  /* free memory recursively */
  if(p->type == TypeOpr) {
    for(i=0; i<p->opr.nops; ++i) {
      freeNode(p->opr.op[i]);
    }
  }

  free(p);
}


void yyerror(char *s) {
  fprintf(stderr, "yyerror: %s\n", s);
}

int main() {
  yyparse();
  return 0;
}


