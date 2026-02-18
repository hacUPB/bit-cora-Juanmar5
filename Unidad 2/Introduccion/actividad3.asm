@xPos
M=0            // posición actual

@prevX
M=0            // posición anterior


(LOOP)
@xPos
D=M
@prevX
M=D

// ESPERAR TECLA
(WAIT_KEY)
@KBD
D=M
@WAIT_KEY
D;JEQ

// PROCESAR TECLA
@KBD
D=M
@100           // 'd'
D=D-A
@MOVE_RIGHT
D;JEQ

@KBD
D=M
@105           // 'i'
D=D-A
@MOVE_LEFT
D;JEQ

@AFTER_MOVE
0;JMP

// MOVER DERECHA
(MOVE_RIGHT)
@xPos
D=M
@31
D=D-A
@AFTER_MOVE
D;JEQ

@xPos
M=M+1
@AFTER_MOVE
0;JMP

// MOVER IZQUIERDA
(MOVE_LEFT)
@xPos
D=M
@AFTER_MOVE
D;JEQ

@xPos
M=M-1

(AFTER_MOVE)

//BORRAR
@SCREEN
D=A
@prevX
D=D+M
A=D
M=0

//DIBUJAR
@SCREEN
D=A
@xPos
D=D+M
A=D
M=-1

//ESPERAR
(RELEASE)
@KBD
D=M
@RELEASE
D;JNE

@LOOP
0;JMP