from pylab import *
import numpy as np

kappa=0.1

n=100000
dx=1.0
#niters=50000
niters=500

x=np.arange(n,dtype="float64")
u=np.empty(n,dtype="float64")
udt=np.empty(n,dtype="float64")

u_init = lambda x: np.exp( -(dx*(x-n/2))**2/100000) 
u=u_init(x)
plot (x,u,)

udt[:]=0.0

fac=(1-2.0*kappa)
for i in xrange(niters):
    udt[1:-1]=u[1:-1]+kappa*(u[0:-2]+u[2:]-2*u[1:-1])
    u[:]=udt[:]

plot (x,u,'r')
xlim([48000,52000])
#savefig('foo.eps')
show()


