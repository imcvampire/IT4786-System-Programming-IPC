#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BIN_PATH "bin/pipe-call/"
#define CONSUMER_FILE_NAME "consumer"
#define CONSUMER_FILE_PATH BIN_PATH CONSUMER_FILE_NAME

int main() {
  int data_processed;
  int file_pipes[2];
  const char some_data[] = "123";
  pid_t fork_result;
  char buffer[BUFSIZ + 1];
  memset(buffer, 0, sizeof(buffer));

  if (pipe(file_pipes) == 0) {
    fork_result = fork();
    if (fork_result == (pid_t)-1) {
      fprintf(stderr, "Fork failure");
      return EXIT_FAILURE;
    }

    if (fork_result == 0) {
      sprintf(buffer, "%d", file_pipes[0]);
      (void)execl(CONSUMER_FILE_PATH, "consumer", buffer, (char *)0);
      return EXIT_FAILURE;
    } else {
      data_processed = write(file_pipes[1], some_data, strlen(some_data));
      printf("%d - wrote %d bytes\n", getpid(), data_processed);
    }
  }
  return 0;
}
