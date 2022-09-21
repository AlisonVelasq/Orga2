CFLAGS=-Wall -Wextra -pedantic -std=c99 -ggdb -Og -no-pie
CC=gcc
LDLIBS=-lm
AS=nasm
ASFLAGS=-f elf64 -g -F DWARF

all: ejercicio

mod.o: mod.s
ejercicio: ejercicio.c mod.o

clean:
	rm -f mod.o ejercicio
