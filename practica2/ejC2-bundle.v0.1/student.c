#include "student.h"
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>


void printStudent(student_t *stud)
{
    /* Imprime por consola una estructura de tipo student_t
    */
    printf("Nombre: %s\n", stud->name);
    printf("dni: %u\n", stud->dni);
    printf("Calificaciones: ");
    for(int i = 0; i <3 ; i++){
        printf("%i", *(stud->califications + i));
        printf(", ");
    }
    printf("\n");
    printf("Concepto: %d\n", stud->concept);
    printf("----------\n");
}

void printStudentp(studentp_t *stud)
{
    /* Imprime por consola una estructura de tipo studentp_t
    */
    printf("Nombre: %s\n", stud->name);
    printf("dni: %u\n", stud->dni);
    printf("Calificaciones: ");
    for(int i = 0; i <3 ; i++){
        printf("%i", *(stud->califications + i));
        printf(", ");
    }
    printf("\n");
    printf("Concepto: %d\n", stud->concept);
    printf("----------\n");

}
