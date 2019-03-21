CC=gcc
CFLAGS=-Wall

all: wav
wav: wav.o
wav.o: wav.c  melfunction_pkg/melfunction.h melfunction_pkg/melfunction_terminate.h melfunction_pkg/melfunction_initialize.h melfunction_pkg/melfunction_initialize.c melfunction_pkg/rt_nonfinite.h    

clean:
	rm -f wav wav.o

run: wav
	./wav


	
