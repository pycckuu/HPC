"""
This script gets the top common words from few gutenberg ebooks

Output:
* Top 10 common words
* wordCount.pdf, a plot using matplotlib
"""

from pyspark.sql.session import SparkSession

import pyspark.sql.functions as fsc
import time
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np

def wordCount(df,columnName = 'word'):
    return df.groupBy(columnName).count()


def removePunctuation(column):
    return fsc.trim( fsc.lower( fsc.regexp_replace(column,'\p{P}','')  )  ).alias('sentence')

def plotWordCount(data):
    wordCount = map(lambda x: (x[0],x[1]),data)
    word,count = zip(*wordCount)
    word = np.array(word)
    count = np.array(count)
    pos = np.arange(len(word)) + 0.5
    print(pos)
    plt.barh(pos,count,align='center')
    plt.yticks(pos,word)
    plt.savefig('wordCount.pdf')

def main():
    spark = (SparkSession
             .builder
             .appName("WordCount")
             .getOrCreate()
             )
    dataRawDF = spark.read.text("../data/pg*.txt")
    sentencesDF = dataRawDF.select(removePunctuation(fsc.col('value')))
    wordsDF = sentencesDF.select( fsc.explode( fsc.split('sentence','\W+')  ).alias('word')   ).filter( fsc.col('word')!= '' )
    plotWordCount( wordCount(wordsDF).orderBy(fsc.desc('count')).take(10) )
    spark.stop()

if __name__ == "__main__":
    elapsed = time.time()
    main()
    elapsed = time.time() - elapsed
    print("Total elapsed time: {0} sec".format(elapsed))
