program array_operations
   integer :: a(10), b(2,3)

   a = [(i,i=1,10)]

   print '("a:        ",10i5)', a
   print '("a(:):     ",10i5)', a(:)
   print '("a(4:):    ",10i5)', a(4:)
   print '("a(:6):    ",10i5)', a(:6)
   print '("a(2:5):   ",10i5)', a(2:5)
   print '("a(::3):   ",10i5)', a(::3)
   print '("a(2:4:2): ",10i5)', a(2:4:2)
   print '("a(9:1:-2):",10i5)', a(9:1:-2)
   print '("a(1::2):  ",10i5)', a(1::2)

   b = reshape(a,[2,3])
   print '("b(2,3) = reshape(a,[2,3]):")'
   print '(3i5)', b
end program array_operations
