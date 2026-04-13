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