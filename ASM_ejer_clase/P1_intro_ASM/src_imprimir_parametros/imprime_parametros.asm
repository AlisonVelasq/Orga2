extern printf ; para poder hacer el call, lo que hace es deja vacio ese espacio, asi no me salta el error a copilarlo y lo definimos mas adelante (creo)
global imprime_parametros ;indica que voy a exportar imprime_parametros para usarlo externamente

section .data
;obs que prinf recibe 4 parametros y el primero es un string con los tipos de datos en c
formato_printf: db 'a: %d, f: %f, s: %s', 10, 0 ;es necesario definir la aridad del prinf
; 10 es el \n de c y 0 es el null
;lo que hace formato_printf es definime un vertor en ascii y apunta al primer elem de este
;ej 40|30|....|10|0

section .text
; void imprime_parametros(int a, double f, char* s);
; a -> rdi
; f -> xmm0
; s -> rsi
imprime_parametros:
	; Armo stackframe
	push rbp
	mov rbp, rsp

	; printf("a: %d, f: %f, s: %s\n", a, f, s);
	; Cuatro parámetros:
	; - "a: %d, f: %f, s: %s\n" = puntero -> rdi
	; - a = entero -> rsi
	; - f = double -> xmm0
	; - s = puntero -> rdx
	
	;antes de llamar al call prinf tengo que tener guardados sus 4 parametros, en los siguientes registros en orden:
	;usa exactamente el mismo orden que la convencion c, i.e lee los parametros para prinf en ese orden: rdi, rsi, rdx,..etc
	mov rdx, rsi
	mov rsi, rdi
	mov rdi, formato_printf
	; mov xmm0, xmm0
	mov rax, 1 ;mas adelante se aclara
	call printf ; para llamar a una funcion es muy importante que este alineada a 16 bytes

	; Fin
	pop rbp
	ret