.include "\data.asm"
.include "\macros.asm"

.data  
  menu_inicial: .word c0, c1, c2, c3, c4 # Endere�os da jump_table para o switch/case
.text
inicial_menu: # Coleta opções do usuário
  print(menu)
  ori  $v0, $0, 5
  syscall

  addi $v0, $v0, -1

menu_switch: # Inicia switch
  slti $t0, $v0, 7
  beq  $t0, $0, def
    
  la   $s1, menu_inicial
  sll  $v0, $v0, 2       # Leva � jump_table[v0], endere�o da instru��o que deve ser executada
  add  $v0, $v0, $s1
  lw   $s0, 0($v0)
  jr   $s0
    
  c0: # Imprime valor do acumulador (último valor da pilha)
    print_value()
    j    sw_end
  c1: # Zera acumulador
    mtc1 $0, $f12
    j     sw_end
  c2: # Adiciona valor à pilha
    add_pile()
    j     sw_end
  c3: # Opera na pilha
    operate()
  c4: # Termina programa
    exit()
  def:
    print(exce)
    j inicial_menu
sw_end:
  j inicial_menu

.data  
  operadores: .word ast, plu, com, min, per, sla, op_def # Endere�os da jump_table para o switch/case
.text
operate:
  # Carrega últimos dois na pilha
  l.s   $f12, -4($t8)
  l.s   $f1, 0($t8)
  # Opera nos registradores
  addi $v0, $v0, -42
  slti $t0, $v0, 5
  beq  $t0, $0, op_def
  blt  $v0, $0, op_def
  
  sll  $v0, $v0, 2
  la   $t0, operadores
  add  $t0, $t0, $v0
  
  lw   $t0, 0($t0)
  jr   $t0
ast:
  mul.s $f12, $f12, $f1
  j op_end
plu:
  add.s $f12, $f12, $f1
  j op_end
com:
  j op_def
min:
  sub.s $f12, $f12, $f1
  j op_end
per:
  j op_def
sla:
  div.s $f12, $f12, $f1
  j op_end
op_def:
  break
op_end:
  addi $t8, $t8, -4
  j menu_switch
