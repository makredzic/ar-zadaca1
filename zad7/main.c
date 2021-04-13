#include <stdio.h>
#include <stdint.h>

int32_t n2[10] = {0,2,4,6,8,-8,-6,-4,-2,0};
int32_t n1[10] = {1,3,5,7,9,-9,-7,-5,-3,-1};

void swap(void* f, void* s, uint32_t size); 
  /*uint8_t *fb = (uint8_t*)f;
  uint8_t *sb = (uint8_t*)s;

  for (int i = 0; i < size; ++i) {
    uint8_t temp = fb[i];
    fb[i] = sb[i];
    sb[i] = temp;
  }
*/

void printNiz(int32_t* niz, uint32_t size) {
  int i = 0;
  while ( i < size) {
    printf("%d ", niz[i]);
    ++i;
  }
  printf("\n");
};

int main() {
  printf("Before swap:\n");
  printNiz(n1, 10);
  printNiz(n2, 10);

  swap(n1, n2, 40);

  printf("After swap: \n");
  printNiz(n1, 10);
  printNiz(n2, 10);

  return 0;
};
