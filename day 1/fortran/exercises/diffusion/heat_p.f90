! This program demonstrates a parallel implemation of the numerical
! solution of the 1D diffusion equation on a finite interval 
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
   real, allocatable, target :: wold(:), wnew(:)
   real, allocatable :: x(:)[:], u(:)[:]
   real, dimension(:), pointer :: uold, unew, tmp
   real :: a[*], dx, dt[*], r, xlim(2)[*], eps[*], u_lshare[*], u_rshare[*]
   integer :: n[*], np, step, num_steps[*], output_steps[*]
   integer :: i, istart, iend, me

end program heat
