program string
   implicit none
   character(80):: file_name
   integer:: nx, ny, depth

   print *, 'Enter file name: '
   read(*,*) file_name
   open(10,file=file_name,status='old')
   read(10,*) file_name
   read(10,*) nx, ny
   read(10,*) depth
   print *, 'file name:', file_name
   print *, 'nx=', nx, 'ny=', ny
   print *, 'depth=', depth
   close(10)
end program string
