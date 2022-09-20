
global strArrayNew
global strArrayGetSize
global strArrayAddLast
global strArraySwap
global strArrayDelete

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

; str_array_t* strArrayNew(uint8_t capacity)
; en rdi esta capacity
strArrayNew:
    push rbp
    mov rbp, rsp
    
    ;reservo memoria con malloc para crear mi instancia de struct
    ;y voy agregando
    

    pop rbp
    ret
; uint8_t  strArrayGetSize(str_array_t* a)
strArrayGetSize:


; void  strArrayAddLast(str_array_t* a, char* data)
strArrayAddLast:


; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
strArraySwap:


; void  strArrayDelete(str_array_t* a)
strArrayDelete:


