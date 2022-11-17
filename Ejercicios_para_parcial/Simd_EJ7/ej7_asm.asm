global ejb
;el punto a ya etsba ahecho en clase, asi que lo voy a modificar para hacer el punto b
section .rodata
  transform5a4: db 0x00,0x01,0x02,0xFF,0x03,0x04,0x05,0xFF,0x06,0x07,0x08,0xFF,0x09,0x0A,0x0B,0xFF
  transform5a1: db 0x0C,0x0D,0x0E,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
  transformUlt: db 0x0D,0x0E,0x0F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
  ;en  memoria: 0xFF, 0xFF,....,0x0F, 0x0E, 0x0D
  multPI: dd 3.14, 3.14, 3.14, 3.14
section .text

 ejb: ; rdi = a
  push rbp
  mov rbp,rsp
  movdqu xmm8, [transform5a4]
  movdqu xmm9, [transform5a1]
  ;tengo 16 elemtos ahora
  movdqu xmm0, [rdi]         ; xmm0 = |_|xxx|xxx|xxx|xxx|xxx|
  movdqu xmm1, xmm0          ; xmm1 = |_|xxx|xxx|xxx|xxx|xxx|
  ;hago rdi+14 y no rdi+15 ya que voy a tomar desde el ultimo x que me quedo antes, 
  ;para que este quede como basura al comienzo
  ;era lo mismo hacerlo del otro lado ya que solo tengo que shiftear al otro lado
  movdqu xmm2, [rdi+10*3-16] ; xmm2 = |yyy|yyy|yyy|yyy|yyy|_|
  ;shifteo todo el dquadword en una posicion
  psrldq xmm2, 1             ; xmm2 = |_|yyy|yyy|yyy|yyy|yyy|
  movdqu xmm3, xmm2          ; xmm3 = |_|yyy|yyy|yyy|yyy|yyy|
  
  movdqu xmm4, [rdi+15+14]   ; xmm4 = |zzz|zzz|zzz|zzz|zzz|_|

  psrldq xmm4, 1             ; xmm4 = |_|zzz|zzz|zzz|zzz|zzz|
  movdqu xmm5, xmm4 ;copio para despues guardar aqui el elem 5 que me sobra
;tengo que usar otra mascara por que esta vez esta todo corrido a la izquierda (no sobre un lugar como antes)
  movdqu xmm6, [rdi+32] ; xmm6 = |qqq|zzz|zzz|zzz|zzz|_|
  ;agarro los ultimos 16 bytes, por eso 16*3-16 = 32, de esta forma puedo usar la mask transf2
  
  ;uso el shuf a byte para completar con cero y tener 4 elem de 4 bytes
  pshufb xmm0, xmm8          ; xmm0 = |0xxx|0xxx|0xxx|0xxx| (*)
  ;el ultimo elem suelto lo guardo solo en un registro xmm0
  pshufb xmm1, xmm9          ; xmm1 = |0000|0000|0000|0xxx|
  ;hago lo mismo con los 5 elem restantes
  pshufb xmm2, xmm8          ; xmm2 = |0yyy|0yyy|0yyy|0yyy|
  pshufb xmm3, xmm9          ; xmm3 = |0000|0000|0000|0yyy|

  pshufb xmm4, xmm8          ; xmm2 = |0zzz|0zzz|0zzz|0zzz|
  pshufb xmm5, xmm9          ; xmm3 = |0000|0000|0000|0zzz|

  movdqu xmm9, [transformUlt] ;si o si pasar a un registro
  pshufb xmm6, xmm9          ; xmm6 = |0000|0000|0000|0qqq|

  ;antes de juntarlos nesecito multiplicarlo por pi
  ;vamos a pasarlo a float (scalar single FP : 4 bytes) por que con un double me ocuparia mucha mas y no lo pide
  ;tengo enteron dword y debo convertirlos a single FP, (uso cvtdq2ps por ser packet) desde xmm0 a xmm6

  cvtdq2ps xmm0, xmm0
  cvtdq2ps xmm1, xmm1
  cvtdq2ps xmm2, xmm2
  cvtdq2ps xmm3, xmm3
  cvtdq2ps xmm4, xmm4
  cvtdq2ps xmm5, xmm5
  cvtdq2ps xmm6, xmm6

  ;uso la mul de punto flotante, ps por que es single
  movdqu xmm7, [multPI]

  mulps xmm0, xmm7 ; xmm0= |0xxx*3.14|0xxx*3.14|0xxx*3.14|0xxx*3.14|
  mulps xmm1, xmm7 ; xmm1= |0000|0000|0000|0xxx*3.14|
  mulps xmm2, xmm7
  mulps xmm3, xmm7
  mulps xmm4, xmm7
  mulps xmm5, xmm7
  mulps xmm6, xmm7

  ;SOLO SI EL NUMERO ES PAR LO MULTIPLICO POR 3,14
  ;como mierda se si un num es par? wtf amigo

  ;sumo normal de FP single (addpS) con el valor que quedo solo
  addps  xmm0, xmm1          ; xmm0 = |0xxx|0xxx|0xxx|0xxx+0xxx|
  addps  xmm2, xmm3          ; xmm2 = |0yyy|0yyy|0yyy|0yyy+0yyy|
  addps  xmm4, xmm5          ; xmm4 = |0zzz|0zzz|0zzz|0zzz+0zzz|
  addps  xmm4, xmm6          ; xmm4 = |0zzz|0zzz|0zzz|0zzz+0zzz+0qqq|

;   addps  xmm0, xmm2          ; xmm0 = |  S3 |  S2 |  S1 |  S0 |
;   ;muevo con el shuf para poder sumar los dos ultimos
;   pshufd xmm1, xmm0, 1110b   ; xmm1 = |-----|-----|  S3 |  S2 |
;   ;sumo normal elem a elem
;   addps  xmm0, xmm1          ; xmm0 = |-----|-----|S1+S3|S0+S2|
;   ;corro igual que antes
;   pshufd xmm1, xmm0, 0001b   ; xmm1 = |-----|-----|-----|S1+S3|
;   ;sumo elem a elem y listo 
;   addps  xmm0, xmm1          ; xmm0 = |-----|-----|-----|S0+S1+S2+S3|

  ;mejor uso suma horizontal de FP
  haddps xmm0, xmm2          ; xmm0 = |0xxx+0xxx|0xxx+0xxx+0xxx|0yyy+0yyy|0yyy+0yyy+0yyy|
  haddps xmm0, xmm0          ; xmm0 = |_|_|0xxx+0xxx+0xxx+0xxx+0xxx|0yyy+0yyy+0yyy+0yyy+0yyy|
  haddps xmm0, xmm0          ; xmm0 = |_|_|_|0xxx+0xxx+0xxx+0xxx+0xxx+0yyy+0yyy+0yyy+0yyy+0yyy|
  ;le agrego la suma de xmm4
  haddps xmm4, xmm4          ;xmm4 = |_|_|0zzz+0zzz|0zzz+0zzz+0zzz+0qqq|
  haddps xmm4, xmm4          ;xmm4 = |_|_|_|0zzz+0zzz+0zzz+0zzz+0zzz+0qqq|
  ;por ultimo sumo normal elem a elem los resultados para tener el total
  addps xmm0, xmm4           ;xmm0 = |_|_|_|0xxx+0xxx+0xxx+0xxx+0xxx+0yyy+0yyy+0yyy+0yyy+0yyy + 0zzz+0zzz+0zzz+0zzz+0zzz+0qqq|

  cvtps2pd xmm0, xmm0 ;convierot a double(8 bytes) 
  ;xmm0 = |_|0xxx+0xxx+0xxx+0xxx+0xxx+0yyy+0yyy+0yyy+0yyy+0yyy + 0zzz+0zzz+0zzz+0zzz+0zzz+0qqq|

  ;devuelvo un double entonces mi respuesta ya esta en el xmm0  
    
  pop rbp
ret

; (*) aca estoy dibujando los numeros como se verian en normal, es decir el cero en la parte menos significativa.
