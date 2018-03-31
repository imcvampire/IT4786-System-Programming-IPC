#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main() {
  FILE *f;
  char buffer[BUFSIZ + 1];
  sprintf(buffer, "Hello World!!!!");
  f = popen("cat", "w");
  if (f != NULL) {
    fwrite(buffer, sizeof(char), strlen(buffer), f);
    pclose(f);
    return 0;
  }
  return EXIT_FAILURE;
}
