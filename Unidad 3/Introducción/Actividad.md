# **Actividad 1: Hola Mundo**

1. ¿Para qué sirven los breakpoints?
    - Para marcar una pausa en el programa y empezar a depurar el proceso paso por paso 
2. ¿Para qué se usa la ventana de depuración Autos?
    - Permite ver cuáles son las variables en uso en la la línea actual y anterior
    - Te muestra valores importantes sin que tengas que agregarlos a mano.

# **Actividad 2**

Predicciones: 

    - Se muestran cuáles son los valores iniciales de cada variable a, b y c

    - Se avisa que se va a llamar a la función modificar por valor y que la variable a será modificada

    - Luego hace el mismo aviso pero con modificar por referencia en la variable b.

    - Realiza el llamada una última vez para modificar por puntero y la variable (convertida a puntero) c

    - Modificar por valor instancia n como un integer que se reemplaza por la variable llamada por la función y suma su valor por 5 

    - Modificar por referencia convierte el valor en un puntero e imprime su dirección más 5

    - Modificar por puntero disuelve el puntero y devuelve su valor interno más 5

Código:
``` c++
void swapPorValor(int a, int b) {
    int temp = a;
    a = b;
    b = temp;

    cout << "Dentro de swapPorValor -> a: " << a << ", b: " << b << endl;
}

void swapPorReferencia(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;

    cout << "Dentro de swapPorReferencia -> a: " << a << ", b: " << b << endl;
}

void swapPorPuntero(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;

    cout << "Dentro de swapPorPuntero -> a: " << *a << ", b: " << *b << endl;
}

int main() {
    int x = 5;
    int y = 10;

    cout << "Valores iniciales -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorValor(x, y)" << endl;
    swapPorValor(x, y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorReferencia(x, y)" << endl;
    swapPorReferencia(x, y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorPuntero(&x, &y)" << endl;
    swapPorPuntero(&x, &y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    return 0;
}
```
# **Actividad 3**

## Dónde pertenece cada variable en la memorias

### Segmento de código:
- main()
- suma()
- crearArrayHeap()
- funcionConStatic()

### Variables globales y estáticas:
- global_inicializada
- global_no_inicializada
- var_estatica
- mensaje_ro (puntero)

### Zona de solo lectura:
- "Hola, memoria de solo lectura"

### Heap:
- array creado con new int[tam]

### Stack:
- a, b, c (main)
- tamArray
- arrayHeap (puntero)
- a, b, c (suma)


# **Actividad 4: Experimentos**
### Experimento 1: Modificar el segmento de texto

¿Qué ocurre?
- El programa falla o se cierra.

¿Por qué?
- Porque el segmento de código es de solo lectura. No se puede modificar el código del programa mientras se ejecuta.

### Experimento 2: Modificar una constante global

¿Qué ocurre?
- El programa produce un error o comportamiento indefinido.

¿Por qué?
- La cadena está en una zona de solo lectura, y el sistema no permite modificarla aunque se fuerce el puntero.

### Experimento 3: Modificar variables globales

¿Qué ocurre?
- El programa funciona bien y los valores cambian.

¿Por qué?
- Las variables globales están en el segmento de datos, que sí permite modificaciones en tiempo de ejecución.

### Experimento 4: Modificar una variable local estática fuera de la función

¿Qué ocurre?
- El código no compila.

¿Por qué?
- La variable es local a la función, por lo que no se puede usar fuera de ella, aunque sea estática.

¿Qué pasa al entrar y salir de la función?
- Las variables locales normales se crean y destruyen.
- Las variables locales estáticas conservan su valor.

### Experimento 5: Variable local estática vs no estática

¿Qué ocurre?
- La variable no estática siempre vale 100.
- La variable estática aumenta su valor en cada llamada.

¿Por qué?
- La variable estática se guarda entre llamadas; la normal no.

### Experimento 6: Modificar el Heap

¿Qué ocurre?
- Después de delete[], acceder al arreglo genera comportamiento indefinido.

¿Por qué?
- La memoria ya fue liberada y no debe usarse.

### Diferencia Heap vs Stack:

- Stack: automático y seguro.
- Heap: manual y más propenso a errores.

### ¿Qué pasa si no libero la memoria?
- Se generan fugas de memoria.

### ¿Por qué usar delete[]?
- Porque el arreglo fue creado con new[].



# **Actividad 5 – Análisis del mapa de memoria**

Actividad 5 – Copia de objetos y su ubicación en memoria
A. Predicción (sin ejecutar el código)

1. 
- ¿Cuál será la salida final en la consola?
Creo que el programa va a mostrar los valores de las variables y cómo cambian cuando se llaman las funciones. Pienso que el contador global y el estático van a aumentar, y que las variables pasadas por valor no van a cambiar fuera de la función.

2. Salida completa esperada:

- Se imprimen los valores iniciales de las variables.

- El contador global aumenta cada vez que se llama la función.

- El contador estático también aumenta, pero mantiene su valor entre llamadas.

- Los valores pasados por valor no cambian en main.

- (Puede que el contador estático se reinicie, no estoy del todo seguro).

3. Mapa de memoria conceptual (antes de que termine main):

- Datos globales / estáticos:
```
contador_global

contador_estatico
```
- Stack:

```
val_A, val_B, val_C (en main)

Parámetro a de sumaPorValor
```

- Código:
```
Función main

Función sumaPorValor
```

- No creo que se use el Heap en este programa.


B. Verificación y análisis (con depurador)

1. Comparación entre la salida real y la predicción:
- La salida fue parecida a lo que esperaba, pero confirmé que el contador estático no se reinicia, sino que sigue aumentando entre llamadas. Mi error fue pensar que podía comportarse como una variable local normal.

- Las capturas más importantes fueron:

    - Antes de la primera llamada a la función.

    - Después de cada llamada, cuando el contador cambia.

2. ¿Qué demuestran las capturas?
- Demuestran que:

    - Pasar parámetros por valor crea copias en el stack.

    - Los cambios dentro de la función no afectan a las variables originales.

    - Las variables globales y estáticas sí conservan cambios.

3. Comportamiento de contador_estatico:
- contador_estatico recuerda su valor porque se guarda en el segmento de datos estáticos y no se destruye al salir de la función.
- A diferencia de una variable local normal, no se vuelve a crear cada vez, sino que se inicializa una sola vez y conserva su valor entre llamadas.