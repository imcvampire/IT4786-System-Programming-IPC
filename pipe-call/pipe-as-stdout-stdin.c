#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main() {
  int processed_data;
  int file_pipes[2];
  const char some_data[] = "123";
  pid_t fork_result;

  if (pipe(file_pipes) == 0) {
    fork_result = fork();
    if (fork_result == (pid_t)-1) {
      fprintf(stderr, "Fork failure");
      return EXIT_FAILURE;
    }
    if (fork_result == (pid_t)0) {
      close(0);
      dup(file_pipes[0]);
      close(file_pipes[0]);
      close(file_pipes[1]);
      execlp("od", "od", "-c", (char *)0);
      return EXIT_FAILURE;
    } else {
      close(file_pipes[0]);
      processed_data = write(file_pipes[1], some_data, strlen(some_data));
      close(file_pipes[1]);
      printf("%d - wrote %d bytes\n", (int)getpid(), processed_data);
    }
  }

  return 0;
}
