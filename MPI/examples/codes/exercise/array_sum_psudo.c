/* pesuodo code for array-sum, code your own */

#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[]) {


  int my_id, root_process, num_procs, an_id, chank_size;
  MPI_Status status;

  int start_row, end_row;

  int array[1000];


  /* refer to the serial code to define necessary variables,
   * and the size of the array */

  root_process = 0;

  /* Now replicate this process to create parallel processes.*/

  MPI_Init(&argc, &argv);

  /* find out MY process ID, and how many processes were started */

  MPI_Comm_rank(MPI_COMM_WORLD, &my_id);
  MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

  if (my_id == root_process) {
    /* to determine how many rows per process to sum.
    *
    * initialize an array,
    *
    * distribute a portion of the array to each child process,
    *
    * and calculate the sum of the values in the segment assigned
    * to the root process,
    *
    * and, finally, I collect the partial sums from slave processes,
    * print them, and add them to the grand sum, and print it */

    int i, num_rows;
    long int sum;

    num_rows = 20;

    for (i = 0; i < num_rows; i++) {
      array[i] = i;
    }

    printf("num_proc: %d\n", num_procs);

    chank_size = num_rows / num_procs;

    printf("chank_size: %d\n", chank_size);

    for (int i = 1; i < num_procs; i++)
    {
      start_row = i * chank_size;
      end_row = (i + 1) * chank_size - 1;

      // printf("%d\n", start_row);
      MPI_Send(&start_row, 1, MPI_INT, i, 0, MPI_COMM_WORLD);
      MPI_Send(&end_row, 1, MPI_INT, i, 0, MPI_COMM_WORLD);
      MPI_Send(&array[start_row], chank_size, MPI_INT, i, 0, MPI_COMM_WORLD);
    }



  }

  else {

    // I must be slave process, so I must receive my array segment,
    // *
    // * calculate the sum of my portion of the array,
    // *
    // * and, finally, send my portion of the sum to the root process.
    MPI_Recv(&start_row, 1, MPI_INT, root_process, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    MPI_Recv(&end_row, 1, MPI_INT, root_process, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
    MPI_Recv(&array[start_row], end_row - start_row + 1, MPI_INT, root_process, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);

    printf("%d-%d\n", start_row, end_row);
    printf("array first element: %d\n", array[start_row + 1]);
  }

  /* Stop this process */

  MPI_Finalize();

  return 0;
}
