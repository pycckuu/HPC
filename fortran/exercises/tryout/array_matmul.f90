program agen
   implicit none
   integer, parameter :: n=5
   real :: a(n,n), b(n), x(n)
   integer :: i

   a(1,:) = [ 2,-1, 0, 0, 0]
   a(2,:) = [-1, 2,-1, 0, 0]
   a(3,:) = [ 0,-1, 2,-1, 0]
   a(4,:) = [ 0, 0,-1, 2,-1]
   a(5,:) = [ 0, 0, 0,-1, 2]

   x = [1,1,1,1,1]
   b = matmul(a,x)

   print *, 'A:'
   print '(5f5.0)', a
   print *, 'x:'
   print '(f5.0)',x
   print *, 'b = A*x:'
   print '(f5.0)', b
end program agen
