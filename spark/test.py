from __future__ import print_function

import sys
from operator import add

from pyspark import SparkConf, SparkContext


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: test.py <path>", file=sys.stderr)
        sys.exit(-1)

    conf = SparkConf().setAppName("PythonTest")
    sc = SparkContext(conf=conf)

    test_path = sys.argv[1]

    # create dummy rrd
    data = [(l, l) for l in range(0, 1000)]
    rrd = sc.parallelize(data)
    # save rrd as text file
    rrd.saveAsTextFile(test_path)

    # load as text file
    lines = sc.textFile(test_path)
    print(lines.count())
