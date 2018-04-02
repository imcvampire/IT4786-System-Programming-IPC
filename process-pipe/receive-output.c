#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  FILE *f;
  char buffer[BUFSIZ + 1];
  int chars_read;

  memset(buffer, 0, sizeof(buffer));
  f = popen("uname -a", "r");
  if (f != NULL) {
    chars_read = fread(buffer, sizeof(char), BUFSIZ, f);
    if (chars_read > 0) {
      printf("Output: %s \n", buffer);
    }
    pclose(f);
    return 0;
  }
  return EXIT_FAILURE;
}
