#!/bin/bash

export HADOOP_PREFIX=/hadoop
export HADOOP_CONF_DIR="${HADOOP_PREFIX}/etc/hadoop"
export HADOOP_VERSION="$(cat /hadoop_version)"

. "$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh"

if [ "${HADOOP_VERSION:0:2}" == "3." ]; then
	echo "Enable S3A filesystem"
	for i in $HADOOP_PREFIX/share/hadoop/tools/lib/aws-java-sdk-bundle-*.jar $HADOOP_PREFIX/share/hadoop/tools/lib/hadoop-aws-*.jar; do
		name=$(basename $i)
		if [ ! -f $HADOOP_PREFIX/share/hadoop/common/lib/$name ]; then
			ln -v -s $i $HADOOP_PREFIX/share/hadoop/common/lib/$name
		fi
	done
fi

if [ ! -d /tmp/hadoop-root/dfs/ ]; then
	echo "Format namenode"
	"$HADOOP_PREFIX/bin/hdfs" --config "$HADOOP_CONF_DIR" namenode -format
fi

echo "Starting namenode"
"$HADOOP_PREFIX/sbin/hadoop-daemon.sh" --config "$HADOOP_CONF_DIR" start namenode

echo "Starting datanode"
"$HADOOP_PREFIX/bin/hdfs" --config "$HADOOP_CONF_DIR" datanode
