#include <stdint.h>

void transform(char* buffer, int32_t size, char (*predicate)(char)) {
  int i = 0;
  while (i < size) {
    buffer[i] = predicate(buffer[i]); //u ovom slucaju, predicate uzima 1 karakter i vrati taj karakter kao UPPERCASE
    ++i;
  }
}
