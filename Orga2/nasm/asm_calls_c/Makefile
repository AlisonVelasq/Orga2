AS      := nasm
ASFLAGS := -f elf64 -F DWARF -g -Wall

CC      := gcc
CFLAGS  := -Wall -Wextra -pedantic -g -no-pie

TARGET := suma

.PHONY: all
all: $(TARGET)

#Compilar assembly
main.o: main.asm
	$(AS) $(ASFLAGS) $< -o $@

fun.o: fun.c
	$(CC) $(CFLAGS) -c $< -o $@

#Crear ejecutable
$(TARGET): main.o fun.o
	$(CC) $(CFLAGS) $^ -o $@

#Clean directorio
.PHONY: clean
clean:
	rm -rf *.o $(TARGET)