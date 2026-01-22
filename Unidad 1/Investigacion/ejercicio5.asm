@1
D=A
@i
M=D
@12
M=0

(LOOP)
@i
D=M
@6
D=D-A
@END
D;JGE

@i
D=M
@12
M=M+D

@i
M=M+1
@LOOP
0;JMP

(END)
@END
0;JMP
