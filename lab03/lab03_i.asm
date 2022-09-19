#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa que receba dois endereços de memória 
# (fonte e destino) (0x10010000, 0x10010004), além da 
# quantidade de posições de memória (bytes) que devem 
# ser copiados (0x10010008), e faça a transferência dos 
# dados presentes no endereço de fonte, para o endereço 
# de destino.
#
#########################################################

# Pseudo-código
#
# fonte* = 0x0
# dest*	 = 0x4
# n		 = *(0x8)
#
# for (i = 0 ; i < n ; i++){
#   *(dest++) = *(fonte++)
# ============================== #
# Carrega posição inicial
lui  $t0, 0x1001 # => Endereço fonte
# Carrega valores nos registradores
lw   $t1, 4($t0) # => Endereço destino
lw   $t2, 8($t0) # => Número de bytes a serem copiados
lw   $t0, 0($t0) # => Endereço fonte
# Loop
move $t3, $0	 # => Inicializa 'i'
F0:
  bgt  $t3, $t2, exit # Se i>n, sai do loop
  
  lb   $t4, 0($t0)    # Carrega byte da fonte em t0
  sb   $t4, 0($t1)    # Armazena o byte no destino (endereçado por t1)
  
  addi $t0, $t0, 1    # *fonte++
  addi $t1, $t1, 1    # *dest++
  
  addi $t3, $t3, 1    # i++
  j    F0
exit:
  ori  $v0, $0, 10
  syscall


