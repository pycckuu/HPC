from mpi4py import MPI
# to run:
# mpirun -np 4 python euler39_mpi.py 
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
nprocs = comm.Get_size()

if rank != 0:
   data = "Greetings from process "+str(rank) 
   comm.send(data, dest=0)
else :
    for procid in range(1,nprocs):
        data = comm.recv(source=procid)
        print "process 0 receives message from process",procid,":",data

