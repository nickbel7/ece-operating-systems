void compute_and_output_mandel_line(int fd, int line)
{
        /*
         * A temporary array, used to hold color values for the line being drawn
         */
        int i;
        for(i=line;i<y_chars;i+=(*NPROC)){
            int color_val[x_chars];
            compute_mandel_line(i, color_val);
            sem_wait(&semaphore[i % (*NPROC)]);
            output_mandel_line(fd, color_val);
            sem_post(&semaphore[(i+1) % (*NPROC)]);
        }
    }

int main(int argc, char **argv)
{
        if(argc!=2){
                perror("Too few args\n");
                exit (3);
        }
        NPROC= (int*) malloc(sizeof(int));
        safe_atoi(argv[1],NPROC);

        xstep = (xmax - xmin) / x_chars;
        ystep = (ymax - ymin) / y_chars;

        /*
         * draw the Mandelbrot Set, one line at a time.
         * Output is sent to file descriptor '1', i.e., standard output.
         */

        //====Creating the Semaphores======
        semaphore=create_shared_memory_area((*NPROC)*sizeof(sem_t));
        int i;
        for (i=0; i<(*NPROC);i++){
            if(i==0) sem_init(&semaphore[i],1,1);
                else sem_init(&semaphore[i], 1, 0);
        }

        //====Creating forks=======
        int line;
        for (line = 0; line < (*NPROC); line++) {
            if(fork()==0){
                compute_and_output_mandel_line(1, line);
                exit(2);
            }
        }

        //====Waiting for children & freeing mem====
        for (line = 0; line <(*NPROC); line++) {
            wait(NULL);
        }

        destroy_shared_memory_area(semaphore,(*NPROC)*sizeof(sem_t));

        reset_xterm_color(1);
        return 0;
}
