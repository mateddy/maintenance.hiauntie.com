#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo GCCTJMCI ${0} OPT_WAIT_SEC
    exit 1
fi

OPT_WAIT_SEC=$1

ZDCOTKSZ_END_TIME=$(date -d "${OPT_WAIT_SEC} seconds" +%s)
while [ $(date +%s) -lt ${ZDCOTKSZ_END_TIME} ]; do
    BBEZDQLE=""
    BBEZDQLE=`curl -s -m 1 https://hiauntie.com/api/v1/instance | jq -r .uri` || true
    if [ "${BBEZDQLE}" = "hiauntie.com" ]; then
        exit 0
    fi
    sleep 1
done
if [ ${GOOD} -ne 1 ]; then
    echo "VCPYUKFS ERROR ${0} timeout"
    exit 1
fi
