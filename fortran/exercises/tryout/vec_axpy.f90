! 1) Compile the source using loop
!
!    gfortran -cpp vec_axpy.f90 -o vec_axpy
!
! 2) Compile the source using BLAS routine
!
!    gfortran -cpp -DUSE_BLAS vec_axpy -o vec_axpy_blas -lblas
!
! Compare the run time, with large m, e.g. m=10000000
program vec_axpy
   implicit none
   integer(8):: i, n
   real(8), allocatable:: x(:), y(:)
   real(8), parameter:: a=1.0
   integer:: c1, c2, clock_rate

   print *, 'Enter m:'
   read *, n
   allocate(x(n),y(n))

   call random_number(x)
   call random_number(y)

   call system_clock(count_rate=clock_rate) !Find the time rate
   call system_clock(count=c1)
#ifndef USE_BLAS
   y = a*x + y
#else
   call daxpy(n,a,x,1,y,1)
#endif
   call system_clock(count=c2)
   print *, 'Elapsed time:', 1.0*(c2 - c1)/clock_rate, 'sec'
end program vec_axpy
