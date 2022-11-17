#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

void MultiplicarVectores(short *A, short *B, int *Res, int dimension);
int ProductoInterno(short *A, short *B, int dimension);
void SepararMaximosMinimos(char *A, char *B, int dimension);

int main(int argc, char const *argv[]){
    short a[] = {3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2}; 
    short b[] = {2, 2, 2, 2, 2, 2, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5};
    
    int dim = sizeof(a); //me da cant de bytes
    dim = dim/2; //quiero la cant de elem del vector

    int* r = malloc(dim*4); //guardo 4 bytas para cada multiplicacion de enteros
    //por que la respuesta estara en enteros de 4 bytes
    MultiplicarVectores(a, b, r, dim);
    for(int i = 0; i < dim; i++){
        printf("%d ", r[i]);
    }

    int suma = ProductoInterno(a, b, dim);
    printf("\nla suma en: %i\n", suma);
    
    char A[] = "hola mundo comoome re quiero mat";
    char B[] = "me re quiero mathola mundo comoo";

    //NO PUEDO HACER char* A y modificar desde ahi con asm, no se por que

    SepararMaximosMinimos(A, B, 32);

    printf("%s\n", A);
    printf("%s\n", B);

}