#!/bin/bash

set -e

NEXT_SAT=`dateutils.dround today saturaday`
NEXT_MAIN="香港時間 ${NEXT_SAT} 凌晨三時"

echo "FXMZXOHC maintenance_toot_warning_12 toot start"

toot verbose "HiAuntie.com 將於${NEXT_MAIN}開始進行系統維護，預計需時一小時。系統會間歇停止運作，用戶可能會受到影響。請避免在維護期間發文。不便之處，敬請原諒。"

echo "WDLIWKHA maintenance_toot_warning_12 toot end"
