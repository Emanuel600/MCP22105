# switch (c) {
#   case 0:
#     print("n is zero")
#     break
#   case 4:
#     print("n is even")
#   case 1:
#   case 9:
#     print("n is a square")

.macro print (%str)
	la $a0, %str
	
	li $v0, 4
	syscall
.end_macro

.macro getInt (%reg)
	li $v0, 5
	syscall
	
	move %reg, $v0
.end_macro

.macro exit
	li $a0, 10
	syscall
.end_macro

.data

  jump_table: .word case_0, case_1, case_2, case_3, case_4
              .word case_5, case_6, case_7, case_8, case_9
              .word case_default

  insert_str: .asciiz "Entre com um número de 0 a 9: "
  zero: .asciiz "Número é zero\n"
  par: .asciiz "Número é par\n"
  quadrado: .asciiz "Número é um quadrado\n"
  primo: .asciiz "Número é primo\n"
  default: .asciiz "Número fora dos limites\n"
  
.text
main:
  print(insert_str)
  getInt($s0)
  
  sltiu $t0, $s0, 10
  beq   $t0, $0, case_default
  # Carrega valor de jump_table[n] no registrador t0
  sll   $t0, $s0, 2
  la    $t1, jump_table
  add   $t0, $t0, $t1
  lw    $t0, 0($t0)
  
  jr    $t0	# Pula para o endereço do registrador t0
  
  sw0:
    case_0:
      print(zero)
      j sw_end
    case_4:
      print(par)
    case_1:
    case_9:
      print(quadrado)
      j sw_end
    case_2:
    case_6:
    case_8:
      print(par)
      j sw_end
    case_3:
    case_5:
    case_7:
      print(primo)
      j sw_end
    case_default:
      print(default)
      j sw_end
      
  sw_end:
    j main
exit