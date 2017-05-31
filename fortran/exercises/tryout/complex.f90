program test_type
   complex :: z
   real :: a, b, c

   print *, 'Enter a: '
   read *, a
   print *, 'enter b: '
   read *, b
   print *, 'cmplx(a,b):', cmplx(a,b)
   z = cmplx(a,b)
   print *, 'z=(a,b):', z
   c = (-3,4)
   print *, 'c=(a,b):', c
end program test_type
