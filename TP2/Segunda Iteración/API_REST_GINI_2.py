import requests
import ctypes

# --- 1. CONFIGURACIÓN DE LA LIBRERÍA C ---
# Cargar la librería que se acaba de compilar
lib_c = ctypes.CDLL('./libfloat_a_entero2.so')

# Se le dice a Python que la función de C recibe un 'float' de C
lib_c.puente_c.argtypes = [ctypes.c_float]
# Se le dice a Python que la función de C devuelve un 'int' de C
lib_c.puente_c.restype = ctypes.c_int


# --- 2. DESCARGA DE DATOS (Capa Superior) ---
url = 'https://api.worldbank.org/v2/en/country/all/indicator/SI.POV.GINI?format=json&date=2011:2024&per_page=32500&page=1'
respuesta = requests.get(url)

if respuesta.status_code == 200:
    datos = respuesta.json()
    lista_registros = datos[1]

    print("--- ÍNDICE GINI: ARGENTINA ---")
    
    for registro in lista_registros:
        nombre_pais = registro['country']['value']
        valor_gini = registro['value']
        anio = registro['date']
        
        if nombre_pais == 'Argentina' and valor_gini is not None:
            
            # --- 3. CONEXIÓN CON LA CAPA INTERMEDIA ---
            # valor_gini es un float de Python. Se convierte a float de C y se llama a la función
            resultado_c = lib_c.puente_c(valor_gini)
            
            print(f"Año {anio}:")
            print(f"  -> Original (Float): {valor_gini}")
            print(f"  -> Procesado por C (Int + 1): {resultado_c}")
else:
    print("Error al conectar con la API.")
