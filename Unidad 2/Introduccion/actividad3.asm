// =====================================
// Variables
// =====================================
@xPos
M=0            // posición horizontal (0–31)

// =====================================
// LOOP PRINCIPAL
// =====================================
(LOOP)

// -------- BORRAR SEGMENTO --------
@SCREEN
D=A
@xPos
D=D+M
A=D
M=0

// -------- DIBUJAR SEGMENTO --------
@SCREEN
D=A
@xPos
D=D+M
A=D
M=-1           // 16 píxeles encendidos

// -------- ESPERAR TECLA --------
(WAIT_KEY)
@KBD
D=M
@WAIT_KEY
D;JEQ          // espera hasta que se presione algo

// -------- PROCESAR TECLA --------
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

// -------- ESPERAR SOLTAR TECLA --------
(RELEASE)
@KBD
D=M
@RELEASE
D;JNE

@LOOP
0;JMP

// =====================================
// MOVER DERECHA
// =====================================
(MOVE_RIGHT)
@xPos
D=M
@31
D=D-A
@RELEASE
D;JEQ          // no salir de pantalla

@xPos
M=M+1
@RELEASE
0;JMP

// =====================================
// MOVER IZQUIERDA
// =====================================
(MOVE_LEFT)
@xPos
D=M
@RELEASE
D;JEQ          // no ir a negativo

@xPos
M=M-1
@RELEASE
0;JMP
