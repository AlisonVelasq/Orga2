;a) void SumarVectores(char *A, char *B, char *Resultado, int dimension)
;en rdi:a, rsi:b, rdx: suma rcx:dim
section .text
    global sumarVectores

    sumarVectores:
    push rbp 
    mov rbp, rsp
    ;en mi rdi tengo dim bytes
    rdi tiene 8 bytes -> 64 bits qword
    
    
    en rcx ya esta la dim
    tengo de precondicion que sean multiplo de 8
    shr rcx, 3 

    .cycle:
        movq xmm0, [rdi] ; copio los 8 bytes del string
        movq xmm1, [rsi]
        ;[rdi] puede agarrar 16 bytes, porque estoy usando los registros xmm0

        add rdi, 8
        add rsi, 8

        paddb xmm0, xmm1
        movq [rdx], xmm0
        add rdx, 8
        loop .cycle
    
    
    pop rbp 
    ret

    ;con 16 bytes
    ; shr rcx, 4

    ; .cycle:
    ;     movdqu xmm0, [rdi] ; copio los 8 bytes del string
    ;     movdqu xmm1, [rsi]
    ;     ;[rdi] puede agarrar 16 bytes, porque estoy usando los registros xmm0
    ;     ;otra cosa, max y min
    ;     movdqu xmm2, xmm0 ;
    ;     pmaxub xmm2, xmm1
        
    ;     movdqu [rdi], xmm2
    ;     ;fin
    ;     paddb xmm0, xmm1
    ;     movdqu [rdx], xmm0
        
    ;     add rdi, 16
    ;     add rsi, 16

    ;     add rdx, 16
    ;     loop .cycle
    
    ; ;quiero sumar byte a byte
    ;     ;movdqu [rdx], xmm0
    ;     mov rax, 0
