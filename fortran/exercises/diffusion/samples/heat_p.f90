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
! Copyrigh(C) 2001-2017 Western University
! Ge Baolai
! WEstern University
! SHARCNET | Compute Canada
! E-mail: <bge@sharcnet.ca>
! Telephone: 519-661-2111 ext 88544

program heat
   implicit none
   real, allocatable, target :: wold(:), wnew(:)
   real, allocatable :: x(:)[:], u(:)[:]
   real, dimension(:), pointer :: uold, unew, tmp
   real :: a[*], dx, dt[*], r, xlim(2)[*], eps[*], u_lshare[*], u_rshare[*]
   integer :: n[*], np, step, num_steps[*], output_steps[*]
   integer :: i, istart, iend, me, counter=0
   character(80) :: ofile

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
#ifdef DEBUG0
   print '("Image ",i3,": np=",i3)', me, np
#endif

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
#ifdef USE_X11
      call pgbeg(0, "/xs", 1, 1)
      call pgask(0)
      call pgenv(xlim(1), xlim(2), 0., 1.0,  0,  0)
      call pgline(n,x(1),uold(1))
#else
      write(ofile,'(i3.3)') counter
      ofile = 'output'//trim(adjustl(ofile))//'.dat'
      open(11,file=ofile,status='unknown')
      print *, 'Ouput to ', ofile
      write(11,'(2f15.7)') (x(i),uold(i),i=1,n)
      close(11)
#endif
   endif
   counter = 1

   ! Perform time evolution process
   istart = np*(me - 1) + 1
   iend = istart + np + mod(n,num_images())
#ifdef DEBUG1
   print '("Image ",i3," start, end indices: ",i3,i3)', me, istart, iend
#endif
   do step = 1, num_steps
      ! Calculate new value at each point
      forall (i=istart:iend)
         unew(i) = (1.0 - 2*r)*uold(i) + r*(uold(i-1) + uold(i+1))
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
#ifdef DEBUG1
         print '("Image ",i2," sending u(",i3,i3,") to image 1")', me, istart, iend-1
#endif
         u(istart:iend-1)[1] = u(istart:iend-1)
      endif

      ! Output the current solution
      if (mod(step, output_steps) == 0 .and. 1 == me) then
#ifdef USE_X11
         call pgeras
         call pgline(n,x(1),u(1))
#else
         write(ofile,'(i3.3)') counter
         ofile = 'output'//trim(adjustl(ofile))//'.dat'
         open(11,file=ofile,status='unknown')
         print *, 'Ouput to ', ofile
         write(11,'(2f15.7)') (x(i),u(i),i=1,n)
         close(11)
#endif
         counter = counter + 1
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
