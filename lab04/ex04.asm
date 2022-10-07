.macro print_strptr (%ptr)
  li $v0, 4
  la $a0, %ptr
  syscall
.end_macro

.macro read_str (%ptr, %max_size)
  li $v0, 8
  la $a0, %ptr
  li $a1, %max_size
  syscall
.end_macro

.macro print_str (%str)
.data
mStr: .asciiz %str
.text
   li $v0, 4
   la $a0, mStr
   syscall
.end_macro

.data
str_buffer: .space 1024


##############################################################################
#
#     Utilizando os procedimentos implementados no exercício anterior
# implemente um programa que solicita ao usuário uma frase, e em seguida,
# apresenta apenas a primeira palavra da frase digitada com todas as letras
# maiúsculas.
#
#     Exemplo, se o usuãrio digitar "Bom dia!", o programa deverá 
# imprimir "BOM"
#
##############################################################################

.text

  print_str("Digite uma frase: ")
  read_str(str_buffer, 1024) # Já carrega char* em a0
  
  jal toUpper
  
  print_strptr (str_buffer)
  
  addi $v0, $0, 10
  syscall
###################################################
# void changeCase(char * str);
#
#  Converte apenas a primeira palavra de uma frase
# em letras maiusculas
#  Registradores:
# $a0: input*
###################################################
toUpper:
	# Limites - lower
	addi $t8, $0, 96      # Limite inferior - lower
	addi $t9, $0, 123     # Limite superior - lower
	# Carrega valor de ' '
	addi $t7, $t7, 0x20
	opera:
	lb   $t0, 0($a0)      # Carrega letra atual da string
	beq  $t0, $0 , return # Retorna ao encontrar byte nulo
	beq  $t0, $t7, cut    # Corta a string e retorna
	lower_upper:
	# if (letra<123 & letra>96)
	slt  $t1, $t0, $t9    # Verifica letra < 123
	sgt  $t2, $t0, $t8    # Verifica letra > 96
	and  $t1, $t1, $t2
	beq  $t1, $0,  next   # se nao e lower-alpha, analisa proxima
	addi $t0, $t0, -32
	next: # (input*)++
	sb   $t0, 0($a0)      # Armazena caractere na string
	addi $a0, $a0, 1      # Incrementa ponteiro
	j opera
	cut:
	add  $t0, $0 , $0
	sb   $t0, 0($a0)      # Armazena nulo, terminando a string (resto permanece na memoria)
	return:
	jr $ra
###################################################
