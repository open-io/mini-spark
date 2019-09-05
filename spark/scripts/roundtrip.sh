#!/bin/bash

set -o nounset

SPARK_DIR="/spark"
SPARK_BIN="${SPARK_DIR}/bin"
SPARK="${SPARK_BIN}/spark-submit"

SPARK_MASTER_URL="spark://127.0.0.1:7077"

$SPARK \
    --master $SPARK_MASTER_URL \
    $SPARK_DIR/examples/src/main/python/pi.py \
    100
