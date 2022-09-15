;creo un vector en .data
section .data
    vector: dd 1, 2, 3, 4, 5, 6 ;uso dd para guardar enteros de 32 bits
                                ;la direccion del primer elem es el nombre del vector, en este caso vector guarda un puntero a 1
    len equ $ - vector ; 4*6 = 24-> 11111111

section .text
    global _start
    global _final

_start:
        xor rdi, rdi
        mov edi, vector ; asigno el puntero del vector a rdi
        xor rcx, rcx
        mov rcx, len ; tam del vect
        shr rcx, 2 ; DIV en 4, 24 = 11000, 6= 110
        xor rax, rax ; limpio
    .cycle:
        add eax, [edi] ; como mis enteros dos de 4 bytes, sumo de a 4
        add edi, 4
        loop .cycle
        _final:  ;tenia un segmentation faul pq puse las ultimas dos lineas para llamar al sistema
        mov eax, 1 ;sys_exit
        int 0x80   ;llama a syscall
