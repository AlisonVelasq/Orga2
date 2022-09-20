%DEFINE RANDOM 1

extern malloc

section .text 
    global cliente:
    ;en rdi tengo el puntero al vector cliente
    ;mi funcion me devuelve un puntero al cliente
    cliente:
        push rbp
        mov rbp, rsp
        push r12
        push rbx
        push r13
        push r13

        mov r12, rdi

        mov rdi, 64
        call malloc
        mov rbx, rax ;rbx: mi puntero a la mem reservada

        mov ecx, RANDOM 
        .cycle:
            add r12, 64
            loop .cycle
        

        ;copio el cliente el la memoria reservada en malloc, rbx
        ;copio r12 a rbx
        mov r13, [r12]
        mov [rbx], r13
        ;rbx esta apuntando al primer elem del struct?
        ;supongo que si
        add r12, 21;rbx + 21 va al sig elem del struct

        mov r13, [r12]
        mov [rbx], r13

        add r12, 27 ;21 + 6 padding

        mov r13, [r12] ;copio dni
        mov [rbx], r13

        add r12, 8

        mov r13, [r12] ;copio compra
        add [rbx], r13

        ;le voy a pasar un cliente cualquiera, pero lo eligo yo 

        mov rdi, 

        pop r13
        pop r13
        pop rbx
        pop r12

        pop rbp
        ret