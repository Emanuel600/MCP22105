.macro print_strptr (%ptr)
  li $v0, 4
  la $a0, %ptr
  syscall
.end_macro

.macro print_intReg (%reg)
  move $a0, %reg
  li $v0, 1
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

.macro exit
   li $v0, 10
   syscall
.end_macro

.data
str_len:    .word 0
str_buffer: .space 1024
str1:       .asciiz "MCP22105 is cool"

.text

	print_str("Digite uma frase: ")
	read_str(str_buffer, 1024)
	
	print_str("Voce digitou: ")
	print_strptr(str_buffer)
	
	## Chamar strlen
	la $a0, str_buffer
	jal strlen
	sw $v0, str_len
	
	print_str("A string digitada tem ")
	lw  $t0, str_len
	print_intReg($t0)
	print_str(" caracteres\n")
	
	# Fazer a conversÃ£o da string para caracteres minÃºsculos
	la	$a0, str_buffer
	li	$a1, 0
	jal	changeCase
	print_str("Minusculo: ")
	print_strptr(str_buffer)
	print_str("\n")
	
	# Fazer a conversÃ£o da string para caracteres maiÃºsculos
	la	$a0, str_buffer
	li	$a1, 1
	jal	changeCase
	print_str("Maiusculo: ")
	print_strptr(str_buffer)
	print_str("\n")
	
	print_str("Final do programa\n")
	exit

#############################################	
# void changeCase(char * str, bool type);
#
#  A funÃ§Ã£o deve converter as letras da string
# para maiÃºsculo ou minÃºsculo, conforme o segundo
# parÃ¢metro type (0 - minÃºsculo, 1-maiÃºsculo). 
#
#  As letras minÃºsculas estÃ£o entre os valores 97(a) e
# 122(z), e as letras maiÃºsculas entre os valores
# 65(A) e 90(Z). A conversÃ£o pode ser feita somando
# ou subtraindo a diferenÃ§a entre esses valores.
#
#  Registradores:
# $a0: input* ; $a1= type
changeCase:
	# Limites - lower
	addi $t8, $0, 96     # Limite inferior - lower
	addi $t9, $0, 123    # Limite superior - lower
	# Limites - upper
	addi $t6, $0, 64     # Limite inferior - upper
	addi $t7, $0, 91     # Limite superior - upper
	opera:
	lb   $t0, 0($a0)     # Carrega letra atual da string
	beq  $t0, $0, return # Retorna ao encontrar byte nulo
	beq  $a1, $0, upper_lower
	j lower_upper
	lower_upper:
	# if (letra<123 & letra>96)
	slt  $t1, $t0, $t9   # Verifica letra < 123
	sgt  $t2, $t0, $t8   # Verifica letra > 96
	and  $t1, $t1, $t2
	beq  $t1, $0,  next  # se e numero, analisa proxima
	addi $t0, $t0, -32
	j next
	upper_lower:
	# else if (letra<123 & letra>96)
	slt  $t1, $t0, $t7   # Verifica letra < 91
	sgt  $t2, $t0, $t6   # Verifica letra > 64
	and  $t1, $t1, $t2
	beq  $t1, $0,  next  # ignora nao-letras
	addi $t0, $t0, 32
	next: # (input*)++
	sb   $t0, 0($a0)     # Armazena caractere na string
	addi $a0, $a0, 1     # Incrementa ponteiro
	j opera
	return:
	jr $ra
#############################################

#############################################	
# int strlen(char * str) {
#   int len = 0;
#   while ( *str != 0 ){
#     str = str + 1;
#     len = len + 1;
#   }
#   return len;
#}
strlen:
	li $v0, 0 # len = 0
	strlen_L0:
		lb   $t0, 0($a0)
		beq  $t0, $zero, strlen_L0_exit
		addi $a0, $a0, 1
		addi $v0, $v0, 1
		j strlen_L0
	strlen_L0_exit:
	jr $ra
#############################################
	
	
