program vec_array_struct
   implicit none
   integer(8):: i, n
   real, parameter:: a=1.0
   type point 
      real :: x, y
   end type point
   type(point), allocatable:: u(:) 
   integer:: c1, c2, clock_rate

   print *, 'Enter m:'
   read *, n

   allocate(u(n))
   do i=1,n
      call random_number(u(i)%x)
      call random_number(u(i)%y)
   enddo

   call system_clock(count_rate=clock_rate) !Find the time rate
   call system_clock(count=c1)
   do concurrent (i=1:n)
      u(i)%y = a*u(i)%x + u(i)%y
   enddo
   call system_clock(count=c2)
   print *, 'Elapsed time:', 1.0*(c2 - c1)/clock_rate, 'sec'
end program vec_array_struct
