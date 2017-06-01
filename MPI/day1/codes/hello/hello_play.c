/* play for yourself */
#include <stdio.h>
#include <mpi.h>

int main(int argc, char **argv) {
    int my_id, num_procs;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_id);
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    if ( my_id == 0 ) {
        /* do some work as process 0 */
    }
    else if ( my_id == 1 ) {
        /* do some work as process 1 */
    }
    else if ( my_id == 2 ) {
        /* do some work as process 2 */
    }
    else {
        /* do this work in any remaining processes */
    }

    /* Stop MPI processes */
    MPI_Finalize();
}

