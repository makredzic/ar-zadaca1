.section .data
.global niz
.global size
niz: .hword 1,2,5,7,9,10
size: .word 6

.section .bss
.global result
result: .word 

.section .text
.global main
main:
  addiu $sp, $sp, -32 #alociramo 32 bajta na stacku za pohranu $ra, pohranili bismo i $a0, $a1 posto su nerezervirani ali funkcija isSorted NE mijenja te registre tako da nema potrebe da ih pohranjujemo 

  la $a0, niz
 
  la $a1, size
  lw $a1, ($a1) #$a1 = size 

  sw $ra, 16($sp) #prilikom poziva isSorted ispod, $ra ce se promijeniti, zato se mora sacuvati na stacku kako bi mogli izaci iz main funkcije na samome kraju 

  jal isSorted # poziv funkcije isSorted(), vraca $v0 = 1 ako je sortiran niz  

  bne $v0, $0, nastavak #ako je $v0 != 0 odnosno ako je $v0 == 1 odnosno ako niz JESTE sortiran, skoci na nastavak
  
  la $t0, result #ako niz nije sortiran, u result treba pohraniti 0xdeadfa11
  lui $t1, 0xdead
  ori $t1, 0xfa11
  sw $t1, ($t0)

  j krajPrograma
nastavak:

  andi $t0, $a1, 1 # $t0 ce biti samo zadnji bit od $a1 kad uradimo $a1 & 0x00000001
  
  bne $t0, $0, neparan #ovjde ispod ide kod u slucaju da je paran broj elemenata, u suprotnom skace na neparan

  addiu $t0, $a1, -1 # t0 = size - 1, 
  sra $t0, $t0, 1
  sll $t0, $t0, 1 #iako shiftamo desno za bit pa lijevo, opet to moramo uraditi inace ne bude dobar broj jer je cjelobrojno dijeljenje
  addu $t0, $t0, $a0 # t0 = adresa od (size-1)/2 elementa u nizu 
  lh $t0, ($t0) # t0 = niz[(size-1)/2]

  addu $t1, $a0, $a1 #t1 = adresa od size/2 elementa u nizu 
  lh $t1, ($t1) # t1 = niz[size/2]

  addu $t0, $t0, $t1 # t0 = niz[(size-1)/2] + niz[size/2]
  sra $t0, $t0, 1 # t0 = t0/2

  la $t1, result
  sw $t0, ($t1)
  j krajPrograma 


neparan:
  sra $t0, $a1, 1 # $a1 broj elemenata u nizu, npr 5, (5 >> 1) = 2 => niz[2] = srednji clan
  sll $t0, $t0, 1 #$t0 je indeks srednjeg elementa, pomnozi se sa 2 jer su 16bitni brojevi u nizu 
  addu $t0, $t0, $a0
  lh $t0, ($t0)

  la $t1, result
  sh $t0, ($t1) 


  j krajPrograma

isSorted: # bool isSorted(int $a0[], int $a1); $a1 je ustvari size  // https://geeksforgeeks.org/program-check-array-sorted-not-iterative-recursive

  slti $v0, $a1, 2 # if (size < 2) odnosno da li je 1 ili 0 elemenata u nizu 
  bne $v0, $0, krajFunkcije # size < 2 TRUE


  addiu $t0, $0, 1 # $t0 = 1 (kao int i = 1 u petlji)
  j uslov
tijelo:
  sll $t2, $t0, 1 # 2t0 odnosno 2i 
  addu $t2, $t2, $a0 # 2i + adresa od niz
  lh $t4, ($t2)

  addiu $t2, $t0, -1 # t2 = t0-1 (odnosno i-1)
  sll $t2, $t2, 1 # t2 = 2*(i-1)
  addu $t2, $t2, $a0
  lh $t3, ($t2)
  

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
  lw $ra, 16($sp) #ucitamo $ra iz stacka koji smo sacuvali na pocetku 
  addiu $sp, $sp, 32 #dealociramo 4 bajta koji su alocirani na pocetku za $ra

  addiu $v0, $0, 0
  jr $ra
