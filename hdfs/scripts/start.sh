#!/bin/bash

export HADOOP_PREFIX=/hadoop
export HADOOP_CONF_DIR="${HADOOP_PREFIX}/etc/hadoop"

. "$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh"

if [ ! -d /tmp/hadoop-root/dfs/ ]; then
	echo "Format namenode"
	"$HADOOP_PREFIX/bin/hdfs" --config "$HADOOP_CONF_DIR" namenode -format
fi

echo "Starting namenode"
"$HADOOP_PREFIX/sbin/hadoop-daemon.sh" --config "$HADOOP_CONF_DIR" start namenode

echo "Starting datanode"
"$HADOOP_PREFIX/bin/hdfs" --config "$HADOOP_CONF_DIR" datanode
