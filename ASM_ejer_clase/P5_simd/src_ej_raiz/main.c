#include<stdio.h>
#include<stdlib.h>

extern void cuentaADouble(float* vector, int n);

int main(){

	void* vector_original = malloc(8*4);

	float* vector_asFloats = (float*) vector_original;
	double* vector_asDoubles = (double*) vector_original;

	printf("Vector de floats: ");
		vector_asFloats[0] = 1.0;
		vector_asFloats[1] = 1.0;
		vector_asFloats[2] = 7;
		vector_asFloats[3] = -3;
		vector_asFloats[4] = 9.0;
		vector_asFloats[5] = 9.0;
		vector_asFloats[6] = 16.0;
		vector_asFloats[7] = 16.0;
	
	for(int i = 0; i < 8; i++){
		printf("%f, ", vector_asFloats[i]);
	}
	
	printf("\n");

	cuentaADouble(vector_asFloats, 8);

	printf("Vector de doubles: ");
	for(int i = 0; i < 4; i++){
		printf("%f, ", vector_asDoubles[i]);
	}
	printf("\n");

	free(vector_original);
	
}