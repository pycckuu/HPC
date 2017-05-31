/* example for different tasks */
#include <stdio.h>
#include <mpi.h>

int main(int argc, char **argv) {
  int my_id, num_procs;

  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_id);
  MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

  if ( my_id == 0 ) {
    printf("Hello! I'm the master with process ID %d\n", my_id);
  }
  else if ( my_id == 1 ) {
    printf("Hi, my process ID is %d\n", my_id);
  }
  else if ( my_id == 2 ) {
    printf("My process ID is %d\n", my_id);
  }
  else {
    printf("What! I'm the others, with process ID %d\n", my_id);
  }
  /* Stop MPI processes */
  MPI_Finalize();
}

