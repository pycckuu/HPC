"""
This Spark script solve the 1D diffussion equation

Output:
* one_d_diffusion.dat, output after 1000 steps
"""


from pyspark.sql.session import SparkSession

import time,sys
import numpy as np


def main():
    spark = (SparkSession
             .builder
             .appName("1DDiff")
             .getOrCreate()
            )

    ncells = int(sys.argv[1]) if len(sys.argv) > 1 else 100
    dx = 1.0 / (ncells-1)
    dt = 0.9/2.0 * dx * dx #it used to be 0.00005
    print('dt = {0} '.format(dt))
    nsteps = 1000

    def tempFromIdx(i):
        if i==0 or i==ncells-1:
            val = 0
        else:
            val = 25
        return(i,val)

    temp = map( tempFromIdx, range(ncells))
    data = spark.sparkContext.parallelize(temp)

    def interior(i):
        return (i[0] > 0 and i[0]< ncells-1)

    def get_vals(item):
        i,t= item
        vals = [ (i,t) ]
        coeff_u = t*dt/(dx*dx)
        cvals = [ (i,-2*coeff_u),(i+1,coeff_u),(i-1,coeff_u) ]
        return vals + list(filter( interior, cvals ))

    for j in range(nsteps):
        new_data = data.flatMap( get_vals )
        data = new_data.reduceByKey( lambda x,y: x+y)
        if j%200==0:
            data.count()

    data = data.sortByKey()
    fout = open('../output/one_d_diffusion.dat','w')
    for i in data.collect():
        fout.write('{0}\t{1}\n'.format(i[0],i[1]))

if __name__ == "__main__":
    elapsed = time.time()
    main()
    elapsed = time.time() - elapsed
    print("Total elapsed time = {0} sec".format(float(elapsed)))
