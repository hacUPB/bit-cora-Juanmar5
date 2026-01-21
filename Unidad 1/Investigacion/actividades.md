# Actividad 1
Se realizaron los ejercicios de **Fetch-Decode-Execute**

[Link test](www.youtube.com)

![alt text](../Imágenes/Bing_Bong_Plushie-SV3-P-2_1000x.png.webp)


# Actividad 2
### Qué sucede?
- A pasa a 1 y guarda en D
- A pasa a 2 y guarda la suma de eso más lo que había en D (1+2)
- D ahora es 3 y A pasa a 16
- En la dirección 16 de la RAM se almacena el valor D (3)
- A pasa a 6
- Se repite el paso 6 (A pasa a 6) en loop

### Experimento

``` asm
@5
D=A 
@10 
D=D+A
@20 
M=D
```


# Actividad 3
### Predicciones

### Definiciones
#### Instrucción de la ALU y qué hace
- D=D-A
- La ALU resta el valor de A a D y guarda el resultado en D
#### Para qué el registro PC?
- Guardar la dirección de la siguiente instrucción que va a ejecutar
- Cambiar de valor cuando hay saltos
#### Diferencias @i y @READKEYBOARD
**@i**
- Es una variable
- Refiere a una posición de memoria donde se guarda un valor

**@READKEYBOARD**
- Es una etiqueta
- Representa una dirección de instrucción a la que el programa puede saltar
#### Qué se necesita para leer teclado y mostrar información en pantalla?
**Leer el teclado**
- Usar la dirección especial @KBD
- Si M ≠ 0, significa que hay una tecla presionada

**Escribir en la pantalla**
- Usar direcciones desde @SCREEN
- Escribir valores (-1 para encender píxeles, 0 para apagarlos)
- Bucles para actualizar continuamente la pantalla

#### Identifica y explica un bucle
``` asm
@READKEYBOARD
0;JMP
```
- El programa salta a @READKEYBOARD
- Hace un bucle infinito que revisa constantemente el estado del teclado para que reaccione si se presionan teclas
#### Identifica y explica condición
``` asm
@KBD
D=M
@KEYPRESSED
D;JNE
``` 

- Se lee el valor del teclado.
- Si D ≠ 0, significa que hay una tecla presionada.
- El programa salta a la etiqueta KEYPRESSED.

Esta condición permite ejecutar código solo cuando una tecla está presionada

### Actividad 4