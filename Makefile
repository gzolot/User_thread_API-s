.DEFAULT_GOAL := all

CC 	= gcc

 

CFLAGS	= -Wall -g -I .

 

LD	= gcc

 

LDFLAGS	= -Wall -g


PROGS  	= nums snakes hungry

 

SNAKEOBJS  = randomsnakes.o

 

HUNGRYOBJS = hungrysnakes.o

 

NUMOBJS    = numbersmain.o

 

OBJS      = $(SNAKEOBJS) $(HUNGRYOBJS) $(NUMOBJS)

 

SRCS      = randomsnakes.c numbersmain.c hungrysnakes.c

 

HDRS     =

 

EXTRACLEAN = core $(PROGS)

 

tests:$(PROGS)

all: liblwp.a
 
liblwp.so: lwp.c magic64.S smartalloc.c
	gcc -fPIC -c lwp.c magic64.S smartalloc.c
	gcc -shared -o liblwp.so lwp.o magic64.o smartalloc.o


allclean: clean
	@rm -f $(EXTRACLEAN)

 

clean:   
	rm -f $(OBJS) lwp.o magic64.o liblwp.a smartalloc.o 

 
snakes: randomsnakes.o liblwp.a libsnakes.a
	$(LD) $(LDFLAGS) -o snakes randomsnakes.o -L. -lncurses -lsnakes -llwp

 

hungry: hungrysnakes.o liblwp.a libsnakes.a
	$(LD) $(LDFLAGS) -o hungry hungrysnakes.o -L. -lncurses -lsnakes -llwp

 

nums: numbersmain.o liblwp.a
	$(LD) $(LDFLAGS) -o nums AlwaysZero.c numbersmain.o -L. -llwp

 

hungrysnakes.o: lwp.h snakes.h

 

randomsnakes.o: lwp.h snakes.h

 

numbermain.o: lwp.h

 

liblwp.a: lwp.c
	gcc -c lwp.c magic64.S smartalloc.c
	ar r liblwp.a lwp.o magic64.o smartalloc.o
	rm lwp.o

 

submission: lwp.c Makefile README
	tar -cf project2_submission.tar lwp.c Makefile README
	gzip project2_submission.tar
