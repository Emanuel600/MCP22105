#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Implemente como procedimento para imprimir um vetor de
# inteiros da memória. Conforte o algoritmo abaixo:
#
#
# void print_vector(int* v, int size) {
#	while(size--){
#		print_int(*v++);
#		print_string(", ");
#	}
#	print_string("\n");
# }
#
# Além do procedimento, implemente também um código para
# testar a função implementada
#
#########################################################

.include "macros.inc"

.data
vec: .word 13 12 14 132 -12 2321
siz: .word 6

.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit

main:
	# Cria pilha
	addi $sp, $sp, 8
	sw   $ra, 4($sp)
	# Prepara registradores
	la   $a0, vec
	lw   $a1, siz
	# Chama metodo
	jal  print_vector
	# Retorna
	lw   $ra, 4($sp)
	jr   $ra
	

print_vector:
	addi $sp, $sp, -8
	printvec_loop:
	beqz $a1, return
	lw   $t0, 0($a0)  # Carrega elemento atual na memoria
	# Armazena na pilha
	sw   $a0, 8($sp)
	sw   $a1, 4($sp)
	# Imprime na tela
	print_intReg($t0)
	print_str(", ")
	# Restora da pilha
	lw   $a0, 8($sp)
	lw   $a1, 4($sp)
	# Decrementa
	addi $a0, $a0, 4
	addi $a1, $a1, -1
	j printvec_loop
return:
	# Destroi pilha
	addi  $sp, $sp, 8
	print_str("\n")
	jr $ra
