! 1) Compile the source using loop
!
!    gfortran -cpp merge.f90 -o merge_loop
!
! 2) Compile the source using merge()
!
!    gfortran -cpp -DUSE_MERGE merge.f90 -o merge
!
! Compare the run time, with large m, e.g. m=10000000
program test_do_concurrent
   implicit none
   integer(8):: i, m
   real, allocatable:: a(:), b(:), c(:), d(:)
   integer:: c1, c2, clock_rate
   logical, allocatable:: mask(:)

   print *, 'Enter m:'
   read *, m
   allocate(a(m),b(m),c(m),d(m),mask(m))

   call random_number(a)
   call random_number(b)
   c = 1.5
   d = -0.5

   call system_clock(count_rate=clock_rate) !Find the time rate

   call system_clock(count=c1)
#ifndef USE_MERGE
   do concurrent (i=1:m)
      if (a(i) > b(i)) then
         a(i) = a(i) - b(i)*d(i)
      else
         c(i) = c(i) + a(i)
      endif
   enddo
#else
   mask = a > b
   a = a - merge(b*d,0.,mask)
   c = c + merge(a,0.,mask)
#endif
   call system_clock(count=c2)
   print *, 'Elapsed time using merge():', &
      1.0*(c2 - c1)/clock_rate, 'sec'
end program test_do_concurrent
