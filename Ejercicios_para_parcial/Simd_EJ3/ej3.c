#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

void MultiplicarVectores(short *A, short *B, int *Res, int dimension);

int main(int argc, char const *argv[]){
    short a[] = {3, 3, 3, 3, 3, 3, 3, 3}; 
    short b[] = {2, 2, 2, 2, 2, 2, 2, 2};
    
    int dim = sizeof(a); //me da cant de bytes

    int* r = malloc(dim*2);
    //por que la respuesta estara en enteros de 4 bytes
    MultiplicarVectores(a, b, r, dim);
    for(int i = 0; i < dim/2; i++){
        printf("%d ", r[i]);
    }
    

}