.section .rodata #rodata jer je number konstanta, ali moze i .data sekcija ko u prvom zadatku
number: .word 15

.section .bss
result: .word

.section .text
.global main
main:
  la $t0, number 
  lw $t0, ($t0)# CIJELI PROGRAM JE $t0 = number

  andi $t1, $t0, 0x0001
  la $t2, result #t2 = adresa od result
  sw $t1, ($t2) # vrijednost iz $t1 saved na adresu iz $t2, to jest u result variablu


  sll $t1, $t0, 5 # $t1 = 32$t0 
  sll $t2, $t0, 3 # $t1 = 8$t0  

  subu $t1, $t1, $t2 # $t1 = 32$t0 - 8$t0 => $t1 = 24$t0

  sll $t2, $t0, 1 # $t2 = 2$t0
  subu $t1, $t1, $t2 # $t1 = 24$t0 - 2$t0 => $t1 = 22$t0

  la $t2, result
  sw $t1, ($t2) # vrijednost iz $t1 = 22$t0 = 22 * number


  sll $t1, $t0, 3 # $t1 = 8$t0
  subu $t1, $t1, $t0 # $t1 = 8$t0 - $t0 = 7$t0
  sw $t1, ($t2) #ostala u $t2 adresa od result variable


  andi $t1, $t0, 7 #https://mziccard.me/2015/05/08/modulo-and-division-vs-bitwise-operations
  sw $t1, ($t2)

  andi $t1, $t0, 31 #ne radi jer je broj 15 < 31
  sw $t1, ($t2)

  addiu $v0, $0, 0
  jr $ra
