program array_asgmt
   real :: a(5), b(3,5)

   a = [1,2,3,4,5]
   b(:,1) = a(1:3)
   print *, a
   print *, b
end program array_asgmt
