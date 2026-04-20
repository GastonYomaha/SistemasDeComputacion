.global procesar_indice_ensamblador
.text

procesar_indice_ensamblador:
    # --- PRÓLOGO DEL STACK FRAME ---
    pushq   %rbp            # Se guarda el base pointer de la función que llama
    movq    %rsp, %rbp      # Se establece un base pointer propio

    # --- RESERVAR ESPACIO EN EL STACK ---
    # Se Restan 16 bytes al puntero del stack (%rsp) para crear espacio 
    # para las "variables locales" (parámetro y resultado).
    # Se restan 16 y no menos para mantener la alineación de memoria obligatoria. (segun convencion de llamadas)
    subq    $16, %rsp

    # --- USAR EL STACK PARA EL PARÁMETRO ---
    # Se guarda el float (que llegó en %xmm0) en la memoria del stack (a -4 bytes del base pointer)
    movss   %xmm0, -4(%rbp)

    # --- LÓGICA DE CONVERSIÓN ---
    # Se lee el float desde la pila y se pone en otro registro para procesarlo.
    movss   -4(%rbp), %xmm1
    
    # Convertir Scalar Single-Precision FP to Integer:
    # CVTSS2SI redondea automáticamente al entero más cercano:
    cvtss2si %xmm1, %eax    

    # --- SUMAR UNO ---
    # Se le suma 1 al registro %eax que ahora contiene el entero
    addl    $1, %eax        

    # --- USAR EL STACK PARA DEVOLVER EL RESULTADO ---
    # Se guarda el entero resultante en el stack (a -8 bytes del base pointer)
    movl    %eax, -8(%rbp)
    movl    -8(%rbp), %eax

    # --- EPÍLOGO DEL STACK FRAME ---
    # Primero se restaura el puntero de la pila para "borrar" las variables locales
    movq    %rbp, %rsp
    # Se desarma el stack frame antes de volver
    popq    %rbp            
    
    # Se retorna a la función que llama. El resultado viaja en %eax.
    ret
