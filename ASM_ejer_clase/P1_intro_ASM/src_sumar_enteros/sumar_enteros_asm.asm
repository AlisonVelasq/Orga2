section .text
global sumarenteros
sumarenteros:
;armamos el stackframe
	push rbp ;preservo el rbp de la funcion llamadora
	; es decir el rbp que tenemos al momento de entrar a la funcion sumar enteros
	mov rbp, rsp ;tenemos marcado donde empieza la pila de la funcion
	; edi: entero1
	; esi: entero2

	add edi, esi ;por que trabajo con 32 bit, ei los menos signif de rdi y rsi
	;addpd suma doubles
	mov eax, edi

	pop rbp ; restauro el rbp que habia preservado
	ret
