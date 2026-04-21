# **Actividad 1: Dibujando un punto en la pantalla**

### Escribe un programa que dibuje un punto negro en la esquina superior izquierda de la pantalla.
### Traduce este programa a lenguaje C++.

- Aquí se sabe ya que @16384 es donde comienza a escribirse en la pantalla
``` asm
@16384
M=1
```

- Código C++ [Hubo uso de IA para la traducción]
``` c++
#include <iostream>

int main() {
    // Simulación de la RAM Hack (32K palabras)
    int RAM[32768] = {0};

    // Dirección de la pantalla
    RAM[16384] = 1;

    // Verificación
    std::cout << "Valor en SCREEN[0]: " << RAM[16384] << std::endl;
    return 0;
}
```


![alt text](Ej1.png)
- Se agregó un 1 para que el primer valor del binario de la dirección de memoria sea un 1 en vez de un 0 y se pinta ese punto



# **Actividad 2: Dibujando una línea horizontal**

### Modifica el programa anterior para que dibuje una línea horizontal negra de 16 pixeles de largo en la esquina superior izquierda de la pantalla.
### Traduce este programa a lenguaje C++.

- Con la misma información, revisé con el binario para notar que cambiar los 16 valores por un 1 equivale a -1 en decimal
``` asm
@16384
M=-1
```
![alt text](Ej2.png)
- Así que lo apliqué y así mismo me dio la línea completa

- Hipótesis de código C++
``` c++
#include <iostream>

int main() {
    int RAM[32768] = {0};
    RAM[16384] = -1;

    std::cout << "Valor en SCREEN[0]: " << RAM[16384] << std::endl;
    return 0;
}

```

# **Actividad 3: Entrada salida interactiva**

Modifica el programa de la actividad anterior de tal manera que puedas mover la línea horizontal de derecha a izquierda usando las teclas **d** e **i** respectivamente.

Traduce este programa a lenguaje C++.

- Pseudocódigo: Se tendría que realizar la siguiente operación:
```
Leer KBD
{
if KBD = 0
    go to keyboard
        if KBD = 105

            RAM[20496]=0 // Izquierda
            RAM[20496]=-1

    go to keyboard
}
```

- Pseudocódigo 2: mi idea de qué podría ser el código en C++ con mi conocimiento de Java
``` c++
#include <iostream>

int main() {
    int RAM[32768] = {0};
    int i = 16384
    while keypressed.is[d]{
        RAM[i] = -1;
        i = i++
    }
    while keypressed.is[i]{
        RAM[i] = 0;
        i = i--
    }

    std::cout << "Valor en SCREEN[0]: " << RAM[i] << std::endl;
    return 0;
}

```

- Código finalizado en C++ [con apoyo de IA]
``` c++
#include <iostream>

int main() {
    const int SCREEN = 16384;
    const int SCREEN_WIDTH = 32;

    int RAM[32768] = {0};

    int xPos = 0;
    int prevX = 0;

    char key;

    std::cout << "Usa 'd' para derecha, 'i' para izquierda, 'q' para salir\n";

    while (true) {
        // Guardar posición anterior
        prevX = xPos;

        std::cin >> key;
        if (key == 'q') break;

        if (key == 'd' && xPos < SCREEN_WIDTH - 1) {
            xPos++;
        }
        if (key == 'i' && xPos > 0) {
            xPos--;
        }

        // Borrar posición anterior
        RAM[SCREEN + prevX] = 0;

        // Dibujar nueva posición
        RAM[SCREEN + xPos] = -1;

        std::cout << "Posición: " << xPos << "\n";
    }

    return 0;
}
```
- Código en Assembly
``` asm
@xPos
M=0            // posición actual

@prevX
M=0            // posición anterior


(LOOP)
@xPos
D=M
@prevX
M=D

// ESPERAR TECLA
(WAIT_KEY)
@KBD
D=M
@WAIT_KEY
D;JEQ

// PROCESAR TECLA
@KBD
D=M
@100           // 'd'
D=D-A
@MOVE_RIGHT
D;JEQ

@KBD
D=M
@105           // 'i'
D=D-A
@MOVE_LEFT
D;JEQ

@AFTER_MOVE
0;JMP

// MOVER DERECHA
(MOVE_RIGHT)
@xPos
D=M
@31
D=D-A
@AFTER_MOVE
D;JEQ

@xPos
M=M+1
@AFTER_MOVE
0;JMP

// MOVER IZQUIERDA
(MOVE_LEFT)
@xPos
D=M
@AFTER_MOVE
D;JEQ

@xPos
M=M-1

(AFTER_MOVE)

//BORRAR
@SCREEN
D=A
@prevX
D=D+M
A=D
M=0

//DIBUJAR
@SCREEN
D=A
@xPos
D=D+M
A=D
M=-1

//ESPERAR
(RELEASE)
@KBD
D=M
@RELEASE
D;JNE

@LOOP
0;JMP
```


[Pruebas de funcionamiento](https://youtu.be/2_BoMS7esME)



