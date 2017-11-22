#if !defined(CALC2_INCLUED_H)
#define CALC2_INCLUED_H

struct NodeTypeTag;

typedef enum {
  TypeCon,
  TypeId,
  TypeOpr,
} NodeEnum;

/*! constants*/
typedef struct {
  int value; 
} ConNodeType;

/*! identifier */
typedef struct {
  int i;
} IdNodeType;

/* operators */
typedef struct {
  int oper;  /* operator */
  int nops;  /* number of operands */
  struct NodeTypeTag *op[6]; /* operands (expandable) ,max of operands is 6*/
} OprNodeType;

/* node type tag*/
typedef struct NodeTypeTag {
  NodeEnum type;
  union {
    ConNodeType con;
    IdNodeType id;
    OprNodeType opr;
  };
} NodeType;


extern int sym[26];

#endif //CALC2_INCLUED_H




