void main() {
  yylex(); /* start the analysis */
  printf("No of words: %d\n", wordCount);
}

int yywrap() {
  return 1;
}

