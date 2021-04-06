#include <stdio.h>
#include <stdint.h>

int16_t exchange(int16_t* a, int16_t b);
int16_t a = 69, b = 420;

int main() {
  
  int16_t* p = &a;
  int16_t result = exchange(p, b);


  printf("a = %d, b = %d, result = %d\n", a, b, result);
  return 0;
}
