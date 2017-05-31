module interval_math
   implicit none
   type interval
      real :: lo
      real :: up
   end type interval
   interface operator(+)
      module procedure interval_add
   end interface
contains
function interval_add(x, y) result(z)
   implicit none 
   type(interval), intent(in) :: x, y
   type(interval) :: z

   z%lo = x%lo + y%lo 
   z%up = x%up + y%up 
end function interval_add
end module interval_math

program test_struct
   use interval_math
   real :: a, b
   type(interval) :: w, u, v

   u = interval(-1.0, 1.0)
   a = w%lo - 0.5
   b = w%up - 0.5
   v = interval(a,b)
   w = u + v

   print *, 'a', a, ', b=', b
   print *, 'u%lo=', u%lo, ', u%up=', u%up
   print *, 'v%lo=', v%lo, ', v%up=', v%up
   print *, 'w%lo=', w%lo, ', w%up=', w%up
end program test_struct
