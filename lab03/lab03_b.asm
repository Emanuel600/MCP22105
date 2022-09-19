#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Faça um programa que teste se o conteúdo da posição de 
# memória 0x10010000 e 0x10010004 são iguais e, em caso 
# positivo, armazene o valor na posição 0x10010008.
#
#########################################################
# Carrega endereço inicial
lui  $t0, 0x1001
# Carrega valores nos registradores
lw   $t0, 0($t0)
lw   $t1, 4($t2)
# Compara e carrega caso igual (Como termina se não for igual, armazena apenas se forem iguais)
bne  $t0, $t1, exit
sw   $t0, 8($t2)
# Termina execução
exit:
  addi $v0, $0, 10
  syscall