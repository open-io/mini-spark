.PHONY: build

build: build_spark build_hdfs

build_spark_base:
	docker build -t mini-spark/spark-base ./spark-base

build_spark: build_spark_base
	docker build -t mini-spark/spark-master ./spark-master
	docker build -t mini-spark/spark-worker ./spark-worker

build_hdfs:
	docker build -t mini-spark/hdfs ./hdfs

compose:
	docker-compose up

spark_shell:
	docker-compose exec spark-master /spark/bin/spark-shell --master spark://spark-master:7077

hdfs_shell:
	docker-compose exec hdfs /bin/bash
