/*! interpreter for calc2 */

#include <stdio.h>
#include "calc2.h"
#include "calc2.tab.h"

int ex(NodeType *p) {
  if(!p) return 0;
  switch(p->type) {
    case TypeCon: return p->con.value;
    case TypeId: return sym[p->id.i]; 
    case TypeOpr:
      switch(p->opr.oper) {
        case WHILE: while(ex(p->opr.op[0])) ex(p->opr.op[1]);
                   return 0;
        case IF: if(ex(p->opr.op[0])) ex(p->opr.op[1]);
                   else if(p->opr.nops > 2) ex(p->opr.op[2]);
                   return 0;
        case PRINT: printf("%d\n", ex(p->opr.op[0]));
                   return 0;
        case ';': ex(p->opr.op[0]);                    
                   return ex(p->opr.op[1]);
        case '=': return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
        case UMINUS: return -ex(p->opr.op[0]);
        case '+': return ex(p->opr.op[0]) + ex(p->opr.op[1]);
        case '-': return ex(p->opr.op[0]) - ex(p->opr.op[1]);
        case '*': return ex(p->opr.op[0]) * ex(p->opr.op[1]);
        case '/': return ex(p->opr.op[0]) / ex(p->opr.op[1]);
        case '<': return ex(p->opr.op[0]) < ex(p->opr.op[1]);
        case '>': return ex(p->opr.op[0]) > ex(p->opr.op[1]);
        case GE:  return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
        case LE:  return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
        case NE:  return ex(p->opr.op[0]) != ex(p->opr.op[1]);
        case EQ:  return ex(p->opr.op[0]) == ex(p->opr.op[1]);
      }
  }

  return 0;
}
