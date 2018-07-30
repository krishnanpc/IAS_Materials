from pyspark import SparkContext, SparkConf

conf = SparkConf().setAppName("test").setMaster("local[2]")
sc = SparkContext(conf=conf)
# Distribute the data: here we have a list of numbers from 1 to 10 million
# Store the data in an RDD called nums
nums = sc.parallelize( range(1,10000000) )
# Compute a derived RDD by filtering odd values
r1 = nums.filter( lambda x : (x % 2 == 1) )
# Now compute squares for all remaining values and store key/value tuples
result = r1.map( lambda x : (x, x*x*x) )
# Retrieve all distributed values into the driver and print them
# This will actually run the computation
# print(result.collect())
# [(1, 1), (3, 27), (5, 125), (7, 343), (9, 729), (11, 1331), ... ]
# Store results in memory
resultCached = result.cache()
