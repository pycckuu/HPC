from pylab import *
import numpy as np

kappa=0.1

n=100000
dx=1.0
niters=500

x=np.arange(n,dtype="float64")
u=np.empty(n,dtype="float64")
udt=np.empty(n,dtype="float64")

# initialize
for i in xrange(len(u)):
    u[i]=np.exp( -(dx*(i-n/2))**2/100000)

plot (x,u,'ro')

# iterate over time steps
for i in xrange(niters):

# compute value after evolving over single time step
    for i in xrange(1,len(u)-1):
        udt[i]=u[i]+kappa*(u[i+1]+u[i-1]-2.0*u[i])

# update value of u
    for i in xrange(len(u)):
        u[i]=udt[i]

plot (x,u,'r')
xlim([48000,52000])
show()

