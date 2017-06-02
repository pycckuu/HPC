import time
from multiprocessing import Pool

def f(x):
    return x**3

y = range(int(1e7))
p= Pool (processes=8)

start= time.time()
results = p.map(f,y)
end = time.time()

print "map blocks on launching process"
print "time,",end-start

#print results

# map_async

start = time.time()
results = p.map_async(f,y)
print "map_async is non-blocking on launching process"
output = results.get()
end=time.time()
print "time",end-start
#print output
