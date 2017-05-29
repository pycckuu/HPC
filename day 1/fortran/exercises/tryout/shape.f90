program test_shape
   real :: a(10,5,100)
   real(8) :: x(4)

   print *, 'shape(a):', shape(a)
   print *, 'shape(x):', shape(x)
end program test_shape
