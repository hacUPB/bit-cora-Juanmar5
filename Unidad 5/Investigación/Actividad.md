# **Actividad 1:**

### **Parte 1: recordando los conceptos (en C#)**

Responde con tus propias palabras:

1. ¿Qué es el encapsulamiento para ti?
- Es cuando se agrupan métodos y atributos dentro de una clase desde donde solo se puede acceder por una herencia de la clase o subclase para establecer y modificar sus valores. Si la variable no pertenece a esa clase no puede utilizar esas cosas. Me ha servido para no permitir que un rectángulo tome el radio de un círculo como atributo.
2. ¿Qué es la herencia?
- Es cuando ya una variable que pertenece a la clase o subclase hereda sus métodos y atributos como valores, sirve principalmente para ahorrarse el tiempo de reescribir constantemente los mismos atributos con distintos valores repetidamente para 4 variables que hacen lo mismo, sino solo usar una e ir de ahí (como escribir NPCs)
3. ¿Qué es el polimorfismo?
- Significa que tenga atributos y métodos que hereda una subclase de la clase principal, pero solo algunos, no todos
- (Ejemplo: Personaje (nombre, altura, magia, ataque) -> Chef (nombre, altura))

### **Parte 2: análisis de código (en C#)**

**Encapsulamiento:**

- Señala una línea de código que sea un ejemplo claro de encapsulamiento y explica por qué lo es.
```c++
public abstract class Figura{    
		private string nombre;
    public string Nombre {        
		    get { return nombre;}
		    protected set { nombre = value; }    
		    }
    public Figura(string nombre)    {        
		    this.Nombre = nombre;    
		    }
    public abstract void Dibujar();
    }
```
    - Este porque aquí ya está preparando la clase padre o main con la declaración y constructores de Nombre, Figura y el método Dibujar
- ¿Por qué crees que el campo nombre es private pero la propiedad Nombre es public? ¿Qué problema se evita con esto?
    - Es para que nombre como private al agarrarse por objetos fuera de la clase principal no se pueda modificar sino solo leer, mientras que solo sus subclases puedan tomarlo para sí mismos y modificarlo



**Herencia:**

- ¿Cómo se evidencia la herencia en la clase Circulo?
    - Empezando porque se declara como subclase en ```public class Circulo : Figura``` por lo cual ya cuenta con un nombre como atributo, seguido de que hereda el método de Dibujar y lo sobreescribe a su modo
- Un objeto de tipo Circulo, además de Radio, ¿Qué otros datos almacena en su interior gracias a la herencia?
    - El atributo nombre y el método Dibujar

**Polimorfismo:**

- Observa el bucle `foreach`. La variable `fig` es de tipo Figura, pero a veces contiene un Circulo y otras un Rectangulo. Cuando se llama a `fig.Dibujar()`, el programa ejecuta la versión correcta. En tu opinión, ¿Cómo crees que funciona esto “por debajo”? No necesitas saber la respuesta correcta, solo quiero que intentes razonar cómo podría ser.
    - Funciona porque Figura es la main class, Rectángulo y Círculo son subclases, pero siguen contando como Figura. Entonces al llamar a fig, estás llamando a todo lo que sea Figura, lo que incluye los 3 hijos.

### **Parte 3: hipótesis sobre la implementación**

Esta es la parte más importante. Imagina que eres un diseñador de lenguajes de programación. Tienes que decidir cómo implementar estos conceptos en la memoria y en el procesador. No hay respuestas incorrectas, solo ideas. Dibuja si te ayuda.

1. Memoria y herencia: cuando creas un objeto Rectangulo, este tiene Base, Altura y también Nombre. ¿Cómo te imaginas que se organizan esos tres datos en la memoria del computador para formar un solo objeto?
- Supondría yo que cada atributo está en las variables globales y estáticas mientras que su instancia dependería de si están declarados como new (en el Heap) o no (en el Stack)
2. El mecanismo del polimorfismo: pensemos de nuevo en la llamada fig.Dibujar(). El compilador solo sabe que fig es una Figura. ¿Cómo decide el programa, mientras se está ejecutando, si debe llamar al Dibujar del Circulo o al del Rectangulo? Lanza algunas ideas o hipótesis.
- Creería que una vez ya sabe que es una figura y llama a Dibujar, al haberse sobreescrito el método por la clase correspondiente, ejecuta lo que tiene en ese momento escrito como acción
3. La barrera del encapsulamiento: ¿Cómo crees que el compilador logra que no puedas acceder a un miembro private desde fuera de la clase? ¿Es algo que se revisa cuando escribes el código, o es una protección que existe mientras el programa se ejecuta? ¿Por qué piensas eso?
- Supongo que lo ignora si sabe que está en la dirección de memoria (traducción de clase) incorrecta


# **Actividad 2:**

- Cuando uno hace click, se crea una partícula que sale desde la parte de abajo de la pantalla y sube. Conforme sube, se prepara para explotar

- Cuando explota, el programa crea muchas partículas nuevas que salen en distintas direcciones. Por ejemplo una hace círculos, otra sale en direcciones aleatorias y otra hace forma de estrella

- Funciona porque las subclases heredan de una clase base Particle que define métodos como update() y draw(), pero cada subclase lo va sobreescribiendo

- En el update() del programa, se recorren todas las partículas y se actualizan, se van declarando como vector2 al estar en xy. Si una partícula debe explotar, entonces se elimina y se crean nuevas partículas de explosión en su posición. También se eliminan las partículas cuando ya no sirven, usando delete, para evitar problemas de memoria, ya que están en el heap por usar el new

- En el draw(), simplemente se recorren todas las partículas y se dibujan. No importa si son de tipo círculo, estrella o random, porque cada una ya tiene su propio método draw()

![alt text](<A2 Ejemplo.png>)

# **Actividad 3:**

1. Hipótesis antes de ejecutar
- Antes de correrlo esperaba ver que el objeto ofApp guardara principalmente el vector particles, porque ese es el atributo más importante de la clase. También esperaba que en memoria se viera una referencia a ofBaseApp por la herencia.

2. Observación en memoria
- Al ejecutar con el depurador sí se puede ver que el objeto tiene dentro el vector particles, y dentro de ese vector aparecen punteros a objetos de tipo Particle.

- En mi caso capturé uno de los elementos del vector y el depurador mostró:

```
__vfptr
update
draw
isDead
shouldExplode
getPosition
getColor
```

- Esto significa que el objeto en memoria no solo guarda sus datos, sino también una referencia interna a la tabla de funciones virtuales.

3. Conclusión

- Concluyo que un objeto en C++ sí se organiza como una estructura real en memoria.
- El depurador deja ver que además de los datos normales también existe un puntero oculto (__vfptr) que conecta con los métodos virtuales.

- Esto me ayudó a entender que una clase no es solo “código”, sino que la instancia realmente ocupa memoria con datos y referencias a funciones.

- Captura de un objeto tipo CircularExplosion

- Aunque en mi prueba inicialmente capturé una RisingParticle, el comportamiento observado ayuda a entender cómo se vería CircularExplosion.

4. Qué esperaría ver

- Por la jerarquía:

```
Particle
   ↓
ExplosionParticle
   ↓
CircularExplosion
```

- esperaría ver en memoria:

    - primero la parte heredada de Particle
    - luego los atributos de ExplosionParticle
    - finalmente la parte propia de CircularExplosion

    - como:
```
position
velocity
color
age
lifetime
size
```

5. Qué se puede concluir

- Esto me hace pensar que la herencia en memoria se implementa como bloques consecutivos.

- O sea, el objeto hijo primero guarda internamente la parte del padre, luego la del abuelo, y así hasta agregar sus propios datos.

6. Tabla virtual (_vtable)


![alt text](<Screenshot 2026-04-06 112421.png>)
Aquí apareció

__vfptr

y debajo estaban listadas las funciones:

```
RisingParticle::update
RisingParticle::draw
RisingParticle::isDead
RisingParticle::shouldExplode
RisingParticle::getPosition
RisingParticle::getColor
``` 

7. Qué observo

- Lo que observo es que la tabla tiene las direcciones exactas de las funciones que pertenecen al tipo real del objeto.

- O sea, aunque el vector sea de Particle*, el puntero virtual sabe que realmente es un RisingParticle.

8. Relación con polimorfismo

- Creo que esto es exactamente lo que hace posible el polimorfismo.

Cuando el programa llama:
```
particles[i]->draw();
```
no mira solo el tipo Particle, sino que revisa el __vfptr, entra a la tabla virtual y llama la versión correcta de draw() según el objeto real.

- Por eso funciona igual que el ejemplo de IAnimal:


```
si es perro → llama Perro.HacerSonido()
si es gato → llama Gato.HacerSonido()
```

```
si es CircularExplosion → llama su draw()
si es StarExplosion → llama su draw()
```

9. Conclusión final

- Concluyo que la _vtable sirve para que el programa decida en tiempo de ejecución qué método ejecutar según el tipo real del objeto.

- Eso conecta directamente con métodos virtuales y polimorfismo, porque permite que una misma referencia (Particle*) actúe diferente dependiendo del objeto al que apunta.


### **Actividad 4**

Al ejecutar el primer código, solo funciona la línea de `publicVar`. Cuando se descomentan las otras líneas (`protectedVar` y `privateVar`), el programa da errores de compilación. Esto pasa porque esas variables no son accesibles desde `main`, ya que tienen restricciones de acceso (`protected` y `private`).

Se concluye que el encapsulamiento en C++ controla desde dónde se pueden usar las variables, y esto se verifica en tiempo de compilación.

En el segundo programa, al intentar acceder directamente a `secret1`, el código no compila. Esto ocurre porque `secret1` es privado, entonces no se puede acceder desde fuera de la clase.

En el tercer programa, el código sí compila y se ejecuta. Usando `reinterpret_cast`, se accede directamente a la memoria del objeto y se logran leer los valores de `secret1`, `secret2` y `secret3`, aunque sean privados.

Esto demuestra que el encapsulamiento no es una protección absoluta en memoria, sino una restricción a nivel de lenguaje. Es decir, el compilador evita el acceso directo, pero en tiempo de ejecución sí es posible acceder si se manipula la memoria.

En mis palabras, el encapsulamiento es la forma de ocultar los datos internos de un objeto y controlar cómo se accede a ellos. Es importante porque protege la información, evita errores y hace que el código sea más organizado y seguro.


### **Actividad 5**

Al observar en el depurador un objeto de tipo `CircularExplosion`, se puede ver que en memoria aparecen primero los datos de la clase base `Particle`, luego los de `ExplosionParticle` y finalmente los de `CircularExplosion`. Es decir, el objeto contiene toda la información de su jerarquía de herencia organizada en bloques.

El depurador muestra atributos como posición, velocidad, color, edad, lifetime y tamaño. También se ve la `_vtable`, lo que indica que hay funciones virtuales. Esto permite entender que un objeto no solo guarda sus propios datos, sino también todo lo que hereda.

Se concluye que la herencia en memoria se implementa como una extensión de la clase base, donde las clases derivadas agregan más datos al final del objeto.

La herencia en C++ se implementa usando `:` después del nombre de la clase, por ejemplo:

```cpp
class Hija : public Padre {};
```

Esto indica que la clase hija hereda los atributos y métodos de la clase padre, dependiendo del tipo de acceso (`public`, `protected` o `private`).

Para el caso de herencia múltiple, C++ permite que una clase herede de varias clases al mismo tiempo, por ejemplo:

```cpp
class A { public: int a; };
class B { public: int b; };
class C : public A, public B { public: int c; };
```

Al analizar un objeto de este tipo en memoria, se puede observar que contiene primero los datos de una clase base, luego los de la otra, y finalmente los propios. Es decir, el objeto se construye combinando las partes de todas las clases base.

Se concluye que la herencia múltiple hace que un objeto tenga múltiples bloques de memoria correspondientes a cada clase base, lo que puede hacerlo más complejo pero también más flexible.
