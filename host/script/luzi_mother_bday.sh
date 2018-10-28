#!/bin/bash

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo "EMEUKTYH luzi_mother_bday ${TIMESTAMP_FULL} start"

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account announcement --msg "今天是站長 @luzi82 老母生日。嚴正提醒站長祝福老母生日快樂，並繼續孝順老母，繼續俾家用佢。"

echo "LXXYKGEC luzi_mother_bday ${TIMESTAMP_FULL} end"
