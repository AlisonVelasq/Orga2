section .rodata
    ;para intercalar vamos a usar PSHUFB, vamos a reordenar a byte
    mask1: db 0x80, 0x0E, 0x80, 0x0C, 0x80, 0x0A, 0x80, 0x08, 0x80, 0x06, 0x80, 0x04, 0x80, 0x02, 0x80, 0x00;creo la mascara (de atras pa adelante)
    mask2: db 0x0F, 0x80, 0x0D, 0x80, 0x0B, 0x80, 0x09, 0x80, 0x07, 0x80, 0x05, 0x80, 0x03, 0x80, 0x01, 0x80

    mask3: db 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1, 0x0, 0x1
section .text
    global Intercalar

;void Intercalar(char *A, char *B, char *vectorResultado, int dimension)
    ;rdi:A rsi:B rdx:resul rcx:dim
    Intercalar:
        push rbp
        mov rbp, rsp 
        push r12
        push r13

        mov r12, rdx

        movq xmm1, [rdi] ;guardo 8 elem
        movq xmm2, [rsi]

        punpcklbw xmm1, xmm2

        add rdi, 8
        add rsi, 8
                
        ;pshufb xmm0, mask1 ; |..|x14|....|x1|..|x0|
        ;pshufb xmm1, mask2 ; no entiendo como intercalar con shuf

        ; movdqu xmm0, [mask3]
        ; pblendvb xmm1, xmm2, xmm0

        movdqu [r12], xmm1

        pop r13
        pop r12
        pop rbp 
        ret

    