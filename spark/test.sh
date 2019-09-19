#!/bin/bash

set -o nounset

_dir="$(dirname "${BASH_SOURCE[0]}")"
test_dir="$(realpath ${_dir})"

COMPOSE="docker-compose --file ${test_dir}/docker-compose.yml"

run_test_container() {
    $COMPOSE up -d
}

test_container() {
    $COMPOSE exec spark /wait.sh
    $COMPOSE exec openioci /app/.oio/roundtrip.sh
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
