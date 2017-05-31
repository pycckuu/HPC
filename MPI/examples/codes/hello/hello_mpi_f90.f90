! Fortran example
program hello_mpi_f90
include 'mpif.h'
      
integer ierr,my_id, num_procs

call mpi_init(ierr)

call mpi_comm_rank(MPI_COMM_WORLD,my_id,ierr)
call mpi_comm_size(MPI_COMM_WORLD,num_procs,ierr)

!print rank and size to screen

print*, "Hello World! I am process ", my_id, "out of ", num_procs, "processors "

call mpi_finalize(ierr)

end
