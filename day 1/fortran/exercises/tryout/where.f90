program test_where
   real :: a(10), b(10)

   b = [-1,-1,0,0,1,-1,0,1,-1,1]
   a = 0
   print *, 'a:'
   print '(10f5.0)', (a(i), i = 1,10)
   print *, 'b:'
   print '(10f5.0)', (b(i), i = 1,10)

   where (b < 0) a = b
   print *, 'where (b<0) a=b:'
   print '(10f5.0)', (a(i), i = 1,10)

   where (b /= 0)
      a = a/b
   elsewhere
      a = 0
   endwhere
   print *, 'where (b /= 0) a=a/b elsewhere a = 0:'
   print '(10f5.0)', (a(i), i = 1,10)
end program test_where
