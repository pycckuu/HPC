program test_array_asgmt
   implicit none
   integer(8) :: i, j, n
   real :: x(500000000), y(500000000)
   integer :: c1, c2, crate

   x = 0.0
#ifndef USE_LOOP
   call system_clock(c1,crate)
   y = x + 1
   call system_clock(c2,crate)
   !print *, 'Time (sec) on y=x+1:', (c2-c1)/real(crate)
#else

   call system_clock(c1,crate)
   do i = 1, n
      y(i) = x(i) + 1
   enddo
   call system_clock(c2,crate)
   !print *, 'Time (sec) on y=x+1 with loop', (c2-c1)/real(crate)
#endif
end program test_array_asgmt
