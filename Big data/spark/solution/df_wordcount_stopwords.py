"""
This Spark script gets the top common words from few gutenberg ebook, but removes the 
defined Stopwords given by stopwords.txt

Output:
* Top 10 common words
* wordCount.pdf, a plot showing the count
"""

from pyspark.sql.session import SparkSession
from pyspark.sql.types import ArrayType, StringType

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
    with open("../data/stopwords.txt","r") as f:
        stopwords = set([line.strip() for line in f])

    sentencesDF = dataRawDF.select(removePunctuation(fsc.col('value')))
    splitDF = sentencesDF.select( fsc.split('sentence','\W+').alias('word')   )
    
    def removeStopWords(tokens):
        return [token for token in tokens if token not in stopwords]

    removeStopWordsUDF = fsc.udf(removeStopWords,ArrayType(StringType()))
    explodedNoStopWordsDF = splitDF.select( fsc.explode(removeStopWordsUDF("word")).alias("word")).filter(fsc.col("word")!="")

    plotWordCount( wordCount(explodedNoStopWordsDF).orderBy(fsc.desc('count')).take(10) )
    spark.stop()

if __name__ == "__main__":
    elapsed = time.time()
    main()
    elapsed = time.time() - elapsed
    print("Total elapsed time: {0} sec".format(elapsed))
