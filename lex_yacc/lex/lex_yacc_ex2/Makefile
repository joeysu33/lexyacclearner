LEXFLAGS = --c++
YACCFLAGS = --language=c++
LEX = lex $(LEXFLAGS)
YACC = bison $(YACCFLAGS)
CC =g++ --verbose

inc2:include2.l
	lex -o include2.l.c include2.l
	gcc -o inc2 include2.l.c -ll

include: include.l.o include.tab.o main.o 
	$(CC) include.l.o include.tab.o main.o -o include

include.l.o: include.l.cc include.tab.hh main.hpp 
	$(CC) -c include.l.cc

include.tab.o: include.tab.cc main.hpp include.tab.hh
	$(CC) -c include.tab.cc

main.o: main.hpp main.cpp 
	$(CC) -c main.cpp

include.tab.cc include.tab.hh: include.y 
	$(YACC) -d include.y 

include.l.cc: include.l include.tab.hh
	$(LEX) -o include.l.cc include.l

clean:
	rm -f *.o *.h *.c *.hh *.cc inc2 include

rebuild: clean include

