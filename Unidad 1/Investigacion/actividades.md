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
- Predicción: Un jump como en el del keyboard debería servir para ejecutar la comparación si resto los números

``` asm
@25
D=A
@5
M=D
@10
D=D-A
@MENOS
D;JLT
@7
M=0
@END
0;JMP
(MENOS)
@7
M=1
(END)
@END
0;JMP
```
- Observo: Sí funcionó pero tuve que hacer varios ajustes como agregar la resta del 10 para que se compara el valor con cero de manera justa además de las líneas iniciales para introducir un número a comparar, no sé si guardar el valor en la memoria antes de la comparación era realmente necesario pero sirve como constancia de qué valor introduje al inicio así que lo dejé ahí
- Reflexiono: El JLT y demás jumps comparativos siempre comparan con cero y por ende cualquier comparativo debe restar el valor a comparar al número siendo comparado, además de que declarar etiquetas sirve como forma de copiar y pegar un if o condicional como si fuera una función siendo llamada

### Actividad 5
- Predicción: Creo que puedo crear un loop que haga una suma a un contador que determine cuántas veces se ha creado un loop y lo compare hasta que sea igual a cero con un valor de 5 y mientras sume por 1, guarde en la memoria 12 y se repita las veces que tome el contador para que sume el valor exactamente 5 veces

``` asm
@1
D=A
@i
M=D
@12
M=0

(LOOP)
@i
D=M
@6
D=D-A
@END
D;JGE

@i
D=M
@12
M=M+D

@i
M=M+1
@LOOP
0;JMP

(END)
@END
0;JMP
```

### Actividad 6

Sin consultar tus apuntes, el simulador o cualquier otro material, responde con tus propias palabras a las siguientes preguntas. ¡No te preocupes por la perfección! El objetivo es ver qué recuerdas ahora mismo.
Parte 1: recuperación de conocimiento (retrieval practice)
1. Describe con tus palabras las tres fases del ciclo Fetch-Decode-Execute. ¿Qué rol juega el Program Counter (PC) en este ciclo?
- Fetch: Agarrar el código y leerlo
- Decode: Interpretar lo que hará cada función individual
- Execute: Ejecutar y comprobar que la hipótesis sea correcta
- PC: Cuenta el número del próximo paso a ejecutar por la CPU
2. ¿Cuál es la diferencia fundamental entre una instrucción-A (que empieza con @) y una instrucción-C (que involucra D, M, A, etc.) en el lenguaje ensamblador de Hack? Da un ejemplo de cada una.
- La instrucción A da un valor únicamente a A
- La instrucción C puede igualar y asignar valores a otras direcciones como lo son la ROM y la RAM por medio del valor de A
- Como @10 vs D=A y M=D
3. Explica la función de los siguientes componentes del computador Hack: el registro D, el registro A y la ALU.
- Registro A llega a una dirección de memoria como abrir un locker, Registro D almacena el valor de la A para futuro uso o asignación
- La ALU
4. ¿Cómo se implementa un salto condicional en Hack? Describe un ejemplo (p. ej., saltar si el valor de D es mayor que cero).
- Con JLT, JLE, JGT, JGE. Por ejemplo decir que D;JGE es pedir que el valor de D sea mayor o igual a cero
5. ¿Cómo se implementa un loop en el computador Hack? Describe un ejemplo (p. ej., un loop que decremente un valor hasta que llegue a cero).
- 
6. ¿Cuál es la diferencia entre la instrucción D=M y la instrucción M=D?
- M=D le da a M el valor de D, D=M le da a D el valor de M
7. Describe brevemente qué se necesita para leer un valor del teclado (KBD) y para “pintar” un pixel en la pantalla (SCREEN).
- @READKEYBOARD o @KBD que empieza a tomar valores de las teclas a partir del 24576
- Del valor 16384  a  24575 de la RAM empezar a pintar pixeles editando los bytes de ceros a unos que pintan pixeles negros

Parte 2: reflexión sobre tu proceso (metacognición)
1. ¿Cuál fue el concepto o actividad más desafiante de esta unidad para ti y por qué?
- La 3 porque fue un salto muy fuerte respecto a los loops en la CPU, el código del keyboard era bastante amplio y complejo comparado a los ejercicios simples de antes.
2. La metodología de “predecir, ejecutar, observar y reflexionar” fue central en nuestras actividades. ¿En qué momento esta metodología te resultó más útil para entender algo que no tenías claro?
- En Predecir y Reflexionar porque pude regresar en mis notas para corregir y justificar mi fallo, lo que me permitía aprender mejor.
3. Describe un momento “¡Aha!” que hayas tenido durante estas dos semanas. ¿Qué estabas haciendo cuando ocurrió?
- Supongo que si no fue entender cómo funciona el valor de memoria de Screen fue entender que los saltos comparaban a cero.
4. Pensando en la próxima unidad, ¿Qué harás diferente en tu proceso de estudio para aprender de manera más efectiva?
- Seguiré adelantando las unidades para poder tener una base y repasarlas en clase para verificar qué hice mal y qué no, de esa forma entendiendo bien todo