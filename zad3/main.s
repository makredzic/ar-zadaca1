.section .text
.global main
main: #u $t0 ucitan nasumican 32bitni broj
  lui $t0, 0x6bc3
  ori $t0, 0xfa28 # $t0 = 0110 1011 1100 0011  1111 1010 0010 1000

  lui $t1, 0x77ff
  ori $t1, 0xbffe #$t1 = 0111 0111 1111 1111  1011 1111 1111 1110

  and $v0, $t0, $t1#v0 = 0110 0011 1100 0011  1011 1010 0010 1000
  jr $ra
