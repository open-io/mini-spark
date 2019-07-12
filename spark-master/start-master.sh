#!/bin/bash

export SPARK_MASTER_HOST=`hostname`

/spark/sbin/spark-config.sh
/spark/bin/load-spark-env.sh

export SPARK_HOME=/spark

cd /spark/bin && /spark/sbin/../bin/spark-class org.apache.spark.deploy.master.Master --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT
