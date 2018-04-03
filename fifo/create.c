#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
  int res = mkfifo("/tmp/my_fifo", 0777);
  if (res == 0) {
    printf("FIFO created\n");
    return 0;
  } else {
    return EXIT_FAILURE;
  }
}
