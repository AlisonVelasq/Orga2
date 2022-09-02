#include "stack.h"
#include <stdlib.h>

/* Desapila el último elemento (i.e. lo devuelve y lo elimina de la pila)
*/
uint64_t pop(stack_t *stack)
{
    uint64_t res = *(stack->esp);
    if (stack->esp < stack->ebp){
        stack->esp += 1;
    }
    return res;
}


/* Devuelve el contenido del tope de la pila (y lo mantiene).
*/
uint64_t top(stack_t *stack)
{
    uint64_t res = *(stack->esp);
    return res;
}

/* Apila el contenido de 'data'
*/
void push(stack_t *stack, uint64_t data)
{
    if(stack->esp > stack->_stackMem){
        stack->esp -= 1;
        *(stack->esp) = data;
    }
}

stack_t * createStack(size_t size)
{
    // Completar: Pedir memoria para el stack
    stack_t *stack = malloc(sizeof(stack_t));

    size_t tam = sizeof(uint64_t)*size;
    stack->_stackMem = malloc(tam);

    //Lo de abajo dado por catedra
    stack->ebp = stack->_stackMem + size - 1;  // La base del stack es la dirección numéricamente más grande.
    stack->esp = stack->ebp;  // Al comienzo, la base y el tope coinciden

    stack->pop = pop;
    stack->top = top;
    stack->push = push;

    return stack;
}

void deleteStack(stack_t *stack)
{
    // Completar
    /*while(stack->esp != stack->ebp){
        free(*(stack->esp));
        stack->esp++;
    }*/
    free(stack->_stackMem);
    free(stack);

}
