#!/bin/bash

set -e

echo "YBYXNLCG maintenance_toot_warning toot start"

cd /home/hiauntie_bot/maintenance.hiauntie.com
python3 -m hiauntie_py.toot --account announcement --msg "HiAuntie.com 即將進行系統維護，預計需時一小時。系統會間歇停止運作，用戶可能會受到影響。請避免在維護期間發文。不便之處，敬請原諒。"

echo "PQHGVWPD maintenance_toot_warning toot end"
