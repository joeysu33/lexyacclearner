
interpreter : calc2.y calc2.l 
	bison -d calc2.y
	flex -o calc2.l.c calc2.l
	gcc -o $@ calc2.l.c calc2.tab.c $@.c  -ly -ll

compiler: calc2.y calc2.l 
	bison -d calc2.y
	flex -o calc2.l.c calc2.l
	gcc -o $@ calc2.l.c calc2.tab.c $@.c  -ly -ll

clean:
	rm -f calc2.*.c calc2.*.h *.o 
	find . -type f -executable -exec rm -f {} \;

