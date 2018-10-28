#!/bin/bash

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

DF_VDA2_STAT=`df -BM | grep vda2 | awk '{ print $3 " / " $2 " = " $5 }'`

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account verbose --msg "HIVKXVHV disk usage ${TIMESTAMP_FULL} ${DF_VDA2_STAT}"
