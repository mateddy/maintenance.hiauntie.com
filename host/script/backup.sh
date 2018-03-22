#!/bin/bash

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo DAEJLRVQ backup start ${TIMESTAMP_FULL} PARAM=$*

/home/hiauntie_bot/maintenance.hiauntie.com/host/script/_backup.sh $*
RESULT=$?

echo YNWXAMWL backup end ${TIMESTAMP_FULL} RESULT=${RESULT}

exit ${RESULT}
