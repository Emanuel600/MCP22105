#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Uma cadeia de caracteres (string) é definida como um 
# conjunto de bytes, ordenados de forma consecutiva na 
# memória, terminada por um caractere nulo (byte 0). Faça 
# um programa que receba o endereço do início de uma string 
# e calcule o seu tamanho (número de caracteres). O 
# endereço da string é armazenado no endereço 0x10010000. 
# Armazene o resultado no endereço de memória 0x10010004.
#
#########################################################

# Pseudo-código
#
# char* a= (0x0) => Endereço do caractere inicial da string
# n= 0			 => Número de caracteres na string
#
# while (*a != '\0'){
#   a++
#   n++
# }
# *(0x4)= n		=> Carrega valor de n no endereço 0x...4
# ====================================================== #
# Carrega endereço inicial
lui  $t0, 0x1001
# Inicializa variáveis nos registradores
lw   $t1, 0($t0) # => Endereço do primeiro byte
move $t2, $0     # => Inicializa n
# Loop
W0:
  lb   $t3, 0($t1)   # => Carrega o byte armazenado no atual t1
  beq  $t3, $0, exit # => Termina loop quando t3='\0'
  addi $t1, $t1, 1	 # => a++
  addi $t2, $t2, 1	 # => n++
  j    W0			 # => Retorna ao início do loop
exit:
  sw   $t2, 4($t0)   # => Armazena resultado
  
  ori  $v0, $0, 10
  syscall


