extern malloc

global codificacion_cesar

section .data
    vec: db 1, 1, 1, 1, 1, 1
    len equ $ - vec 

section .text 
    global _start
    global _final

_start: 

    ;voy a reservar lugar y guardar ahi el strgin modificado
    mov r8, vec

    mov rdi, len
    call malloc
    mov r9, rax

    mov ecx, len
    .cycle: ;rdx --> dl en 1 byte
        mov dl, [r9]
        add dl, 3;sumo al vector 3
        mov [r8], dl
        
        add r9, 1
        add r8, 1
        loop .cycle


    _final:
    mov eax, 1
    int 0x80
