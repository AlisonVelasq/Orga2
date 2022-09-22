;a) void MultiplicarVectores(short *A, short *B, int *Res, int dimension);
;en rdi esta A, rsi B, rdx res, rcx dim

section .text 
    global MultiplicarVectores
;PRIMERO LAS PARTES BAJAS, LUEGO LAS ALTAS
    MultiplicarVectores:
        push rbp 
        mov rbp, rsp 

        ;tengo que multiplicar de a dos bytes
        
            ; tengo 8 enteros de 2 bytes
            ;ie que tengo 16 bytes a copiar si quiero guardar los 8 enteros de una
            ;tengo que usar todo xmm0
            movdqu xmm0, [rdi] ;agarro de a 8 bytes
            movdqu xmm1, [rsi]

            add rdi, 8
            add rsi, 8

            ;res es un vector de int, es decir de a 4 bytes
            ;quiero mult de a 2 bytes y guardarlos en 4 bytes
            movq xmm2, xmm0 ; nesecito un registro mas para poder mult desp

            pmulhw xmm2, xmm1 ; mult parte baja de a 2 bytes
            pmullw xmm0, xmm1 ;para alta de la mult
            ;tengo ir intercalando las partes bajas con las altas
            ;como tengo 2 bytes uso punpckhwd

            movdqu xmm3, xmm0

            punpcklwd xmm3, xmm2
            movdqu [rdx], xmm3
            
            add rdx, 16 ; ya guarde 16 bytes
            
            punpckhwd xmm0, xmm2
            movdqu [rdx], xmm0
            
            ; movq xmm0, [rdi] ;agarro de a 8 bytes
            ; movq xmm1, [rsi]

            ; movq xmm2, xmm0 ; nesecito un registro mas para poder mult desp

            ; pmullw xmm2, xmm1 ; mult parte baja de a 2 bytes
            ; pmulhw xmm0, xmm1 ;para alta de la mult
            ; ;tengo ir intercalando las partes bajas con las altas
            ; ;como tengo 2 bytes uso punpckhwd

            ; punpckhwd xmm2, xmm0
            ; movdqu [rdx], xmm2

        pop rbp
        ret