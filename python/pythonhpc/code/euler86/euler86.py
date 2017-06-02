import math

"""
Euler problem number 86, from https://projecteuler.net/problem=86

note that for cube of sides of size (x y z) with x <= y <= z
the shortest from one corner to its opposite corner is

sqrt( (x+y)^2 + z^2 )

We are looking for cases when that path is an integer.

"""

def checkpsq(i):
    """
    check if i is perfect square
    """
    min=int(math.floor(math.sqrt(i)))
    max=int(math.ceil(math.sqrt(i)))
    if(i==min*min or i==max*max):
        return True

def countbrute(m):
    """
Direct, brute force count, too slow for practical use but useful to understand algorithm
    """
    nfound=0

    for i in range(1,m+1):
        for j in range(1,i+1):
            for k in range(1,j+1):
                d1=i*i+(j+k)*(j+k) 
                if(checkpsq(d1)):
                    nfound=nfound+1

    return nfound


def countm(m):
    """
Better count than brute force, using one fewer loop.  But must compensate for that by counting 
the number of ways a given value of j+k can happen
    """
    nfound=0

    for i in range(1,m+1):
        for jpk in range(2,(2*i)+1):
            d1=i*i+(jpk)*(jpk) 
            if(checkpsq(d1)): 
                if(jpk<=i):
                    factor=jpk/2 
                else:
                    factor=((2*i-jpk)+2)/2 
                nfound=nfound+factor

    return nfound

print("check for M=99 and M=100 case")
print("actual answer is 1975 and 2060")
print("quick check with brute force approach",countbrute(99),countbrute(100))
print("quick check with efficient approach",countm(99),countm(100))

