#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "proc-common.h"

#define SLEEP_PROC_SEC  2
#define SLEEP_TREE_SEC  1

/*
 * Create this process tree:
 * A-+-B---D
 *   `-C
 */
void fork_procs(void)
{
        pid_t b,c,d;
        int status;
        change_pname("A");
        printf("Created A\n");
        b = fork();
        if (b < 0) {
                perror("error with creation of B");
                exit(1);
        }
        if (b == 0) {
                change_pname("B");
                printf("Created B\n");
                d = fork();
                if (d < 0) {
                        perror("error with creation of D");
                        exit(1);
                }
                else if (d == 0) {
                        change_pname("D");
                        printf("Created D\n");
                        printf("D: Sleeping...\n");
                        sleep(SLEEP_PROC_SEC);
                        printf("D exiting\n");
                        exit(13);
                }
                printf("B: waiting\n");
                d = wait(&status);
                explain_wait_status(d,status);
                printf("B: exiting\n");
                exit(19);
        }
        c = fork();
        if (c < 0) {
                perror("error with creation of C");
                exit(1);
        }
        else if (c == 0) {
                change_pname("C");
                printf("Created C\n");
                printf("C: sleeping...\n");
                sleep(SLEEP_PROC_SEC);
                printf("C exiting\n");
                exit(17);
        }
        printf("A: waiting..\n");
        b = wait(&status);
        explain_wait_status(b,status);
        c = wait(&status);
        explain_wait_status(c,status);
        printf("A: Sleeping...\n");
        sleep(SLEEP_PROC_SEC);
        printf("A: Exiting...\n");
        exit(16);
}

/*
 * The initial process forks the root of the process tree,
 * waits for the process tree to be completely created,
 * then takes a photo of it using show_pstree().
 *
 * How to wait for the process tree to be ready?
 * In ask2-{fork, tree}:
 *      wait for a few seconds, hope for the best.
 * In ask2-signals:
 *      use wait_for_ready_children() to wait until
 *      the first process raises SIGSTOP.
 */
int main(void)
{
        pid_t pid;
        int status;

        /* Fork root of process tree */
        pid = fork();
        if (pid < 0) {
                perror("main: fork");
                exit(1);
        }
        if (pid == 0) {
                /* Child */
                fork_procs();
                exit(1);
        }

        /*
         * Father
         */
        /* for ask2-signals */
        /* wait_for_ready_children(1); */

        /* for ask2-{fork, tree} */
        sleep(SLEEP_TREE_SEC);

        /* Print the process tree root at pid */
        show_pstree(pid);

        /* for ask2-signals */
        /* kill(pid, SIGCONT); */

        /* Wait for the root of the process tree to terminate */
        pid = wait(&status);
        explain_wait_status(pid, status);

        return 0;
}
