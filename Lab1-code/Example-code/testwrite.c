#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main(int argc, char **argv)
{
        int fd, oflags, mode;
        oflags = O_CREAT | O_WRONLY | O_TRUNC;
        mode = S_IRUSR | S_IWUSR;
        fd = open(argv[1], oflags, mode);
        if (fd == -1){
                perror("open");
                exit(1);
        }
// perform write(...)
        char buff[1024];
        size_t len, idx;
        ssize_t wcnt;
        for (;;){
                if (fgets(buff,sizeof(buff),stdin) == NULL)
                        return 0;
                idx = 0;
                len = strlen(buff);
                do {
                        wcnt = write(fd,buff + idx, len - idx);
                        if (wcnt == -1){ /* error */
                                perror("write");
                                return 1;
                        }
                        idx += wcnt;
                } while (idx < len);
        }
        close(fd);
        return 0;
}
