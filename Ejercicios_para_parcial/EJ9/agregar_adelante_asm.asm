
;node_t* agregarAdelante_asm(int32_t valor, node_t* siguiente);
;en rdi esta el puntero y en rsi el entero
extern malloc
section .text
    global agregar_adelante_asm

    agregar_adelante_asm:
        push rbp 
        mov rbp, rsp
        push r12
        push rbx

        ;tengo que crear un nuevo nodo y agregarlo adelante
        mov r12, rdi
        call malloc
        mov rbx, rax 

        mov [rbx], r12 ;puntero al siguiente nodo
        add rbx, 8
        mov [rbx], rsi

        pop rbp 
        ret 