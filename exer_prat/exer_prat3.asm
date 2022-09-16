.macro exit
  addi $v0, $0, 10
  syscall
.end_macro

.macro print (%str)
  la   $a0, %str
  addi $v0, $0, 4
  
  syscall
.end_macro

.data
  notas:  .float 6, 2.3, 9.7
  const:  .float 3, 6
  
  passou: .asciiz "Passou"
  falhou: .asciiz "Falhou"
.text
  la   $gp, notas
  # Carrega notas nos registradores
  lwc1 $f1, 0($gp)
  lwc1 $f2, 4($gp)
  lwc1 $f3, 8($gp)
  # Soma notas
  add.s $f0, $f1, $f2
  add.s $f0, $f0, $f3
  # Faz média
  lwc1  $f4, 12($gp)
  div.s $f0, $f0, $f4
  # Calcula se passou
  lwc1   $f4, 16($gp)
  c.lt.s $f0, $f4
  # Imprime se passou ou falhou
  bc1f   passed
  print(falhou)
  exit
  
  passed:
    print(passou)
    exit
