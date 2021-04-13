.section .text
.global swap
swap:
  
  addiu $t0, $0, 0 # i = 0
uslov:
  slt $t1, $t0, $a2
  beq $t1, $0, kraj 

  addu $t2, $a0, $t0
  addu $t3, $a1, $t0

  lb $t4, ($t2)
  lb $t5, ($t3)

  sb $t4, ($t3)
  sb $t5, ($t2)

  addiu $t0, $t0, 1
  j uslov

kraj:
  jr $ra
