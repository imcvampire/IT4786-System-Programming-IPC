#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

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
