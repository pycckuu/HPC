program test_size
   real :: a(10,5)
   real(8) :: x(4)

   print *, 'size(a):', size(a)
   print *, 'size(a,dim=1):', size(a,dim=1)
   print *, 'size(a,dim=2):', size(a,dim=2)
   print *, 'size(x):', size(x)
end program test_size
