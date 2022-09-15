;creo un vector en .data
section .data
    vector dd 1, 2, 3, 4, 5, 6 ;uso dd para guardar enteros de 32 bits
    ;la direccion del primer elem es el nombre del vector, en este caso vector guarda un puntero a 1

    mov rdi, vector ; asigno el puntero del vector a rdi
    mov cx, 6 ; tam del vect
    xor rax, rax ; limpio?
ciclo:
    add rax, [rdi+4] ; como mis enteros dos de 4 bytes, sumo de a 4
    add rdi, 4
    loop ciclo
