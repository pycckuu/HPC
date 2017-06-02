# make sure a module with python that supports MPI is available
# on SHARCNET, accomplish this by executing:
#
# also need to provide find_num_solutions generated with Cython

# to run:
# mpirun -np 4 python mpi4py_greetings.py

from mpi4py import MPI
import find_num_solutions

comm = MPI.COMM_WORLD
myid = comm.Get_rank()
nprocs = comm.Get_size()

nmax=0 ; imax=0 ; N=1000

for i in range(1,N):

    if(i%nprocs==myid):
        nsols=find_num_solutions.find_num_solutions(i)
        if(nsols>nmax):
            nmax=nsols ; imax=i

nmax_global=comm.allreduce(nmax,op=MPI.MAX)
if(nmax_global==nmax):
    print "process ",myid,"found maximum at ",imax

MPI.Finalize

