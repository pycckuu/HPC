program shift
   integer :: a(5)
   integer :: b(4,4)
   integer :: i

   a = [3,4,5,6,7]
   print '("a:           ",5i5)', a
   print *
   print '("cshift(a,1):  ",5i5)', cshift(a,1)
   print '("cshift(a,-1): ",5i5)', cshift(a,-1)
   print *
   print '("eoshift(a,1): ",5i5)', eoshift(a,1)
   print '("eoshift(a,-1):",5i5)', eoshift(a,-1)

   b = reshape([(i,i=1,16)],[4,4])
   print *
   print '("b:")'
   print '(4i5)', b
   print *
   print '("cshift(b,1):")'
   print '(4i5)', cshift(b,1)
   print *
   print '("eoshift(b,1):")'
   print '(4i5)', eoshift(b,1)
end program shift
