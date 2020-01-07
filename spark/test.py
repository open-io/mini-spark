from __future__ import print_function

import sys
from operator import add

from pyspark import SparkConf, SparkContext
from pyspark.sql import SparkSession


def spark_session_test(sc):
    spark = SparkSession(sc)

    df = spark.read.json("people.json")
    df.printSchema()

    df.createOrReplaceTempView("people")
    spark.sql("SELECT name FROM people WHERE AGE > 10").show()


def spark_rrd_test(sc, test_path):
    # create dummy rrd
    data = [(l, l) for l in range(0, 1000)]
    rrd = sc.parallelize(data)
    # save rrd as text file
    rrd.saveAsTextFile(test_path)

    # load as text file
    lines = sc.textFile(test_path)
    print(lines.count())


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: test.py <path>", file=sys.stderr)
        sys.exit(-1)

    conf = SparkConf().setAppName("PythonTest")
    sc = SparkContext(conf=conf)

    test_path = sys.argv[1]

    spark_rrd_test(sc, test_path)
    spark_session_test(sc)
