program integerkinds
   use iso_fortran_env
   implicit none

   integer :: i
   integer(kind=int8)  :: i8
   integer(kind=int16) :: i16
   integer(kind=int32) :: i32
   integer(kind=int64) :: i64
   integer(kind=selected_int_kind(6)) :: j6
   integer(kind=selected_int_kind(15)):: j15

   real :: x
   real(8) :: dx
   complex :: z
   complex(8) :: dz

   print *, 'Default:', huge(i)
   print *, 'Max integer (kind 8):', huge(i8)
   print *, 'Max integer (kind 16):', huge(i16)
   print *, 'Max integer (kind 32):', huge(i32)
   print *, 'Max integer (kind 64):', huge(i64)

   print *, 'Selected Integer kind 6:', huge(j6)
   print *, 'Selected Integer kind 15:', huge(j15)


   print *, 'Real number representation:'
   print *, '  Radix real:', radix(x)
   print *, '  Significant digists of real:', digits(x)
   print *, '  Significant digists of real(8):', digits(dx)
   print *, '  Precision of real:', precision(x)
   print *, '  Precision of real(8):', precision(dx)
   print *, '  Precision of complex:', precision(z)
   print *, '  Precision of complex(8):', precision(dz)
end program integerkinds
