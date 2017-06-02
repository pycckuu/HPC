import time
import ctypes

find_num_solutions = ctypes.CDLL('./testlib.so')



assert find_num_solutions.find_num_solutions(10)==0,"should have zero solutions for p=10"
assert find_num_solutions.find_num_solutions(12)==1,"should have one solution for p=12, as 3*3+4*4=5*5 and 3+4+5=12"
assert find_num_solutions.find_num_solutions(120)==3,"should have 3 solutions for p=120"

nrange=1000
# nrange = 5000
nmax=0
imax=0

start= time.time()
for i in range(1,nrange):
    nsols=find_num_solutions.find_num_solutions(i)
    if(nsols>nmax):
        nmax=nsols
        imax=i
end = time.time()

print "loop up to ", nrange , "took ", end - start, "seconds"

assert imax==840, "not getting the right answer"
assert nmax==8, "not getting the right number of solutions"
print imax,nmax
