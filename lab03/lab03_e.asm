#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa que leia 3 notas dos endereços 
# 0x10010000, 0x10010004 e 0x10010008 e, sabendo que a 
# média é 7, armazene 1 no endereço 0x1001000C caso ele 
# esteja aprovado ou no endereço 0x10010010 caso ele 
# esteja reprovado.
#
#########################################################

# Carrega endereço inicial
lui  $t0, 0x1001
# Carrega a soma dos valores no registrador t1
lw   $t1, 0($t0)
lw   $t2, 4($t0)
add  $t1, $t1, $t2
lw   $t2, 8($t0)
add  $t1, $t1, $t2
# Salva média dos valores no registrador t1
div  $t1, $t1,  3 # Não torna o programa mais eficiente utilisar mais um registrador aqui
# Se média < 7 é falso, média >= 7
slti $t1, $t1, 7

beq  $t1, $0, aprovado
addi $t0, $t0, 0x4		# Como passa por "aprovado" de qualquer forma, endereço final é 0x(4+c) = 0x10
aprovado:
  li   $t1, 1			# Quando aprovado, t1 estaria em 0
  sw   $t1, 12($t0)