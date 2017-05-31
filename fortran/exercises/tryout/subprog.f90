! This example demonstrates how to define an interface to two subroutines
! taking (optional) arguments of different data types, an easy way of
! facilitating polymorphism.
module lapack2015
   implicit none
   interface solve
      module procedure ssolve
      module procedure dsolve
   end interface

contains

subroutine ssolve(a,b,ipiv,info)
   implicit none
   real :: a(:,:), b(:)
   integer, optional :: ipiv(:), info
   integer :: m, n
   integer, allocatable :: iperm(:)
   integer :: ierr

   m = size(a,dim=1)
   n = size(a,dim=2)

   if (m /= n) then
      info = 1
      print *, 'Matrix must be square'
      return
   endif

   allocate(iperm(n))
   call sgesv(n, 1, a, n, iperm, b, n, ierr)
   if (present(ipiv)) then
      ipiv = iperm 
   endif
   if (present(info)) then
      info = ierr
   endif
end subroutine ssolve

subroutine dsolve(a,b,ipiv,info)
   implicit none
   real(8) :: a(:,:), b(:)
   integer, optional :: ipiv(:), info
   integer :: m, n
   integer, allocatable :: iperm(:)
   integer :: ierr

   m = size(a,dim=1)
   n = size(a,dim=2)

   if (m /= n) then
      info = 1
      print *, 'Matrix must be square'
      return
   endif

   allocate(iperm(n))
   call dgesv(n, 1, a, n, iperm, b, n, ierr)
   if (present(ipiv)) then
      ipiv = iperm 
   endif
   if (present(info)) then
      info = ierr
   endif
end subroutine dsolve

end module lapack2015

program test_solve
   use lapack2015
   implicit none
   real :: a(5,5), b(5), x(5)
   real(8) :: da(5,5), db(5), dx(5)
   integer :: i, n, ipiv(5), info

   a(1,:) = [ 2,-1, 0, 0, 0]
   a(2,:) = [-1, 2, 1, 0, 0]
   a(3,:) = [ 0,-1, 2,-1, 0]
   a(4,:) = [ 0, 0,-1, 2,-1]
   a(5,:) = [ 0, 0, 0,-1, 2]

   x = [1, 1, 1, 1, 1]
   b = matmul(a,x)
   da = a
   db = b

   call solve(a,b,ipiv,info)
   print '(5f8.2)', b
   print '(5i5)', ipiv
   print '("info: ",i5)', info

   call solve(da,db)
   print '(5f8.2)', db
end program test_solve


