# **Actividad 4: Dibujando un punto en la pantalla**

### Escribe en tu bitácora el programa en ensamblador y las conclusiones que has sacado de la comparación entre los dos programas.

- For en assembly
``` asm
(versión for)
@sum
M=0

@i
M=1 


(FOR_COND)
@i
D=M
@100
D=D-A 
@END
D;JGT 

@i
D=M
@sum
M=M+D   

@i
M=M+1

@FOR_COND
0;JMP

(END)
@END
0;JMP  
```
- Conlusiones
    - Al convertir las versiones while y for a ensamblador Hack, noté que ambas generan prácticamente el mismo código. En ensamblador se traducen a una combinación de inicialización de variables, evaluación de una condición mediante comparaciones, ejecución del cuerpo del ciclo y un salto condicional para repetir el proceso.

# **Actividad 5**
- Hipótesis
    - Creo que el puntero p va a guardar la dirección de la variable a y que al escribir *p = 20 se modificará el valor original de a, cambiándolo de 10 a 20, aunque no se use directamente la variable a.

- Pseudocódigo
```
crear variable a con valor 10
crear variable p
guardar en p la dirección de a
usar p para cambiar el valor de a a 20
```

- Hack [Apoyado de IA]
``` asm
@10
D=A
@a
M=D

@a
D=A
@p
M=D

@20
D=A
@p
A=M
M=D

(END)
@END
0;JMP
```


    Este ejercicio demuestra que un puntero no guarda valores, sino direcciones de memoria. Es posible modificar una variable sin referirse a ella directamente

- Código 2 a Hack
``` asm
@10
D=A
@a
M=D

@5
D=A
@b
M=D

@a
D=A
@p
M=D

@p
A=M
D=M
@b
M=D

(END)
@END
0;JMP
```

- Observación
    - a comienza con valor 10
    - b comienza con valor 5
     -p apunta a a
     -Al ejecutar b = *p, el valor de a se copia en b
    - b pasa de 5 a 10
    - a no cambia

- Reflexión final

    - En el primer programa, el puntero se usa para escribir indirectamente en memoria, modificando el valor de la variable original
    - En el segundo programa, el puntero se usa para leer indirectamente desde memoria y copiar ese valor a otra variable
    - Ambos casos muestran que el operador * permite acceder al contenido de una dirección almacenada en un puntero

