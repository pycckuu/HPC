program num2str
   integer:: n
   real:: r
   character(len=80):: s1, s2

   print *, 'Enter an integer: '
   read(*,*) n
   print *, 'Enter a number: '
   read(*,*) r

   write(s1,*) n
   print *, s1
   write(s2,*) r
   print *, s2

   s2 = 'Number to string: '//trim(s1)//'_'//trim(adjustl(s2))
   print *, s2
end program num2str
