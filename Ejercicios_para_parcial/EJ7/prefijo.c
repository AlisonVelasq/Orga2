#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

int32_t prefijo(char* s1, char* s2);

int main(int argc, char const *argv[]){
    
    int32_t len = prefijo("pinchado", "pincel");
    printf("la longitud del prefijo es %d\n", len);
}

/*
int prefijo(char* s1, char* s2){
    int tam = 6;
    int lenPrefijo = 0;
    for(int i = 0; i < tam; i++){
        if(*s1++ == *s2++){
            lenPrefijo++;
        }
        else{
            i = tam;
        }
    }
    return lenPrefijo;
}*/