# **Actividad 6 – Hola Objeto**

**1. Diferencia entre constructor y destructor en C++**
- El **constructor** se ejecuta cuando se crea el objeto y sirve para inicializar sus valores.
- El **destructor** se ejecuta cuando el objeto se elimina y sirve para liberar recursos o mostrar que el objeto ya no existe.

**2. Diferencia entre objeto y clase**
- La **clase** es como el modelo o plantilla que define cómo es algo.
- El **objeto** es una instancia real creada a partir de esa clase.

**3. Diferencia entre el objeto Punto en C++ y C#**
- En **C++** el objeto se crea directamente en la memoria (stack).
- En **C#** el objeto se crea en el **heap** usando new, y la variable guarda una referencia.

**4. Qué es p en C++ y en C#**
- En **C++**, p es el objeto mismo.
- En **C#**, p es una referencia que apunta al objeto.

**5. En qué parte de memoria se almacena p**
- En **C++**, p está en el **stack**.
- En **C#**, la referencia está en el **stack** pero el objeto está en el **heap**.

**6. Qué se observó con el depurador**
- En el depurador se puede ver la dirección de memoria del objeto y los valores de *x* y *y*. También se observan los bytes en memoria (*0a* y *14*), que en decimal son **10 y 20**, mostrando cómo se guardan los datos del objeto.

Esto muestra que un **objeto en C++ es un espacio en memoria que contiene sus variables y datos**.
