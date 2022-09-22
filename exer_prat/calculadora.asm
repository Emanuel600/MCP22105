.macro print(%str)
  ori  $v0, $0, 4
  la   $a0, %str
  
  syscall
.end_macro

.macro get_num()
  ori  $v0, $0, 6
  syscall
    
  mov.s $f1, $f0
.end_macro

.macro exit()
  ori  $v0, $0, 10
  syscall
.end_macro

.macro print_value()  # Valor se encontra em f12
  ori  $v0, $0, 2
  syscall
.end_macro

.data
  menu: .asciiz "\nSelecione um item:\n1- Exibir Acumulador\n2- Zerar Acumulador\n3- Realizar Soma\n4- Realizar Subtra��o\n5- Realizar Divis�o\n6- Realizar Multiplica��o\n7- Sair do programa\n"
  acum: .asciiz "\nValor atual: "
  zera: .asciiz "Valor do acumulador zerado\n"
  opge: .asciiz "\nEntre com um n�meros para " # Gen�rico para todas as opera��es a serem feitas
  soma: .asciiz "somar: "
  subt: .asciiz "subtrair: "
  divi: .asciiz "dividir: "
  mult: .asciiz "multiplicar: "

  exce: .asciiz "Valor inv�lido entrado, favor refazer sele��o\n"
  
  jump_table: .word c0, c1, c2, c3, c4, c5, c6 # Endere�os da jump_table para o switch/case
.text
get_menu:
  print(menu)
  ori  $v0, $0, 5
  syscall

  addi $v0, $v0, -1

main_switch: # Inicia switch
  slti $t0, $v0, 7
  beq  $t0, $0, def
    
  la   $s1, jump_table
  sll  $v0, $v0, 2       # Leva � jump_table[v0], endere�o da instru��o que deve ser executada
  add  $v0, $v0, $s1
  lw   $s0, 0($v0)
  jr   $s0
    
  c0: # Imprime valor do acumulador
    print_value()
    j    sw_end
  c1: # Zera acumulador
    mtc1 $0, $f12
    j     sw_end
  c2: # Soma
    print(opge)
    print(soma)
      
    get_num()
      
    add.s  $f12, $f12, $f1
    j     sw_end
  c3: # Subtra��o
    print(opge)
    print(subt)
      
    get_num()
      
    sub.s  $f12, $f12, $f1
    j     sw_end
  c4: # Divis�o
    print(opge)
    print(divi)
      
    get_num()
      
    div.s  $f12, $f12, $f1
    j     sw_end
  c5: # Multiplica��o
    print(opge)
    print(mult)
      
    get_num()
      
    mul.s  $f12, $f12, $f1
    j     sw_end
  c6:
    exit()
  def:
    print(exce)
    j     get_menu
sw_end:
  j     get_menu