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
! from t=0 to t=N*dt, over N time steps, using only one storage unit u
! for the temperature.

program vec_vs_loop
   implicit none
   real, allocatable, target :: u(:) 
   integer:: j, n, num_steps
   real, parameter:: r = 0.5

   ! Read number of spatial points
   print *, 'Enter n:'
   read *, n
   print *, 'Enter num of time steps:'
   read *, num_steps

   ! Allocate spaces and make pointers point to them accordingly
   allocate(u(0:n+1)) ! 0 and n+1 are end points

   ! Set initial temperature at the middle of the rod
   if (mod(n,2) == 0) then
      u(n/2) = 1
      u(n/2+1) = 1
   else
      u(n/2+1) = 1
   endif

   ! March on time
   do j = 1, num_steps
      u(1:n) = (1.0 - 2*r)*u(1:n) + r*(u(0:n-1) + u(2:n+1))
   enddo

   ! Check results
   print '(f20.7)', u
end program vec_vs_loop

