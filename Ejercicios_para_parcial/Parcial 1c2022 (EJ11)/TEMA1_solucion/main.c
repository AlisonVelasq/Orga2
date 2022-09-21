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

	arrayStr = strArrayNew(4);
	printf("capacity: %d\n", arrayStr->capacity);
	printf("size: %d\n", arrayStr->size);
	
	//*(arrayStr->data) = "hola";//me apunta al primer string
	//printf("data: %s\n", *(arrayStr->data)) ;
	return 0;    
}


