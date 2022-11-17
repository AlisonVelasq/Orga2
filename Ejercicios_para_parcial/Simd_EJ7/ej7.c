#include <stdio.h>
#include <stdlib.h>

#define N 16

extern double  ejb(char* a);

int main(int argc, char* argv[]) {

    int i, s=0;
    char v[16*3] = {1,0,0, 2,0,0, 3,0,0, 4,0,0, 5,0,0, 6,0,0, 7,0,0, 8,0,0, 9,0,0, 10,0,0, 11,0,0, 12,0,0,
                    13,0,0, 14,0,0, 15,0,0, 16,0,0,};

    printf("POSTA:");
    for(i=0;i<16*3;i++)
        printf(" %i",v[i]);
    printf("\n");

    printf("ORIGINAL:");
    for(i=0;i<16;i++) {
	    int n = (v[i*3+2]<<16)+(v[i*3+1]<<8)+v[i*3];
	    s=s+n; printf(" %i",n);
    }
    printf("\n");
    
    double f = ejb(v);

    printf("RESULTADO:");
    printf("%f",f);
    printf("\n\n");

 return 0;
}
