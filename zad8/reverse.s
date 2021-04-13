.section .text
.global reverse
reverse: #pokusaj reverse funkcije iz main.c u assembleru, ispis nije dobar iz nekog razloga
  
  addiu $a1, $a1, -1 # size = size-1
  addiu $t0, $0, 0 # t0 = i = 0

uslov:
  slt $t9, $t0, $a1
  beq $t9, $0, kraj
  
  addu $t2, $a0, $t0 # &buffer[i]

  lbu $t3, ($t2) # t3 = buffer[i]

  addu $t4, $a0, $a1 # &buffer[size]
  lbu $t5, ($t4) # t5 = buffer[size]

  sb $t3, ($t4) # buffer[size] = buffer[i]
  sb $t5, ($t2) # buffer[i] = buffer[size]

  addiu $t0, $t0, 1 # i++
  addiu $a1, $a1, -1 # size--
  j uslov

kraj:
  jr $ra
