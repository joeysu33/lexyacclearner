#include <stdio.h>
#include "calc2.h"
#include "calc2.tab.h"

static int lbl;

int ex(NodeType * p) {
  int lbl1, lbl2;
  if(!p) return 0;
  switch(p->type) {
    case TypeCon: printf("\tpush\t%d\n", p->con.value);
                break;
    case TypeId: printf("\tpush\t%c\n", p->id.i + 'a');
                break;
    case TypeOpr:
                 switch(p->opr.oper) {
                   case WHILE: printf("L%03d:\n", lbl1 = lbl++);
                              ex(p->opr.op[0]);
                              printf("\tjz\tL%03d\n", lbl2 = lbl++);
                              ex(p->opr.op[1]);
                              printf("\tjump\tL%03d\n", lbl1);
                              printf("L%03d:\n", lbl2);
                              break;
                   case IF: ex(p->opr.op[0]);
                             if(p->opr.nops > 2) {
                               /* if else */
                               printf("\tjz\tL%03d\n", lbl1 = lbl++);
                               ex(p->opr.op[1]);
                               printf("\tjmp\tL%03d\n", lbl2 = lbl++);
                               printf("L%03d:\n", lbl1);
                               ex(p->opr.op[2]);
                               printf("L%03d:\n", lbl2);
                             } else {
                               /* if */
                               printf("\tjz\tL%03d\n", lbl1=lbl++);
                               ex(p->opr.op[1]);
                               printf("L%03d:\n", lbl1);
                             }
                             break;
                   case PRINT: ex(p->opr.op[0]);
                             printf("\tprint\n");
                             break;
                   case '=': ex(p->opr.op[1]);
                             printf("\tpop\t%c\n",p->opr.op[0]->id.i + 'a');
                             break;
                   case UMINUS: ex(p->opr.op[0]);
                             printf("\tneg\n");
                             break;
                   default: ex(p->opr.op[0]);
                            ex(p->opr.op[1]);
                            switch(p->opr.oper) {
                              case '+': printf("\tadd\n"); break;
                              case '-': printf("\tsub\n"); break;
                              case '*': printf("\tmul\n"); break;
                              case '/': printf("\tdiv\n"); break;
                              case '<': printf("\tcompL\n"); break;
                              case '>': printf("\tcompG\n"); break;
                              case GE:  printf("\tcompGE\n"); break;
                              case LE:  printf("\tcompLE\n"); break;
                              case NE:  printf("\tcompNE\n"); break;
                              case EQ:  printf("\tcompEQ\n"); break;
                            }
                 }
  }

  return 0;
}
