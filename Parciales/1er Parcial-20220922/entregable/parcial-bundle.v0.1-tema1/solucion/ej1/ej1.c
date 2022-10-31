#include "ej1.h"


char** agrupar_c(msg_t* msgArr, size_t msgArr_len){

    //tengo que devolver un vector de string, donde en cada posicion estaran
    //los string concatenados (los del tag 0, tag1, etc)
    //el vector a los sumo tiene cant_tag elementos, que para este ejer es 4

    char** vectConcatenados = malloc(MAX_TAGS*8);

    //tengo un vector que tiene direcciones de memoria y esas direcciones apuntan a strings

    //para guardar cada string en vectConcatenados nesesito llamar a malloc
    //y reservar para cada string, pero estos tamaños pueden ser totalmente distintos
    //ya que podria nesetar mucho espacio solo para el tag 0 y los demas vacios, por ejemplo

    //me creo un vector aux, para guardar la cant de bytes que nesecito para cada string concatenado
    //recuendo que a lo sumo tengo 4 strings concatenados

    //int* vectCantXtag = malloc(MAX_TAGS*sizeof(int)); //si lo hago asi tengo que asignar a cada lugar un cero
    int vectCantXtag[MAX_TAGS] = {0,0,0,0}; //seria mejor un for por si quiero cambiar el el MAX_TAGS

    //recorro el vector msgArr para saber cuanto reservar
    
    for(int i = 0; i < msgArr_len; i++){
        if(msgArr[i].tag == 0){
            //csads char es un byte, entonces reservo, text_len ( cant de char de cada string)
            vectCantXtag[0] += (int)msgArr[i].text_len;
        }
        else if(msgArr[i].tag == 1){
            vectCantXtag[1] += (int)msgArr[i].text_len;;
        }
        else if(msgArr[i].tag == 2){
            vectCantXtag[2] += (int)msgArr[i].text_len;;
        }
        else if(msgArr[i].tag == 3){
            vectCantXtag[3] += (int)msgArr[i].text_len;;
        }
    }

    //ya tengo la cantidad a reservar para cada string concatenado
    //ahora el vect auxiliar y reservo los bytes de cada string concatenado

    for(int i = 0; i < MAX_TAGS; i++){
        vectConcatenados[i] = malloc(vectCantXtag[i]+1);
        //sumo 1 por el 0(nulo) que tienen al final los string, tiene que estar si o si
    }

    //ahora si, concateno
    int com0 = 0; //creo la variables com = 0
    int* dcom0 = &com0; //ontemgo la direccion de esa variable
    //para desreferenciar com uso : *com

    //hago lo mismo para el resto de indices(depende de la cant de tags) pero resumido
    int dcom1 = 0;
    int dcom2 = 0;
    int dcom3 = 0;

    for(int i = 0; i < msgArr_len; i ++){
        if(msgArr[i].tag == 0){
            concatenar(vectConcatenados[0], msgArr[i].text, (int)(msgArr[i].text_len), dcom0);
        }
        else if(msgArr[i].tag == 1){
            concatenar(vectConcatenados[1], msgArr[i].text, (int)(msgArr[i].text_len), &dcom1);
        }
        else if(msgArr[i].tag == 2){
            concatenar(vectConcatenados[2], msgArr[i].text, (int)(msgArr[i].text_len), &dcom2);
        }
        else if(msgArr[i].tag == 3){
            concatenar(vectConcatenados[3], msgArr[i].text, (int)(msgArr[i].text_len), &dcom3);
        }
    }

    return vectConcatenados;

}
//paso por "referencia" el string y el indice ya que quiero que estos si se modifiquen
//i.e le paso la direccion donde esta la variable y modifico desde ahi

void concatenar(char* sConcatenado, char* text, int text_len, int* indice){
    int c = 0;
    int j = 0;
    int i = *indice;
    //me guardo el indice desde donde tengo que concatenar?
    for(j = i; j < i + text_len ; j++){
        sConcatenado[j] = text[c];
        c++;
    }
    *indice = j; //desde j por que copiamos hasta uno anterior a j 
    //( j toma rl valor donde ya no es valida la guarda e.i una mas desde mi ultimo char guardadp )
    
    
    
}