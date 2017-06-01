"""
This spark script gets the RMSE and R2 for the performance of a Linear Regression
model applied to Power Plant dataset.

Output:
* Prints in the standard output the RMSE and R2
"""


from pyspark.sql.session import SparkSession
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.regression import LinearRegression
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

    lr = LinearRegression(predictionCol="Predicted_PE",
                          labelCol="PE",
                          regParam=0.1,
                          maxIter=100,)

    lrPipeline = Pipeline(stages=[vectorizer,lr])
    lrModel = lrPipeline.fit(trainingSetDF)

    intercept = lrModel.stages[1].intercept
    weights = lrModel.stages[1].coefficients
    print("The y intercept: {}".format(intercept))
    print("The coefficients: {}".format(weights))
    print("Columns:{}".format(trainingSetDF.columns))

    predictionsAndLabelsDF = lrModel.transform(testSetDF).select("AT","V","AP","RH","PE","Predicted_PE")

    regEval = RegressionEvaluator(predictionCol="Predicted_PE",labelCol="PE",metricName="rmse")
    rmse = regEval.evaluate(predictionsAndLabelsDF)
    print("Root Mean Squared Error: %.2f" % rmse)

    r2 = regEval.evaluate(predictionsAndLabelsDF,{regEval.metricName:"r2"})
    print("r2: {0:.2f}".format(r2))

    print("==========Cross Validation==========")

    crossval = CrossValidator(estimator=lrPipeline,evaluator=regEval,numFolds=3)
    regParam = [x/100.0 for x in range(1,11)]
    paramGrid = (ParamGridBuilder()
                 .addGrid(lr.regParam,regParam)
                 .addGrid(lr.maxIter,[50,100,150])
                 .addGrid(lr.elasticNetParam,[0,1])
                 .build()
                )
    crossval.setEstimatorParamMaps(paramGrid)

    cvModel = crossval.fit(trainingSetDF).bestModel

    predictionsAndLabelsDF = cvModel.transform(testSetDF).select("AT","V","AP","RH","PE","Predicted_PE")

    rmseNew = regEval.evaluate(predictionsAndLabelsDF)

    r2New = regEval.evaluate(predictionsAndLabelsDF,{regEval.metricName:"r2"})

    print("Old RMSE: {0:.2f}".format(rmse))
    print("New RMSE: {0:.2f}".format(rmseNew))
    print("Old r2: {0:.2f}".format(r2))
    print("New r2: {0:.2f}".format(r2New))

    print("Best RegParam: {0}".format(cvModel.stages[-1]._java_obj.parent().getRegParam()))
    print("Best maxIter: {0}".format(cvModel.stages[-1]._java_obj.parent().getMaxIter()))
    print("Best elasticNetParam: {0}".format(cvModel.stages[-1]._java_obj.parent().getElasticNetParam()))

    spark.stop()

if __name__ == "__main__":
    elapsed = time()
    main()
    elapsed = time() - elapsed
    print("The total elapsed time is {0:0.2f} sec".format(float(elapsed)) )
