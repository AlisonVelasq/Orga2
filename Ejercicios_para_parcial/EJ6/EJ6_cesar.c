#include <stdio.h>
#include <stdlib.h>		
#include <stdint.h>

int ord(char c);
char chr(int n);
//funcion codificacion de cesar simplificada
//se puede asumir que x esta entre [0,26]
//Ejemplo: cesar("CASA", 3) = "FDVD" y cesar("CALABAZA", 7) = "JHSHIHGH"

//a)Escribir una función en C que dada una cadena de caracteres y un entero, devuelva su codificación césar simplificada.

char* codificacion_cesar(char* s, int n, int tam);

int main(int argc, char const *argv[]){
    char* sc = codificacion_cesar("HOLA", 3, 4);
    
    for (int i = 0; i < 4; i++)
    {
        char c1 = (*sc++);
        //printf("%c", c1);
        char c = (char)(chr(ord(c1)+3));
        printf("%c\n", c); //*s++, desreferencio la cadena e imprimo char x char

    }

    //printf("%s\n", (*sc));

    return 0;
}
/*
void codificacion_cesar(char* s, int n, int tam){
    for (int i = 0; i < tam; i++)
    {
        char c1 = (*s++);
        printf("%d", ord(c1));
        char c = (char)(chr(ord(c1)+n));
        printf("%c\n", c); //*s++, desreferencio la cadena e imprimo char x char

    }
    
}*/

int ord(char c) { return (int)c; }
char chr(int n) { return (char)n; }