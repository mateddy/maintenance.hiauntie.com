#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo GCCTJMCI ${0} OPT_WAIT_SEC
    exit 1
fi

OPT_WAIT_SEC=$1

MBFGNMYF_END_TIME=$(date -d "${OPT_WAIT_SEC} seconds" +%s)
while [ $(date +%s) -lt ${MBFGNMYF_END_TIME} ]; do
    RUNNING=`virsh list | grep social.hiauntie.com | wc -l`
    if [ ${RUNNING} -eq 0 ]; then
        exit 0
    fi
    sleep 1
done
if [ ${GOOD} -ne 1 ]; then
    echo "EVHLKQVH ERROR ${0} timeout"
    exit 1
fi
