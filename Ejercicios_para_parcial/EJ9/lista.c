#include "lista.h"

node_t* agregarAdelante(int32_t valor, node_t* siguiente);
extern node_t* agregarAdelante_asm(int32_t valor, node_t* siguiente);
//int32_t valorEn(uint32_t indice, node_t* cabeza);
//void destruirLista(node_t* cabeza);

int main(int argc, char* argv){
    //importante reservar malloc, por que si no solo tengo un puntero, que apunta a basura
    node_t* newnodo = (node_t*)malloc(16);
    newnodo->siguiente = NULL;
    newnodo = agregarAdelante_asm(1, newnodo);
    newnodo = agregarAdelante_asm(2, newnodo);
    newnodo = agregarAdelante_asm(3, newnodo);
    newnodo = agregarAdelante_asm(4, newnodo);

    int i = 0;
    while(newnodo != NULL){
        i++;
        printf("nodo %d : %d\n", i, newnodo->valor);
        newnodo = newnodo->siguiente;
    }
}

node_t* agregarAdelante(int32_t valor, node_t* siguiente){
    node_t* auxnodo = (node_t*)malloc(16);

    
    auxnodo->siguiente = siguiente;
    auxnodo->valor = valor;
    return auxnodo;
}