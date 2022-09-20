#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa para contar o número de elementos 
# encontrados em um array de inteiros. O endereço inicial 
# do vetor está armazenado no endereço de memória 0x10010000, 
# o tamanho do vetor está no endereço 0x10010004 e valor que 
# será contado está no endereço 0x10010008. Armazene no 
# endereço 0x1001000C o número de elementos encontrados 
# na procura.
#
#########################################################

# Pseudo-código
#
# ar* = 0x0     => Endereço base do vetor
# n   = *(0x4)  => Tamanho do vetor
# num = *(0x8)  => Número a ser procurado dentro do vetor
# ins = 0       => Número de instâncias do elemento "num"
#
# while (n != 0){
#   if (ar[i] == num) {ins++} => i apenas serve para dizer que é iterativo
#   n--
# }
# *(0xc) = ins
# ======================================================= #

# Carrega valor inicial na memória
lui  $t0, 0x1001
# Carrega valores nos registradores
lw   $t1, 0($t0) # => Endereço inicial do vetor
lw   $t2, 4($t0) # => n
lw   $t3, 8($t0) # => num

or   $t5, $0, $0 # => inicializa ins
W0:
  beq  $t2, $0, exit
  lw   $t4, 0($t1)   # => t4= ar[i]
  bne  $t4, $t3, update
  addi $t5, $t5, 1
  update:
    addi $t2, $t2, -1
    addi $t1, $t1, 4
    j    W0
exit:
  sw   $t5, 0xc($t0)

  ori $v0, $0, 10
  syscall
