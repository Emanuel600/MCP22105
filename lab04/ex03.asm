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
	
	## Search ' '
	la $a0, str1
	li $a1, ' '
	jal strSearch
	move $s0, $v0
	
	print_str("O espaço está no índice: ")
	print_intReg($s0)
	print_str("\n")
	
	print_str("Final do programa\n")
	exit

#############################################	
# int strSearch(char * str, char value);
#
#  O procedimento deve procurar o caracter passado
# como parâmetro na string, retornando o inteiro
# equivalente a sua posição na string (índice).
#  Caso o caracter não seja encontrado, o procedimento
# deve retornar -1.
#
strSearch:
	add  $v0, $0 , $0      # int v0 = 0
	loop:
	lb   $t0, 0($a0)
	beq  $t0, $0 , error   # Retorna erro ao encontrar byte nulo
	beq  $t0, $a1, return  # Retorna indice do valor encontrado
	addi $a0, $a0, 1       # Move para o proximo byte
	addi $v0, $v0, 1       # v0++
	j loop
	error:
	addi $v0, $0, -1
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
