section .rodata

	MULT_RAIZ: DQ 0.7, 0.3		; MULT_RAIZ 0.3 | 0.7 ;vector de quadword (cada elem tiene 8 bytes)
	MULT_255:  DQ 255.0, 255.0 ;lo guardo dos veces por que voy a trabajar con dos elem por registr

section .text

	GLOBAL cuentaADouble

  	cuentaADouble: 
	  ; rdi = vector a floats
	  ; esi = n;                 
		push rbp                               
		mov rbp,rsp

		mov ecx, esi
		shr ecx, 2	;divido por 4, por que voy a poner guardar hasta 4 elem en un xmm0, por que tengo elem float(4bytes)

		movdqu xmm8, [MULT_RAIZ] ;guardo os 16 bytes
		movdqu xmm9, [MULT_255]

		.ciclo:
			; (double) sqrt(a[i*2] * 0.7 + a[i*2 + 1]*0.3)*255
			;primero multiplico por 7 luego por 3, (vea como lo veo, en el orden normal o como esta en memoria (lo comentado))
			movdqu xmm0, [rdi]  	 ; xmm0 = | fp3 | fp2 | fp1 | fp0 |
			cvtps2pd xmm1, xmm0		 ; xmm1 = |    fp1    |    fp0    |

			;shifteo a izq para que me queden los valores que necesito en la parte baja
			psrldq xmm0, 8			 ; xmm0 = | 0   |   0 | fp3 | fp2 |
			;convierto a double (8 bytes), y ahora splo entran dos elem en le registro
			cvtps2pd xmm2, xmm0		 ; xmm2 = |    fp3    |    fp2    |

			;multiplicacion de a 8 bytes, de punto flotante
			mulpd xmm1, xmm8		 ; xmm1 = |    0.3*fp1    |    0.7*fp0    |
			mulpd xmm2, xmm8		 ; xmm2 = |    0.3*fp3    |    0.7*fp2    |

			;ya tengo multiplicado los 4 primero elemtos por sus respectivo num

			movdqu xmm3, xmm1		 ; xmm1 = |    0.3*fp1    |    0.7*fp0    |

			;quiero que me queden los multiplicando por 0.7 en un reregistro y los del 0.3 en otro asi puedo hacer el addpd
			;para eso uso el SHUFPD con el imm 00 (me agarra la parte baja (el primero elem f0) del dest y  la parte baja del src
			;(el primero del src) y los pone en un registro)
			;lo mismo con el 11, que me agarra las partes altad (los segundos) de ambos resgistros

			shufpd xmm3, xmm2, 00b	 ; xmm3 = |    0.7*fp2    |    0.7*fp0    |
			shufpd xmm1, xmm2, 11b	 ; xmm1 = |    0.3*fp3    |    0.3*fp1    |

			;ahora puedo sar addpd que me suma las partes bajas y las partes altas y los pome en un regitro
			;podria haber usado una suma horizontal HADDPD
			addpd xmm3, xmm1		 ; xmm3 = |   0.3*fp3 + 0.7*fp2    |   0.3*fp1 +  0.7*fp0    |
			;uso el sqrt de double fp, para que agarre de a 8 bytes y les ponga raiz a cada uno
			sqrtpd xmm3, xmm3		 ; xmm3 = |   sqrt(0.3*fp3 + 0.7*fp2)    |   sqrt(0.3*fp1 +  0.7*fp0)    |
			;por ultimo multiplico 255
			;multiplico de a 8 bytes
			mulpd xmm3, xmm9		;; xmm3 = |255*sqrt(0.3*fp3 + 0.7*fp2)|255*sqrt(0.3*fp1 +  0.7*fp0)|

			movdqu [rdi], xmm3 ;lo guardo en el vector salida
			add rdi, 16 ; paso a los siguientes 4 registros
	
			loop .ciclo

		pop rbp
		ret 