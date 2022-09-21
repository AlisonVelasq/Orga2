%DEFINE RANDOM 2

extern malloc

section .text 
    global azar:
    ;en rdi tengo el puntero al vector cliente
    ;mi funcion me devuelve un puntero al cliente
    azar:
        push rbp
        mov rbp, rsp
        push r12
        push rbx
        push r13
        sub rsp, 8

        xor r12, r12
        xor r13, r13
        xor rbx, rbx
        xor rax, rax

        mov r12, rdi

        mov rdi, 64
        call malloc
        mov rbx, rax ;rbx: mi puntero a la mem reservada

        ;indice del cliente que quiero acceder
        xor rcx, rcx
        mov ecx, RANDOM 
        .cycle:
            add r12, 64
            loop .cycle
        

        ;copio el cliente el la memoria reservada en malloc, rbx
        ;copio r12 a rbx
        
        ;copiar exactamente como esta en memoria el cliente
        
        mov ecx, 8
        .rep: ;voy copiando de a 8 bytes
            mov r13, [r12]
            mov [rbx], r13
            add r12, 8 
            add rbx, 8
            loop .rep


        ;rbx esta apuntando al primer elem del struct?
        ;supongo que si
        ;add r12, 21;rbx + 21 va al sig elem del struct

        ; mov r13, [r12]
        ; mov [rbx], r13

        ; add r12, 27 ;21 + 6 padding

        ; mov r13, [r12] ;copio dni
        ; mov [rbx], r13

        ; add r12, 8

        ; mov r13, [r12] ;copio compra
        ; add [rbx], r13

        ;le voy a pasar un cliente cualquiera, pero lo eligo yo 

        

        add rsp, 8
        pop r13
        pop rbx
        pop r12

        pop rbp
        ret