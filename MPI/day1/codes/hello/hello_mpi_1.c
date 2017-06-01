/* first example */
#include <stdio.h> 
#include <mpi.h> 

main(int argc, char *argv[]) {

    MPI_Init(&argc, &argv); 

    printf("Hello World\n"); 

    MPI_Finalize();

} 
