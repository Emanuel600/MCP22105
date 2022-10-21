#########################################################
# Laborat�rio 03 - MCP22105
# Procedimentos
#
# Aluno: Emanuel Staub Araldi
#########################################################
.include "macros.inc"
.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit
.include "string.inc"

main:
	# Criar stack
	addi $sp, $sp, -8
	sw   $ra, 4($sp)
	# Preparar para chamar funcao
	addi $s0, $0 , 11
main_loop:
	beqz $s0, main_return
	addi $s0, $s0, -1
	
	move $a0, $s0
	jal  q_perfeito
	move $s1, $v0
	
	print_intReg($s0)
	print_str("^2 = ")
	print_intReg($s1)
	print_str("\n")
	
	j main_loop
main_return:
	lw   $ra, 4($sp)  # Restora 
	addi $sp, $sp, 8
	jr   $ra
#########################################################
# Um n�mero � dito quadrado perfeito, se puder ser escrito 
# como o quadrado de um n�mero natural (Ex. 1, 4, 9, 16, 25). 
# � poss�vel (embora n�o muito pr�tico) calcular o quadrado 
# perfeito de um n�mero natural de forma recursiva, conforme 
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
# Implemente a fun��o do quadrado perfeito apresentada acima, 
# e fa�a um programa que ir� apresentar os valores do quadrado 
# perfeito dos primeiros 10 n�meros naturais. Utilize as chamadas 
# de sistema para a entrada e sa�da de dados. O c�digo deve ser 
# implementado seguindo a conven��o de chamada de procedimento 
# estudada em sala de aula.
#########################################################

q_perfeito:
	add  $v0, $0 , $0
	beqz $a0, q_return
	# Cria quadro de pilha
	addi $sp, $sp, -16
	sw   $a0, 4($sp)
	sw   $ra, 8($sp)
	# Opera
	sll  $v0, $a0, 1  # n = 2n
	addi $v0, $v0, -1 # n = n-1
	sw   $v0, 12($sp) # Armazena v0
	# Recursao
	addi $a0, $a0, -1
	jal  q_perfeito
	# Opera
	lw   $t0, 12($sp)  # Restora v0
	add  $v0, $v0, $t0 # n = n + q_perfeito(n-1)
	# Restora valores (nao e feito em 'q_return' pois n==0 nao cria pilha)
	lw   $ra, 8($sp)
	addi $sp, $sp, 16
q_return:
	jr $ra
