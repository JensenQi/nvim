#include "bar.h"
#include "foo.h"

#include <stdio.h>

int main() {
  printf("Simple example C compiled correctly and ran.\n");
  char *words = hello_world();
  int size = word_count(words);
  printf("%s word count %d\n", words, size);
  return 0;
}
