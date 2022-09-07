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

.macro print (%str)
	la $a0, %str
	
	li $v0, 4
	syscall
.end_macro

.macro get_and_concoct (%str)
	li   $v0, 8
	la   $a0, %str
	la   $a0, 15($a0) # O final de "resposta" está no 15º byte, então a entrada é armazenada lá
	li   $a1, 256     # Limite de caracteres que podem ser entrados pelo usuário
	syscall
.end_macro

.data
	frase_inicial:  .asciiz  "Diga alguma coisa que eu irei dizer também!\n"
	
	prompt_user:    .asciiz  "Entre com o seu texto: "
	resposta:       .ascii   "O seu texto é: "
	
.text
	set_up:                      # Indica ao usuário como usar o programa
		print(frase_inicial)

	loop:
		print(prompt_user)		  # Prompta o usuário a entrar com uma string
		
		get_and_concoct(resposta) # Recebe a string de entrada e a adiciona a string "resposta"
		
		print(resposta)			  # Imprime "O seu texto é: {entrada}"
		
		lb  $t0, 15($a0)
		
		li  $v0, '\n'			  # Prepara para terminar o programa ('\n' = 10)
		
		bne $t0, $v0, loop		  # Termina programa quando o usuário aperta apenas 'Enter'
		
	exit:
		syscall
