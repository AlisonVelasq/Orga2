section .data 
    entero: db 5 ; solo nesecito un byte para representar del 1 al 10

section .text
    global _llamadora
    global _invocada

_llamadora:
    mov rdi, entero; pongo el entero en rdi y llamo a invocada
    call _invocada
    



    _final:
    mov eax, 1
    int 0x80

_invocada:
    ;invocada recibe un entero en rdi, por convencion lo haremos asi
    ;y retorna el valor en rax y usamos call invocada desde llamadora
    ;ENTONCES asumimos que en rdi esta el entero que "pasamos por parametro"
    
    mov rdi, 1
    mov rax, rdi

    

