# Common flex & yacc Makefile

CCLIBS = -ly -ll
CC = gcc
CCFLAGS = -DYYDEBUG=1
LEX = flex
YACC = bison
YACCFLAGS = -d

#NAME = `echo $PWD | awk 'BEGIN {RS="/";} {print $0;} | sed -n '$p'`
NAME = calc1
OBJS = $(NAME).l.o $(NAME).tab.o
SRCS = $(OBJS:.o=.c)
FILES = $(NAME).l $(NAME).y

$(NAME) : $(FILES)
	$(YACC) -d $(NAME).y
	$(LEX) -o $(NAME).l.c $(NAME).l
	$(CC) $(CCFLAGS) -o $@ $(SRCS) $(CCLIBS)

clean:
	rm -f *.c *.h *.o $(NAME)
