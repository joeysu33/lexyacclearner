lexyacc: symtbl.l.o y.tab.o
	gcc -o lexyacc symtbl.l.o y.tab.o -ll

symtbl.l.o: symtbl.l.c
	gcc -g -c -o symtbl.l.o symtbl.l.c

y.tab.o: y.tab.c
	gcc -g -c -o y.tab.o y.tab.c

y.tab.c: sym.y
	yacc -d sym.y --xml=y.tab.xml --verbose --debug

symtbl.l.c: symtbl.l y.tab.c
	lex -o symtbl.l.c symtbl.l

clean:
	rm -f *.o
	rm -f *.c
	rm -f lexyacc
	rm -f *.h

rebuild: clean lexyacc
	echo "rebuild ..."
