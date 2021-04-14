.section .text
.global transform
transform: #a0 = char* buffer, $a1 = size, $a2 = *predicate
 
 addiu $sp, $sp, -64
 sw $a0, 64($sp) #vjerovatno je dovoljno samo a0 sacuvati jer
 sw $a1, 60($sp) #se on koristi prilikom poziva predicate i dolazi
 sw $a2, 56($sp) #do mijejanja a0 ali dobra praksa je i ostale argumente
 sw $ra, 52($sp) #sacuvati na stacku s obzirom da je ova transform funkcija i caller jer poziva predicate

 addiu $t0, $0, 0 # t0 = 0 = i

uslov:
  slt $t1, $t0, $a1
  beq $t1, $0, kraj

  addu $t2, $a0, $t0 # &buffer[i] - adresa od i-tog elementa buffer niza

  lbu $a0, ($t2) # a0 = buffer[i] zbog poziva predicate
  jalr $a2 # poziv predicate(buffer[i])
  
  sb $v0, ($t2) # na adresu od buffer[i] spremimo return od predicate(buffer[i])

  lw $a0, 64($sp)
  lw $a1, 60($sp)
  lw $a2, 56($sp)

  addiu $t0, $t0, 1 # i++
  j uslov
kraj:
  lw $ra, 52($sp)
  addiu $sp, $sp, 64
  jr $ra
  
