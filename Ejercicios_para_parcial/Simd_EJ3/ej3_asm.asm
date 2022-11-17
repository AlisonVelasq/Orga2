;a) void MultiplicarVectores(short *A, short *B, int *Res, int dimension);
;en rdi esta A, rsi B, rdx res, rcx dim

section .text 
    global MultiplicarVectores
    global ProductoInterno
    global SepararMaximosMinimos
    extern malloc
;PRIMERO LAS PARTES BAJAS, LUEGO LAS ALTAS
    MultiplicarVectores:
        push rbp 
        mov rbp, rsp 

        ;tengo que multiplicar de a dos bytes
        
        ;en rcx ya esta la dim de la matriz
        ;divido por 8 ya que agarro cada 8 elem, supongo que es multiplo de 8
        shr ecx, 3
        .cycle:
            ; tengo 8 enteros de 2 bytes
            ;ie que tengo 16 bytes a copiar si quiero guardar los 8 enteros de una
            ;tengo que usar todo xmm0
            movdqu xmm0, [rdi] ;agarro de a 16 bytes, ie los 8 elem
            movdqu xmm1, [rsi]

            ;res es un vector de int, es decir de a 4 bytes
            ;quiero mult de a 2 bytes y guardarlos en 4 bytes
            movdqu xmm2, xmm0 ; nesecito un registro mas para poder mult desp

            pmulhw xmm2, xmm1 ; mult parte baja de a 2 bytes
            pmullw xmm0, xmm1 ;para alta de la mult
            ;tengo ir intercalando las partes bajas con las altas
            ;como tengo 2 bytes uso punpckhwd

            movdqu xmm3, xmm0

            punpcklwd xmm3, xmm2 ;junto las mitades bajas
            ;ya tengo la multiplicacion guardada en 32 bits, ie tengo 4 elem de dword (4 bytes)
            movdqu [rdx], xmm3 ;guardo en la salida
            
            add rdx, 16 ; ya guarde 16 bytes
            
            punpckhwd xmm0, xmm2 ;junto las mitades altas
            movdqu [rdx], xmm0
            
            add rdx, 16
            ;voy a buscar los sig 8 elem
            add rdi, 16
            add rsi, 16
            
            loop .cycle

        pop rbp
        ret

    ProductoInterno:
    ;int ProductoInterno(short *A, short *B, int dimension)
    ;en rdi tengo A, en rsi tengo B, rdx tengo dim

        push rbp
        push r12
        push r13 
        push rbx
        push r14
        push r15
        sub rsp, 8
        mov rbp, rsp

        mov r12, rdi 
        mov r13, rsi
        mov r15, rdx

        ;uso la funcion de antes, para eso reservo con malloc

        mov rdi, r15 ;cant de elem
        shl rdi, 2 ; multiplico por 4 ya que la salida son int entonces ocupan 4 bytes
        call malloc
        mov rbx, rax

        mov rdi, r12
        mov rsi, r13
        mov rdx, rbx
        mov rcx, r15
        call MultiplicarVectores
        mov r14, rax
        ;limpio xmm1, donde voy a acumular la suma
        pxor xmm1, xmm1


        mov ecx, r15d
        shr ecx, 2 ;divido por 4, ya que agarro de a 4 elem

        ;ahora me falta hacer la suma, tengo:
        ;r14: |...|x3*y3|x2*y2|x1*y1|x0*y0| : 4 enteros de 4 bytes, entran en un xmm0

        .cycle:
            movdqu xmm0, [r14] ;agarro los primeros 4 elem
            ;como son enteros uso la suma horizontal para enteros PHADD..
            ;en este caso como tengo elem de 32 bits uso el DWORD
            phaddd xmm1, xmm0 ; xmm1: |x3*y3+x2*y2|x1*y1+x0*y0|.lo anterior.|.lo anterior.|
            
            add r14, 16
            loop .cycle
        ;por ultimo me falta sumar las 4 sumas parciales que tengo en xmm1
        ;xmm1: |suma1|suma2|suma3|suma4|
        phaddd xmm1, xmm1 ;|suma1+suma2|suma3+suma4|suma1+suma2|suma3+suma4|
        phaddd xmm1, xmm1 ;|suma1+suma2+suma3+suma4|..|...|..|
        ;ya tengo en todos los lugares la suma completa

        movd eax, xmm1; devuelvo un entero de 4 bytes

        add rsp, 8
        pop r15
        pop r14
        pop rbx
        pop r13
        pop r12
        pop rbp
        ret

    
    SepararMaximosMinimos:
    ;void SepararMaximosMinimos(char *A, char *B, int dimension)
    ;rdi: A, rsi: B, rdx:dim

        push rbp 
        push r12
        push r13
        push r14
        push r15
        mov rbp, rsp

        ;voy a usar PMAXUB dest src, que compara el max byte a byte y lo guarda en destino (sin signo par enteros)
        mov r12, rdi 
        mov r13, rsi
        mov r14, rdx 

    
        mov ecx, r14d
        shr ecx, 4 ;divido por 16
        .cycle:
            ;agarro de a 16 elem
            movdqu xmm0, [r12] ; xmm0: |y15|y14|....|y2|y1|y0|
            movdqu xmm1, [r13] ; xmm1 : |x15|x14|....|x2|x1|x0|

            movdqu xmm2, xmm0 ;
            pmaxub xmm2, xmm1 ; xmm2 : |max(y15,x15)|.....|max(y1,x1)|
            ;ahora tengo que guardar estos nuevos valores en A
        
            movdqu [r12], xmm2
            pminub xmm0, xmm1 ; xmm2 : |min(y15,x15)|.....|min(y1,x1)|

            movdqu [r13], xmm0

            add r12, 16
            add r13, 16

            ;add r9, 16
            ;cmp r14, r9
            ;jne .cycle
            loop .cycle


        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp
        ret
