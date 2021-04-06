#include <stdio.h>
#include <stdint.h>

const char* str = "wrorw";
int8_t result;


int main() {

  int i = 0, size = 0;

  while (str[size] != '\0') ++size;

  int j = size - 1;

  while (j > 1) { // geeksforgeeks.org/c-program-check-given-string-palindrome
    if (str[i] != str[j]) {
      printf("Nije palindrom.\n");
      goto kraj;
    }
    i = i+1;
    j = j-1;
  }
  printf("Jest palindrom.\n");
kraj:
return 0;
}
