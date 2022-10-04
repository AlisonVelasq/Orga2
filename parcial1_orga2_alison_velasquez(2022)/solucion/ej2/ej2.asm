extern malloc
global filtro

;########### SECCION DE DATOS
section .data
    imm: dw 00, 10
;########### SECCION DE TEXTO (PROGRAMA)
section .text
;Tengo un vector de enteros de 2 bytes
;entrada: |2b|2b|2b|......|2b|2b|
;quiero que la salida sea : |1/4(los primeros 8 bytes R)|1/4(los segundos 8bytes L)|...etc
;el tam del arreglo de salida deberia ser de rsi/4, ya que voy a ir agrupando de a 4 elem

;int16_t* filtro (const int16_t* entrada, unsigned size)
;tengo en rdi el puntero al vector de entrada y en rsi el tam del vector
filtro:
;debo ir alternandolos

    push rbp 
    mov rbp, rsp
    push r12
    push r13
    ;lo mas comodo seria separar el arreglo en otros dos para que poder sumar las R y las L por separado

    ;nesecito saber cuando elem R tengo
    mov r12, rsi
    shr r12, 1   ;divido por 2 el tamaño del vector 

    mov rdi, r12
    call malloc
    movq xmm0, rax 

    mov rdi, r12 
    call malloc
    movq xmm1, rax

    ;guardo de a 16 bytes
    xor r8, r8
    mov rcx, r12
    
    .cycle:
        pshuflw xmm3, qw [xmm0], imm ; me intecala y en la parte baja
        pshuflw xmm3, qw [xmm0+16*r8], imm  ;completo el resto en la parte alta
        ;asi que voy a avanzar de a 32 bytes
        add r8, 1
        ;no me sirve pshuflw por que solo me guardaria dos valores de los que quiero, nesecitaria 
        ;una instruccion que me tome todo el registro de 16 bytes y eligo intercalado entre esos y los guardo en la parte baja
        loop .cycle


    pop r13
    pop r12
    pop rbp 
    ret 


