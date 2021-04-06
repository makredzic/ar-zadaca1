.section .data
.global str
str: .asciiz "abcbcba"

.section .bss
.global result
result: .byte

.section .text
.globl main
main:
  la $t0, str # t0 = str

  addiu $t1, $0, 0 # t1 = i = 0
  addiu $t2, $0, 0 # t2 = size = 0
  
  j uslov
  tijelo:
    addiu $t2, $t2, 1 # ++t2 odnosno ++size 
  uslov:
    addu $t4, $t0, $t2 # t4 = adresa_od_str + size odnosno str[size]
    lb $t3, ($t4) # t3 = str[size]
    beq $t3, $0, krajPetlje
    j tijelo 
  
krajPetlje: # nakon petlje, $t2 je size str
  addiu $t2, $t2, -1 # u c programu, j = size - 1; medjutim, posto size nigdje nam vise nece trebati, dovoljno je direktno size odnosno t2 smanjiti za 1

  j uslov2
  tijelo2:
    addu $t3, $t1, $t0 # t3 = i + adresa od str
    lb $t3, ($t3) # t3 = str[t3]
    
    addu $t4, $t2, $t0 # t4 = j + adresa od str
    lb $t4, ($t4) # t4 = str[t4]

    bne $t3, $t4, nijePalindrom # if (str[i] != str[j]) goto nijePalindrom 

    addiu $t1, $t1, 1 # i=i + 1
    addiu $t2, $t2, -1 # j = j - 1
  uslov2:
    slti $t3, $t2, 2 # if ( j < 2) t3 = 1 
    beq $t3, $0, tijelo2 # if (t3 == 0) goto tijelo2; to jest if (!(j<2)) goto tijelo2; to jest if (j>=2) goto tijelo2; to jest if (j > 1) goto tijelo 2; 

la $t0, result
addiu $t1, $0, 1
sb $t1, ($t0) # u result upise 1 jer jest palindrom
j krajPrograma

nijePalindrom:
la $t0, result
addiu $t1, $0, 0
sb $t1, ($t0) # u result upise 0 jer nije palindrom


krajPrograma:

  addiu $v0, $0, 0
  jr $ra
  
