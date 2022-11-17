    
    extern malloc
    global filtro

;########### SECCION DE DATOS
section .data
    mask1: dw 0x00, 0x01, 0x04, 0x05, 0x08, 0x09, 0x0C, 0x0D, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF 
    mask2: dw 0x02, 0x03, 0x06, 0x07, 0x0A, 0x0B, 0x0E, 0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF 
    mask3: dd 0.25, 0.25, 0.25, 0.25

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;int16_t* filtro (const int16_t* entrada, unsigned size)
    filtro:
        push rbp 
        mov rbp, rsp 
        push r12
        push r13
        push r14
        push r15
        push rbx
        sub rsp, 8
        
        ;importante pasar todo a no volatiles
        mov r12, rdi
        mov r14, rsi
        sub r14, 3
        mov r15, r14
        ;rsi es N, es decir que multipli *2 (r y l) y *2 cant de bytes
        shl r15, 2 ;mult por 4

        ;reservo con malloc
        mov rdi, r15
        call malloc
        mov r13, rax
        mov rbx, rax ;para devolver el puntero
        

        movdqu xmm8, [mask1]     
        movdqu xmm9, [mask2] 
        movdqu xmm2, [mask3]    
        
        xor rdi, rdi 
        xor rsi, rsi
        
        mov rcx, r14 
        .ciclo:
            ;tomo de a 8 elem (4 de cada)
            movdqu xmm0, [r12] ; xmm0 = |l3|r3|l2|r2|l1|r1|l0|r0|
            ;en vez de separar asi: |l3|l2|l1|l0|r3|r2|r1|r0|, voy a separarlos en distintos registro 
            ;me conviene para considerar el overflow de la suma y poder extender tranqui
            pshufb xmm0, xmm8  ; xmm0 = |__|__|__|__|r3|r2|r1|r0|
            
            movdqu xmm1, [r12]
            pshufb xmm1, xmm9  ; xmm1 = |__|__|__|__|l3|l2|l1|l0|

            ;PARA EVITAR OVERFLOW EN LA SUMA, EXPANDO A 32 ANTES DE SUMAR
            pmovsxwd xmm0, xmm0 ;  xmm0 = |r3|r2|r1|r0| ; tengo 4 dword
            
            ;NO ANDO: shifteo xmm1 a derecha para quedarme con los l0..
            ;psrldq xmm1, 8 ;este shif logico me trae problema mepa, asi que uso mascaras

            pmovsxwd xmm1, xmm1 ;  xmm0 = |l3|l2|l1|l0| dwords
            ;sumo los 4 elem
            phaddw xmm0, xmm0  ; xmm0 = |r3+r2|r1+r0|r3+r2|r1+r0| 
            phaddw xmm0, xmm0  ; xmm0 = |..doble..|r3+r2+r1+r0|r3+r2+r1+r0| 
            phaddw xmm1, xmm1  ; xmm0 = |l3+l2|l1+l0|l3+l2|l1+l0|
            phaddw xmm1, xmm1  ; xmm0 = |..doble..|l3+l2+l1+l0|l3+l2+l1+l0| 

            ;primero expacdo de word a dword ṕor que necesito 4 byytes par convertirloa float
            ;expando con signo
            cvtdq2ps xmm0, xmm0 ; convierto de dword a float, tengo 4 sumas de tipo float
            cvtdq2ps xmm1, xmm1 

            mulps xmm0, xmm2 ; ya estan los primero dos elem multiplicado por 1/4
            mulps xmm1, xmm2
            ;   TRUNCADO
            cvttps2dq xmm0, xmm0 ;pase de float a dword
            cvttps2dq xmm1, xmm1 
            ;tengo guardo el resultado en 4 bytes, pero yo nesecito solo pasarle 2 bytes, estonces le paso la parte abbaja low
            ;primero lo guardo en un registro de 32 (4 bytes)
            movd edi, xmm0
            ;psrldq xmm0, 8 ;shiteo 8 para poder acceder a las l ya no es necesario
            movd esi, xmm1

            ;de esta forma puedo guardar words
            mov word [r13], di 
            mov word [r13+2], si
            ;movq [r13], xmm0 //MAL

            add r12, 2*2 ;mas dos elem de 2 bytes
            add r13, 2*2 ;mas dos elem de 2 bytes
            loop .ciclo

        mov rax, rbx
        ;si ni me aparecen los resultados del test, probablemente son errores de la pila
        ;o estoy entrado mal a lo que reserve por malloc
        add rsp, 8
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp
        ret


