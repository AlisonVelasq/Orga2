// ENUNCIADO
// Sea un vector que contiene exactamente 10 valores enteros sin signo de 3 bytes cada uno.
// Realizar la sumatoria de los mismos y almacenar el resultado en un double.

#include <stdio.h>
#include <stdlib.h>

#define N 16

extern double  ej(char* a);

int main(int argc, char* argv[]) {

    int i, s=0;
    char v[10*3] = {1,0,0, 2,0,0, 3,0,0, 4,0,0, 5,0,0, 6,0,0, 7,0,0, 8,0,0, 9,0,0, 10,0,0,};

    printf("POSTA:");
    for(i=0;i<10*3;i++)
        printf(" %i",v[i]);
    printf("\n");

    printf("ORIGINAL:");
    for(i=0;i<10;i++) {
	    int n = (v[i*3+2]<<16)+(v[i*3+1]<<8)+v[i*3];
	    s=s+n; printf(" %i",n);
    }
    printf("\n");
    
    double f = ej(v);

    printf("RESULTADO:");
    printf("%f (%i %f)",f,s,(double)s);
    printf("\n\n");

 return 0;
}
