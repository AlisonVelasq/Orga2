#include<stdio.h>
#include<stdint.h>

extern uint32_t sum(uint32_t a, uint32_t b);

int main(){
    uint32_t a = 21;
    uint32_t b = 79;

    printf("Suma %d + %d = %d\n", a,b, sum(a,b));
}