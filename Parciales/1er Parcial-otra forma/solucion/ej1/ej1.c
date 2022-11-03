#include "ej1.h"

char** agrupar_c(msg_t* msgArr, size_t msgArr_len){

    char** vectConcatenados = malloc(MAX_TAGS*8);

    int vectCantxTag[MAX_TAGS] = {0};

    //esta vez itero sobre la cant de tags que hay, para hacer el codigo mas facil en asm
    //es mejor hacer un doble for que varios ifs
    for(int i = 0; i < MAX_TAGS; i++){
        for(int j = 0; j < msgArr_len; j++){
            if(msgArr[j].tag == i){
                vectCantxTag[i] += (int)msgArr[j].text_len;
            }
        }
    }

    for(int i = 0; i < MAX_TAGS; i++){
        vectConcatenados[i] = malloc(vectCantxTag[i]+1);
        //sumo 1 por el 0(nulo) que tienen al final los string, tiene que estar si o si
    }

    for(int i = 0; i < MAX_TAGS; i++){
        char* sConcatenado = vectConcatenados[i] ;

        for(int j = 0; j < msgArr_len; j++){

            if(msgArr[j].tag == i){
                //pongo el for aca para poder usar el iterado sobre el string, si no tengo que usar un oarametro para guardar el puntero al sig string a concatenar 
                char* text =  msgArr[j].text;
                int len = (int)(msgArr[j].text_len);

                for(int k = 0; k < len ; k++){
                    (*sConcatenado) = text[k];
                    sConcatenado++;
                }
            }
        }
    }
    return vectConcatenados;
}

                    //creo otra variable puntero, para ir modificando las direccion donde van cada string que concateno
                    //creo otra variable puntero, para ir modificando las direccion donde van cada string que concateno


