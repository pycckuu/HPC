/* Example using MPI_Send and MPI_Recv to pass a message around in a ring */

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
  /* Initialize the MPI environment */
  MPI_Init(&argc,&argv);

 /* Find out rank, size */
 int my_rank;
 MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

 int num_procs;
 MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

 int token;

 /* Receive from the lower process and send to the higher process. Take care
    of the special case when you are the first process to prevent deadlock.*/
 if (my_rank != 0) {
    MPI_Recv(&token, 1, MPI_INT, my_rank-1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Process %d received token %d from process %d\n", my_rank, token, my_rank-1);
 } 
 else {
 // Set the token's value if you are process 0
    token = -1;
 }
 MPI_Send(&token, 1, MPI_INT, (my_rank+1)%num_procs, 0, MPI_COMM_WORLD);

 // Now process 0 can receive from the last process. This makes sure that at
 // least one MPI_Send is initialized before all MPI_Recvs (again, to prevent
 // deadlock)
 if (my_rank == 0) {
    MPI_Recv(&token, 1, MPI_INT, num_procs-1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    printf("Process %d received token %d from process %d\n", my_rank, token, num_procs-1);
 }

 MPI_Finalize();

}
