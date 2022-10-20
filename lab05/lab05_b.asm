#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: 
#########################################################

#########################################################
# Um número é dito quadrado perfeito, se puder ser escrito 
# como o quadrado de um número natural (Ex. 1, 4, 9, 16, 25). 
# É possível (embora não muito prático) calcular o quadrado 
# perfeito de um número natural de forma recursiva, conforme 
# o algoritmo abaixo:
#
# int q_perfeito(int n){ 
#     if(n == 0) {
#         return n; 
#     } else {
#         return q_perfeito(n-1) + 2*n - 1; 
#     }
# }
#
# Implemente a função do quadrado perfeito apresentada acima, 
# e faça um programa que irá apresentar os valores do quadrado 
# perfeito dos primeiros 10 números naturais. Utilize as chamadas 
# de sistema para a entrada e saída de dados. O código deve ser 
# implementado seguindo a convenção de chamada de procedimento 
# estudada em sala de aula.
#########################################################

q_perfeito:
	beqz $a0, q_return
	
	addi $sp, $sp, -8
	sw   $a0, 8($sp)
	sw   $ra, 4($sp)
	
	sll  $v0, $a0, 1  # n = 2n
	addi $v0, $t0, -1 # n = n-1
	
	addi $a0, $a0, -1
	jal  q_perfeito
	
	add  $v0, $v0, $a0
	
	# Como pilha nao e criada se (n == 0)
	lw   $ra, 4($sp)
	addi $sp, $sp, 8

q_return:
	jr $ra