#!/bin/bash

echo "Hadoop: $HADOOP_VERSION"

set -o nounset


_dir="$(dirname "${BASH_SOURCE[0]}")"
test_dir="$(realpath ${_dir})"

COMPOSE="docker-compose --file ${test_dir}/docker-compose.yml"

run_test_container() {
    $COMPOSE up -d
}


test_container() {
    $COMPOSE exec hdfs /wait.sh
    $COMPOSE exec openioci /app/.oio/roundtrip.sh
    $COMPOSE exec hdfs /hadoop/bin/hdfs dfs -copyFromLocal /hadoop/etc/ /test
    S3A_ARGS="-Dfs.s3a.access.key=demo:demo \
        -Dfs.s3a.secret.key=DEMO_PASS \
        -Dfs.s3a.endpoint=172.23.0.2:5000 \
        -Dfs.s3a.path.style.access=true \
        -Dfs.s3a.connection.ssl.enabled=false \
        -Dfs.s3a.attempts.maximum=1 \
        -Dfs.s3a.connection.timeout=1000 \
        -Dfs.s3a.retry.limit=1 \
        -Dfs.s3a.fast.upload=true \
        -Dfs.s3a.fast.upload=bytebuffer"
    $COMPOSE exec hdfs /hadoop/bin/hadoop jar /dfsio.jar io.openio.hadoop.DFSIO \
        $S3A_ARGS \
        -write \
        -baseDir s3a://test/
    $COMPOSE exec hdfs /hadoop/bin/hadoop jar /dfsio.jar io.openio.hadoop.DFSIO \
        $S3A_ARGS \
        -read \
        -baseDir s3a://test/
    $COMPOSE exec hdfs /hadoop/bin/hadoop distcp \
        $S3A_ARGS \
        /test/ s3a://test/
    $COMPOSE exec hdfs /hadoop/bin/hadoop distcp \
        $S3A_ARGS \
        -update \
        s3a://test/ /test/
}

check_result() {
    local result="$1"
    if [[ "$result" != "0" ]]; then
        echo "FAIL: exit code: ${result}"
        cleanup
        exit $result
    fi
}

cleanup() {
    $COMPOSE rm --stop --force
}

run_test_container
test_container
check_result $?

cleanup
