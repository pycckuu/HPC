program vec_struct_array
   implicit none
   integer(8):: i, n
   real, parameter:: a=1.0
   type points 
      real, allocatable:: x(:)
      real, allocatable:: y(:)
   end type points
   type(points):: u
   integer:: c1, c2, clock_rate

   print *, 'Enter m:'
   read *, n

   allocate(u%x(n),u%y(n))
   call random_number(u%x)
   call random_number(u%y)

   call system_clock(count_rate=clock_rate) !Find the time rate
   call system_clock(count=c1)
   do concurrent (i=1:n)
      u%y(i) = a*u%x(i) + u%y(i)
   enddo
   call system_clock(count=c2)
   print *, 'Elapsed time:', 1.0*(c2 - c1)/clock_rate, 'sec'
end program vec_struct_array
