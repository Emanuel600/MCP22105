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

######################################
# res = a + b + c
add $t4, $t0, $t1  # res= a + b
add $t4, $t4, $t2  # res= res + c

######################################
# res = a - b - c
sub $t4, $t0, $t1  # res= a - b
sub $t4, $t4, $t2  # res= res - c

######################################
# res = a * b - c
mul $t4, $t0, $t1  # res= a * b
sub $t4, $t4, $t2  # res= res - c

######################################
# res = a * (b + c)
add $t4, $t1, $t2  # res= b + c
mul $t4, $t0, $t4  # res= a * res

######################################
# res = a + (b - 5)
addi $t4, $t1, -5  # res= b - 5
add $t4, $t4, $t0  # res= res + a

######################################
# res = ((b % 2) == 0)
addi $t4, $0, 2
div $t1, $t4	 # hi= b % 2
mfhi $t4	 # res= hi

seq $t4, $t4, $0 # res= ((b%2)==0)

######################################
# res = (a < b) && (((a+b) % 3) == 10)


######################################
# res = (a >= b) && (c != d)


######################################
# res = (((a/2)+1) > b) || (d == (b-a))







