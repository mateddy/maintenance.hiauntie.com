#!/bin/bash

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo UFIEXGNO backup start ${TIMESTAMP_FULL}

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account verbose --msg "URLKLBPN backup ${TIMESTAMP_FULL} start" || true

ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.bot.sh

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account verbose --msg "HHNSHGUM backup ${TIMESTAMP_FULL} end" || true

echo JXDNKIBA backup end ${TIMESTAMP_FULL}
