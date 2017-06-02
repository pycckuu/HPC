# for a given integer p
# find all integer combinations of a b c for which
# a*a+b*b=c*c
# a+b+c=p 
# where a<b<c

def find_num_solutions(p):
    n=0
    for a in range(1,p/2):
        for b in range(a,p/2):
            c=p-a-b
            if(a*a+b*b==c*c):
                n=n+1

    return n

