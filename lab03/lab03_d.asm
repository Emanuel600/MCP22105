#########################################################
# Laboratório 03 - MCP22105
# Estruturas de Controle
#
# Aluno: Emanuel Staub Araldi
#########################################################

#########################################################
# Implemente um laço que seja executado 10 vezes.
#
#########################################################

add  $t0, $0, $0  # Inicia variável 'i' (Garante i=0)

F0: # Executa laço
  addi $t0, $t0, 1   # Incrementa variável 'i' (i++)
  beq  $t0, 10, exit # Não torna o programa mais eficiente utilisar mais um registrador aqui
  j F0
exit: # Termina programa
  addi $v0, $0, 10
  syscall