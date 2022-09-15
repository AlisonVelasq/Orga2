#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "checkpoints.h"
	//stack y registers en estado 0
int main (void){
	/* Acá pueden realizar sus propias pruebas */
	//stack y registers en estado A
	//huy! voy a llamar una función!! => alineo el stack y losregistros no volátiles tienene que estar en el estado inicial
	assert(alternate_sum_4(8,2,5,1) == 10); //Tengo que dejar todo como lo tenía antes, stack y registers tienen que estar en el estado A	
	return 0;    
}


