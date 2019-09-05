#!/bin/bash

set -o nounset

SPARK_SBIN="/spark/sbin"

wait_for_spark() {
    local max=5
    local attempt=1
    while [ $attempt -le $max ]; do
        $SPARK_SBIN/spark-daemon.sh --config /spark/conf status org.apache.spark.deploy.master.Master 1
        status=$?
        if [ $status -eq 0 ]; then
            break
        fi
        echo "Waiting for spark... ${attempt}/${max}"
        attempt=$(($attempt+1))
        sleep 1
        if [ $attempt -gt $max ]; then
            echo "Timeout!"
            exit 1
        fi
    done
}

wait_for_spark
