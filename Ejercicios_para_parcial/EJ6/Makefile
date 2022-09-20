make:
	nasm -f elf64 -g EJ6_cesar_asm.asm -o EJ6_cesar_asm.o
	gcc -ggdb -o EJ6_cesar EJ6_cesar.c EJ6_cesar_asm.o

clean:
	rm EJ6_cesar EJ6_cesar_asm.o