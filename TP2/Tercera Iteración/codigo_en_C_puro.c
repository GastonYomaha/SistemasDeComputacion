#include <stdio.h>

// Se le dice a C que esta función existe en otro lado (en el archivo .s)
extern int procesar_indice_ensamblador(float gini_float);

int main() {
    float gini_argentina = 40.7; // Un valor de prueba
    
    // Se llama a la función en ensamblador
    int resultado = procesar_indice_ensamblador(gini_argentina);
    
    printf("El GINI original era: %f\n", gini_argentina);
    printf("El resultado procesado por ASM es: %d\n", resultado);
    
    return 0;
}
