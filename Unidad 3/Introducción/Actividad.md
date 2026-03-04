# **Actividad 1: Hola Mundo**

1. ¿Para qué sirven los breakpoints?
    - Para marcar una pausa en el programa y empezar a depurar el proceso paso por paso 
2. ¿Para qué se usa la ventana de depuración Autos?
    - Permite ver cuáles son las variables en uso en la la línea actual y anterior
    - Te muestra valores importantes sin que tengas que agregarlos a mano.

### **Actividad 2**

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
### **Actividad 3**

Dónde pertenece cada variable en la memorias

Variables globales:
    - int global_inicializada = 42;
    - int global_no_inicializada;
    Existen durante toda la ejecución del programa.

Constante de solo lectura:
const char* const mensaje_ro = "Hola, memoria de solo lectura";


📍 Ubicación:
➡️ El texto está en la zona de solo lectura (RO Data)
➡️ El puntero mensaje_ro está en el segmento de variables globales

🔹 Variable estática
static int var_estatica = 100;


📍 Ubicación:
➡️ Segmento de variables globales y estáticas

📌 Aunque esté dentro de una función, NO va al stack.

🔹 Variables locales en main()
int a = 10;
int b = 20;
int c = suma(a, b);
int tamArray = 10;
int* arrayHeap;


📍 Ubicación:
➡️ Stack

📌 Se crean al entrar a main() y se destruyen al salir.

🔹 Variables locales en suma()
int a, b, c;


📍 Ubicación:
➡️ Stack (en el frame de la función suma)

📌 Desaparecen al retornar la función.

🔹 Memoria dinámica
int* arr = new int[tam];


📍 Ubicación:
➡️ Heap

📌 Permanece hasta que se ejecuta:

delete[] arrayHeap;