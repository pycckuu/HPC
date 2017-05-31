! See also https://www.tutorialspoint.com/fortran/
program test_inquiry_functions
   use, intrinsic :: iso_fortran_env
   implicit none

   integer, parameter :: sp = REAL32
   integer, parameter :: dp = REAL64
   integer, parameter :: qp = REAL128

   real (kind = 4) :: a
   real (kind = 8) :: b
   integer (kind = 2) :: i
   integer (kind = 4) :: j
   integer (kind = 8) :: k

   real(sp):: r4
   real(dp):: r8
   real(qp):: r16

   print *,'precision of real(4) =', precision(a)
   print *,'precision of real(8) =', precision(b)

   print *,'precision of real(REAL4) =', precision(r4)
   print *,'precision of real(REAL8) =', precision(r8)
   print *,'precision of real(REAL16) =', precision(r16)
   
   print *,'range of real(4) =', range(a)
   print *,'range of real(8) =', range(b)

   print *,'maximum exponent of real(4) =' , maxexponent(a)
   print *,'maximum exponent of real(8) =' , maxexponent(b)
  
   print *,'minimum exponent of real(4) =' , minexponent(a)
   print *,'minimum exponent of real(8) =' , minexponent(b)
   
   print *,'bits in integer(2) =' , bit_size(i)
   print *,'bits in integer(4) =' , bit_size(j)
   print *,'bits in integer(8) =' , bit_size(k)
end program test_inquiry_functions
