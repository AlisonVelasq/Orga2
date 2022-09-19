AS      := nasm
ASFLAGS := -f elf64 -F DWARF -g -Wall

CC      := gcc
CFLAGS  := -Wall -Wextra -pedantic -g

TARGET := app

.PHONY: all
all: $(TARGET)

#Compilar assembly
EJ6_cesar_asm.o: EJ6_cesar_asm.asm
	$(AS) $(ASFLAGS) $<

EJ6_cesar.o: EJ6_cesar.c
	$(CC) $(CFLAGS) -c $< -o $@

#Crear ejecutable
$(TARGET): EJ6_cesar.o EJ6_cesar_asm.o
	$(CC) $(CFLAGS) $^ -o $@

#Clean directorio
.PHONY: clean
clean:
	rm -rf *.o $(TARGET)