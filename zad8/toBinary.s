.section .text
.global toBinary
toBinary:

  addiu $t0, $0, 0 # t0 = i = 0

  addiu $t1, $0, 2 # t1 = 2 jer div nema sa immediate

uslov:
  beq $a1, $0, krajPetlje
  div $a1, $t1 # lo = num=/2, hi = res = num%2
  
  addu $t7, $a0, $t0 # t7 = addr_od_buff + i
  addiu $t0, $t0, 1 # i++ - poveca se i za sljedecu iteraciju

  mfhi $t6 # res = t6 = ostatak dijeljenja
  addiu $t6, $t6, 48 # res + 48
  sb $t6, ($t7)

  mflo $a1 # u a1 je rezultat dijeljenja bez ostatka
  j uslov

krajPetlje:
  addiu $sp, $sp, -16
  sw $ra, 16($sp)
  
  addu $a1, $0, $t0 #a0 je vec buffer, a1 je sad =i
  jal reverse

  lw $ra, 16($sp)
  addiu $sp, $sp, 16

  addu $v0, $0, $t0
  jr $ra
