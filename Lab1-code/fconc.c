#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void doWrite(int fd, char *buff, int len) {
        int idx;
        ssize_t wcnt;
        idx = 0;
        do {
                wcnt = write(fd,buff + idx, len - idx);
                if (wcnt == -1){
                        perror("write error");
                        return;
                }
                idx += wcnt;
        } while (idx < len);
        return;
}

void write_file(int fd, const char *infile) {
        int fd_temp;
        fd_temp = open(infile, O_RDONLY, S_IRUSR);
        if (fd_temp == -1){
                perror("open");
                exit(1);
        }
        char buff[1024];
        ssize_t rcnt;
        for (;;){
                rcnt = read(fd_temp, buff, sizeof(buff)-1);
                if (rcnt == 0)
                        break;
                if (rcnt == -1){
                        perror("read");
                        return;
                }
                buff[rcnt] = '\0';
                doWrite(fd, buff, rcnt);
        }
        close(fd_temp);
}

int main(int argc, char **argv)
{
        int fd_out, fd_tempfile, oflags, mode;
        oflags = O_CREAT | O_WRONLY | O_TRUNC;
        mode = S_IRUSR | S_IWUSR;
        fd_tempfile = open("tempfile", oflags, mode);
        write_file(fd_tempfile, argv[1]);
        write_file(fd_tempfile, argv[2]);
        if (argc == 4)
                fd_out = open(argv[3], oflags, mode);
        else if (argc == 3)
                fd_out = open("fconc.out", oflags, mode);
        if (fd_out == -1){
                perror("open");
                exit(1);
        }
        write_file(fd_out, "tempfile");
        close(fd_out);
        remove("tempfile");
        return 0;
}
