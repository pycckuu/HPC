program test_array_asgmt
   implicit none
   integer(8) :: i, j, n
   real, allocatable :: a(:,:), b(:,:)
   integer :: c1, c2, crate

   print *, 'Enter n: '
   read *, n

   allocate(a(n,n),b(n,n))

   call system_clock(c1,crate)
   a = 0.0
   call system_clock(c2,crate)
   print *, 'Time (sec) on a=0:', (c2-c1)/real(crate)

#ifndef USE_LOOP
   call system_clock(c1,crate)
   b = a + 1
   call system_clock(c2,crate)
   print *, 'Time (sec) on b=a+1:', (c2-c1)/real(crate)
#else

   call system_clock(c1,crate)
   do j = 1, n
      do i = 1, n
         b(i,j) = a(i,j) + 1
      enddo
   enddo
   call system_clock(c2,crate)
   print *, 'Time (sec) on b=a+1 with loops:', (c2-c1)/real(crate)
#endif
end program test_array_asgmt
