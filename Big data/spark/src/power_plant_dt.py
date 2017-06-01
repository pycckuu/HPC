"""
This spark script gets the RMSE and R2 for the performance of a Decision Tree 
model applied to Power Plant dataset.

Output:
* Prints in the standard output the RMSE and R2

TO-DO:
Change the <CODE> lines for real Spark code
"""

from pyspark.sql.session import SparkSession
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.regression import DecisionTreeRegressor
from pyspark.ml import Pipeline
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.ml.tuning import ParamGridBuilder,CrossValidator

from time import time

def main():
    spark = (SparkSession
             .builder
             .appName("PowerPlant")
             .getOrCreate()
             )

    powerPlantDF = spark.read.csv("../data/CCPP/sheet*.csv",header=True,inferSchema=True)

    vectorizer = VectorAssembler(inputCols = ["AT","V","AP","RH"],outputCol="features")

    split20DF,split80DF = powerPlantDF.randomSplit([0.20,0.80],seed=100)
    testSetDF = split20DF.cache()
    trainingSetDF = split80DF.cache()

    dt = (DecisionTreeRegressor()
          .setLabelCol("PE")
          .setPredictionCol("Predicted_PE")
          .setFeaturesCol("features")
          .setMaxBins(100)
         )

    dtPipeline = ( <CODE>
                 )

    regEval = RegressionEvaluator(predictionCol="Predicted_PE",labelCol="PE",metricName="rmse")
    crossval = CrossValidator(estimator=dtPipeline,evaluator=regEval,numFolds=3)

    paramGrid = ( <CODE>
                )

    crossval.setEstimatorParamMaps(paramGrid)

    dtModel = crossval.fit(trainingSetDF).bestModel

    predictionsAndLabelsDF = (dtModel
                              .transform(testSetDF)
                              .select("AT","V","AP","RH","PE","Predicted_PE")
                             )
    rmseDT = regEval.evaluate(predictionsAndLabelsDF)
    r2DT = regEval.evaluate(predictionsAndLabelsDF,{<CODE>})

    print("DT RMSE: {0:.2f}".format(rmseDT))
    print("DT R2: {0:.2f}".format(r2DT))

    spark.stop()

if __name__ == "__main__":
    elapsed = time()
    main()
    elapsed = time() - elapsed
    print("The total elapsed time is {0:0.2f} sec".format(float(elapsed)) )
