#########################################################
# Laboratório 02 - MCP22105
# Alocação de dados em memória e Chamada de Sistemas
#
# Aluno: 
#########################################################

#########################################################
# Realize a conversão das expressões abaixo considerando
# que os valores das variáveis já estão carregados nos
# registradores, conforme o mapeamento indicado abaixo
#
# Mapeamento dos registradores:
# i: $s3, j: $s4
# Endereço base dos vetores: A: $s6 e B: $s7
#########################################################


#########################################################
# B[8] = A [i-j]

sub  $t0, $s3, $s4
sll  $t0, $t0, 2

add  $t0, $t0, $s6

lw   $t0, 0($t0)
sw   $t0, 32($s7)


#########################################################
# B[32] = A[i] + A[j]

sll  $t0, $s3, 2
sll  $t1, $s4, 2

lw   $t0, 0($t0)
lw   $t1, 0($t1)


#########################################################
# Faça um programa no MARS, utilizando as chamadas de 
# sistema que implementa um papagaio :)
#
# O programa simplesmente imprime no terminal a mesma 
# frase que foi digitada.
#
#  # Diga alguma coisa que eu irei dizer também!
#  # Entre com o seu texto: ...
#  # O seu texto é: ...
#
#########################################################




