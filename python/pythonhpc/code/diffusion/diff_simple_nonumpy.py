import math

n = 100000
dx = 1.0
niters = 2000
kappa = 0.1

x = n * [0.0, ]
u = n * [0.0, ]
udt = n * [0.0, ]

for i in xrange(len(u)):
    u[i] = math.exp(-(dx * (i - n / 2))**2 / 100000)

#print("type is")
# print(type(u[0]))

fac = (1 - 2.0 * kappa)
for niter in xrange(niters):

    for i in xrange(1, len(u) - 1):
        udt[i] = fac * u[i] + kappa * (u[i + 1] + u[i - 1])

    for i in xrange(len(u)):
        u[i] = udt[i]
