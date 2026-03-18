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

- Cuando uno hace click, se crea una partícula que sale desde la parte de abajo de la pantalla y sube. Conforme sube, se le va acabando el tiempo de vida y explota.

- Cuando explota, el programa crea muchas partículas nuevas que salen en distintas direcciones. Por ejemplo una hace círculos, otra sale en direcciones aleatorias y otra hace forma de estrella.

- Todo esto funciona porque todas las clases heredan de una clase base llamada Particle. Esa clase define métodos como update() y draw(), pero no los implementa, sino que cada subclase los define a su manera.

- En el update() del programa, se recorren todas las partículas y se actualizan. Si una partícula debe explotar, entonces se eliminan y se crean nuevas partículas de explosión en su posición. También se eliminan las partículas cuando ya no sirven, usando delete, para evitar problemas de memoria.

- En el draw(), simplemente se recorren todas las partículas y se dibujan. No importa si son de tipo círculo, estrella o random, porque cada una ya tiene su propio método draw().


# **Actividad 3:**

Antes de ejecutar el programa, esperaba ver en memoria un objeto de tipo ofApp con sus métodos y el vector particles. Pensaba que el depurador iba a mostrar los valores de las variables y tal vez direcciones de memoria.

Al ejecutar y ver el objeto en el depurador, se puede observar que aparece el vector particles, que guarda punteros a objetos Particle. También se ven direcciones de memoria, lo que indica que los objetos realmente están guardados en memoria mientras el programa corre. El depurador permite ver el contenido de las variables y cómo cambian en tiempo real. Con esto se concluye que un objeto sí es un espacio en memoria que contiene sus atributos.

Luego, al inspeccionar un objeto de tipo CircularExplosion, se puede ver que en memoria no solo está esa clase, sino también todo lo que hereda: primero Particle, luego ExplosionParticle y finalmente CircularExplosion. El depurador muestra atributos como posición, velocidad, color, edad y tamaño. Esto demuestra que un objeto contiene toda la información de su jerarquía de herencia.

También se observa que el objeto está compuesto de varias partes organizadas en memoria, y que cada atributo ocupa un espacio específico. Esto ayuda a entender mejor cómo funcionan los objetos internamente.

Al revisar la _vtable, se observa que es una tabla de funciones virtuales. Contiene direcciones a funciones como update(), draw() y isDead(). En el caso de CircularExplosion y StarExplosion, las tablas son parecidas pero no iguales, porque cada clase implementa sus propios métodos.

Comparando ambas tablas, se nota que algunas funciones apuntan a implementaciones diferentes dependiendo de la clase. Esto indica que la _vtable permite que el programa sepa qué función ejecutar según el tipo real del objeto.

Se concluye que la tabla de funciones virtuales sirve para implementar el polimorfismo. Gracias a esto, cuando se llama un método como draw() desde un puntero a Particle, el programa ejecuta la versión correcta dependiendo de si es CircularExplosion, RandomExplosion o StarExplosion.

Esto es similar al ejemplo de interfaces en C#, donde se llama el mismo método pero cada objeto responde diferente. La _vtable es lo que permite que el programa sepa qué función usar en cada caso, sin importar que todos se manejen como el mismo tipo base.


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
