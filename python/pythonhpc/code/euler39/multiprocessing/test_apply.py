import time
import os
from multiprocessing import Pool

def f():
    start=time.time()
    time.sleep(2)
    end=time.time()
    print "inside f pid",os.getpid()
    return end-start


print "master process PID", os.getpid()
p = Pool(processes=8)

result = p.apply(f)
print "apply is blocking"
print "total time",result

result=p.apply_async(f)
print "apply_async is non-blocking"

while not result.ready():
    time.sleep(0.5)
    print "working on something else while result computes"

print "total time",result.get()
