
section .text
    global prefijo

    prefijo:
        push rbp 
        mov rbp, rsp
        

        ;en rdi -> char* s1, y en rsi -> char*rsi
        xor r8, r8 ; lo voy a usar como contador del prefijo

        ;no puedo acceder a la parte baje de rdi por que es una direccion de memoria
        ;normalmente en rdi se guardan direccion de memoria
        
        .cycle:
            mov cl, [rdi] ;rcx -> cl
            mov dl, [rsi] ;rdx -> dl
            cmp cl, dl
            je .iguales
            jmp .fin
        
        .iguales:
            add r8d, 1
            add rdi, 1
            add rsi, 1
            jmp .cycle
        
        .fin
            mov eax, r8d
            pop rbp 
            
        ret

