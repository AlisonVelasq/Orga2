
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
	;tengo vectores de words(16 bits)
	movdqu xmm1, [rdi] ; XMM1 = [ a7 | a6 | a5 | a4 | a3 | a2 | a1 | a0 ]
	;pmulLw, multiplica y deja los 16 bits mas significativos de la multiplicacion (que recordemos q el resultado puede ser de 32)
	pmullw xmm1, [rsi] ;      = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ]
	;tengo 8 elem de 16 bytes, de la parte baja
	;hago lo mismo para la parte alta
	movdqu xmm2, [rdi] ; XMM2 = [ a7 | a6 | a5 | a4 | a3 | a2 | a1 | a0 ]
	pmulhw xmm2, [rsi] ;      = [ a7*b7(16:31) | a6*b6(16:31) | ... | a0*b0(16:31) ]

	movdqu xmm3, xmm1    ; XMM3 = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ] ;copi xmm1
	;con la siguiente instrucion juntos la mitades bajas xmm1 y xmm2
	;y tengo 4 elem de 32 bytes (4bytes) =>16bytes
	punpcklwd xmm3, xmm2 ;      = [ a3*b3 | a2*b2 | a1*b1 | a0*b0 ]

	movdqu xmm4, xmm1    ; XMM4 = [ a7*b7(0:15) | a6*b6(0:15) | ... | a0*b0(0:15) ]
	;lo mismo con las mitades altas
	punpckhwd xmm4, xmm2 ;      = [ a7*b7 | a6*b6 | a5*b5 | a4*b4 ]

	;ya tengo los 8 registros juntos con sus partes bajas y altas en 2 registros
	;primero sumo de a 4 bytes con lo que tenia antes de xmm0  y xmm3 (suma normal, elem a elem del dest y src)
	paddd xmm0, xmm3     ; Acumulamos sumas parciales
	;por ultimo sumo todo con xmm4 elem a elem de a 4 bytes (paddD)
	paddd xmm0, xmm4     ; idem

	sub dx, 8
	lea rdi, [rdi + 8 * INT16_SIZE]
	lea rsi, [rsi + 8 * INT16_SIZE]

	cmp dx, 0
	jnz .ciclo

	; Resultado
	;me queda la sumas parciales en xmm0, solo me falta sumar esos 4 elem y listo, tengo la sumatoria total
	phaddd xmm0, xmm0 	;suma horizontal ( me queda repetido la mitad, pero lo ignoro)
	phaddd xmm0, xmm0   ;suma horizontal, tamb me uqeda repetido pero no importa solo me importa los 4 bytes mas significativos

	movd eax, xmm0 ;devuelvo eso

	; Stack Frame (Limpieza)
	pop rbp

	ret
