global diagonal

%define SHORT_SIZE 2

section .text

diagonal:

    ; void diagonal(short* matriz, short n, short* vector)
    ; short* matriz -> RDI
    ; short n       -> SI
    ; short* vector -> RDX

    ; Stack Frame (Armado)
    push rbp
    mov rbp, rsp 

    ; Preparación
    and rsi, 0xFFFF ; extensión sin signo a 64 bits ('n' no va a ser negativo)

    ; Ciclo
    mov rcx, 0 ; índice de ciclo
    
    .ciclo:
        cmp rcx, rsi
        je .fin_ciclo

        mov r9w, [rdi]
        mov [rdx], r9w

        add rdx, SHORT_SIZE ; voy a la sig celda del vector y aca se ira guardar los valores de la diagonal
        ;consectual; quiero que rdi apunte al siguiente en la diagonal
        ;add rdi, rsi + SHORT_SIZE ; rsi es la dimension de la matriz ; no es valido por que tiene qu etener dos registros
        ;primero avanzamos e¿nm celdas(vamos a la sig fila) y luego una celda para estar en la diagonal (solo funciona si n = 3)
        lea rdi, [rdi + rsi * SHORT_SIZE + SHORT_SIZE] ;uso lea por el direccionamiento

        inc rcx
        jmp .ciclo

    .fin_ciclo:

    ; Stack Frame (Limpieza)
    pop rbp

    ret
