
global dotProduct

%define INT16_SIZE 2

section .text

; Enunciado:
; Dados dos vectores de enteros de 16 bits,
; realizar el producto escalar entre ambos
; y almacenar el resultado en 32 bits.

dotProduct:

	; int32_t dotProduct
	; RDI -> int16_t *a
	; RSI -> int16_t *b
	; DX -> short n

	; Stack Frame (Armado)
	push rbp
	mov rbp, rsp

	; Ciclo Principal

	pxor xmm0, xmm0

.ciclo:

	movdqu xmm1, [rdi] ; XMM1 = [ a7 | a6 | a5 | a4 | a3 | a2 | a1 | a0 ]
	pmullw xmm1, [rsi] ;      = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ]

	movdqu xmm2, [rdi] ; XMM2 = [ a7 | a6 | a5 | a4 | a3 | a2 | a1 | a0 ]
	pmulhw xmm2, [rsi] ;      = [ a7*b7(16:31) | a6*b6(16:31) | ... | a0*b0(16:31) ]

	movdqu xmm3, xmm1    ; XMM3 = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ]
	punpcklwd xmm3, xmm2 ;      = [ a3*b3 | a2*b2 | a1*b1 | a0*b0 ]

	movdqu xmm4, xmm1    ; XMM4 = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ]
	punpckhwd xmm4, xmm2 ;      = [ a7*b7 | a6*b6 | a5*b5 | a4*b4 ]

	paddd xmm0, xmm3     ; Acumulamos sumas parciales
	paddd xmm0, xmm4     ; idem

	sub dx, 8
	lea rdi, [rdi + 8 * INT16_SIZE]
	lea rsi, [rsi + 8 * INT16_SIZE]

	cmp dx, 0
	jnz .ciclo

	; Resultado

	phaddd xmm0, xmm0
	phaddd xmm0, xmm0
	movd eax, xmm0

	; Stack Frame (Limpieza)
	pop rbp

	ret
