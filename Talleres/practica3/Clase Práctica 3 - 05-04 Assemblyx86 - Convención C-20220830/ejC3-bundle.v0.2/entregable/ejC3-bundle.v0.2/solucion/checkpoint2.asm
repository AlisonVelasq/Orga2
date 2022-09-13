extern sumar_c
extern restar_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_simplified
global alternate_sum_8
global product_2_f
global alternate_sum_4_using_c

;########### DEFINICION DE FUNCIONES

; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]
alternate_sum_4:
	;prologo
	; COMPLETAR
	push rbp
	mov rbp, rsp

	;recordar que si la pila estaba alineada a 16 al hacer la llamada
	;con el push de RIP como efecto del CALL queda alineada a 8
	sub rdi, rsi
	add rdi, rdx
	sub rdi, rci
	mov rax, rdi

	;epilogo
	; COMPLETAR 
	pop rbp
	ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[rdi], x2[rsi], x3[rdx], x4[rcx]
alternate_sum_4_using_c: 

	;prologo
    push rbp ; alineado a 16
    mov rbp,rsp

	CALL restar_c
	mov rdi,rax
	mov rsi, rdx
	CALL sumar_c
	mov rdi,rax
	mov rsi, rcx
	CALL restar_c

	;epilogo
	pop rbp
    ret 



; uint32_t alternate_sum_4_simplified(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; registros: x1[?], x2[?], x3[?], x4[?]

alternate_sum_4_simplified:
	sub rdi, rsi
	add rdi, rdx
	sub rdi, rcx
	mov rax, rdi
	ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);	
; registros y pila: x1[?], x2[?], x3[?], x4[?], x5[?], x6[?], x7[?], x8[?]
alternate_sum_8:
	;prologo
	push rbp ; alineado a 16
    mov rbp,rsp

	; COMPLETAR
	sub edi, esi
	add edi, edx
	sub edi, ecx
	add edi, r8d
	sub edi, r9d
	add rdi, [rbp - 16 - 4]
	sub rdi, [rbp - 16 - 8] ; está mal este y el de arriba
	mov eax, edi

	;epilogo
	pop rbp
	ret
	

; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[?], x1[?], f1[?]
product_2_f:

	ret

