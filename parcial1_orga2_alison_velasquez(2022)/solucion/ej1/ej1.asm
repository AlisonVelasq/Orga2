
%DEFINE max_etiq 4
%DEFINE off_text_len 8
%DEFINE off_tag 12

extern malloc
global agrupar
;char** agrupar(msg_t* msgArr, size_t msgArr_len);
;en rdi tengo el puntero a array, y en esi el tamaño del array(4 bytes)
;esi es el tam de mi array


;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

    agrupar:
        push rbp 
        mov rbp, rsp
        push r12
        push r13
        push r14
        push r15
        push rbx
        sub rsp, 8 ;alineo a 8

        ;preservo mis datos en registros no volatile spor que voy a llamar a malloc
        mov r12, rdi
        xor r13, r13
        mov r13d, esi 

        ;nesecito devolver en rax un array de string
        ;entonces reservo memoria

        mov rdi, max_etiq
        call malloc         ;la pila esta alineada

        mov rbx, rax        ;el rax ya tengo el puntero al comienzo del array, puedo modificar rbx

        ;tambien necesito reservar memoria para copiar todos mis string a un solo string "grande"
        ;se me ocurre guardar los punteros a la struct de estos string, ( i.e tendria guardados el mismo puntero a la struc mas desplazamiento
        ;dependiendo donde encuentre mis etiquetas) todos juntos dela mismas etiquetas
        ;guardaria primero los del tag 0 y imediatamente cuando tenga el ultimo del cero los concateno
        ;luego lo mismo con la sig etiqueta, se guardaria despues de que temrino la etiqueta 0
        ;por ej: |puntero del tag0|puntero2 del tag0|puntero3 del tag0|puntero1 del tag2|puntero2 del tag 2| etc
        ;y puedo usar que seguro tengo msgArr_len (ie r13) punteros a string distintos

        ;entonces reservo r13*8 bytes para guardar los punteros
        shl r13, 2 ;multiplico por 8
        mov rdi, r13
        call malloc
        mov r15, rax
        
        ;ahora debo recorrer el array e ir concatenando las etiquetas que sean iguales y guardarlas en rbx
        ;el tamaño de mi array ya lo tengo en r13d
        xor r9, r9
        xor rcx, rcx
        mov rcx, r13
        xor r14, r14        ;empiezo con el tag 0
        ;primer recorrido, busco tags 0
        ;tengo que iterar ( max_etiq (4)*msgArray_len (r13) ) veces
        .buscar:
            ;itera 4 veces
            ;caso  donde ya recorri todo el array buscando por ej 0
            cmp rcx, 0 ;cuando vuelva al .buscar y rcx sea cero, signfica que ya recorrio el array 
            ;es decir ya tengo todos los punteros de la etiqueta i guardados
            mov rdi, r15; mi puntero donde guarde los puntero a distintas partes de la struct
            mov rsi, r9 ; en r9 tengo un contador cada vez que agregp un puntero al tag deseado
            call concatenar ;en rax tengo mi primer string concatenado
            mov dword [rbx], rax ; lo copio en mi vector final
            mov r15, r8; donde se quedo mi vector de punteros a struct ;MMMMM
            xor r9, r9
            ;nota: NO usar r8 en concatenar

            xor rcx, rcx
            mov rcx, r13    ;el cycle itera msgArray_len(r13) vecesv

            jmp .cycle
            add r14, 1
            cmp r14, max_etiq ;itera para cada etiq
            jne .buscar 
            jmp .fin
        
        
        .cycle: ;r14 entra valiento la etiqueta que estoy buscando
            ;nesecito otro contador que recorra r13 veces
            ;busco los tags iesimo (r14)
            
            cmp dword [r12 + off_tag], r14d  ;si enconte el tag que estoy buscando
            je .sonIguales

            add r12, 16 ; paso ala siguiente struct
            loop .cycle
            jmp .buscar 

        .sonIguales:
            add r9, 1; mi contador de cantidad de strings
            mov r8, r15 ; 
            ;guardo el puntero a string en rax
            xor rdx, rdx
            mov rdx, r12 ;(no desreferencio r12) guardo en el volatil el puntero a la struct que tiene el string que quiero
            ;asi me ahorro guardar el largo del de los string
            mov dword [r8], rdx
            add r8, 8 ;agregue un puntero dw r13, [rdi] ; guardo el puntero a mi struct
            ;add r15, [r1

        .fin:    
        mov rax, [rbx]

        add rsp, 8
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp 
        ret

;en rdi tengo el puntero al vector de string
;en rsi tengo la cant de strings ocupado por esa etiqueta
concatenar:
    push rbp 
        mov rbp, rsp
        push r12
        push r13
        push r14
        push r15
        push rbx
        sub rsp, 8

        ;guardo en r15, cuantos chars tengo que reservar, para copiar el total de la concatenacion de strings
        mov rbx, rdi
        mov r14, rsi
        xor r15, r15 
        
        mov rcx, r14 ;cant de mi vector
        .cycle:
            mov r13, dword [rdi] ; guardo el puntero a mi struct
            add r15, [r13 + off_text_len] ; tomo el len del text que esta en el off 0
            loop .cycle 
        
        ;en r15 tendria que tener la cantidad de bytes a reservar para el string 
        add r15, 1 ; cuento el 0 para que el string temrmine
        mov rdi, r15
        call malloc
        mov r12, rax 

        ; clono los strings 

        mov rcx, r14 
        .cycle2:
            mov rdi, [rbx+8*rcx] ; tengo  la primer struct
            mov rdi, [rdi] ;guar el puntero al string off 0
            jmp .clonar

            loop .cycle2
            ;en rax ya esta el puntero al comiendo del string concatenado
            jmp .fin 

        .clonar:
            mov cl, [rdi] 
            mov [r8], cl
            cmp cl, 0
            je .cycle
            add rdi, 1
            add r8, 1
            jmp .clonar

        .fin:
        add rsp, 8
        pop rbx
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbp 
        ret

