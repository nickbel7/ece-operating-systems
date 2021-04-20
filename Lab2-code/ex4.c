#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "tree.h"
#include "proc-common.h"

#define SLEEP_PROC_SEC  2
#define SLEEP_TREE_SEC  1

const int INT_LEN = sizeof( int );

int do_write(int fd, int data)
{
    int status;
    int bytes_written = 0;
    while (bytes_written < INT_LEN) {
        status = write(fd, (void*)(&data), INT_LEN);
        if ( status < 0 ) {
            return -1;
        }
        bytes_written += status;
    }
    return 0;
}

int do_read(int fd, int *data)
{
    int bytes_read=0;
    int status;

    while (bytes_read < INT_LEN) {
        status = read(fd, (void*)(data), INT_LEN);
        if (status < 0) {
            return -1;
        }
        bytes_read += status;
    }
    return 0;
}

void fork_proc(struct tree_node *node, int fd)
{
        int  i, status;
        char *proc_name = node->name;
        pid_t b;
        int f[2][2], res1, res2, res;
        change_pname(proc_name);
        printf("Created %s: \n", proc_name);
        if (node->nr_children == 0) {
                do_write(fd, atoi(node->name)); //write to file descriptor (atoi: string to int)
                printf("Reached leaf node: %s\n", proc_name);
                exit(0);
        }
        pid_t child_pid[2];
        for (i=0 ; i<node->nr_children ; i++) {
                printf("Parent %s: Creating pipe...\n", proc_name);
                pipe(f[i]);
                b = fork();
                child_pid[i] = b;
                if (b < 0) {
                        perror("error with creation of B");
                        exit(1);
                }
                if (b == 0) {
                        printf("Child name: %s\n", node->children[i].name);
                        close(f[i][0]);
                        fork_proc(node->children+i, f[i][1]);
                }
        }
        do_read(f[0][0], &res1);
        printf("received value: %d\n", res1);
        do_read(f[1][0], &res2);
        printf("received value: value = %d\n", res2);
        switch (node->name[0]) {
                case '+':
                        res = res1 + res2;
                        break;
                case '*':
                        res = res1 * res2;
                        break;
        }
        do_write(fd, res);

        for (i=0; i<node->nr_children; i++) {
                child_pid[i]=wait(&status);
                explain_wait_status(child_pid[i], status);
                close(f[i][1]);
        }

        exit(0);
}
int main(int argc, char **argv)
{
        pid_t pid;
        int status, result;
        int pfd[2];
        struct tree_node *root;

        if (argc != 2) {
                fprintf(stderr, "Usage: %s <input_tree_file>\n\n", argv[0]);
                exit(1);
        }

        printf("Parent: Creating pipe...\n");
        if (pipe(pfd) < 0) {
                perror("pipe");
                exit(1);
        }

        root = get_tree_from_file(argv[1]);
        /* Fork root of process tree */
        pid = fork();
        if (pid < 0) {
                perror("main: fork");
                exit(1);
        }
        if (pid == 0) {
                /* Child */
                fork_proc(root, pfd[1]);
                exit(1);
        }
        close(pfd[1]);
        pid = wait(&status);
        explain_wait_status(pid, status);
        do_read(pfd[0], &result);

        sleep(SLEEP_TREE_SEC);

        /* Print the process tree root at pid */
        show_pstree(pid);

        printf("Result: %i\n", result);

        /* Wait for the root of the process tree to terminate */
        pid = wait(&status);
        explain_wait_status(pid, status);

        return 0;
}
