"""
This code will estimate the value of PI using the Monte Carlo method.
Usage:
     spark-submit pi_spark.py

Output:
     Print the value of PI
"""

from pyspark.sql.session import SparkSession

from time import time
from random import random

def inCircle(value):
    x = random() * 2 - 1
    y = random() * 2 - 1
    return 1 if x*x + y*y <= 1 else 0

def main():
    spark = (SparkSession
             .builder
             .appName("PiSpark")
             .getOrCreate()
            )
    numSamples = 10000000
    parallelRDD     = spark.sparkContext.parallelize(range(numSamples))
    withinCircleRDD = parallelRDD.map(inCircle)
    count = withinCircleRDD.reduce(lambda x1,x2: x1 + x2)
    print("The value of PI is {0:.6f}".format(4.0 * count / numSamples))

    spark.stop()

if __name__ == "__main__":
    elapsed = time()
    main()
    elapsed = time() - elapsed
    print("Total elapsed time: {0:0.2f} sec".format(float(elapsed)))
