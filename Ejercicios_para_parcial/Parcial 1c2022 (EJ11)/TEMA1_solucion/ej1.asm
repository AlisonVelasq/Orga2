extern malloc

extern strClone
global strArrayNew
global strArrayGetSize
global strArrayAddLast
global strArraySwap
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
;el puntero al vector esta en rdi
strArrayGetSize:
    push rbp
    mov rbp, rsp
    
    xor rax, rax
    mov al, byte [rdi] ;simplemente devuelvo el size
    ;NO
    ;tengo que recorrer el vector hasta encontrar un elem vaacio
    ;mi contador va a estar en rbx
    ;mov r12, rdi
    ;.cycle: ;recorro de a 8 bytes, ya que tengo punteros a string
    ;    cmp [r12], 

    pop rbp 
    ret


; void  strArrayAddLast(str_array_t* a, char* data)
;en rdi esta el puntero al struct y en rsi el string
strArrayAddLast:
    push rbp 
    mov rbp, rsp
    push r12
    push rbx
    push r13
    push r14

    ;recorro el array size veces, hasta llegar al ultimo elem  agregado y 
    ;agrego el puntero al string, que voy a copiar previamente

    mov r12, rdi
    mov rbx, rsi

    mov rdi, rbx
    call strClone ; en rax tengo el puntero al string copiado

    ;ahora recorro el array
    ;nesecito el puntero al array
    xor r14, r14
    mov r14, [r12+8] ; aca esta el puntero al vector
    ;NO: mov r14, [r14] ;aca deberia estar el puntero al primer string
    ;de esta forma podria recorrerlo de a 8 bytes
    
    ;SI: al parecer no tengo que desreferenciar r14,
    ;sino que r14 ya me da el vector de dirreciones, si lo desrefencio obtengo ele string

    ;el syze
    xor r13, r13 
    mov r13b, byte [r12]
    ;podria usar strArrayGetSize

    mov rcx, r13
    .cycle:
        add r14, 8 ;recorro r13b strings    
        loop .cycle

    ;r14 ya deberia apuntar al lugar donde quiero agregar un string
    mov [r14], rax ; apunto a mi string clonado
    ;ADENTRO de r14 guardo el nuevo puntero
    add byte [r12], 1 ;le agrego 1 al size

    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp 
    ret

; void  strArraySwap(str_array_t* a, uint8_t i, uint8_t j)
;tengo en rdi a, rsi i, rdx j
strArraySwap:
    push rbp 
    mov rbp, rsp
    push r12
    push r13
    push r14
    push rbx
    push r15
    sub rsp, 8
    ;tengo que cambiar el string i con el j

    mov r12, rdi
    ;la idea es guardar en dos registros las direciones de los string y desp solo cambiarlas en el vect
    
    ;primero nesecito mi puntero al vector
    mov r14, [r12+8]
    mov r15, r14
    ;mov r16, r14
    ;busco el string i
    xor rcx, rcx
    ;interpreto que mi array empieza en i = 0, si no puedo restar 1 a i
    mov cl, sil
    .cycle:
        add r14, 8 ;sumo las direciones de memoria hasta llegar
        loop .cycle
    
    mov cl, dl 
    .cycle2:
        add r15, 8
        loop .cycle2
    
    mov rbx, qword [r14]
    mov r13, qword [r15]

    mov qword [r14], r13
    mov qword [r15], rbx



    add rsp, 8
    pop r15
    pop rbx
    pop r14
    pop r13
    pop r12
    pop rbp 
    ret

; ; void  strArrayDelete(str_array_t* a)
; strArrayDelete:


