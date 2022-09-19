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
# for (int i=0 ; i<n ; i++)
#   if (ar[i] == num) {ins++}
# *(0xc) = ins
# ======================================================= #

