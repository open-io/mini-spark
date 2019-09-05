#!/bin/bash

export SPARK_PREFIX=/spark

SPARK_MASTER_HOST="0.0.0.0"
echo "Starting master"
$SPARK_PREFIX/sbin/start-master.sh -h $SPARK_MASTER_HOST

echo "Starting slave"
$SPARK_PREFIX/bin/spark-class org.apache.spark.deploy.worker.Worker "spark://127.0.0.1:7077"
