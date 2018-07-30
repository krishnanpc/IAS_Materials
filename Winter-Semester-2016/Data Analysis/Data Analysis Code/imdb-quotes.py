import sys
from pyspark import SparkContext, SparkConf
from pyspark.mllib.feature import HashingTF, IDF
from pyspark.mllib.classification import NaiveBayes, NaiveBayesModel
from pyspark.mllib.util import MLUtils
from pyspark.mllib.clustering import KMeans, KMeansModel
from pyspark.mllib.clustering import StreamingKMeans

if __name__ == "__main__":

  # create Spark context with Spark configuration
  conf = SparkConf().setAppName("Spark Count").setMaster("local[2]")
  sc = SparkContext(conf=conf)

  documents = sc.textFile(sys.argv[1]).map(lambda line: line.split(" "))
  qoutes = sc.textFile(sys.argv[2]).map(lambda line: line.split(" "))

  hashingTF = HashingTF()
  tf_doc = hashingTF.transform(documents)
  tf_qoute = hashingTF.transform(qoutes)

  # While applying HashingTF only needs a single pass to the data, applying IDF needs two passes:
  # First to compute the IDF vector and second to scale the term frequencies by IDF.
  tf_doc.cache()
  tf_qoute.cache()

  idf = IDF().fit(tf_doc)
  tfidf = idf.transform(tf_doc)

  idf_q = IDF().fit(tf_qoute)
  tfidf_q = idf_q.transform(tf_qoute)

  # spark.mllib's IDF implementation provides an option for ignoring terms
  # which occur in less than a minimum number of documents.
  # In such cases, the IDF for these terms is set to 0.
  # This feature can be used by passing the minDocFreq value to the IDF constructor.
  # idfIgnore = IDF(minDocFreq=sys.argv[2]).fit(tf)
  # tfidfIgnore = idfIgnore.transform(tf)
  # tfidf_q.saveAsTextFile(sys.argv[3])
  # tfidf.saveAsTextFile(sys.argv[4])

  # Train a naive Bayes model.
  # model = NaiveBayes.train(tf_doc, 1.0)

  clusters = KMeans.train(tf_qoute, 2, maxIterations=10, runs=10, initializationMode="random")
  # model =  KMeansModel(clusterCenters=centroids)
  # model.predict(rdd).take(10)
  res = clusters.predict(tf_doc)
  res.saveAsTextFile(sys.argv[3])
