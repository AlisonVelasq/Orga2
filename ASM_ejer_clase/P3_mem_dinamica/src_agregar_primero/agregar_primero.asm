section.text:
	global agregarPrimero
	extern malloc

	agregarPrimero:
		push rbp
		mov rbp, rsp ; pila alineada
		;hago los soguientes push por convencion ya que voy a usar esos registros
		push rbx		 ; pila alineada 8
		push r12		 ; pila alineada 16
		;void agregarPrimero(lista_t* unaLista, int unInt);
		; rdi = *unaLista
		; esi = unInt

		mov rbx, rdi
		mov r12d, esi

		;1. Crear el nodo usando malloc
		mov rdi, 16 ;especifico el tamaño del malloc
		call malloc  ; rax = el puntero a nuevo nodo
		;importante al hacer el call la pila debe estar alineada a 16, en este caso lo esta

		mov [rax], r12d

		;2. Conectar el nuevo nodo a su siguiente en la lista
		mov rdi, [rbx]
		mov [rax + 8], rdi
		
		;3. Conectar el puntero anterior en la lista al nuevo nodo
		mov [rbx], rax

		pop r12
		pop rbx
		pop rbp
		ret