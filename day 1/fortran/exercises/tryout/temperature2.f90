! A rod is heated in the middle, the temperature T along the rod changes
! over time, which can be approximated by the following formula
!
!   T(x,t+dt) = (1 - r)*T(x,t) + r(T(x-dx,t) + T(x+dx,t))
!
! where r is a parameter determined by the physics and the numerical
! approximation used. That is, the temperature at location i at next 
! time t+dt can be computed using the temperatures at locations i-1, i
! and i+1 at current time t.
! 
! This examples shows the calculation of temperature across the rod 
! from t=0 to t=N*dt, over N time steps.
!
! Note: To compile the code using loop for temperature, use command
!
!     gfortran -cpp temperature2.f90 -o temperature2
!
! To compile the code using block assignment, use command
!
!     gfortran -cpp -DUSE_NO_LOOP temperature2.f90 -o temperature2

program vec_vs_loop
   implicit none
   real, allocatable, target :: w(:), wnew(:) ! Spaces for u and unew
   real, dimension(:), pointer :: u, unew, tmp ! Pointers to spaces
   integer:: i, j, n, num_steps
   real, parameter:: r = 0.5

   ! Read number of spatial points
   print *, 'Enter n:'
   read *, n
   print *, 'Enter num of time steps:'
   read *, num_steps

   ! Allocate spaces and make pointers point to them accordingly
   allocate(w(0:n+1),wnew(0:n+1)) ! 0 and n+1 are end points
   u => w
   unew => wnew

   ! Set initial temperature at the middle of the rod
   if (mod(n,2) == 0) then
      u(n/2) = 1
      u(n/2+1) = 1
   else
      u(n/2+1) = 1
   endif

   ! March on time
   do j = 1, num_steps
#ifndef NO_LOOP
      ! Loop over all location points
      do concurrent (i=1:n)
         unew(i) = (1.0 - 2*r)*u(i) + r*(u(i-1) + u(i+1))
      end do
#else
      ! Or use the alternative expression without explicit loop
      unew(1:n) = (1.0 - 2*r)*u(1:n) + r*(u(0:n-1) + u(2:n+1))
#endif

      ! Swap storages by swaping pointers instead of values
      tmp => u
      u => unew
      unew => tmp
   enddo

   ! Check results
   print '(f20.7)', u
end program vec_vs_loop

