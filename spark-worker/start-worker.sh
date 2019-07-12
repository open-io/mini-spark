#!/bin/bash

/spark/sbin/spark-config.sh
/spark/bin/load-spark-env.sh

export SPARK_HOME=/spark

cd /spark/bin && /spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER
