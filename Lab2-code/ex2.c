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

/*
 * Create process tree for input file:
 */
void fork_proc(struct tree_node *node)
{
        //Initial process -> root of file
        int status, i;
        char *proc_name = node->name;
        change_pname(proc_name);
        printf("Created %s \n", proc_name);
        if (node->nr_children ==0) {
                printf("%s: Sleeping..\n", proc_name);
                sleep(SLEEP_PROC_SEC);
                return;
        }
        printf("%s: waiting..\n", proc_name);
        pid_t child_pid [node->nr_children];
        for (i=0 ; i<node->nr_children ; i++) {
                pid_t b = fork();
                child_pid[i] = b;
                if (b < 0) {
                        perror("error with creation of B");
                        exit(1);
                }
                if (b == 0) {
                        fork_proc(node->children + i);
                        exit(1);
                }
        }
        for (i=0; i<node->nr_children ; i++) {
                child_pid[i] = wait(&status);
                explain_wait_status(child_pid[i], status);
        }

        printf("%s: Exiting..\n", proc_name);
        exit(1);
}

int main(int argc, char **argv)
{
        pid_t pid;
        int status;

        struct tree_node *root;

        if (argc != 2) {
                fprintf(stderr, "Usage: %s <input_tree_file>\n\n", argv[0]);
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
                fork_proc(root);
        }

        sleep(SLEEP_TREE_SEC);

        /* Print the process tree root at pid */
        show_pstree(pid);

        /* Wait for the root of the process tree to terminate */
        pid = wait(&status);
        explain_wait_status(pid, status);

        return 0;
}
