section .rodata

	MULT_RAIZ: DQ 0.7, 0.3		; MULT_RAIZ 0.3 | 0.7
	MULT_255:  DQ 255.0, 255.0

section .text

	GLOBAL cuentaADouble

  	cuentaADouble: 
	  ; rdi = vector a floats
	  ; esi = n;                 
		push rbp                               
		mov rbp,rsp

		mov ecx, esi
		shr ecx, 2		

		movdqu xmm8, [MULT_RAIZ]
		movdqu xmm9, [MULT_255]

		.ciclo:
			; (double) sqrt(a[i*2] * 0.7 + a[i*2 + 1]*0.3)*255
			movdqu xmm0, [rdi]  	 ; xmm0 = | fp3 | fp2 | fp1 | fp0 |
			cvtps2pd xmm1, xmm0		 ; xmm1 = |    fp1    |    fp0    |

			psrldq xmm0, 8			 ; xmm0 = | 0   |   0 | fp3 | fp2 |
			cvtps2pd xmm2, xmm0		 ; xmm2 = |    fp3    |    fp2    |

			mulpd xmm1, xmm8		 ; xmm1 = |    0.3*fp1    |    0.7*fp0    |
			mulpd xmm2, xmm8		 ; xmm2 = |    0.3*fp3    |    0.7*fp2    |

			movdqu xmm3, xmm1		 ; xmm1 = |    0.3*fp1    |    0.7*fp0    |

			shufpd xmm3, xmm2, 00b	 ; xmm3 = |    0.7*fp2    |    0.7*fp0    |
			shufpd xmm1, xmm2, 11b	 ; xmm1 = |    0.3*fp3    |    0.3*fp1    |
			
			addpd xmm3, xmm1		 ; xmm3 = |   0.3*fp3 + 0.7*fp2    |   0.3*fp1 +  0.7*fp0    |
			sqrtpd xmm3, xmm3		 ; xmm3 = |   sqrt(0.3*fp3 + 0.7*fp2)    |   sqrt(0.3*fp1 +  0.7*fp0)    |

			mulpd xmm3, xmm9		;; xmm3 = |255*sqrt(0.3*fp3 + 0.7*fp2)|255*sqrt(0.3*fp1 +  0.7*fp0)|

			movdqu [rdi], xmm3
			add rdi, 16
	
			loop .ciclo

		pop rbp
		ret 