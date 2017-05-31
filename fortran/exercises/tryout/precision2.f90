program test_select_x_kind
   implicit none
   integer :: n1
   integer(kind=selected_int_kind(38)) :: n2
   real :: v
   real(kind=selected_real_kind(15)) :: v15
   real(kind=selected_real_kind(7)) :: v7
   integer, parameter:: k5=selected_int_kind(5)
   integer, parameter:: k7=selected_real_kind(7)
   integer, parameter:: k15=selected_real_kind(15)

   print '("Precision of literal constants:")'
   print '("32768_k5=",i10)', 32768_k5
   print '("32769_k5=",i10)', 32769_k5
   print '("0.1_k15=",f30.20)', 0.1_k15
   print '("0.1234567_k7=",f30.20)', 0.1234567_k7
   print '("0.25_k15=",f30.20)', 0.25_k15

   print *, 'Enter a large integer:'
   read *, n1
   print *, n1
   print *, 'Enter a large integer:'
   read *, n2
   print *, n2

   print *, 'Enter a real number:'
   read *, v
   print *, v

   print *, 'Enter a real numbe with at least 7 digits:'
   read *, v7
   print *, v7

   print *, 'Enter a real number with at least 15 digits:'
   read *, v15
   print *, v15
end program test_select_x_kind
