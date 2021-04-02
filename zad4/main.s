.section .data
niz: .word 1,2,3,4,5

.section .bss
result: .word 

.section .rodata
size: .word 5


.section .text
.global main
main:
  addiu $sp, $sp, -4 #alociramo 4 bajta na stacku za pohranu $ra, pohranili bismo i $a0, $a1 posto su nerezervirani ali funkcija isSorted NE mijenja te registre tako da nema potrebe da ih pohranjujemo 

  la $a0, niz
  #lw $a0, ($a0) #$a0 = niz[0]
 
  la $a1, size
  lw $a1, ($a1) #$a1 = size 

  sw $ra, ($sp) #prilikom poziva isSorted ispod, $ra ce se promijeniti, zato se mora sacuvati na stacku kako bi mogli izaci iz main funkcije na samome kraju 

  jal isSorted # poziv funkcije isSorted(), vraca $v0 = 1 ako je sortiran niz  

  bne $v0, $0, nastavak #ako je $v0 != 0 odnosno ako je $v0 == 1 odnosno ako niz JESTE sortiran, skoci na nastavak
  
  la $t0, result #ako niz nije sortiran, u result treba pohraniti 0xdeadfa11
  lui $t1, 0xdead
  ori $t1, 0xfa11
  sw $t1, ($t0)

  j krajPrograma
nastavak:

  andi $t0, $a1, 1 # $t0 ce biti zadnji bit samo od $a1 tako to uradimo $a1 & 0x00000001
  
  bne $t0, $0, neparan #ovjde ispod ide kod u slucaju da je paran broj elemenata, u suprotnom skace na neparan



neparan:
  sra $t0, $a1, 1 # $a1 broj elemenata u nizu, npr 5, (5 >> 1) = 2 => niz[2] = srednji clan
  sll $t0, $t0, 2 #$t0 je indeks srednjeg elementa, pomnozi se sa 4 jer su intovi 
  addu $t0, $t0, $a0
  lw $t0, ($t0)

  la $t1, result
  sw $t0, ($t1) 


  j krajPrograma

isSorted: # bool isSorted(int $a0[$a1], int $a1); $a1 je ustvari size  // https://geeksforgeeks.org/program-check-array-sorted-not-iterative-recursive

  slti $v0, $a1, 2 # if (size < 2) odnosno da li je 1 ili 0 elemenata u nizu 
  bne $v0, $0, krajFunkcije # size < 2 TRUE


  addiu $t0, $0, 1 # $t0 = 1 (kao int i = 1 u petlji)
  j uslov
tijelo:
  sll $t2, $t0, 2 # 4t0 odnosno 4i 
  addu $t2, $t2, $a0
  lw $t3, ($t2)

  addiu $t2, $t0, -1
  sll $t2, $t2, 2
  addu $t2, $t2, $a0
  lw $t4, ($t2)
  

  slt $v0, $t3, $t4 # if ( $t3 < $t4 ) $v0 = 1 to jest, if ($t3 >= $t4) $v0 = 0  
  beq $v0, $0, krajFunkcije # if($v0 == 0) return false (napusta funkciju)  

  addiu $t0, $t0, 1 # $t0++ odnosno i++
uslov:
  slt $t1, $t0, $a1 # if ($t0 < $a1) to jest, if (i < size)
  bne $t1, $0, tijelo


addiu $v0, $0, 1 #ako dodje do ovdje program, $v0 = 1 odnosno return true;
krajFunkcije:
  jr $ra
  

krajPrograma:
  lw $ra, ($sp) #ucitamo $ra iz stacka koji smo sacuvali na pocetku 
  addu $sp, $sp, 4 #de alociramo 4 bajta koji su alocirani na pocetku za $ra

  addiu $v0, $0, 0
  jr $ra
