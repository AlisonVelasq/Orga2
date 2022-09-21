section .text

global mod
extern malloc

; rdi: float * (2048 floats) (1024 pares).
mod:
  push rbp
  mov rbp, rsp
  push rbx
  sub rsp, 8
  
  mov rbx, rdi

  mov rdi, 1024*4 ;cada elem ocupa 4 bytes
  call malloc
  ; en rax tenemos el resultado.

  xor rcx, rcx
.ciclo:
;por que no se si la memoria esta alineada
;por que tomo rcx elems de 4 bytes y *2 ya que hago esto dos veces (en xmm0 y xmm1)
  movdqu xmm0, [rbx + rcx*2*4] ; xmm0: [y1 | x1 | y0 | x0], guardo los primeros 16 bytes
  ;lo hago de esta forma por que no puedo hacer rcx*16
  mulps xmm0, xmm0   ; xmm0: [y1*y1 | x1*x1 | y0*y0 | x0*x0]
  movdqu xmm1, [rbx + rcx*2*4 + 16] ; xmm1: [y3 | x3 | y2 | x2 ] ;sumo 16 bytes para guardar los siguientes
  mulps xmm1, xmm1                  ; xmm1: [y3*y3 | x3*x3 | y2*y2 |x2*x2]
              
  haddps xmm0, xmm1  ; xmm0: [ y3*y3+x3*x3 | y2*y2+x2*x2 | y1*y1+x1*x1 | y0*y0+x0*x0 ]
  sqrtps xmm0, xmm0  ; xmm0: [ sqrt(y3*y3+x3*x3) | sqrt(y2*y2+x2*x2) | sqrt(y1*y1+x1*x1) | sqrt(y0*y0+x0*x0) ]
  movdqu [rax + rcx*4], xmm0 ;guardo 16 bytes
  add rcx, 4 ; por que voy agregando cada 4 elem
  cmp rcx, 1024 ;hasta cubrir los 1024 elem que tengo
  jl .ciclo ; mientras el flag Neg este encedido ir al ciclo

  add rsp, 8
  pop rbx
  pop rbp
  ret
