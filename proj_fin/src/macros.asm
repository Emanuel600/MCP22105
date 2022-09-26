.macro print(%str)
  ori  $v0, $0, 4
  la   $a0, %str
  
  syscall
.end_macro
# Adiciona valor a pilha, %reg é um registrador contendo o endereço final da pilha
.macro add_pile()
  ori  $v0, $0, 6
  syscall
  
  addi $t8, $t8, 4
  swc1 $f0, 0($t8)
.end_macro
# Opera nos últimos valores da pilha
.macro operate()
  #  TODO: Adicionar safeguard contra operar com pilha<2
  ori  $v0, $0, 12
  syscall
  
  j operate
.end_macro
.macro exit()
  ori  $v0, $0, 10
  syscall
.end_macro

.macro print_value()  # Valor se encontra em f12
  ori  $v0, $0, 2
  syscall
.end_macro
