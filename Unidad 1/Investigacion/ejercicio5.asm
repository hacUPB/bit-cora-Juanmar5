@5
D=A
@i
M=D

@12
M=0

(LOOP)
@i
D=M
@END
D;JEQ

@12
M=M+1

@i
M=M-1
@LOOP
0;JMP

(END)
@END
0;JMP
