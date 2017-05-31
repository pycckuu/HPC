#FC = f90
FC = mpif90
FFLAGS += -cpp -std=f2008 -fcoarray=lib -DUSE_X11 #-DDEBUG0 -DDEBUG1 
LDFLAGS += -L$(LIBCAF_MPI_PATH) -lcaf_mpi -L$(PGPLOT_PATH) -lpgplot -lX11
