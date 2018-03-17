#!/bin/bash

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo UFIEXGNO backup start ${TIMESTAMP_FULL}

ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.bot.sh

echo JXDNKIBA backup end ${TIMESTAMP_FULL}
