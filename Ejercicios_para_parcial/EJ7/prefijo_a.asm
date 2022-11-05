
section .text
    global prefijo
    global quitar_prefijo
    extern malloc
;int prefijo_c(char* s1, char* s2
;rdi:s1, rsi:s2
    prefijo:
        push rbp 
        mov rbp, rsp
        

        ;en rdi -> char* s1, y en rsi -> char*rsi
        xor r8, r8 ; lo voy a usar como contador del prefijo

        ;no puedo acceder a la parte baje de rdi por que es una direccion de memoria
        ;normalmente en rdi se guardan direccion de memoria
        
        .cycle:
            mov cl, [rdi] ;rcx -> cl
            mov dl, [rsi] ;rdx -> dl
            cmp cl, dl
            je .iguales
            jmp .fin
        
        .iguales:
            add r8d, 1
            add rdi, 1
            add rsi, 1
            jmp .cycle
        
        .fin
            mov eax, r8d
            pop rbp 
        ret

;char* quitar_prefijo_c(char* s1, char* s2)
;rd1:s1, rsi:s2
    quitar_prefijo:
        push rbp 
        push rbx
        push r12
        push r13
        push r14
        push r15
        sub rsp, 1

        mov rbp, rsp

        mov r12, rdi
        mov r13, rsi 
        
        ;los registros ya estan en rdi y rsi asi que llamo directamente
        call prefijo
        mov r14, rax

        ;primer for para reservar lugar con malloc
        mov r15, r13 ;creo un temp
        mov rcx, r14
        .ciclo:
            inc r15
            loop .ciclo
        xor rbx, rbx
        mov bx, word 0 ;aca voy a reservar el tam a reservar
        .contador:
            inc bx
            inc r15
            cmp [r15], byte 0
            jne .contador 

        inc bx ; incrmento para el char nulo
        xor rdi, rdi
        mov di, bx
        call malloc ;ya no me sirve r12
        mov r12, rax ;guardo el puntero a la salida

        sub rbx, 1 ;resto 1 por que le agregue antes 1 por el nulo 
        mov r15, r12 ; por que voya inc r15 y no puedo perder la dire
        mov r9, 0 ; contador iesimo
        add r13, r14 ; le añado el offset del prefijo
        .for: 
            mov r8b, [r13 + r9]
            mov [r15], r8b  
            inc r9
            inc r15
            cmp r9, rbx
            jne .for 

        mov rax, r12
        .fin:
        add rsp, 1
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp 
        ret 

