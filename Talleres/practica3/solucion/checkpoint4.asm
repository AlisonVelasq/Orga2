extern malloc
extern free
extern fprintf

section .data
NULL db 'NULL'

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
	;prologo 
	push rbp
	mov rbp, rsp

.ciclo:
    mov dl, [rdi]
    mov cl, [rsi]
    cmp dl, 0
    je .aFin
    cmp cl, 0
    je .bFin
    mov cl, [rdi]
    mov dl, [rsi]
    add rdi, 1
    add rsi, 1
    cmp cl, dl
    je .ciclo

;.noEq:
    cmp dl, cl
    jl .aMayor
    jmp .aMenor
.aFin:
    cmp cl, 0
	je .iguales
    jmp .aMenor
.bFin:
    cmp dl, 0
	je .iguales
    jmp .aMayor

.aMenor:
    mov rax, 1
    jmp .epilogo
.aMayor:
    mov rax, -1
    jmp .epilogo                             
.iguales:
    mov rax, 0
.epilogo:
    pop rbp
	ret

; char* strClone(char* a) en rdi esta el puntero al string
strClone:
    ;prologo 
	push rbp
	mov rbp, rsp
    push r12
    sub rsp, 8
    mov r12, rdi

    call strLen
    add rax, 1
    mov rdi, rax
    call malloc ;reservo memoria para el string

    mov r8, rax ;el puntero a la memoria reservada CREO:(no tiene uqe ve rcon la pila, solo reserva en memoria prin)

    mov rdi, r12 ;puntero

.clonar:
    mov cl, [rdi] 
    mov [r8], cl
    cmp cl, 0
    je .fin
    add rdi, 1
    add r8, 1
    jmp .clonar

.fin:
    ;epilogo
    add rsp, 8
    pop r12
    pop rbp
	ret

; void strDelete(char* a)
strDelete:
    ;prologo 
	push rbp
    mov rbp, rsp

    call free

    ;epilogo
    pop rbp
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    mov r12, rsi
    mov r13, rdi
    ;qué pasa si es nulo?
    mov cl, [rdi]
    cmp cl, 0
    je .nulo

    call strLen
    mov rdx, rax
    mov rsi, r13
    mov rdi, r12

    call fprintf ;fprintf(rdi[direccion a file],rsi[direccion a string],rdx[largo string])
    
    jmp .epilogo

    .nulo:
    mov rdx, 5
    mov rdi, rsi
    mov rsi, NULL
    call fprintf

.epilogo:
    pop r13
    pop r12
    pop rbp
	ret


; uint32_t strLen(char* a)
strLen:
    push rbp
    mov rbp, rsp

    xor rax, rax
    mov cl, [rdi]
.count:
    cmp cl, byte 0
    je .epilogo
    add rdi, 1
    add rax, 1
    mov cl, [rdi]
    jmp .count

.epilogo:
    pop rbp
    ret


