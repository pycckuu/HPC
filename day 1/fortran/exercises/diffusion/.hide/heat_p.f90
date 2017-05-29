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

   ! Input parameters
   me = this_image()
   if (1 == me) then
      ! Read parameters from the input file
      open(10,file='input.dat',status='old')
      read(10,*) a
      read(10,*) dt
      read(10,*) num_steps
      read(10,*) output_steps
      read(10,*) xlim
      read(10,*) n
      read(10,*) eps
      close(10)

      ! Broadcast to peers (collective communication yet to have)
      do i = 2, num_images()
         a[i] = a
         dt[i] = dt
         num_steps[i] = num_steps
         output_steps[i] = output_steps
         xlim(:)[i] = xlim(:)
         n[i] = n
         eps[i] = eps
      enddo
   endif
   
   sync all
   dx = (xlim(2) - xlim(1))/(n-1)
   np = n / num_images()
   r = a*dt/(dx*dx)

   ! Allocate spaces (we trade space/perforance for convenience)
   allocate(x(0:n+1)[*],wold(0:n+1),wnew(0:n+1),u(0:n+1)[*])
   uold => wold
   unew => wnew

   ! Set initial condition on uold, inititialize unew
   x = xlim(1) + [((i-1)*dx,i=0,n+1)]
   where (-eps <= x .and. x <= eps)
      uold = 1.0 - abs(x)/eps
   elsewhere
      uold = 0.0
   end where 

   ! Output the initial values
   if (1 == me) then
      call pgbeg(0, "/xwindow", 1, 1)
      call pgask(0)
      call pgenv(xlim(1), xlim(2), 0., 1.0,  0,  0)
      call pgline(n,x(1),uold(1))
   endif

   ! Perform time evolution process
   istart = np*(me - 1) + 1
   iend = istart + np + mod(n,num_images())
   do step = 1, num_steps
      ! Calculate new value at each point
      forall (i=istart:iend)
         unew(i) = (1.0 - 2.0*r)*uold(i) + r*(uold(i-1) + uold(i+1))
      end forall
      u_lshare = unew(istart+1)
      u_rshare = unew(iend-1)
      sync all

      ! Apply boundary conditions and process ghost points
      unew(1) = 0       ! Left end point
      unew(n) = 0       ! Right end point
      if (1 < me) then
         unew(istart-1) = u_rshare[me-1]
      endif
      if (me < num_images()) then
         unew(iend+1) = u_lshare[me+1]
      endif

      ! Assemble the global solution for output on image 1
      sync all
      u(istart:iend-1) = unew(istart:iend-1)
      if (me /= 1) then
         u(istart:iend-1)[1] = u(istart:iend-1)
      endif

      ! Output the current solution
      if (mod(step, output_steps) == 0 .and. 1 == me) then
         call pgeras
         call pgline(n,x(1),u(1))
      endif

      ! Swap the storage - swap pointers instead of arrays
      tmp => uold
      uold => unew
      unew => tmp
   enddo

   if (1 == me) then
      call pgend
   endif

   ! Free spaces
   sync all
   ! deallocate(x,uold,unew)
end program heat
