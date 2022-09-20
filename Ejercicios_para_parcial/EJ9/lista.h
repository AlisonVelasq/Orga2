
#include <stdio.h>
#include <stdlib.h>		
#include <stdint.h>
#include <string.h>	


typedef struct node_str {
    struct node_t* siguiente;    //8 bytes
    int32_t valor;              //4 bytes
} node_t; //12 + 4 bytes, al final la struct tiene que estar alineado a 8 bytes


