#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

void sumarVectores(char *A, char *B, char *Resultado, int dimension);

int main(int argc, char const *argv[]){

    //char* a = "aaaaaaaa";
    char a[] = "AAAAAAAAAAAAAAABBBBBBBB";
    //char* b = "bbbbbbbb";
    char b[] = "!!!!!!!!!!!!!!!!!!!!!!!";
    
    //mis array tienen que ser multiplo de 8

    //si tengo que guardar el resul en un puntero: necesito reservar memoria antes de llamar a una func asm
    //por que ya tengo un puntero antes de llamar a la puntero
    int dim = sizeof(a);
    char* sumav = (char*) malloc(dim); //apunta a basura(?)


    sumarVectores(a, b, sumav, dim);

    printf("suma: %s\n", sumav);



}  