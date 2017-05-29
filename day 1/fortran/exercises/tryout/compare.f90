program any_all
   real :: a(10), b(10)

   call random_number(a)
   call random_number(b)

   if (any(a > b)) then
      print *, 'An elem in A > an elem in B'
   endif

   if (all(a > b)) then
      print *, 'All elem in A > elems in B'
   else if (all(b > a)) then
      print *, 'All elem in B > elems in A'
   else
      print *, 'Set A and B overlap'
   endif
end program any_all
