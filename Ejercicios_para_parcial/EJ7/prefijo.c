#include <stdio.h>
#include <stdlib.h>		//biblioteca estándar, atoi, atof, rand, srand, abort, exit, system, NULL, malloc, calloc, realloc...
#include <stdint.h>		//contiene la definición de tipos enteros ligados a tamaños int8_t, int16_t, uint8_t,...

int32_t prefijo(char* s1, char* s2);
char* quitar_prefijo(char* s1, char* s2);

int main(int argc, char const *argv[]){
    
    int32_t len = prefijo("Pinchado", "Pincel");
    char* res = quitar_prefijo("Pinchado", "Pincel");
    printf("la longitud del prefijo es %d\n", len);
    printf("quitando prefijo es: %s \n", res);
}


int prefijo_c(char* s1, char* s2){
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
}
char* quitar_prefijo_c(char* s1, char* s2){
    //tengo que reservar los bytes para el char* de salida
    //para eso nesito saber la longitud del prefijo y hago: long de s2 - long del prefijo, eso es lo que tengo que reservar
    int32_t len_pre = prefijo(s1,s2);

    //recorro con el for hasta llegar al indice de s2 desde donde quiero empezar a copiar
    char* temp = s2;
    for(int i = 0; i < len_pre; i++){
        temp++;
    }
    //desde aca puedo copiar
    int tam = 0;
    
    while((*temp) != 0){
        tam++;
        temp++;
    }

    char* res = malloc(tam);

    for(int i = 0; i < tam; i++){
        res[i] = s2[len_pre + i];
    }
    return res;
}