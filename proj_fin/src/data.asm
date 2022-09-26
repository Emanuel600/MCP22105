.data

menu: .ascii "\nSelecione um item:\n"
             "1- Exibir Acumulador\n"
             "2- Zerar Acumulador\n"
             "3- Adicionar a Pilha\n"
             "4- Operar\n"
      .asciiz "5- Sair do programa\n"

acum: .asciiz "\nValor atual: "
zera: .asciiz "Valor do acumulador zerado\n"
opge: .asciiz "\nEntre com um numeros para " # Generico para todas as operacoes a serem feitas
soma: .asciiz "somar: "
subt: .asciiz "subtrair: "
divi: .asciiz "dividir: "
mult: .asciiz "multiplicar: "

exce: .asciiz "Valor invalido entrado, favor re-entrar\n"
