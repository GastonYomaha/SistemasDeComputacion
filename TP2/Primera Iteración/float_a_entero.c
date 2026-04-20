#include <stdio.h>

// Esta función recibe el float de Python, lo convierte a int y le suma 1
int procesar_indice(float gini_float) {
    // Conversión (casteo) de float a entero con redondeo. (Ej: 42.3 se convierte en 42 mientras que 40.7 se convierte en 41). Esto es porque castear a entero trunca el valor del float.
    int gini_entero = (int)(gini_float + 0.5);
    
    // Se le suma 1 
    int resultado = gini_entero + 1;
    
    return resultado;
}
