extern malloc
global strArrayNew
; global strArrayGetSize
; global strArrayAddLast
; global strArraySwap
; global strArrayDelete

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text
; str_array_t* strArrayNew(uint8_t capacity)
; en rdi esta capacity

;voy a crear un punteros a n string ya reservados con malloc
;no voy a tener strings per si el lugar para despues guardarlos

strArrayNew:
    push rbp
    mov rbp, rsp
    push r12
    push rbx
    ;reservo memoria con malloc para crear mi instancia de struct
    ;y voy agregando
    xor r12, r12
    xor rbx, rbx

    mov r12b, dil ;guardo mi capacity

    ;reservo memoria para el struct
    mov rdi, 16
    call malloc
    mov rbx, rax ; puntero al struct

    ;reservo memoria para el array de strings
    xor rdi, rdi
    shl r12, 3 ; multiplica por 8
    mov rdi, r12
    
    call malloc ; el puntero a los 4 bytes esta en rax
    ;por cada uno de esos bytes deberia reservar la cant de chars que va a tener cada uno de mis string?

    ;pongo los valores de la struct
    mov byte [rbx], 0 ;no tengo ningun elemto ocupado en el array
    shr r12, 3
    mov byte [rbx+1], r12b
    mov [rbx+8], rax ; el puntero a mi vector de strings

    mov rax, rbx

    pop rbx
    pop r12
    pop rbp
    ret
; uint8_t  strArrayGetSize(str_array_t* a)
; strArrayGetSize:


; ; void  strArrayAddLast(str_array_t* a, char* data)
; strArrayAddLast:


; ; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
; strArraySwap:


; ; void  strArrayDelete(str_array_t* a)
; strArrayDelete:


