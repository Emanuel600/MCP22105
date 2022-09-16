# Recebe notas do usuário e as armazena na memória
.macro GetNota (%ind)
  # Pede entrada da nota
  la   $a0, input
  addi $v0, $0, 4
  syscall
  # Armazena nota na memória
  la   $gp, notas

  addi $v0, $0, 6
  syscall
  
  s.s  $f0, %ind($gp)
.end_macro
# Load immediate as a float
.macro lif (%imd, %reg)
  li  $t0, %imd
  
  mtc1 $t0, %reg
  cvt.s.w %reg, %reg
.end_macro
# Exit program gracefuly
.macro exit
  addi $v0, $0, 10
  syscall
.end_macro
# Print null terminated string
.macro print (%str)
  la   $a0, %str
  addi $v0, $0, 4
  
  syscall
.end_macro

.data
  notas:  .float 0, 0, 0
  
  input:  .asciiz "Entre com a nota: "
  passou: .asciiz "\n ==Passou== \n"
  falhou: .asciiz "\nFalhou\n"
.text
  # Recebe notas do usuário
  GetNota(0)
  GetNota(4)
  GetNota(8)

  la   $gp, notas
  # Carrega notas nos registradores
  lwc1 $f1, 0($gp)
  lwc1 $f2, 4($gp)
  lwc1 $f3, 8($gp)
  # Soma notas
  add.s $f0, $f1, $f2
  add.s $f0, $f0, $f3
  # Faz média
  lif(3, $f4)
  div.s $f0, $f0, $f4
  # Calcula se passou
  lif(6, $f4)
  c.lt.s $f0, $f4
  # Imprime se passou ou falhou
  bc1f   passed
  print(falhou)
  exit
  
  passed:
    print(passou)
    exit
