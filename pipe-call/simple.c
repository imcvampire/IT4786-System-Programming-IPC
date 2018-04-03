#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  int processed_data;
  int file_pipes[2];
  const char some_data[] = "123";
  char buffer[BUFSIZ + 1];
  memset(buffer, 0, sizeof(buffer));

  if (pipe(file_pipes) == 0) {
    processed_data = write(file_pipes[1], some_data, strlen(some_data));
    printf("Wrote %d bytes\n", processed_data);
    processed_data = read(file_pipes[0], buffer, BUFSIZ);
    printf("Read %d bytes: %s\n", processed_data, buffer);
    return 0;
  }
  return EXIT_FAILURE;
}
