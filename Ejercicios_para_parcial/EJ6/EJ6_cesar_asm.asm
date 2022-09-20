extern malloc

global codificacion_cesar

section .data
    

;el puntero al string esta en rdi, n en rsi y tam en rdx
section .text
codificacion_cesar:
    push rbp
    mov rbp, rsp

    ;voy a reservar lugar y guardar ahi el strgin modificado
    mov r8, rdi

    mov rdi, rdx
    call malloc
    mov r9, rax

    mov ecx, edx
    .cycle: ;rdx --> dl en 1 byte
        mov dl, [r8]
        add rdx, rsi
        mov [r9], dl
        
        add r9, 1
        add r8, 1
        loop .cycle


    pop rbp 
ret 
