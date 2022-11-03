#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"
//#include "ej1.c"

extern char** agrupar(msg_t* msgArr, size_t msgArr_len);

int main (void){
	/* Acá pueden realizar sus propias pruebas */
msg_t* vectMsg = (msg_t*)malloc(6 * sizeof(msg_t));

	(vectMsg[0]).text = "holaa";
	(vectMsg[0]).text_len = 5;
	(vectMsg[0]).tag = 0;

	(vectMsg[1]).text = " mundoo";
	(vectMsg[1]).text_len = 7;
	(vectMsg[1]).tag = 0;

	(vectMsg[2]).text = " soy alison";
	(vectMsg[2]).text_len = 11;
	(vectMsg[2]).tag = 0;

	(vectMsg[3]).text = "costo un";
	(vectMsg[3]).text_len = 8;
	(vectMsg[3]).tag = 2;

	(vectMsg[4]).text = "bye <3";
	(vectMsg[4]).text_len = 6;
	(vectMsg[4]).tag = 3;

	(vectMsg[5]).text = " huevo :(";
	(vectMsg[5]).text_len = 9;
	(vectMsg[5]).tag = 2;

	//imprimo

	for(int i = 0; i < 6; i++){

		printf("%s \n", vectMsg[i].text);
		printf("%i \n", (int)vectMsg[i].text_len);
		printf("%i \n", vectMsg[i].tag); 
	}
	
	char** tagConcatenados = agrupar(vectMsg, 6);

	printf("Imprimo los strings concatenados\n");
	for(int i = 0; i < MAX_TAGS; i++){

		printf("%s \n", tagConcatenados[i]);

	}
	return 0;    
}


