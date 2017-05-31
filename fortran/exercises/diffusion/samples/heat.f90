! This program solves the 1D diffusion equation on a finite interval 
! [-L,L] for t > 0
!
!     u = au   ,  on (-L,L), u(x,0) = f(x), u(-L,t) = 0, u(L,t) = 0
!      t    xx
!
! where the initial condition f(x) takes the form
!
!     f(x) = H - |x|/eps if -eps <= x <= eps, and f(x) = 0 otherwise
! 
! using the explicit finite difference approach on a set of equally 
! spaced mesh points.
! 
! Copyrigh(C) 2001-2017 Western University
! Ge Baolai
! Faculty of Science
! WEstern University
! SHARCNET | Compute Canada
! E-mail: <bge@sharcnet.ca>
! Telephone: 519-661-2111 ext 88544
program heat
   implicit none
   real, allocatable, target :: wold(:), wnew(:)
   real, allocatable :: x(:)
   real, dimension(:), pointer :: uold, unew, tmp
   real :: a, dx, dt, r, xlim(2), height, eps
   integer(8) :: step, num_steps, output_steps, counter=0
   integer :: n, i, istart, iend
   character(80) :: ofile
   logical :: output_to_disk

   ! Input parameters
   open(10,file='input.dat',status='old')
   read(10,*) a
   read(10,*) dt
   read(10,*) num_steps
   read(10,*) output_steps
   read(10,*) xlim
   read(10,*) n
   read(10,*) eps
   read(10,*) height
   read(10,*) output_to_disk
   close(10)

   dx = (xlim(2) - xlim(1))/(n-1)
   r = a*dt/(dx*dx)

   ! Allocate spaces (we trade space/perforance for convenience)
   allocate(x(0:n+1),wold(0:n+1),wnew(0:n+1))
   uold => wold
   unew => wnew

   ! Set initial condition on uold, inititialize unew
   x = xlim(1) + [((i-1)*dx,i=0,n+1)]
   where (-eps <= x .and. x <= eps)
      uold = height - abs(x)/eps
   elsewhere
      uold = 0.0
   end where 

   ! Output the initial values
   if (output_to_disk) then
      write(ofile,'(i3.3)') counter
      ofile = 'output'//trim(adjustl(ofile))//'.dat'
      open(11,file=ofile,status='unknown')
      print *, 'Ouput to ', ofile
      write(11,'(2f15.7)') (x(i),uold(i),i=1,n)
      close(11)
   endif
   call pgbeg(0, "/xs", 1, 1)
   call pgask(0)
   call pgenv(xlim(1), xlim(2), 0., 1.0,  0,  0)
   call pgline(n,x(1),uold(1))
   counter = 1

   ! Perform time evolution process
   do step = 1, num_steps
      ! Calculate new value at each point
      do concurrent (i=1:n)
         unew(i) = (1.0 - 2*r)*uold(i) + r*(uold(i-1) + uold(i+1))
      end do

      ! Apply boundary conditions at two ends
      unew(1) = 0       ! Left end point
      unew(n) = 0       ! Right end point

      ! Output the current solution
      if (mod(step, output_steps) == 0) then
         if (output_to_disk) then
            write(ofile,'(i3.3)') counter
            ofile = 'output'//trim(adjustl(ofile))//'.dat'
            open(11,file=ofile,status='unknown')
            print *, 'Ouput to ', ofile
            write(11,'(2f15.7)') (x(i),unew(i),i=1,n)
            close(11)
         endif
         call pgeras
         call pgline(n,x(1),unew(1))
         counter = counter + 1
      endif

      ! Swap the storage - swap pointers instead of arrays
      tmp => uold
      uold => unew
      unew => tmp
   enddo

   call pgend

   ! Free spaces
   ! deallocate(x,uold,unew)
end program heat
