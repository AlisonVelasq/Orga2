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

		;como voy a usar rdi para el malloc y nada me asegura que esi siga teniendo el valor que nesecito
		;entonces los paso a registros que se que no se van a modificar
		mov rbx, rdi
		mov r12d, esi

		;1. Crear el nodo usando malloc
		;quiero reservar 16 bytes por que es el tam se nuestra struc nodo
		mov rdi, 16 ;especifico el tamaño del malloc
		call malloc  ; rax = el puntero a nuevo nodo
		;importante al hacer el call la pila debe estar alineada a 16, en este caso lo esta

		;agrego el dato al nuevo nodo, esta en el off 0
		;en los primeros 4bytes guardo el entero, los otro 4 son de padding
		mov [rax], r12d

		;2. Conectar el nuevo nodo a su siguiente en la lista
		;en el off 0 de rbx esta el *primero
		mov rdi, [rbx] ;en rdi tengo a lo que esta apuntando el *lista, es decir *primero
		mov [rax + 8], rdi ;que ahora el *primero qu ele pase seria el *prox se mi nuevo nodo
		
		;3. Conectar el puntero anterior en la lista al nuevo nodo
		;en rax estoy guardando el nuevo nodo
		mov [rbx], rax ;ahora el puntero d el alist apunta PRIMERO al nuevo nodo y "corri" los demas
	

		pop r12
		pop rbx
		pop rbp
		ret