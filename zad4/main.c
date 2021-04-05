#include <stdio.h>
#include <stdint.h>

const int16_t niz[] = {1, 2, 3, 4, 5};
int32_t result, size = 5;


int isSorted(const int16_t arr[], int32_t n);


int main() {

  if (!isSorted(niz, size)) return result = 0xdeadfa11;

  if ((size & 1) != 0) goto neparan;

  result = (niz[ (size-1)/2 ] + niz[size/2]) / 2.0;
  
  printf("Median je %d.\n", result);
  return 0;

neparan:

  result = niz[size>>1];

  printf("Median je %d.\n", result);
  return 0;
}


int isSorted(const int16_t arr[], int32_t n) {
  if (n < 2) return 1;

  for (int i = 1; i < n; i++) {
    if (arr[i] < arr[i-1]) return 0;
  }
  
  return 1; 
};
