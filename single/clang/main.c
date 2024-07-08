#include <stdio.h>

unsigned int fib(unsigned int count) {
  if (count <= 1)
    return count;
  return fib(count - 1) + fib(count - 2);
}

int main() {
  unsigned int count = 42;
  return printf("%u\n", fib(count));
}
