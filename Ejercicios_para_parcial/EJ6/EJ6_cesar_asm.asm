extern malloc

global codificacion_cesar

section .data
    vec: db 1, 1, 1, 1, 1, 1


;el puntero al string esta en rdi, n en rsi y tam en rdx
section .text
codificacion_cesar:
    push rbp
    mov rbp, rsp

    ;voy a reservar lugar y guardar ahi el strgin modificado
    mov r8, rdi

    mov rdi, tam
    call malloc
    mov r9, rax

    mov ecx, tam
    .cycle: ;rdx --> dl en 1 byte
        mov dl, [r9]
        add rdx, rsi
        mov [r8], dl
        
        add r9, 1
        add r8, 1
        loop .cycle


    pop rbp 
ret 
