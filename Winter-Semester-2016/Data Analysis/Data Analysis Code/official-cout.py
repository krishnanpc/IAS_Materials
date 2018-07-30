import sys
from pyspark import SparkContext, SparkConf


if __name__ == "__main__":

  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Spark Count").setMaster("local[2]")
  sc = SparkContext(conf=conf)
  rdd = sc.textFile(sys.argv[1])

  counts = rdd.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)
  counts.saveAsTextFile(
