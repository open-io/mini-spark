.PHONY: build

export HADOOP_VERSION ?= 2.7.7
export SPARK_VERSION ?= 2.4.3

build: build_spark build_hdfs

build_spark:
	docker build -t mini-spark/spark:${SPARK_VERSION} --build-arg SPARK_VERSION=${SPARK_VERSION} ./spark

build_hdfs:
	docker build -t mini-spark/hdfs:${HADOOP_VERSION} --build-arg HADOOP_VERSION=${HADOOP_VERSION} ./hdfs

compose:
	docker-compose up

spark_shell:
	docker-compose exec spark /spark/bin/spark-shell --master spark://127.0.0.1:7077

test_spark:
	./spark/test.sh

hdfs_shell:
	docker-compose exec hdfs /bin/bash

test_hdfs:
	./hdfs/test.sh
