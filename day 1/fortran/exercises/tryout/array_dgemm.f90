! This program compares the performance of three implementations of 
! matrix-matrix multiplications
!
! To compile using gfortran, use the following command
!
!     gfortran array_dgemm.f90 -O2 -lblas
!
! To compile using intel ifort, try the following command options
!
!     ifort array_dgemm.f90 -O2 -o array_dgemm \
!         -L$MKLROOT/lib/intel64 -lmkl_intel_lp64 -lmkl_core \
!         -lmkl_sequential -lpthread -lm
!
! where '\' means line continuation.
program array_dgemm
   implicit none
   real(8), allocatable :: a(:,:), b(:,:), c(:,:)
   integer :: i, j, k, n
   integer :: c1, c2, crate

   ! Initialize parameters
   print *, 'Enter n:'
   read *, n

   ! Get system clock rate
   call system_clock(count_rate=crate)

   ! Allocate spaces
   allocate(a(n,n),b(n,n),c(n,n))

   ! Generate n-by-n random matrices
   call random_number(a)
   call random_number(a)

   ! Perform C = A*B by definition
   call system_clock(c1)
   do i = 1, n
      do j = 1, n
         c(i,j) = 0.0d0
         do k = 1, n
            c(i,j) = c(i,j) + a(i,k)*b(k,j)
         enddo
      enddo
   enddo 
   call system_clock(c2)
   print *, 'Naiive implementation:', 1.0*(c2-c1)/crate, 'sec'

   ! Perform multiplication in an alternative way (unit stride)
   call system_clock(c1)
   do j = 1, n
      c(:,j) = a(:,1)*b(1,j)
      do k = 2, n
         c(:,j) = c(:,j) + a(:,k)*b(k,j)
      end do
   end do
   call system_clock(c2)
   print *, 'Modified implementation:', 1.0*(c2-c1)/crate, 'sec'

   ! Perform C = A*B using intrinsic MATMUL()
   call system_clock(c1)
   c = matmul(a,b)
   call system_clock(c2)
   print *, 'MATMUL:', 1.0*(c2-c1)/crate, 'sec'

   ! Perform C = A*B using BLAS routine DGEMM (See man page of DGEMM)
   call system_clock(c1)
   call dgemm('N', 'N', n, n, n, 1.0d0, a, n, b, n, 0.0d0, c, n)
   call system_clock(c2)
   print *, 'DGEMM:', 1.0*(c2-c1)/crate, 'sec'
end program array_dgemm
