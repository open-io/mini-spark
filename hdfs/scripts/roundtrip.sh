#!/bin/bash

set -o nounset

HADOOP_BIN="/hadoop/bin/"
DFS="${HADOOP_BIN}/hdfs dfs"

$DFS -mkdir /test
$DFS -copyFromLocal /hadoop/share/hadoop/common/ /test
$DFS -find /test
$DFS -rm -r /test
