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
! from t=0 to t=dt, a single time step.
!
! Question: How to calculate the temperature over N time steps?

program vec_vs_loop
   implicit none
   real, allocatable:: u(:), unew(:) ! u for T at t, unew for T at t+dt
   integer:: i, n
   real, parameter:: r = 0.5

   ! Read number of spatial points
   print *, 'Enter n:'
   read *, n

   ! Allocate spaces for arrays
   allocate(u(0:n+1),unew(0:n+1)) ! 0 and n+1 are end points
   u = 0

   ! Set initial temperature at the middle of the rod
   if (mod(n,2) == 0) then
      u(n/2) = 1
      u(n/2+1) = 1
   else
      u(n/2+1) = 1
   endif

   ! Loop over all location points
   do concurrent (i=1:n)
      unew(i) = (1.0 - 2*r)*u(i) + r*(u(i-1) + u(i+1))
   end do
   print *, 'After one time step:'
   print '(f10.2)', unew

   ! Alternative expression without explicit loop
   unew(1:n) = (1.0 - 2*r)*u(1:n) + r*(u(0:n-1) + u(2:n+1))
   print *, 'After one time step - with alternative expression:'
   print '(f10.2)', unew
end program vec_vs_loop

