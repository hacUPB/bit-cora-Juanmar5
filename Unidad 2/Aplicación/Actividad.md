# **Actividad 6**


**Bitácora**

- Implementa el programa anterior en lenguaje ensamblador aplicando el concepto de punteros.
    - Hipótesis:
    Creo que el arreglo se puede recorrer usando un puntero que apunte a la primera posición de memoria donde está almacenado.
    - Predicción:
    Si inicializo un arreglo desde la dirección 16 y uso un puntero que avance en memoria, entonces puedo recorrer el arreglo y sumar cada uno de sus elementos hasta completar 10 valores.

``` asm
@11
D=A
@16
M=D

@233
D=A
@17
M=D

@23
D=A
@18
M=D

@77
D=A
@19
M=D

@112
D=A
@20
M=D

@61
D=A
@21
M=D

@67
D=A
@22
M=D

@98
D=A
@23
M=D

@900
D=A
@24
M=D

@810
D=A
@25
M=D

@26
M=0

@27
M=0

@16
D=A
@28
M=D

(LOOP)
@27
D=M
@10
D=D-A
@END
D;JGE

@28
A=M
D=M
@26
M=M+D

@28
M=M+1

@27
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP
```

- Inicialización de variables

    - sum se inicializó en 0
    - j se inicializó en 0
    - ptr se inicializó con la dirección base del arreglo (16)

- Condición del ciclo

    - Comparo j con 10 usando una resta (j - 10).

- Acceso al arreglo con puntero


    - Valor de ptr usado como dirección para acceder al elemento actual del arreglo.

- Acumulación de la suma

    - El valor leído del arreglo se sumó a sum.
    - Construir la suma total de los elementos del arreglo.

- Actualización del puntero y contador

    - Se incrementó ptr para apuntar al siguiente elemento
    - Se incrementó j para avanzar el ciclo
    - Todo pues para recorrer secuencialmente el arreglo.

- Al implementar el arreglo en ensamblador Hack se observa que un arreglo es simplemente un bloque contiguo de memoria


# **Autoevaluación**

**Mirando hacia adentro: autoevaluación de conceptos y proceso**

**Parte 1: recuperación de conocimiento (Retrieval Practice)**
1. Explica cómo se representa y manipula un puntero en el lenguaje ensamblador de Hack. Describe las operaciones equivalentes a `p = &a` (asignar dirección) y `*p = 20`

```
p = &a
Guardar la dirección de a en p
```

```
*p = 20
Ir a la dirección que guarda p y escribir 20 ahí
```

- En Hack:
    - Usas @p para leer la dirección.
    - Luego A=M para ir a esa dirección.
    - Con M=20 escribes el valor.

2. ¿Cómo implementarías el acceso a un elemento de un arreglo, como `arr[j]`, en lenguaje ensamblador? 


Un arreglo empieza en una dirección base
arr → dirección inicial
j → desplazamiento
Para arr[j]:
Tomas la dirección base
Le sumas j
Lees o escribes en esa dirección

**Parte 2: reflexión sobre tu proceso (Metacognición)**
1. ¿Cuál fue el concepto más abstracto o difícil de “traducir” de C++ a ensamblador en esta unidad (punteros, ciclos, arreglos)? ¿Qué hiciste para lograr entenderlo?

Que no era un valor sino una dirección

2. En la Actividad 06 se sugirió construir el programa “PASO A PASO mediante pruebas”. ¿Cómo te ayudó este enfoque a manejar la complejidad del problema?

francamente me acomplejó un poco más entender todo lo que hacía por el poco tiempo que tuve para hacerlo, pero ayudó a entenderlo como tal

3. Esta unidad fue el “puente” hacia C++. ¿Qué concepto de bajo nivel te sientes más seguro de poder identificar cuando lo veas implementado en C++?

Seguramente los saltos, me hacen pensar más en las condicionales