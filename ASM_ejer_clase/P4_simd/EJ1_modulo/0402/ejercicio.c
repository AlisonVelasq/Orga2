// Sean un vector de 1024 pares de componentes $x$ e $y$, ordenadas una a
// continuacion de la otra. Las componentes están almacenadas en punto
// flotante de 32 bits. Calcular el modulo del vector que representan
// utilizando la formula $\sqrt{x^2+y^2}$. Retornar el resultado un nuevo
// vector. La aridad de la función es \verb|float* mod(float *v)|.
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

extern float* mod(float *);

float *modc(float *v) {
  float *res = malloc(sizeof(float) * 1024);
  for (int i = 0; i < 1024; i++) {
    float x = v[2*i];
    float y = v[2*i + 1];

    res[i] = sqrt(x*x + y*y);
  }

  return res;
}

void testVsModc(void) {
  float test_inputs[2048];
  for (int i = 0; i < 2048; i++) {
    test_inputs[i] = (((double)rand()) / RAND_MAX) * 100;
  }
  float *res_c = modc(test_inputs);
  float *res_asm = mod(test_inputs);
  for (int i = 0; i < 1024; i++) {
    double diff = fabs(res_c[i] - res_asm[i]);
    if (diff > 0.00001) {
      fprintf(stderr, "Fallo la comparacion del elemento %d\n", i);
      fprintf(stderr, "res_c: %f\nres_asm:%f\n", res_c[i], res_asm[i]);
      fprintf(stderr, "referencia:\n\tx: %f\n\ty: %f\n", test_inputs[2*i], test_inputs[2*i+1]);
      exit(EXIT_FAILURE);
    }
  }
  free(res_c);
  free(res_asm);
}

void testReferencia(void) {
  float ref[2048] = {0.0, 0.0,
                     1.0, 0.0,
                     0.0, 1.0,
                     1.0, 1.0,
                     2.0, 1.0,
                     3.15, 15.9};

  float esperado[1024] = {0.0, sqrt(1.0), sqrt(1.0), sqrt(2.0), sqrt(5.0), sqrt(3.15*3.15 + 15.9*15.9)};
  float *res = mod(ref);
  for (int i = 0; i < 1024; i++) {
    double diff = fabs(esperado[i] - res[i]);
    if (diff > 0.00001) {
      fprintf(stderr, "Fallo la comparacion del elemento %d\n", i);
      fprintf(stderr, "esperado: %f\nres:%f\n", esperado[i], res[i]);
      fprintf(stderr, "referencia:\n\tx: %f\n\ty: %f\n", ref[2*i], ref[2*i+1]);
      exit(EXIT_FAILURE);
    }
  }
  free(res);
}

int main(void) {
  testReferencia();
  testVsModc();
}
