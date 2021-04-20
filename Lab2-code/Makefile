.PHONY: all clean

all: fork-example tree-example ask2-fork ask2-signals ex1.o ex1-fork ex2.o ex2-fork ex3.o ex3-signals ex4.o ex4-expr

CC = gcc
CFLAGS = -g -Wall -O2
SHELL= /bin/bash

tree-example: tree-example.o tree.o
        $(CC) $(CFLAGS) $^ -o $@

fork-example: fork-example.o proc-common.o
        $(CC) $(CFLAGS) $^ -o $@

ask2-fork: ask2-fork.o proc-common.o
        $(CC) $(CFLAGS) $^ -o $@

ask2-signals: ask2-signals.o proc-common.o tree.o
        $(CC) $(CFLAGS) $^ -o $@

ex1.o: ex1.c
        $(CC) -Wall -c ex1.c

ex1-fork: ex1.o proc-common.o
        $(CC) $(CFLAGS) $^ -o $@

ex2.o: ex2.c
        $(CC) -Wall -c ex2.c

ex2-fork: ex2.o proc-common.o tree.o
        $(CC) $(CFLAGS) $^ -o $@

ex3.o: ex3.c
        $(CC) -Wall -c ex3.c

ex3-signals: ex3.o proc-common.o tree.o
        $(CC) $(CFLAGS) $^ -o $@

ex4.o: ex4.c
        $(CC) -Wall -c ex4.c

ex4-expr: ex4.o proc-common.o tree.o
        $(CC) $(CFLAGS) $^ -o $@

%.s: %.c
        $(CC) $(CFLAGS) -S -fverbose-asm $<

%.o: %.c
        $(CC) $(CFLAGS) -c $<

%.i: %.c
        gcc -Wall -E $< | indent -kr > $@

clean:
        rm -f *.o tree-example fork-example pstree-this ask2-{fork,tree,signals,pipes}
