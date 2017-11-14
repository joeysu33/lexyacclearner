LEX = lex
CC = gcc
CCFLAGS = 

mywc:wc.l.o
	$(CC) -o mywc wc.l.o -ll

wc.l.o: wc.l
	$(LEX) -o wc.l.c wc.l
	$(CC) $(CCFLAGS) -c -o wc.l.o wc.l.c

clean:
	rm -f *.o *.c *.h

rebuid: clean mywc
