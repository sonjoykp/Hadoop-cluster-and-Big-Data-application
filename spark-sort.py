import sys
from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
if __name__ == "__main__":
    conf = SparkConf().setAppName("spark-sort")
    conf.set("spark.driver.memory", "32g")
    conf.set("spark.executor.memory", "32g")
    conf.set("spark.executor.cores", 10)
    conf.set("spark.task.cpus", 1)
    sc = SparkContext(conf=conf)
    spark = SparkSession.builder.appName("spark-sort").getOrCreate()
    inputFile = sys.argv[1]
    outputFile = sys.argv[2]
    df = spark.read.option('header', 'true').csv(inputFile, inferSchema=True)
    df = df.sort(['cca2', 'timestamp'], ascending=[True, True])
    #print(type(df))
    # df.write.csv(outputFile)
    #df.write.option("header","true").csv(outputFile)
    df.coalesce(1).write.option("header","true").csv(outputFile)