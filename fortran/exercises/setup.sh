# This file should be sourced.

if [ -z $PGPLOT_DIR ]; then
    PGPLOT_DIR=/home/bge/lib/pgplot
    PGPLOT_FONT=${PGPLOT_PATH}/grfont.dat
    PGPLOT_PATH=${PGPLOT_DIR}
fi
PGPLOT_DEV=/xs

if [ -z $LIBCAF_MPI_PATH ]; then
    LIBCAF_MPI_PATH=/home/bge/lib/opencoarrays/lib
fi

export PGPLOT_DIR PGPLOT_FONT PGPLOT_DEV PGPLOT_PATH
export LD_LIBRARY_PATH=$PGPLOT_PATH:$LD_LIBRARY_PATH
export LIBCAF_MPI_PATH

module unload intel mkl openmpi
module load gcc/5.1.0
module load openmpi/gcc510-std/1.8.7
