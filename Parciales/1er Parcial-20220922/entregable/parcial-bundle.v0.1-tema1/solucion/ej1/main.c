#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"
//#include "ej1.c"//si quiero que ande en c

int main (void){
	/* Acá pueden realizar sus propias pruebas */
/*
	//pruebo definiendo un solo elemto en la struct, para esto llamo a malloc
	//creo un puntero donde reservare memoria, como quiero una struct msg
	//entonces guardo en msg_t* los 16 bytes de lña struct
		
	msg_t* prueba= (msg_t*) malloc(16);

	(*prueba).text = "holaa";
	(*prueba).text_len = 5;
	(*prueba).tag = 0;

	printf("%s \n", (*prueba).text);
		printf("%i \n",(*prueba).text_len);
		printf("%i \n", (*prueba).tag);
	
	
	
	//creo un vector de la struct msg_t
	//msg_t* vectMsg = (msg_t*)malloc(3 * sizeof(msg_t*));  //server lugar par aun vector de 3 posiciones
	//PREGUNTAR   parece que no tengo que reservar lugar para la cant de elem que va a tener mi vector
	
	
	msg_t** vectMsg ;
	(vectMsg[0]) = malloc(16); //reservbo en el primer lugar de ese vector 16 bytes de la struct
	(vectMsg[1]) = malloc(16);
	(vectMsg[2]) = malloc(16);
	
	
	//es exactamente lo mismo hacerlo con (*vectMsg) o vectMsg[0]
	//lo importante era reservar el lugar
*/
	//-----------LO DE ARRIBA NO, use msg_t** NO ERA LA IDEA

	//creo un vector de tipo msg_t (no un vector de punteros de struct, como habia hecho arriba)
	//y miro al vector como una tira larga, donde cada 24 bytes, empieza la siguiente posicion del vector
	//asi qeu reservo de una vez el lugar, que es 3*24, para 3 posiciones

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
	
	char** tagConcatenados = agrupar_c(vectMsg, 6);

	for(int i = 0; i < MAX_TAGS; i++){

		printf("%s \n", tagConcatenados[i]);

	}
	return 0;    
}


