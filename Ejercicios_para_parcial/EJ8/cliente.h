#include <stdio.h>
#include <stdlib.h>		
#include <stdint.h>
#include <string.h>	

#define NAME_LEN 21

typedef struct cliente_str {    //tengo un vector de char(1 byte), entonces tengo 21 bytes? .......  tiene 1 byte?, no es un char
    char nombre[NAME_LEN];      // off 0 -->(+21 bytes)
    char apellido[NAME_LEN];    // +21 -->(+42)
    uint64_t compra;            // + 6 bytes (padding para que este alineado a 8) +8 bytes --> 56
    uint32_t dni;               //+4 (4 bytes + 4 padding)
} cliente_t; //en total 60 + 4 (para alinear el struc) --> 64 bytes
//el tamaño del struct tiene que estar alineado al elem mas grande(8 bytes)

typedef struct __attribute__((__packed__)) packed_cliente_str {
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
} __attribute__((packed)) packed_cliente_t;