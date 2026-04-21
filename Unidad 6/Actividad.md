# **Unidad 6**
### **Actividad 1**

1. ¿Cómo puedes interactuar con la aplicación? Menciona específicamente las teclas y qué efecto parecen tener sobre las partículas.
     - S: Stop, para todos los movimientos de las partículas
     - A: Attract, atraen todas las partículas hacia donde apunte el cursor
     - R: Repel, las repele de donde mire el cursor
     - N: Normal, las dispara en direcciones aleatorias para que choquen contra cualquier bound del cuadrado
2. ¿Observas los diferentes tipos de “partículas”? ¿Se comportan todas igual inicialmente?
    - No, mientras estas estén en default irá igual que con normal (salvo algunas partículas siendo más rápidas) por lo cual todas tienen un comportamiento completamente distinto, solo durante attract y repel siguen una tendencia que aún así varía según su distancia hacia el mouse
3. Toma algunas capturas de pantalla de la aplicación en diferentes momentos (estado inicial, después de presionar ‘a’, ‘r’, ‘s’, ‘n’) y añádelas a tu bitácora.
    - Normal![alt text](<Screenshot 2026-04-13 112632.png>)
    - Attract![alt text](<Screenshot 2026-04-13 112639.png>)
    - Repel![alt text](<Screenshot 2026-04-13 113624.png>)
    - Stop ![alt text](<Screenshot 2026-04-13 113639.png>)
4. ¿Qué crees que está pasando “detrás de cámaras” cuando presionas las teclas? Formula una hipótesis inicial sobre cómo la aplicación cambia el comportamiento de las partículas.
    - Se llama a la función de las partículas instanciadas para que cambien su comportamiento según el estado en el que esté

### **Actividad 2**

1. Identificación de roles

* Interfaz `Observer`:
  La clase que actúa como interfaz es `Observer`.
  Define el método:

  ```cpp
  virtual void onNotify(const std::string & event) = 0;
  ```

  Este método es el que se ejecuta cuando el sujeto manda una notificación.


* Clase `Subject`:
  La clase `Subject` es la que maneja a los observadores.
  Tiene estos métodos:

  - `addObserver()` → para agregar observadores
  - `removeObserver()` → para eliminarlos
  - `notify()` → para avisarles cuando pasa algo


* ConcreteSubject:
  El `ConcreteSubject` en este caso es `ofApp`, porque es quien realmente envía las notificaciones.

  Por ejemplo, cuando se presiona una tecla, `ofApp` llama a `notify()` y ahí es donde se dispara todo.


* ConcreteObserver:
  La clase `Particle` es el `ConcreteObserver`, porque:

  * Implementa `onNotify()`
  * Recibe los eventos
  * Reacciona cambiando su estado (Attract, Repel, etc.)


2. Flujo de notificación

* Cuando presiono la tecla ‘a’:
  En `keyPressed` pasa esto:

  ```cpp
  notify("attract");
  ```

  O sea, se manda un evento a todos los observadores.


* Método `notify` en `Subject`:
  Este método recorre todos los observadores y les avisa:

  ```cpp
  for (Observer * observer : observers) {
      observer->onNotify(event);
  }
  ```

  Básicamente, llama a `onNotify` en cada partícula.


* Método `onNotify` en `Particle`:
  Cuando recibe `"attract"`:

  ```cpp
  setState(new AttractState());
  ```

  O sea, cambia su estado a uno donde se mueve hacia el mouse.


3. Registro y eliminación de observadores

* Dónde se agregan como observadores:
  En el método `setup()` de `ofApp`, por ejemplo:

  ```cpp
  Particle * p = ParticleFactory::createParticle("star");
  particles.push_back(p);
  addObserver(p);
  ```

  Ahí cada partícula se registra como observador.


* Dónde se eliminarían:
  En el destructor de `ofApp`:

  ```cpp
  removeObserver(p);
  delete p;
  ```


* Por qué es importante el destructor:
  Porque evita problemas de memoria y referencias inválidas.
  Si no se eliminan los observadores, el `Subject` podría intentar notificar a objetos que ya no existen, lo cual puede causar errores o crashes.

1. ¿Cuál es el propósito del patrón Observer?

El patrón Observer sirve para que varios objetos puedan estar pendientes de otro objeto sin que estén directamente acoplados entre sí. Es decir, un objeto principal (el sujeto) puede avisar a otros objetos (observadores) cuando pasa algo, sin necesidad de saber exactamente qué hacen ellos internamente.

En este caso, el problema que resuelve es evitar tener que actualizar manualmente cada partícula desde el `ofApp`. En vez de eso, el `ofApp` simplemente manda un mensaje (como “attract” o “repel”) y todas las partículas reaccionan solas y eso da una comunicación más organizada y flexible entre los objetos.

2. Relación

![alt text](<Screenshot 2026-04-20 110958.png>)

**Representación simple:**

```
ofApp (Subject)
   ↓ notify()
Particle (Observer)
Particle (Observer)
Particle (Observer)
...
```

3. Diagrama de secuencia (cuando presiono una tecla)

    1. El usuario presiona una tecla (por ejemplo, ‘a’).
    2. Se ejecuta `keyPressed` en `ofApp`.
    3. `ofApp` llama a `notify("attract")`.
    4. `notify` recorre todas las partículas registradas.
    5. A cada partícula se le llama `onNotify("attract")`.
    6. Cada partícula cambia su estado a `AttractState`.
    7. En el siguiente `update`, las partículas empiezan a moverse hacia el mouse.

![alt text](<Screenshot 2026-04-20 113847.png>)

4. Ventajas de usar Observer en este caso

Usar este patrón tiene varias ventajas frente a hacerlo “a lo bruto” desde `ofApp`:

- Menor acoplamiento:
    - `ofApp` no necesita saber cómo funciona cada partícula, solo manda el mensaje.

- Más fácil de escalar:**
    - Si agrego nuevos tipos de partículas, no tengo que cambiar `ofApp`, solo cómo reaccionan ellas.

- Código más limpio:**
    - Evita tener un montón de `if` dentro de `ofApp::update`.

- Más flexible:**
    - Se pueden agregar o quitar observadores dinámicamente sin romper el sistema.

Si en vez de esto `ofApp` controlara directamente todo, el código sería más rígido y difícil de mantener, especialmente si el proyecto crece.


# **Actividad 3 – Investigación del patrón Factory Method**

**Nombre del estudiante:** Juan Martín Molina Ramírez

## **1. Propósito del patrón Factory Method**

En mis propias palabras, el patrón **Factory Method** sirve para **centralizar la creación de objetos en un solo lugar**, evitando que el código cliente tenga que preocuparse por los detalles específicos de construcción y configuración.

El problema principal que resuelve es que, cuando una aplicación necesita crear muchos objetos de distintos tipos, el código puede llenarse de instrucciones como:

```cpp
new Particle()
```

seguidas de múltiples líneas para configurar propiedades.

Eso hace que el código sea más difícil de leer, mantener y extender.

Con una fábrica, en cambio, el cliente solo pide:

```cpp
ParticleFactory::createParticle("star")
```

y recibe el objeto ya listo para usar.

Me parece una solución muy útil porque **desacopla el proceso de creación del proceso de uso del objeto**.

---

## **2. Identificación de la Factory**

### **Clase Factory**

La clase que actúa como fábrica en este ejemplo es:

```cpp
ParticleFactory
```

---

### **Método factory**

El método específico es:

```cpp
createParticle()
```

En este caso es un **método estático**, porque se llama directamente desde la clase sin necesidad de crear una instancia.

Por ejemplo:

```cpp
ParticleFactory::createParticle("planet")
```

---

### **Tipo de objeto que devuelve**

Este método devuelve un objeto del tipo:

```cpp
Particle*
```

es decir, un puntero a una partícula ya creada y configurada.

---

## **3. Proceso de creación**

### **Cómo decide qué partícula crear**

Dentro de `ParticleFactory::createParticle`, el método revisa el tipo recibido como parámetro.

La lógica suele funcionar con condicionales:

```cpp
if(type == "star")
```

o varios `if / else`.

Dependiendo del texto recibido, crea una partícula y le asigna propiedades diferentes.

Por ejemplo:

* `"star"` → tamaño pequeño, color blanco, velocidad media
* `"shooting_star"` → velocidad alta
* `"planet"` → tamaño grande y movimiento lento

---

### **Información que necesita**

La fábrica necesita principalmente el **tipo de partícula**, normalmente como un `string`.

Ese valor le permite decidir qué configuración aplicar.

---

### **Qué pasa si recibe un tipo desconocido**

Si recibe un tipo no válido, lo más probable es que retorne:

```cpp
nullptr
```

o una partícula por defecto.

Pienso que esto podría mejorarse usando:

* una partícula genérica por defecto
* manejo de errores
* un `enum` en vez de `string`
* excepciones o mensajes de depuración

Esto evitaría errores silenciosos.

---

## **4. Uso de la Factory en `ofApp::setup`**

En `ofApp::setup`, la fábrica se usa para llenar el vector `particles`.

La lógica se vería más o menos así:

```cpp
particles.push_back(ParticleFactory::createParticle("star"));
```

Cada llamada crea una partícula distinta sin necesidad de configurar manualmente sus propiedades.

Esto hace que `setup()` sea mucho más limpio.

---

## **5. Comparación sin usar Factory**

Si no se utilizara la fábrica, `ofApp::setup` tendría que hacer todo manualmente.

Se vería algo así:

```cpp
Particle* p = new Particle();
p->size = 10;
p->color = ofColor::white;
p->velocity = ofVec2f(2, 1);
particles.push_back(p);
```

Y esto tendría que repetirse para cada tipo.

Si hubiera muchas partículas, el método crecería demasiado y mezclaría dos responsabilidades:

* inicializar la app
* definir cómo se construye cada tipo de partícula

Por eso la fábrica mejora mucho la organización.

---

# **6. Ventajas de `ParticleFactory` en `ofApp::setup`**

## **Mejor organización del código**

La creación queda separada de la lógica de inicialización.

`ofApp::setup` solo decide **qué necesita**, no cómo construirlo.

Esto respeta el principio **SRP (Single Responsibility Principle)**.

---

## **Mayor legibilidad**

El código es más corto y fácil de entender.

Leer:

```cpp
createParticle("planet")
```

es mucho más claro que varias líneas configurando propiedades.

---

## **Facilidad para añadir nuevos tipos**

Si quiero agregar nuevas partículas, solo modifico la fábrica.

El resto del código permanece igual.

Esto mejora muchísimo la mantenibilidad.

---

# **7. Nuevo tipo: `"black_hole"`**

Si quisiera añadir un nuevo tipo llamado `"black_hole"`, seguiría estos pasos:

## **Paso 1: agregar el caso en la fábrica**

Dentro de `createParticle()` agregaría una nueva condición:

```cpp
if(type == "black_hole")
```

---

## **Paso 2: configurar propiedades**

Le asignaría:

* tamaño grande
* color negro
* velocidad muy lenta

Por ejemplo:

```cpp
particle->size = 40;
particle->color = ofColor::black;
particle->velocity = ofVec2f(0.2, 0.1);
```

---

## **Paso 3: usarlo en `setup`**

Luego simplemente en `ofApp::setup` llamaría:

```cpp
particles.push_back(ParticleFactory::createParticle("black_hole"));
```

---

### **¿Tendría que modificar `setup`?**

Solo tendría que modificarlo si quiero **crear instancias de ese nuevo tipo**.

Pero la lógica interna de construcción no cambia en `setup`, porque todo eso ya está encapsulado dentro de la fábrica.

Por eso el impacto es mínimo.

---

# **8. Método estático vs instancia**

## **Ventajas de que sea estático**

Me parece útil que sea estático porque:

* no necesito crear un objeto `ParticleFactory`
* el acceso es directo
* es ideal cuando la fábrica no necesita guardar estado

Hace el uso muy simple:

```cpp
ParticleFactory::createParticle()
```

---

## **Desventajas**

La desventaja es que es menos flexible si en el futuro quisiera:

* varias fábricas distintas
* configuraciones dinámicas
* herencia de fábricas
* inyección de dependencias

En esos casos una instancia sería mejor.

---

# **Conclusión personal**

Después de analizar este patrón, entendí que el **Factory Method simplifica mucho la creación de objetos repetitivos pero con configuraciones diferentes**.

En este caso me parece excelente para manejar partículas, porque evita llenar `setup()` de detalles innecesarios y hace mucho más fácil añadir nuevos tipos visuales en el futuro.

Además, me ayudó a ver cómo los patrones no solo organizan el código, sino que también mejoran la escalabilidad del proyecto.


## **Actividad 3: Patrón Factory Method**

1.  **Identificación de la Factory**
    * **¿Qué clase actúa como factory?**: La clase `ParticleFactory`.
    * **¿Cuál es el "método factory"?**: Es el método `createParticle`. Es un **método estático**, lo que significa que no necesito crear una instancia de la fábrica para usarlo; lo llamo directamente como `ParticleFactory::createParticle()`.
    * **¿Qué devuelve?**: Devuelve un puntero a un objeto de tipo `Particle` (o más específicamente, una partícula ya configurada según el tipo).

2.  **Proceso de creación**
    * **¿Cómo decide qué crear?**: Usa un bloque `if / else if` que compara el string que le pasamos (`"star"`, `"shooting_star"`, `"planet"`) y según eso le asigna valores diferentes de tamaño, color y velocidad.
    * **¿Qué información necesita?**: Solo un `std::string` que indique el tipo.
    * **¿Qué devuelve si no conoce el tipo?**: Actualmente devuelve una `Particle` con los valores por defecto (blanca y pequeña). Una mejora sería lanzar una excepción o devolver un `nullptr` para manejar errores de tipografía.

3.  **Uso de Factory en `setup()`**
    * En el `setup`, simplemente hacemos:
        ```cpp
        Particle * p = ParticleFactory::createParticle("star");
        ```
    * **Diferencia sin Factory**: Si no la usáramos, el `setup` estaría lleno de código repetitivo. Tendríamos que hacer el `new`, configurar manualmente el color, el tamaño y la velocidad para cada grupo de partículas. El `setup` pasaría de ser una lista de "qué quiero crear" a un manual aburrido de "cómo configurar cada cosa".

### **Reporte en bitácora (Actividad 3)**

* **Propósito con mis palabras**: El Factory sirve para centralizar la creación de objetos. El problema que resuelve es que el código que *usa* los objetos (como `ofApp`) no tenga que saber *cómo* se construyen ni qué detalles técnicos tienen.
* **Ventajas**: Aporta **SRP (Responsabilidad Única)** porque `ofApp` solo se encarga de la lógica de la app y la fábrica solo de crear. Además, es mucho más legible: en el `setup` solo ves nombres de tipos de partículas en lugar de 20 líneas de configuración de colores y tamaños.
* **Caso "black_hole"**:
    1.  Iría a `ParticleFactory::createParticle`.
    2.  Añadiría un `else if (type == "black_hole")`.
    3.  Configuraría ahí mismo: `size = 15.0f`, `color = ofColor(0)`, `velocity *= 0.1f`.
    4.  **¿Modificaría `ofApp::setup`?**: Sí, pero solo para llamar a la fábrica con el nuevo string. No tengo que tocar nada de la lógica de creación.
* **Estático vs Instancia**: Al ser estático es más cómodo porque se usa como una "caja de herramientas" global. Si fuera de instancia, podría heredar de otras fábricas o guardar estados (como un contador de cuántas partículas van creadas), pero para este caso, lo estático simplifica el código.

---

## **Actividad 4: Patrón State**

1.  **Identificación de componentes**
    * **Contexto**: La clase `Particle`. Es la que "tiene" el estado y cambia según lo que pase.
    * **Interfaz State**: La clase `State`. Sus métodos clave son `update` (lógica de movimiento), `onEnter` (lo que hace la partícula apenas cambia a ese estado) y `onExit` (limpieza antes de cambiar).
    * **Clases ConcreteState**: `NormalState`, `AttractState`, `RepelState` y `StopState`. Cada una tiene una fórmula matemática distinta para mover la partícula.

2.  **Delegación y Transiciones**
    * **Delegación**: En `Particle::update()`, en lugar de preguntar "en qué estado estoy", simplemente hace `state->update(this);`. La partícula le "pasa la bola" al estado actual para que él decida qué hacer.
    * **Transiciones**: El método `setState()` se encarga de todo. Borra el estado viejo (llama a `onExit`) y pone el nuevo (llama a `onEnter`).
    * **Disparador**: El evento de `onNotify` (Observer) es el que dispara el cambio de estado cuando presionamos una tecla.

### **Reporte en bitácora (Actividad 4)**

* **Propósito con mis palabras**: El patrón State sirve para que un objeto se comporte de forma totalmente distinta según su situación interna, pero sin llenar el código de `if` o `switch` gigantes. Es súper útil cuando un objeto tiene comportamientos que excluyen a otros.
* **Diagrama de estados (mental):**
    
* **Ventajas vs `if/else`**: Si usáramos un string `estadoActual`, el método `update` de la partícula sería un caos de código difícil de leer. Con el patrón State, el código está "limpio": si quiero arreglar algo de cómo las partículas huyen del mouse, solo abro `RepelState.cpp` y no toco nada más. Cumple el **Principio Abierto/Cerrado** porque puedo crear un nuevo comportamiento creando una clase nueva sin tocar la clase `Particle`.
* **onEnter y onExit**: Sirven para preparar o limpiar el terreno. Por ejemplo, en `AttractState::onEnter`, podrías cambiar el color de la partícula a rojo para indicar que está activa, y en `onExit` devolverle su color original. En el código actual, `NormalState::onEnter` le da una velocidad aleatoria inicial.

---

## **Actividad 5: Aplicación propia**

Para esta parte, inventaremos una partícula tipo **"Ghost"** (Fantasma).

### **Reporte en bitácora (Actividad 5)**

**1. Implementación de la nueva partícula:**
* **Factory**: Modifiqué `ParticleFactory` para que acepte el tipo `"ghost"`. Estas partículas son blancas, casi transparentes (`alpha` bajo) y pequeñas.
* **Observer**: La partícula "Ghost" se registra igual que las demás. Cuando recibe la notificación `"scare"`, cambia a un estado de huida.
* **State**: Creé un nuevo estado llamado `FleeState`. Cuando el usuario presiona la tecla 'f', el `ofApp` notifica `"scare"` y los fantasmas activan este estado donde se mueven al borde más cercano para esconderse.

**Código añadido (Resumen):**
```cpp
// En ParticleFactory.cpp
else if (type == "ghost") {
    particle->color = ofColor(255, 255, 255, 100);
    particle->size = 3.0f;
}

// En Particle::onNotify
else if (event == "scare") {
    setState(new FleeState());
}

// En ofApp::keyPressed
case 'f':
    notify("scare");
    break;
```

> **Nota:** Para que esto funcione al 100%, definí la clase `FleeState` heredando de `State` y programé su `update` para que la velocidad apunte siempre lejos del centro de la pantalla.