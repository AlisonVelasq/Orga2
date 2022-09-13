global suma_parametros

suma_parametros:
	; armo stackframe
	push rbp
	mov rbp, rsp

	mov eax, edi ; a0
	sub eax, esi ; a1
	add eax, edx ; a2
	sub eax, ecx ; a3
	add eax, r8d ; a4
	sub eax, r9d ; a5
	add eax, [rbp + 16] ; a6
	sub eax, [rbp + 24] ; a7
	;explicacion pila
	;rbp+8 =rip, rbp +16 =primer elem de la pila
	; fin
	pop rbp
	ret