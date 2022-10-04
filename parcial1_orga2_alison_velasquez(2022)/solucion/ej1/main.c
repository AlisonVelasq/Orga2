#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */

	// //la idea del ej 1 es concatenar los string que tiene las mismas etiquetas

	// //prueba
	// msg_t* msgArray = (msg_t*)malloc(16*3); //mi struct tiene 16 bytes
	// //tengo un array de estas structs;
	// msg_t* mArray = msgArray;

	// mArray->tag = 0;
	// mArray->text = "Hola ";
	// mArray->text_len = 5;
	
	// mArray = mArray++;
	// //mArray = (msg_t*)malloc(16);

	// mArray->tag = 1;
	// mArray->text = "chau";
	// mArray->text_len = 4;
	
	// mArray = mArray++;
	// //mArray = (msg_t*)malloc(16);

	// mArray->tag = 0;
	// mArray->text = "Mundo!";
	// mArray->text_len = 6;
	
	// //imprimo

	// for(int i = 0; i < 3; i++){
	// 	printf("en %d : tag: %d\n",i, msgArray->tag );
	// 	printf("en %d : text %s\n", i, msgArray->text);
	// 	printf("en %d : tam de string &d\n", i, msgArray->text_len);

	// 	msgArray = msgArray++;
	// }
	
	return 0;    
}


