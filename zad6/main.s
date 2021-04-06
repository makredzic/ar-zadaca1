.section .data
.global a
.global b
a: .hword 69
b: .hword 420

.section .bss
.global result
result: .hword

.section .text 
.global main
main:
  la $a0, a

  la $a1, b
  lh $a1, ($a1)

  addiu $sp, $sp, -32
  sw $ra, 16($sp)

  jal exchange
  la $t0, result
  sh $v0, ($t0)

  lw $ra, 16($sp)
  addiu $sp, $sp, 32

  addiu $v0, $0, 0
  jr $ra
