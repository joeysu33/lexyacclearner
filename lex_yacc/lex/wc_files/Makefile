CC = gcc
LEX = lex

mywc: wc.l.o
	$(CC) -o mywc wc.l.o

wc.l.o:wc.l
	$(LEX) -o wc.l.c wc.l
	$(CC) -c wc.l.c -o wc.l.o

clean:
	rm -f *.o *.c *.h mywc

rebuild: clean mywc
