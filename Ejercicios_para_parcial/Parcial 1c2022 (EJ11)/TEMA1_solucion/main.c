#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ejs.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	
	//creo un str_array
	str_array_t* arrayStr = (str_array_t*)malloc(16);
	//me parece que no es necesario llamar al malloc

	arrayStr = strArrayNew(3);
	printf("capacity: %d\n", arrayStr->capacity);
	printf("size: %d\n", arrayStr->size);
	
	arrayStr->data[0] = "hola11111111111";//me apunta al primer string
	arrayStr->size++;
	arrayStr->data[1] = "chau xx11111111111111";
	arrayStr->size++;
	//arrayStr->data[2] = "mulan";
	//arrayStr->size++;
	printf("data: %s\n", arrayStr->data[0]) ;
	printf("data: %s\n", arrayStr->data[1]) ;
	printf("data: %s\n", arrayStr->data[2]) ;
	printf("size: %d\n", arrayStr->size);

	uint8_t s = strArrayGetSize(arrayStr);
	printf("size2: %d\n", s);

	strArrayAddLast(arrayStr, "mulan");
	
	printf("data: %s\n", arrayStr->data[2]) ;
	printf("size: %d\n", arrayStr->size);  
	return 0;
}


