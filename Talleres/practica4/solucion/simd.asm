global fir_filter_simd
extern fir_filter

; size_t fir_filter_simd(FIR_t*filtro, int16_t *in, unsigned length, int16_t *out);
fir_filter_simd:
    ; Reemplazar con una super eficiente implementación en SIMD!
    jmp fir_filter
    