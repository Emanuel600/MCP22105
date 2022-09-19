#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa que leia o conteúdo da posição de 
# memória 0x10010000 e armazene-a na posição 0x10010004 
# se ela for positiva, ou 0x10010008 se for negativa.
#
#########################################################
lui  $t0, 0x1001
lw   $t1, 0($t0)

bgt  $t1, $0, store
addi $t0, $t0, 4

store:
  sw   $t1, 4($t0)
