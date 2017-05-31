/* simplest sebd-recv, test for 2 processes or more*/

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){

  // Initialize the MPI environment
  MPI_Init(&argc,&argv);

  // Find out rank, size
  int my_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

  int num_procs;
  MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

  int number;
  if (my_rank == 0) {
  // If we are rank 0, set the number to -1 and send it to process 1
    number = -1;
    MPI_Send(&number, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
  } else if (my_rank == 1) {
     MPI_Recv(&number, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
     printf("Process 1 received number %d from process 0\n", number);
  }

  // We are assuming at least 2 processes for this task
  if (num_procs < 2) {
     fprintf(stderr, "World size must be greater than 1 for %s\n", argv[0]);
             MPI_Abort(MPI_COMM_WORLD, 1);
  }

 MPI_Finalize();

}
