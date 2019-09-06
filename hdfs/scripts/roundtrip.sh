#!/bin/bash

set -o nounset
set -o errexit

HADOOP_BIN="/hadoop/bin/"
DFS="${HADOOP_BIN}/hdfs dfs"
DISTCP="${HADOOP_BIN}/hadoop distcp"

$DFS -mkdir /test
$DFS -copyFromLocal /hadoop/etc /test
$DFS -find /test
$DISTCP /test /copy
$DFS -rm -r /copy
$DFS -rm -r /test
