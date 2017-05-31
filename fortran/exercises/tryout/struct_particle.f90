module mydef
   type particle
      real :: m
      real :: x, y
      real :: u, v
   end type particle
end module mydef

program type_example
   use mydef
   type(particle) :: p, q
  
   p = particle(1.2,-1.0,3.0,0.5,2.0)
   q = p

   print *, 'Particle q:'
   print *, '  m=', q%m
   print *, '  x=', q%x, ', y=', q%y
   print *, '  u=', q%u, ', v=', q%v
end program type_example
