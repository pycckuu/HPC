#FC = f90
FC = mpif90
FFLAGS += -cpp -std=f2008 -fcoarray=lib -DDEBUG
LDFLAGS += -L$(LIBCAF_MPI_PATH) -lcaf_mpi
