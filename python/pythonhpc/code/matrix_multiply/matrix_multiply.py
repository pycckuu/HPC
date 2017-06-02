import time
# numpy.show_config()
N=16384
M=512
import numpy as np
A=np.random.random((N, M))
B=np.random.random((M, N))

start= time.time()
C=np.dot(A,B)
end = time.time()

print "time to multiply matrices N=",N,"M=",M, end-start,"seconds"
