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
str1:       .asciiz "MCP22105 is cool"

.text
	print_str("Str1: ")
	print_strptr(str1)
	print_str("\n")
	
	## Chamar strlen
	la $a0, str1
	jal strlen
	move $s0, $v0
	
	print_str("A str1 tem ")
	print_intReg($s0)
	print_str(" caracteres\n")
	
	## Resize str1
	la $a0, str1
	li $a1, 8
	jal strResize
	
	print_str("Str1 ajustada: ")
	print_strptr(str1)
	print_str("\n")
	
	## Chamar strlen
	la $a0, str1
	jal strlen
	move $s0, $v0
	print_str("A str1 ajustada tem ")
	print_intReg($s0)
	print_str(" caracteres\n")
	
	
	print_str("Final do programa\n")
	exit

#############################################	
# int strResize(char * str, int size);
#
#  O procedimento deve modificar o tamanho da string
# de acordo com o tamanho especificado pelo parâmetro
# size. O size deve ser sempre menor que o tamanho
# atual da string.
#
#  O procedimento retorna o valor -1, caso o size seja
# maior que o tamanho da string, ou o novo tamanho da
# string, caso contrário, ou seja, o próprio valor de
# size.
#
# ! STACK !
#-----------------------------
#   $a1 (strResize)  12($sp)
#-----------------------------
#   $a0 (strResize)  8($sp)
#=============================
#   $ra              4($sp)
#-----------------------------
#   $a0 (strlen)     0($sp)
#-----------------------------
strResize:
	addi $sp, $sp, -8
	sw   $a1, 12($sp)
	sw   $a0, 8($sp)
	sw   $ra, 4($sp)

	jal  strlen
	lw   $a0, 8($sp)
	lw   $a1, 12($sp)
	
	bgt  $a1, $v0, error
	beq  $v0, $0 , error
	
	add  $a0, $a0, $a1
	sb   $0 , 0($a0)
	add  $v0, $a1, $0
	j return
	error:
	addi $v0, $0, -1
	return:
	lw $ra, 4($sp)
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
