import sys
from pyspark import SparkContext, SparkConf
from pyspark.mllib.feature import HashingTF, IDF


if __name__ == "__main__":

  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Spark Count").setMaster("local[2]")
  sc = SparkContext(conf=conf)

  # get threshold
  threshold = int(sys.argv[2])

  #rdd = sc.textFile(sys.argv[1])
  #records = rdd.toArray()

  #file = sc.parallelize(records)

  #firstPass = rdd.map(lambda x: x.split(0), x.split(1))
  ### tubles = firstPass.flatMap()
  # read in text file and split each document into words
  tokenized = sc.textFile(sys.argv[1]).flatMap(lambda line: line.split(" "))

  # count the occurrence of each word
  wordCounts = tokenized.map(lambda word: (word, 1)).reduceByKey(lambda v1,v2:v1 +v2)

  # filter out words with fewer than threshold occurrences
  filtered = wordCounts.filter(lambda pair:pair[1] >= threshold)

  # count characters
  # charCounts = filtered.flatMap(lambda pair:pair[0]).map(lambda c: c).map(lambda c: (c, 1)).reduceByKey(lambda v1,v2:v1 +v2)

  #list = charCounts.collect()
  list = filtered.collect()
  print repr(list)[1:-1]
  filtered.saveAsTextFile(sys.argv[3])

