/* This program sums all rows in an array using MPI parallelism.
 *
 * The root process acts as a master and sends a portion of the
 * array to each child process.  
 * Master and child processes then
 * all calculate a partial sum of the portion of the array assigned
 * to them, 
 * and the child processes send their partial sums to 
 * the master, who calculates a grand total.
 *
 * Your tasks are to fill out:
 * MPI (send, recv) commands
 * and calculate partial sum 
**/

#include <stdio.h>
#include <mpi.h>
   
#define max_rows 100000
#define send_data_tag 2001
#define return_data_tag 2002

int array[max_rows];
int array2[max_rows];
   
int main(int argc, char *argv[]) 
{
  long int sum, partial_sum;
  MPI_Status status;
  int my_id, root_process, i, num_procs;
  int an_id, num_rows_to_receive, avg_rows_per_process; 
  int sender, num_rows_received, start_row, end_row, num_rows_to_send;

  /* define num_rows */
  //int num_rows=18;
  int num_rows=20;

  /* Now replicte this process to create parallel processes.
   * From this point on, every process executes a seperate copy
   * of this program */

  MPI_Init(&argc,&argv);
     
  root_process = 0;
      
  /* find out MY process ID, and how many processes were started. */
     
  MPI_Comm_rank(MPI_COMM_WORLD, &my_id);
  MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

  if(my_id == root_process) {
         
     /* determine how many rows per process to sum. */
     avg_rows_per_process = num_rows/num_procs;

     /* initialize an array */
     for(i=0; i<num_rows; i++) {
       array[i] = i+1;
       printf("%d\n", array[i]);
     }

     /* distribute a portion of the bector to each child process */
     for(an_id=1; an_id<num_procs; an_id++) {
        start_row=an_id*avg_rows_per_process;
        end_row=(an_id + 1)*avg_rows_per_process-1;

       if(num_rows-end_row < avg_rows_per_process)
        end_row = num_rows-1;

       num_rows_to_send = end_row-start_row + 1;

       // MPI_Send here
       
      
     
     }

     /* and calculate the sum of the values in the segment assigned
      * to the root process here*/
 

  
     } 

     printf("sum %ld calculated by process %d\n", sum, root_process);

     /* and, finally, I collet the partial sums from the slave processes, 
      * print them, and add them to the grand sum, and print it */

     for(an_id=1; an_id<num_procs; an_id++) {
       // MPI_Recv here
  
       sender = status.MPI_SOURCE;

       printf("Partial sum %ld returned from process %d\n", partial_sum, sender);
     
        sum += partial_sum;
      }

      printf("The grand total is: %ld\n", sum);
  } 

   else {

     /* I must be a slave process, so I must receive my array segment,
      * storing it in a "local" array, array2. */

     // MPI_Recv number of rows here 
          
     // MPI_Recv array elements here; 

     num_rows_received = num_rows_to_receive;

     /* Calculate the sum of my portion of the array */





    printf("Partial sum %ld calculated by process %d\n", partial_sum, my_id); 
    printf("Number of rows summed by process %d is %d\n", my_id, num_rows_received); 

     /* and finally, send my partial sum to hte root process */

     MPI_Send(&partial_sum,1,MPI_LONG,root_process,return_data_tag,MPI_COMM_WORLD);
   }

   MPI_Finalize();
}
