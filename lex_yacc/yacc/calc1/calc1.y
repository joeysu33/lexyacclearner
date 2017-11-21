%{
/* save values */
int symtbl[26];
%}

%token VAR NUM
%start program 
%left '+' '-'
%left '*' '/'

%%
program : program stat '\n'
      |
      ;

stat : expr {printf("=%d\n", $1); }
     | VAR '=' expr {symtbl[$1] = $3; }
     ;

expr : NUM {$$ = $1; }
     | VAR {$$ = symtbl[$1]; }
     | '-' expr {$$ = -$2; }
     | expr '+' expr { $$ = $1 + $3; }
     | expr '-' expr { $$ = $1 - $3; }
     | expr '*' expr { $$ = $1 * $3; }
     | expr '/' expr { 
       if ($3 == 0) 
       {  
         fprintf(stderr, "%s", "divide 0 is error"); 
         exit(1);
       } 
       else 
         $$ = $1 / $3; 
       }
     | '(' expr ')' { $$ = $2; }
     ;


