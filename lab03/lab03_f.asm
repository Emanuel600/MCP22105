#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa para buscar um determinado valor em um 
# array de inteiros. O endereço inicial do vetor está 
# armazenado no endereço de memória 0x10010000, o tamanho 
# do vetor está no endereço 0x10010004 e valor que será 
# pesquisado está no endereço 0x10010008. Caso o valor 
# seja encontrado, escreva 0x01 no endereço 0x1001000C, 
# caso contrário, escreva 0x00.
#
#########################################################

# Pseudo-código
#
# ar* = 0x0 // Recebe endereço base do array
# n   = *(0x4)
# num = *(0x8)
#
# for (i=0 ; i<n ; i++){
#   rel = (ar[i] == num)
#   if (rel){ break }
# }
#
# *(0xc) = rel // Endereço 0xc recebe valor armazenado em rel
# ========================================================= #

# Carrega endereço base de memória em t0
lui  $t0, 0x1001
# Carrega dados essenciais nos registradores
lw   $t1, 0($t0) # => Endereço base do array (Também serve como 'i')
lw   $t2, 4($t0) # => Número de elementos no array
lw   $t3, 8($t0) # => Valor que queremos encontrar
# Itera os elementos dentro do array
ori  $t4, $0, 0  # => Inicializa 'i'
F0:
  lw   $t5, 0($t1)   # Carrega elemento atual do array no t4
  seq  $t5, $t5, $t3
  addi $t4, $t4, 1   # => i++
  bne  $t5, $0, exit
  blt  $t4, $t2, exit
  add  $t1, $t1, 4   # => ar[i] (*ptr++)
  j    F0
exit:
  sw   $t5, 12($t0)
  addi $v0, $0, 10
  syscall

