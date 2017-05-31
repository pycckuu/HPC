program test_pack
   implicit none
   real :: a(5), v(5)
   logical :: m(5)

   a = [1,2,3,4,5]
   m = [.FALSE.,.TRUE.,.TRUE.,.FALSE.,.FALSE.]
   print *, pack(a,m)
   print *, pack(a,a>=3)
end program test_pack
