;el mismo ejercicios pero esta vex guardarlos todo en la pila, con 32 bits

section .data
    vector: dd 1, 1, 1, 1, 1, 1, 1, 1, 1
    len equ $ - vector 

section .text 
    global _start
    global _final

_start: 
    push r12 
    ;mov rbp, rsp ;guardo el primer luga rd ela pila
    ;ya q el rsp va a ir incrementando junto con la pila

    mov edi, vector

    xor rcx, rcx
    mov rcx, len 
    shr rcx, 2
    
    .cycle:
        mov r9d, [edi]
        push r9
        add edi, 4
        loop .cycle
    
    xor rax, rax
    ;ahora sumo los elementos
    ;esta vez los voy a sumar con un indice del desplazamiento

    mov rcx, len 
    shr rcx, 2

    ;indice de la pila
    xor rsi, rsi
    ;mov rsi, 0 ;salto el rbp y rip
    xor rdx, rdx

    mov rbp, rsp
    
    .suma:
    ;mov r8, rbp + rsi ; no puedo hacer esto
        mov rdx, QWORD [rbp + rsi]
        add rax, rdx
        add rsi, 8
        loop .suma
    

    _final:
    mov eax, 1
    int 0x80