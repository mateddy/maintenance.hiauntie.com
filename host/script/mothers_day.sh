#!/bin/bash

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo "CSUWULVA mothers_day ${TIMESTAMP_FULL} start"

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account announcement --msg "今天是香港的母親節。祝天下間既老母快樂。祝天下間老母既老母快快樂樂。祝天下間老母既老母既老母快快快樂樂樂。"

echo "QIBJECXL mothers_day ${TIMESTAMP_FULL} end"
