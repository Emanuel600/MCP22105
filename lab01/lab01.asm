#########################################################
# Laboratório 01 - MCP22105
# Expressões Aritméticas e Lógicas
#
# Aluno: Emanuel Staub Araldi
#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# a: $t0, b: $t1, c: $t2, d: $t3, res: $t4
#########################################################

# Estou assumindo que os valores de a, b, c e d não
# podem ser modificados

######################################
# res = a + b + c
add  $t4, $t0, $t1   # res= a + b
add  $t4, $t4, $t2   # res= res + c

######################################
# res = a - b - c
sub  $t4, $t0, $t1   # res= a - b
sub  $t4, $t4, $t2   # res= res - c

######################################
# res = a * b - c
mul  $t4, $t0, $t1   # res= a * b
sub  $t4, $t4, $t2   # res= res - c

######################################
# res = a * (b + c)
add  $t4, $t1, $t2   # res= b + c
mul  $t4, $t0, $t4   # res= a * res

######################################
# res = a + (b - 5)
addi $t4, $t1, -5   # res= b - 5
add  $t4, $t4, $t0  # res= res + a

######################################
# res = ((b % 2) == 0)
addi $t4, $0, 2
div  $t1, $t4	   # hi= b % 2
mfhi $t4	   # res= hi

ori  $t5, $0, 1    
sltu $t4, $t4, $t5 # se res < 1, res=0 -> res= ((b%2)==0)

######################################
# res = (a < b) && (((a+b) % 3) == 10)
add  $t4, $t0, $t1 # res= a+b

addi $t5, $0, 3
div  $t4, $t5      # hi= res % 3

addi $t5, $0, 10
mfhi $t4           # res= hi
seq  $t4, $t4, $t5 # res= (res==10)

slt  $t5, $t0, $t1 # a < b
and  $t4, $t5, $t4 # res= (a<b) & res

######################################
# res = (a >= b) && (c != d)
slt  $t4, $t0, $t1 # res= (a < b)= !(a >= b) 
xori $t4, $t4, 1   # res= !res

sne  $t5, $t2, $t3 # c != d
and  $t4, $t4, $t5 # res= (res & (c != d))

######################################
# res = (((a/2)+1) > b) || (d == (b-a))
sub  $t5, $t1, $t0 # b-a
seq  $t5, $t3, $t5 # d == b-a

sra  $t4, $t0, 1   # res= a/2
addi $t4, $t4, 1   # res= (res + 1)

sgt  $t4, $t4, $t1 # res= (res > b)

or   $t4, $t4, $t5 # res= (res | (d == (b-a)))


