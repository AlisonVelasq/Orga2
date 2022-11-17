#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

void Intercalar(char *A, char *B, char *vectorResultado, int dimension);

int main(int argc, char const *argv[]){
    char a[] = "hola soy alison la mas linda 33";
    char b[] = "xd xd me quiero ir a dormir :cc";

    //reservo lugar para el vector resultado que sera el doble de grande
    int dim = 32;

    char* res = malloc(17);

    Intercalar(a,b,res,dim);
    printf("%s\n", res);
}