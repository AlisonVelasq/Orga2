;a)escribir un prog que lea los enteros desde memoria y guardarlos en registros distintos antes de guardarlos
;%define num(x) ( 16 +x)

%DEFINE OFFSET
section .data
    vector: dd 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3
    len equ $ - vector ; 4*16 = 64-> 100000
    ;cada enteros tiene 4 bytes (64 bits)

section .text
    global _start
    global _final

_start:
        ;armo el stack frame por que no me alcanzan los registros
        ;push rbp
        ;mov rbp, rsp 
        ;no anda este push
        push r12 ;pusheo el registro no volatil que voy a usar
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
        ;mov r9d, [edi+12]
        
        ;ARREGLAR LO DE ABAJO

        ;contador del loop
        mov rcx, len ; tam del vect (4(bytes)*16(enteros))
        shr rcx, 2 ; DIV en 4
        sub rcx, 3 ; le resto la cant de registros que ya guarde

        ;tengo que reservar lugar en la pila para ir almacenando los enteron? ;add rsp, 64; 48 = 4(bytes)*12(enteros), quiero guardas 12 enteros de 4 bytes cada uno
        add edi, 12
    .rep: ;en la pila guarde de a 4 bytes ;primero paso a un registro de 32 y luego pusheo ;push dword [esi] ; tengo que especificar cuanto estoy pusheando ;MAL: no puedo pushear cosas de 32 bits
        mov r9d, [edi]
        push r9 ;leo el registro en 32 (la parte baja(r9d)) y pusheo en 64bits (r9)
        add edi, 4
        loop .rep
        ;OTRA OPCION: pushear algo de 32 paddeado a 64, NO el rbp queda en cualquier lado
        ;AL PARECER SOLO PÚEDO PUSHEAR COSAS DE 64 BITS

        xor rax, rax ; limpio
        ;sumo los registros
        add eax, esi ; ambos deben ser de 32 bits, sino no anda(i.e ambos con e)
        add eax, edx
        add eax, r8d
        ;add eax, r9d
        
        ;vuelvo a poner elS contador (16-3)
        mov rcx, len ; tam del vect (4(bytes)*16(enteros))
        shr rcx, 2 ; DIV en 4
        sub rcx, 3
;(**)
; para acceder a los elemtos de la pila no puedo modificar el rsp, que es el iterador de la pila
; entonces para hacerlo en un loop tengo que depender de un offset o con un registro no volatil y popeando

        
    .suma: ;en la pila guarde de a 4 bytes ;primero paso a un registro de 32 y luego pusheo ;push dword [esi] ; tengo que especificar cuanto estoy pusheando ;MAL: no puedo pushear cosas de 32 bits
        ;pop r12, si solo hago esto, estoy popeando el rsp, por lo que pongo un +16 (rso y rip)
        pop r12
        add eax, r12d
        loop .suma

        ;RBP NO SE MODIFICAAAA

    
        _final:  ;tenia un segmentation faul pq puse las ultimas dos lineas para llamar al sistema
        mov eax, 1 ;sys_exit
        int 0x80   ;llama a syscall
