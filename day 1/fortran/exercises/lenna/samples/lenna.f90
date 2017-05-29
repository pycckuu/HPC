! This program demonstrates the use of Fortran coarray for parallel
! processing. When run in parallel, each instance of the program loads
! an image file containing a portion of the portrait of Lena Söderberg.
! The main process (image 1 - in the term of Fortran) collects from
! other processes the portions of Lenna and assembles them to restore
! the original whole picture.
!
! Copyright(C) 2001-2017 Western University
! Ge Baolai <bge@sharcnet.ca>
! Western University
! SHARCNET | Compute Ontario | Compute Canada
! 519-661-2111 ext 88544

program lenna
   implicit none
   integer, allocatable:: pic(:,:), pic_p(:,:)[:]
   integer:: nx, ny, nx_p[*], ny_p[*], depth, p, q
   integer:: id, i, i1, i2, j1, j2, row, col
   character(80):: base_name[*], img, fmt

   ! Process 0 (image 1) reads parameters for restoring the image
   if (this_image() == 1) then
      open(10,file='input.dat',status='old')
      read(10,'(a)') base_name
      read(10,*) nx, ny
      read(10,*) p, q
#ifdef DEBUG
      print *, 'Image file base name: ', trim(base_name)
      print *, 'Image size: ', nx, ny
      print *, 'Image partition: ', p, q
#endif
      close(10)
      allocate(pic(nx,ny))
   endif

   ! Each process loads a piece of PGM image file into array pic_p
   sync all
   write(img,*) this_image()-1  ! Make string of image (proc) number
   img = adjustl(img)   ! Remove leading spaces
   img = trim(base_name[1])//'_'//trim(img)//'.pgm' ! e.g. Lenna_2.pgm
   open(10,file=img,status='old')
   read(10,*)   ! Skip the header of magic string "P2"
   read(10,*) nx_p, ny_p
   read(10,*) depth
   allocate(pic_p(nx_p,ny_p)[*])
   do i = 1, ny_p
      read(10,*) pic_p(i,:)
   enddo
   close(10)
   sync all
   
   ! Process 0 collects pieces of image from others and restore them
   if (this_image() == 1) then
      ! Collect pieces from other processes and assemble them
      pic(1:nx_p,1:ny_p) = pic_p
      do i = 2, num_images()
         row = (i-1) / q
         col = mod((i-1),q)
         i1 = row*ny_p + 1
         i2 = i1 + ny_p[i] - 1  ! Last one might be smaller
         j1 = col*nx_p + 1
         j2 = j1 + nx_p[i] - 1  ! Last one might be smaller
         pic(i1:i2,j1:j2) = pic_p(:,:)[i]
      enddo

      ! Write the assembled image to a PGM file
      img = trim(base_name)//'_whole'//'.'//'pgm'      ! e.g. Lenna.pgm
      open(11,file=img,status='unknown')
      write(11,'("P2")')
      write(11,'(i3,i4)') nx, ny
      write(11,'(i3)') depth
      write(fmt,'(i3)') nx-1
      fmt = '(i3,'//trim(fmt)//'i4)'         ! e.g. '(i3,255i4)'
      do i = 1, ny
         write(11,fmt) pic(i,:)
      enddo
      close(11)
   endif
end program lenna
