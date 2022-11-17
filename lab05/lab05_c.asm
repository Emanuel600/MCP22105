#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Implemente como procedimento para ordenar um vetor de
# inteiros na memória. O procedimento de ordenação utilizado
# pode ser o BubbleSort, conforte o algoritmo abaixo:
#
# void bubble(int* v, int size) {
#	int i; # t0
#	int j; # t1
#	int aux;
#	int k = size - 1 ; # t2
#
#   for(i = 0; i < size; i++) {
#      for(j = 0; j < k; j++) {
#         if(v[j] > v[j+1]) {
#             aux = v[j];
#             v[j] = v[j+1];
#             v[j+1] = aux;
#         }
#      }
#      k--;
#   }
# }
#
# Além do procedimento, implemente também um código para
# testar a função implementada
#
#########################################################]
.include "macros.inc"
.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit
.include "string.inc"

.data
vetor:  .word 45,3,7,89,32,76
.data 0x10010020
vetorB: .word 78,2,6,90,124,76,34,71

.text

#-----------
# ($a0) old_stk -> 16($sp)
#-----------
# <empty>      -> 12($sp)
#-----------
#   $ra        -> 8($sp)
#-----------
#   $a1        -> 4($sp)
#-----------
#   $a0        -> 0($sp)
#############################################
main:
	addiu $sp, $sp, -16
	sw    $ra, 8($sp)

	la  $a0, vetor
	li  $a1, 6	
	jal bubble
	
	la  $a0, vetorB
	li  $a1, 8	
	jal bubble

	lw    $ra, 8($sp)
	addiu $sp, $sp, 16
	jr $ra

#########################################################
# void bubble(int* v, int size) {
#	int i; # t0
#	int j; # t1
#	int aux;
#	int k = size - 1 ; # t2
#
#   for(i = 0; i < size; i++) {
#      for(j = 0; j < k; j++) {
#         if(v[j] > v[j+1]) {
#             aux = v[j];
#             v[j] = v[j+1];
#             v[j+1] = aux;
#         }
#      }
#      k--;
#   }
# }
########################################################
bubble:
	or   $t0, $t0, $0 # i
	addi $t2, $a1, -1 # k = size-1
	
	F0:
		slt  $t7, $t0, $a1
		beq  $t7, $0 , F0_end
		or   $t1, $0 , $0 # j=0
		F1:
			slt  $t7, $t1, $t2
			beqz $t7, F1_end
			# Carrega valores na mem�ria
			sll  $t4, $t1, 2   # [j]
			add  $t4, $t4, $a0 # &v[j]
			lw   $t5, 4($t4)   # t5 = v[j+1]
			lw   $t6, 0($t4)   # t6 = v[j] = aux
			# if (v[j] > v[j+1])
			sgt  $t7, $t6, $t5
			beqz $t7, F1_update
			sw   $t5, 0($t4)
			sw   $t6, 4($t4)
			F1_update:
			addi $t1, $t1, 1
			j    F1
		F1_end:
		addi $t2, $t2, -1
		addi $t0, $t0, 1
		j    F0
	F0_end:
	return:
		jr $ra