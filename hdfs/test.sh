#!/bin/bash

set -o nounset

IMAGE_NAME="mini-spark/hdfs"

cid_file=$(mktemp --suffix=.cid -u)

image_exists() {
    docker inspect $1 &>/dev/null
}

prepare() {
    if ! image_exists ${IMAGE_NAME}; then
        echo "ERROR: image ${IMAGE_NAME} does not exist."
        exit 1
    fi
}

run_test_container() {
    docker run --rm --cidfile=${cid_file} --name hdfs-test ${IMAGE_NAME}
}

wait_cid() {
    local max=5
    local attempt=1
    local result=1
    while [ $attempt -le $max ]; do
        [ -f $cid_file ] && break
        echo "Waiting for container to start..."
        attempt=$(($attempt+1))
        sleep 1
    done
}
test_container() {
    docker exec hdfs-test /wait.sh
    docker exec hdfs-test /roundtrip.sh
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
    if [ -f $cid_file ]; then
        docker stop $(cat $cid_file)
    fi
}

prepare
run_test_container &
wait_cid
test_container
check_result $?

cleanup
