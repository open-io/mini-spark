#!/bin/bash

set -o nounset

_dir="$(dirname "${BASH_SOURCE[0]}")"
test_dir="$(realpath ${_dir})"

COMPOSE="docker-compose --file ${test_dir}/docker-compose.yml"

run_test_container() {
    $COMPOSE up -d
}

test_container() {
    SPARK_DIR="/spark"
    SPARK="${SPARK_DIR}/bin/spark-submit"

    SPARK_MASTER_URL="spark://127.0.0.1:7077"

    S3_ENDPOINT="http://172.25.0.2:5000"
    $COMPOSE exec spark /wait.sh && \
    $COMPOSE exec openioci /app/.oio/roundtrip.sh && \
    $COMPOSE exec spark /spark/bin/spark-submit \
	    --master $SPARK_MASTER_URL \
	    --conf spark.hadoop.fs.s3a.access.key=demo:demo \
	    --conf spark.hadoop.fs.s3a.secret.key=DEMO_PASS \
	    --conf spark.hadoop.fs.s3a.endpoint=$S3_ENDPOINT \
	    $SPARK_DIR/test.py s3a://test/
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
