#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Implemente como encontrar um valor em um vetor de
# inteiros da memória. Conforte o algoritmo abaixo:
#
#
# bool search_vector(int* v, int size, int value) {
#	while(size--){
#		if (*v++ == value) { return 1; }
#	}
#	return 0;
# }
#
# Além do procedimento, implemente também um código para
# testar a função implementada
#
#########################################################
.include "macros.inc"
.data
vec: 12, 32, -12, 190

.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit

main:
	# Cria pilha
	addi $sp, $sp, -8
	sw   $ra, 08($sp)
	# Procura elemento no vetor
	la   $a0, vec
	li   $a1, 4
	li   $a2, 190
	jal  search_vector
	# Salva resultado
	move $s0, $v0
	# Imprime se foi encontrado ou nao
	bnez $s0, found
	print_str("Elemento não foi encontrado no vetor")
	j    return
	found:
		print_str("Elemento encontrado no vetor")
return:
	lw   $ra, 08($sp)
	addi $sp, $sp, 8
	jr   $ra
	
search_vector:
	or   $v0, $0 , $0
search_loop:
	beqz $a1, search_return
	lw   $t0, 0($a0)
	seq  $v0, $t0, $a2
	bnez $v0, search_return
	addi $a0, $a0, 4
	addi $a1, $a1, -1
	j    search_loop
search_return:
	jr   $ra