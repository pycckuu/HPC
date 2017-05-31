! This program solves the 1D diffusion equation on a finite interval 
! [-L,L] for t > 0
!
!     u = au   ,  on (-L,L), u(x,0) = f(x), u(-L,t) = 0, u(L,t) = 0
!      t    xx
!
! where the initial condition f(x) takes the form
!
!     f(x) = 1 - |x|/eps if -eps <= x <= eps, and f(x) = 0 otherwise
! 
! using the explicit finite difference approach on a set of equally 
! spaced mesh points.
! 
! Copyrigh(C) 2016 Western University
! Ge Baolai <gebaolai@gmail.com>
! Faculty of Science | SHARCNET | Compute Canada
program heat
   implicit none
   ! Declared parameters and variables:
   ! a, dx, dt, xlim(2), eps, n, num_steps, output_steps
   ! wold, wnew, uold => wold, unew => wnew

   ! Input parameters

   ! Allocate spaces (we trade space/perforance for convenience)

   ! Set initial condition on uold, inititialize unew

   ! Output the initial values

   ! Perform time evolution process
   do step = 1, num_steps
      ! Calculate new value at each point

      ! Apply boundary conditions at two ends

      ! Output the current solution

      ! Swap the storage - swap pointers instead of arrays
   enddo

end program heat
