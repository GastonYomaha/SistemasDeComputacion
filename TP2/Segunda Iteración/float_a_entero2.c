// Se le dice a C que esta función existe en otro lado (en el archivo .s)
extern int procesar_indice_ensamblador(float gini_float);

// Esta es la función que Python va a llamar
int puente_c(float gini) {

// C convoca a la rutina en ensamblador
return procesar_indice_ensamblador(gini);
}

