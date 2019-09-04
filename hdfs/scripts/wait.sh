#!/bin/bash

set -o nounset

HADOOP_BIN="/hadoop/bin/"

wait_for_hdfs() {
    local max=5
    local attempt=1
    while [ $attempt -le $max ]; do
        $HADOOP_BIN/hdfs dfsadmin -safemode wait
        status=$?
        if [ $status -eq 0 ]; then
            break
        fi
        echo "Waiting for hdfs... ${attempt}/${max}"
        attempt=$(($attempt+1))
        sleep 1
        if [ $attempt -gt $max ]; then
            echo "Timeout!"
            exit 1
        fi
    done
}

wait_for_hdfs

$HADOOP_BIN/hdfs dfs -mkdir /test
$HADOOP_BIN/hdfs dfs -copyFromLocal /hadoop/share/hadoop/common/ /test/
