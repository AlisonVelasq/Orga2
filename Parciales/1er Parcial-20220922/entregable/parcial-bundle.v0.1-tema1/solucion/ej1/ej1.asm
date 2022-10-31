global agrupar


;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;char** agrupar_c(msg_t* msgArr, size_t msgArr_len)
;es rdi esta msgArr, es rsi msgArr_len

agrupar:

    push rbp
    mov rbp, rsp
    //reservo lugar en la pila para guardar el vector de cant de char a reservar por categoria
    sub rbp, 4 ;por los 4 lugares tags en donde voy a guardar la cant de chars a reservar


    mov r13, rdi
    mov r14, rsi

    //resevo con malloc la salida en r12
    mov rdi, MAX_TAGS*8
    call malloc
    mov r12, rax

    mov [rbp+16], 0 //en rbp+16 esta el primer elem que guarde
    mov [rbp+24], 0
    mov [rbp+32], 0
    mov [rbp+40], 0

    mov r13, rbx
    mov rcx, r14
    .cycle:
        cmp [r13+16], 0
        je .tagcero
        cmp [r13+16], 1
        je .taguno
        cmp [r13+16], 2
        je .tagdos
        cmp [r13+16], 3
        je .tagtres

        loop .cycle
    jmp .reservar 

    .tagcero:
        mov r15, [r13+8] //guardo text_len
        add [rbp+16], r15
        add r13, 24 //paso a la siguiente struct
        jmp .cycle

    .taguno:
        mov r15, [r13+8] //guardo text_len
        add [rbp+24], r15
        add r13, 24
        jmp .cycle 

    .tagdos:
        mov r15, [r13+8] //guardo text_len
        add [rbp+32], r15
        add r13, 24
        jmp .cycle

    .tagtres:
        mov r15, [r13+8] //guardo text_len
        add [rbp+40], r15
        add r13, 24
        jmp .cycle

    .reservar:
        mov rdi, [rbp+16]
        call malloc//en rax esta la dire de memoria donde reserve lugar
        mov [r12], rax //guardo en el puntero que indica r12, la dire rax

        mov rdi, [rbp+24]
        call malloc
        mov [r12+8], rax

        mov rdi, [rbp+32]
        call malloc
        mov [r12+16], rax

        mov rdi, [rbp+40]
        call malloc
        mov [r12+24], rax

    xor r15, r15 //aca guardo el indice
    mov rbx, r13
    mov rcx, r14
    .ciclo:
        cmp [rbx+16], 0
        je .concatenoCero
        cmp [rbx+16], 1
        je .concatenoUno
        cmp [rbx+16], 2
        je .concatenoDos
        cmp [rbx+16], 3
        je .concatenoTres
        loop .ciclo

    .concatenoCero:
        mov rdi, [r12]
        mov rsi, rbx


    .concatenoUno:
        mov rdi, [r12+8]
        mov rsi, rbx






    .concatenar:

        mov byte dil,  


    add rbp, 4

    pop rbp
