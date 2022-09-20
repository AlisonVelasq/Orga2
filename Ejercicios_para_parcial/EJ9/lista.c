#include "lista.h"

node_t* agregarAdelante(int32_t valor, node_t* siguiente);
//node_t* agregarAdelante_asm(int32_t valor, node_t* siguiente);
//int32_t valorEn(uint32_t indice, node_t* cabeza);
//void destruirLista(node_t* cabeza);

int main(int argc, char* argv){
    node_t* newnodo;
    newnodo->siguiente = NULL;
    newnodo = agregarAdelante(1, &newnodo);
    newnodo = agregarAdelante(2, &newnodo);
    newnodo = agregarAdelante(3, &newnodo);
    newnodo = agregarAdelante(4, &newnodo);

    for (int i = 0; i < 4; i++)
    {
        printf("nodo %d : %d", i, newnodo->valor);
    }
    
}

node_t* agregarAdelante(int32_t valor, node_t* siguiente){
    node_t* auxnodo;
    auxnodo->siguiente = siguiente;
    auxnodo->valor = valor;
    return auxnodo;
}