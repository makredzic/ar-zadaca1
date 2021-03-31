.section .data
number: .word 33

.section .bss
result: .byte

.section .text
.global main
main:
  la $t0, number
  lw $t0, ($t0)

  andi $t0, $t0, 0x0001
  la $t1, result
  sb $t0, ($t1)

  addi $v0, $0, 0
  jr $ra
