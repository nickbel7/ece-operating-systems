#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv)
{
        int fd;
        fd = open(argv[1], O_RDONLY);
        if (fd == -1){
                perror("open");
                exit(1);
        }
        if (argv[3]) printf("%s\n", argv[3]);
        // perform read(..)
        char buff[1024];
        ssize_t rcnt;
        for (;;){
                rcnt = read(fd,buff,sizeof(buff)-1);
                if (rcnt == 0) /* end-of-file */
                        return 0;
                if (rcnt == -1){ /* error */
                        perror("read");
                        return 1;
                }
        buff[rcnt] = '\0';
        fprintf(stdout, "%s", buff);
        }
        close(fd);
        return 0;
}
