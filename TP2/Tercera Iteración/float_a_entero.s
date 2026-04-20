.global procesar_indice_ensamblador
.text

procesar_indice_ensamblador:
    # --- PRÓLOGO DEL STACK FRAME ---
    pushq   %rbp            # Se guarda el base pointer de la función que llama
    movq    %rsp, %rbp      # Se establece un base pointer propio

    # --- LÓGICA DE CONVERSIÓN ---
    # Según el estándar x86-64, el primer parámetro 'float' llega en el registro %xmm0.
    # El resultado 'int' debe devolverse en el registro %eax.
    
    # Convertir Scalar Single-Precision FP to Integer:
    # CVTSS2SI redondea automáticamente al entero más cercano:
    cvtss2si %xmm0, %eax    

    # --- SUMAR UNO ---
    # Se le suma 1 al registro %eax que ahora contiene el entero
    addl    $1, %eax        

    # --- EPÍLOGO DEL STACK FRAME ---
    # Se desarma el stack frame antes de volver
    popq    %rbp            
    
    # Se retorna a la función que llama. El resultado viaja en %eax.
    ret
