#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 e, armazene o maior 
# deles na posição 0x10010008.
#
#########################################################
.data
num1: .word 1
num2: .word 2

.text
addi $v0, $0, 10
# Carrega endereço de memória inicial em t0
lui  $t0, 0x1001
# Carrega dados nos registradores t1 e t2
lw   $t1, 0($t0)
lw   $t2, 4($t0)
# Compara os valores e armazena o maior
bgt  $t1, $t2, exit
sw   $t1, 8($t0)
syscall

exit:
  sw   $t2, 8($t0)
  syscall