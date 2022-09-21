
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

/*
 - El primer ejercicio es de agarrar un vector de coords
   floats y calcular pythagoras entre todos
*/

// Dados dos vectores de 64 enteros de 16 bits, realizar
// el producto escalar entre ambos y alamacenar el
// resultado en 32 bits.

int32_t dotProduct(int16_t *a, int16_t *b, short n);

int main(int argc, char* argv[]) {
	int16_t a[8] = {INT16_MAX, 5, 1, -5, 1, 2, 2, -5};
	int16_t b[8] = {4, 7, 0,  2, 0, 3, 1, -1};
	printf("Resultado Obtenido = %d\n", dotProduct(a, b, 8));
	printf("Resultado Esperado = %d\n", INT16_MAX*4 + 5*7 - 5*2 + 2*3 + 2 + 5);
	return 0;
}
