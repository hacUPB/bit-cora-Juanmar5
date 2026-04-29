## **Actividad 1 – Orientación y primer vistazo al entorno gráfico**

En esta primera actividad lo que hice fue descargar el proyecto del triángulo simple desde el repositorio y abrirlo en Visual Studio. Exploré la estructura del proyecto, especialmente el archivo `.cpp`, para tener una idea general de cómo está organizado el código, aunque todavía no entendiera todo en detalle.

Después compilé y ejecuté el programa, y pude ver el triángulo en pantalla funcionando correctamente. Esto me ayudó a confirmar que el entorno está bien configurado y que el proyecto corre sin problemas.

Al observar el código por encima, me di cuenta de que hay muchas cosas que todavía no entiendo completamente, pero sí pude notar que hay partes importantes como la creación de la ventana, el uso de OpenGL y algunas funciones relacionadas con dibujar el triángulo.

A partir de esto, me surgieron varias preguntas que me gustaría investigar más adelante:

* ¿Cómo exactamente se dibuja el triángulo en pantalla? ¿Qué instrucciones hacen que aparezca?
* ¿Qué son los shaders y por qué son necesarios para mostrar algo?
* ¿Cómo se comunican los datos desde el código en C++ hasta la GPU?

En general, esta actividad me sirvió para familiarizarme con el entorno y empezar a ver cómo se ve un proyecto real de OpenGL, aunque todavía no entienda todos los detalles.

---

## **Actividad 2 – ¿Cómo se crea un proyecto OpenGL en Windows?**

En esta actividad entendí qué se necesita para crear un proyecto de OpenGL desde cero en Windows y cómo se conectan todas las partes.

Primero, hay que crear un proyecto vacío en C++ en Visual Studio. Luego, se deben agregar varias librerías que cumplen funciones diferentes. Para organizarlas, se crea una carpeta llamada `external`, donde se guardan dependencias como GLFW, GLAD y GLM.

Cada una tiene un rol específico:

* **GLFW** se encarga de crear la ventana, manejar el teclado y el mouse, y además crear el contexto de OpenGL.
* **opengl32.lib** es una librería de Windows que permite iniciar OpenGL, pero solo tiene funciones básicas (hasta la versión 1.1).
* **GLAD** sirve para cargar las funciones modernas de OpenGL (como las de versión 3.3 o 4.6), ya que estas no vienen directamente en Windows sino en los drivers de la tarjeta gráfica.
* **GLM** es una librería de matemáticas que ayuda con vectores y matrices, aunque no es obligatoria.

También entendí que hay dos tipos importantes de archivos en este proceso:

* Los `.lib`, que se usan cuando el programa se compila (le dicen al compilador qué funciones existen).
* Los `.dll`, que se usan cuando el programa se ejecuta (contienen el código real que se necesita para que funcione).

Por ejemplo, en el caso de GLFW, si no se incluye el archivo `glfw3.dll` en la carpeta del ejecutable, el programa no va a correr aunque compile bien.

En resumen, todo funciona así:

1. GLFW crea la ventana y el contexto de OpenGL.
2. opengl32.lib permite iniciar OpenGL en el sistema.
3. GLAD carga las funciones modernas desde los drivers de la GPU.
4. GLM ayuda con cálculos matemáticos si se necesita.

Lo importante que entendí es que OpenGL no funciona solo, sino que necesita todas estas herramientas trabajando juntas. Además, este proceso de configuración es similar al de otros proyectos con librerías externas, así que aprender esto también sirve para otros casos, no solo para OpenGL.
