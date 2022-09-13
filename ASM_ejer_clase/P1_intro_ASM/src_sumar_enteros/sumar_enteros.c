#include <stdio.h>
//declaro la aridad de la funcion en ASM con extern
extern int sumarenteros(int entero_1, int entero_2);
//en c es extern por default, lo importante es declarar la aridad

//tenemos que tener en cuenta que int en C es de 32 bit
//y nosotros estamos trabajando con 64 en asm, es decir tenemos un registro mas grande
//entonces el entero que nos pasan va a estar pasado en los 4 bytes menos significativos, y en la parte alta tendriamos basuar
//ENTONCES trabajaremos con la mitad menos significativos de los registros, es decir edi y esi
int main(int argc, char *argv[])
{		
	//llamo a la funcion de ASM desde C
	int rta = sumarenteros(10,5);
	printf("La respuesta es %d \n", rta);
	return 0;
}