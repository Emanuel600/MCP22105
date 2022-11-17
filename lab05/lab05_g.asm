#########################################################
# Laboratório 03 - MCP22105
# Procedimentos
#
# Aluno: Emanuel Staub Araldi
#########################################################
#
#########################################################
# Faça um programa que ordena um array, calcula o seu 
# somatório, calcula a sua média aritmética. O programa 
# deve apresentar um MENU de opções para que o usuário 
# possa escolher a ação que deseja realizar no sistema, 
# sendo essas ações as seguintes: 
#	
#	1- Inicializar um array de valores aleatórios e 
#	tamanho arbitrário definido pelo usuário (utilizar 
#	syscalls).
#
#	2- Imprimir o array
#
#	3-Imprimir o array ordenado de forma crescente 
#   (armazene o array ordenado em outra area de memória).
#
#	4-Imprimir o array ordenado de forma decrescente 
#   (armazene o array ordenado em outra area de memória).
#
#	5-Calcular o somatório do array.
#
#	6-Calcular a media aritmética do array.
#
#	7-Encerrar o programa.
#
# Organize bem o seu código dividindo o mesmo em diversas 
# funções (ex. imprime\_vetor(), exibe\_menu(), etc ...)
#########################################################

.include "../inc/macros.inc"

.data
menu: .ascii "1- Inicializar um array de valores aleatórios\n"
	  .ascii "2- Imprimir array\n"
	  .ascii "3- Imprimir array em ordem crescente\n"
	  .ascii "4- Imprimir array em ordem decrescente\n"
	  .ascii "5- Calcular somatório do array\n"
	  .ascii "6- Calcular média aritmética do array\n"
	  .asciiz "7- Terminar programa\n: "
# Menu jumptable
menu_sw: .word it1, it2, it3, it4, it5, it6, it7, def
# Vetores
vec_ale: .space 32
vec_ord: .space 32
vec_des: .space 32
.text 0x00400000
init:
	la $sp, 0x7FFFEFFC
	jal main
	exit
main:
	# Inicializa registradores
	or   $a0, $0 , $0
	or   $a1, $0 , $0
	# Cria pilha
	addi $sp, $sp, 16
	sw   $a1, 12($sp)
	sw   $a0, 08($sp)
	sw   $ra, 04($sp)
	
	swmenu: # menu
	print_strptr(menu)
	addi $v0, $0 , 5
	syscall
	addi $v0, $v0, -1
	sw: #switch
	sltiu $t0, $v0, 7
	beqz $t0, def
	
	la   $s0, menu_sw
	sll  $v0, $v0, 2
	add  $v0, $v0, $s0
	lw   $s1, 0($v0)
	jr   $s1
	it1:
		print_str("Entre com o número de elementos do vetor: ")
		read_int($a1)
		sltiu $t0, $a1, 33
		beqz  $t0, it1_erro
		la    $a0, vec_ale
		# Armazena na pilha
		sw    $a0, 08($sp)
		sw    $a1, 12($sp)
		jal   create_vec
		j     swmenu
		it1_erro:
		print_str("Número entrado deve ser menor ou igual que 32\n")
		j     it1
	it2:
		lw   $a0, 08($sp)
		lw   $a1, 12($sp)
		jal  print_vector
		j    swmenu
	it3:
		lw   $a0, 08($sp)
		lw   $a1, 12($sp)
		jal  bubble
		j    it2
	it4:
		lw   $a0, 08($sp)
		lw   $a1, 12($sp)
		jal  bubble
		lw   $a1, 12($sp)
		#jal  inv
		j    it2
	it5:
		lw   $a0, 08($sp)
		lw   $a1, 12($sp)
		jal  sum_vec
		j    swmenu
	it6:
		lw   $a0, 08($sp)
		lw   $a1, 12($sp)
		jal  avg_vec
		print_str("Média: ")
		print_float($f0)
		print_str("\n")
		j    swmenu
	it7:
		print_str("Terminando programa\n")
		lw   $ra, 4($sp)
		jr   $ra
	def:
		print_str("Entre com um valor de 1-7\n")
		j swmenu
	
	
	jr $ra

# void create_vec(int* adress, int size)
create_vec:
	# Cria pilha
	addi $sp, $sp, -8
	sw   $a0, 4($sp)
	sw   $a1, 8($sp)
	# Gera número aleatório
	addi $v0, $0 , 30 # time()
	syscall
	addi $v0, $0 , 40 # seed()
	syscall
	# Restaura valores
	lw   $a0, 4($sp)
	lw   $a1, 8($sp)
create_loop:
	beqz $a1, return
	addi $v0, $0 , 41 # rand_int()
	syscall
	move $t0, $a0
	lw   $a0, 4($sp)
	sw   $t0, 0($a0)
	addi $a1, $a1, -1
	j    create_loop
return:
	addi $sp, $sp, 8
	jr   $ra
# Imprime vetor
print_vector:
	addi $sp, $sp, -8
	printvec_loop:
	beqz $a1, print_return
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
print_return:
	# Destroi pilha
	addi  $sp, $sp, 8
	print_str("\n")
	jr $ra
# Ordena vetor
bubble:
	or   $t0, $0 , $0 # i = 0
	addi $t2, $a1, -1 # k = size-1
	
	F0:
		slt  $t7, $t0, $a1
		beq  $t7, $0 , F0_end
		or   $t1, $0 , $0 # j=0
		F1:
			slt  $t7, $t1, $t2
			beqz $t7, F1_end
			# Carrega valores na memória
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
		jr $ra
# int sum_vec(int* v, int size) {soma elementos de um vetor}	
sum_vec:
	or   $v0, $0 , $0
sum_loop:
	beqz $a1, sum_return
	lw   $t0, 0($a0)
	add  $v0, $v0, $t0
	addi $a1, $a1, -1
	addi $a0, $a0, 4
	j    sum_loop
sum_return:
	jr   $ra

# float avg_vec(int* v, int size) {calcula média aritmética de um vetor}
avg_vec:
	addi $sp, $sp, -8
	sw   $ra, 4($sp)
	mtc1 $a1, $f1
	cvt.s.w $f1, $f1
	# a0 já possui int* v e a1 int size
	jal  sum_vec
	# Restora valor e destrói pilha
	lw   $ra, 4($sp)
	addi $sp, $sp, 8
	# Armazena valores no formato double
	mtc1 $v0, $f0 # sum(&v)
	cvt.s.w $f0, $f0
	# Calcula média
	div.s $f0, $f0, $f1
return_avg_vec:
	jr   $ra

# void copy_vec(int* v, int adr*, int size) {Copia vetor para um endereço}
