#include "cliente.h"

//la diea es que me devuelva un puntero al cliente al azar que eligio

extern cliente_t* azar(cliente_t arraycliente[3]);

int main(int argc, char* argv){

    cliente_t client1;
    cliente_t client2;
    cliente_t client3;


    client1.nombre[0] = 'a';
    client1.nombre[1] = 'n';
    client1.nombre[2] = 'a';

    client2.nombre[0] = 'm';
    client2.nombre[1] = 'a';
    client2.nombre[2] = 'r';

    client3.nombre[0] = 's';
    client3.nombre[1] = 'o';
    client3.nombre[2] = 'l';

    client1.apellido[0] = 'x';
    client1.apellido[1] = 'n';
    client1.apellido[2] = 'a';

    client2.apellido[0] = 'a';
    client2.apellido[1] = 'x';
    client2.apellido[2] = 'a';

    client3.apellido[0] = 'a';
    client3.apellido[1] = 'n';
    client3.apellido[2] = 'x';
    client3.apellido[3] = 't';

    client1.dni= 20;
    client2.dni = 21;
    client3.dni = 22;

    client1.compra = 10;
    client2.compra = 11;
    client3.compra = 12;

    cliente_t arrayC[3];
    arrayC[0] = client1;
    arrayC[1] = client2;
    arrayC[2] = client3;

    cliente_t* clienteAzar = azar(arrayC);

    //imprimiento valores del cliente

    printf("nombre %s\n", (*clienteAzar).nombre);
    printf("apellido %s\n", (*clienteAzar).apellido);
    printf("DNI: %d\n", (*clienteAzar).dni);
    printf("compra: %d\n",(*clienteAzar).compra);

}
/*
cliente_t azar(cliente_t arraycliente[3]){
    int M = 0;
    int N = 2;
    int r =  rand () % (N-M+1) + M;//num al azar entre M y N

    //imprimiendo datos del cliente
    return arraycliente[r];
}*/