
;node_t* agregarAdelante_asm(int32_t valor, node_t* siguiente);
;en edi esta el entero y en rsi el puntero
extern malloc
section .text
    global agregarAdelante_asm

    agregarAdelante_asm:
        push rbp 
        mov rbp, rsp
        push r12
        push rbx

        ;tengo que crear un nuevo nodo y agregarlo adelante

        mov r12d, edi; en edi esta el valor, 
        xor edi, edi;inecesario
        mov rdi, 16
        ;rdi la cant d ebute qu equiero reservar

        ;CUANDO LLAMO AL MALLOC ME BORRA EL RSI
        mov rbx, rsi

        call malloc
        ;mov rbx, rax
        
        

        mov [rax], rbx ;primero guardo el puntero al siguiente nodo que tiene 8 bytes
        mov dword [rax + 8], r12d ; guardo el nuevo valor, que tiene 4 bytes
        ;primero tengo que guardar el valor(4 bytes) y luego el padding (4 bytes)
        ;no tengo que hacer el paddiing por que ya reserve 16 bytes

        ;mov rsi, rax ; me faltaba "linkear" NO, solo si la funcion es de tipo void sirve
        
        pop rbx
        pop r12
        pop rbp 
        ret 

