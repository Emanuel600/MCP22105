# if ( a < 10 ) {
#   b = 20;
#   if ( a <= 5 ){
#      for ( int i = 0; i < a; i++)
#         b += a * i;
#   } else {
#     while ( a-- > 5) {
#         b -= b / a;
#   }
#}

IF0:
  li   $t0, 10
  bge  $s0, $t0, IF0_end
  
  li   $s1, 20
  
  IF1:
    li   $t0, 5
    
    bgt  $t0, $s0, IF1_else
    
    li   $t0, 0 # int i= 0
    LF0:# Start first for loop
      bge  $t0, $s0, LF0_end # i>=a -> end for loop
      
      mul  $t1, $t0, $s0
      add  $s1, $s1, $t1
      
      addi $t0, $t0, 1  # i++
      j    LF0
    LF0_end: # End first for loop
        j IF1_end
    
  IF1_else:
    li  $t0, 4
    
    LW0: # First while loop
      addi $s0, $s0, -1
      blt  $s0, $t0, LW0_end # Ends loop when (a-1)<4
      
      div  $t1, $s1, $s0
      
      sub  $s1, $s1, $t1
    LW0_end:
      j IF1_end
    IF1_end:
IF0_end:
	addi $v0, $0, 10
	syscall