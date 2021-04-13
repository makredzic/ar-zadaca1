#include <stdio.h>
#include <stdint.h>

void reverse(char* buffer, int size)  {
  size = size - 1;
  int i = 0;
  while (i < size) {
    char temp = buffer[i];
    buffer[i] = buffer[size];
    buffer[size] = temp;
    ++i;
    --size;
  }
} 

int toBinary(char* buffer, int num); /*{
  int i = 0; 
  while (num != 0) { 
    int res = num % 2; 
    buffer[i++] = res + 48; 
    num = num / 2; 
  }

  reverse(buffer, i); 
  return i; 
 }*/ 

int main() {
  char buff[100]; 

  int z = toBinary(buff, 30);
  buff[z] = '\0';

  printf("Binary: %s\n", buff);
  return 0;
}
