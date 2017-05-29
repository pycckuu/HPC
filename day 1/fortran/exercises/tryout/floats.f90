program floats
   integer, parameter :: dp=kind(1.0d0)
   real(dp) :: a, b, c

   open(10,file='ab.dat',status='old')
   read(10,*) a
   read(10,*) b
   print *, a*b
   read(10,*) a
   read(10,*) b
   print *, a*b
end program floats
