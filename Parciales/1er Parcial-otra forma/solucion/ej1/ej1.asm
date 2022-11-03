global agrupar
extern malloc


;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text
%define MAX_TAGS 4
%define off_text 0
%define off_len 8
%define off_tag 16

;char** agrupar_c(msg_t* msgArr, size_t msgArr_len)
; rdi:arr , rsi:len
agrupar:

    push rbp
    mov rbp, rsp

    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 5 ;reservo lugar para guardar la cant de chars x tag

    mov rbx, rdi
    mov r15, rsi

    mov rdi, MAX_TAGS*8
    call malloc
    mov r12, rax

    ;pongo en cero los contadores de chars
    ;lo hago de esta forma para limpiar todo el registro de la pila y solo tener ceros
    mov qword [rbp + 16], qword 0
    mov qword [rbp + 24], qword 0
    mov qword [rbp + 32], qword 0
    mov qword [rbp + 40], qword 0

    ;ciclo para saber cuanto lugar tengo que reservar

    mov r13, 0 ;contador del max TAGS
    
    .cycler:
        ;recorro el vector msgArr
        mov ecx, r15d
        ;limpiar r9 par volver a recorrer
        xor r9, r9
        ;mov r9, [rbx];no por que esto accede al char*
        mov r9, rbx ; quiero acceder al tag con el off_tag
        ;para cada tag recorre todo el vector msgArr
        .recorriendo:
            ;el if que compara con r13 (i)
            xor rdx, rdx
            mov edx, dword [r9+off_tag] ;obtengo el tag del msg_t
            cmp edx, r13d
            je .mismoTAG

            .volver:
            add r9, 24 ;entro a la msg_t iesima, LA STRUCT MIDE 24

            ;OJO CON EL LOOP
            loop .recorriendo ;si aun no termine de recorrer

        inc r13
        cmp r13, MAX_TAGS ;si termine de recorre la cant max de tags
        jne .cycler

        mov r14, r12
        mov [rbp+48], byte 0
        jmp .reservar

    .mismoTAG:
        mov r8, [r9 + off_len]
        add [rbp + 16 + 8*r13], r8 ;r13 va de 0 a 3
        mov rdi, [rbp+16+8*r13]
        jmp .volver

    
    .reservar: ;reservo los lugares que esta en la pila en el vector final
        xor r13, r13
        ; mov rdi, qword [rbp+16]
        ; mov rsi, qword [rbp+24]
        ; mov rcx, qword [rbp+32]
        ; mov r13, qword [rbp+40]
        ;rever el byte nulo que tiene al final los strings
        inc qword [rbp+16]
        inc qword [rbp+24]
        inc qword [rbp+32]
        inc qword [rbp+40]

        xor rsi, rsi
        mov rsi, qword [rbp+48]
        mov r13, qword [rbp + 16 + 8*rsi] ; accedo a la cant a reservar
        ;debo evaluar si es cero, ya que si lo es NO RESERVO
        ;cmp r13, 0
        ;je .nada 

        mov rdi, r13
        call malloc
        mov [r14], rax
        
        ;.sig
        add r14, 8 ;paso a la otra direccion del vector
        ;uso la pila para guardar el indice por que no tengo mas no temporales
        inc dword [rbp+48]
        mov rsi, [rbp+48]
        
        cmp rsi, MAX_TAGS
        jne .reservar 
;       jmp .sigFor:

;    .nada:
;        jmp .sig
    ;ahora el for que concateno
    
;    .sigFor:
    mov r13, 0 ;contador del max TAGS
    
    ;para cada tag recorre todo el vector msgArr
    .ciclo :
        xor r9, r9
        mov r9, rbx
        ;recorro el vector msgArr
        xor r14, r14
        mov r14, [r12 + 8*r13] ;accedo a memoria donde esta el lugar que reserva para el string
        mov ecx, r15d
        .recorrer:
            ;el if que compara con r13 (i)
            mov edx, [r9+off_tag] ;obtengo el tag del msg_t
            cmp edx, r13d
            je .concatenar ;si tengo el mismo tag concateno
            
            .sig
            add r9, 24 ;entro a la msg_t iesima, LA STRUCT MIDE 24

            ;OJO CON EL LOOP
            loop .recorrer ;si aun no termine de recorrer
            
        mov rsi, [r12+ 8*r13]
        inc r13
        cmp r13, MAX_TAGS ;si termine de recorre la cant max de tags
        jne .ciclo
        jmp .fin

    .concatenar: ;tengo que copiar el string r8 en el vector salida r14
        ;por alguna razon usar ecx en vez de rdi me elimina 8000 errores
        xor ecx, ecx 
        xor r8, r8
        mov r8, [r9] ;el text esta en el off cero
        ;edx ya no me imporata aca, lo puedo usar
        xor rdx, rdx
        .concatenando:
            mov cl, [r8]
            mov [r14], cl

            inc r8 ;incremento en un byte la direccion
            inc r14

            inc rdx
            cmp rdx, [r9+off_len] ;OJO
            jne .concatenando
            jmp .sig
    .fin:
        mov rax, r12

        ; mov rdi, [r12]
        ; mov rsi, [r12+8]
        ; mov rcx, [r12+16]
        ; mov r12, [r12+24]


        add rsp, 5
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
    
        pop rbp
    ret