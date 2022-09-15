;a)escribir un prog que lea los enteros desde memoria y guardarlos en registros distintos antes de guardarlos

section .data
    vector: dd 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 
    len equ $ - vector ; 4*16 = 64-> 100000
    ;cada enteros tiene 4 bytes (64 bits)

section .text
    global _start
    global _final

_start:
        ;armo el stack frame por que no me alcanzan los registros
        push rbp
        mov rbp, rsp 

        ;primero limpio los registros que quiero usar
        xor rdi, rdi
        
        xor rsi, rsi 
        xor rdx, rdx
        xor rcx, rcx
        xor r8, r8 
        xor r9, r9

        ;guardo los enteros en los registros
        mov edi, vector ; lo guardo en edi por que mis enteros son de 32 bits
        mov esi, [edi]
        mov edx, [edi+4]
        mov r8d, [edi+8]
        mov r9d, [edi+12]
        
        ;solo guarde 4 registros
        ;tengo que guardarlos en la pila

        ;push [esi+16]
        ;push [esi+20]
        ;push [esi+24]
        ;push [esi+28]
        ;push [esi+32]

        ;contador del loop
        mov rcx, len ; tam del vect (4(bytes)*16(enteros))
        shr rcx, 2 ; DIV en 4
        sub rcx, 4 ; le resto la cant de registros que ya guarde

        sub rsp, 48; 48 = 4(bytes)*12(enteros), quiero guardas 12 enteros de 4 bytes cada uno
    .rep: ;en la pila guarde de a 4 bytes
    ;tengo que reservar lugar en la pila para ir almacenando los enteron?
        push [esi] 
        add esi, 4
        loop .rep


        xor rax, rax ; limpio
        ;sumo los registros
        add eax, esi ; ambos deben ser de 32 bits, sino no anda(i.e ambos con e)
        add eax, edx
        add eax, r8d
        add eax, r9d
        
        ;vuelvo a poner el contador (16-4)
        mov rcx, len
        shr rcx, 2
        sub rcx, 4

        add rbp, 16
    .cycle:
        add eax, [rbp] ; como mis enteros dos de 4 bytes, sumo de a 4
        add rbp, 4
        loop .cycle
    
        pop rbp
        mov rsp, rbp
        _final:  ;tenia un segmentation faul pq puse las ultimas dos lineas para llamar al sistema
        mov eax, 1 ;sys_exit
        int 0x80   ;llama a syscall
