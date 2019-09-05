.PHONY: build

build: build_spark build_hdfs

build_spark:
	docker build -t mini-spark/spark ./spark

build_hdfs:
	docker build -t mini-spark/hdfs ./hdfs

compose:
	docker-compose up

spark_shell:
	docker-compose exec spark /spark/bin/spark-shell --master spark://127.0.0.1:7077

hdfs_shell:
	docker-compose exec hdfs /bin/bash

test_hdfs:
	./hdfs/test.sh
